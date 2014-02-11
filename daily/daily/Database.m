//
//  Database.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/17.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "Database.h"

@interface Database ()

@end

@implementation Database

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"日記を投稿しました！";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.view.backgroundColor = [UIColor blueColor];

    
    AppDelegate *days = [[UIApplication sharedApplication] delegate];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
        NSString *sql = @"CREATE TABLE diary (id INTEGER PRIMARY KEY AUTOINCREMENT,day TEXT,kiji TEXT,title TEXT,photo BLOB);";
        [db open]; //DB開く
        [db executeUpdate:sql]; //SQL実行
        [db close]; //DB閉じる
    }

    FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
    NSString *ins=@"insert into diary (day,kiji,title) values (?,?,?);";
    NSString *sel=@"select * from diary where day = ?;";
    [db open];
    FMResultSet *olddiary = [db executeQuery:sel,days.str];
    
    if([olddiary next]) {
        NSString* del = @"DELETE FROM diary WHERE day = ?;";
        [db executeUpdate:del,days.str];
    }
    
    [db executeUpdate:ins,days.str,days.moji,days.title];
    FMResultSet *results = [db executeQuery:sel,days.str];
    
    
    while( [results next] ){
        NSString *testname = [results stringForColumn:@"kiji"];
        NSString *title = [results stringForColumn:@"title"];
        
     
        
        _titleView =[self makeTextView:CGRectMake(50, 70, 200, 200)text:@""];
        [_titleView setDelegate:self];
        [_titleView setText:title];
        //[self.view addSubview:_titleView];
        
        _textView =[self makeTextView:CGRectMake(50, 200, 200, 200)text:@""];
        [_textView setDelegate:self];
        [_textView setText:testname];
//        [self.view addSubview:_textView];
        NSLog(@"%@", title);
    }
    
    _titlelabel =[self makeTextView:CGRectMake(50, 110, 200, 25)text:@""];
    [_titlelabel setDelegate:self];
    [_titlelabel setText:@"タイトル:"];
  
    _textlabel =[self makeTextView:CGRectMake(50, 180, 200, 25)text:@""];
    [_textlabel setDelegate:self];
    [_textlabel setText:@"本文:"];
    
  //  [self.view addSubview:_titlelabel];

    [self.view addSubview:_titleView];
    [self.view addSubview:_textView];
    [self.view addSubview:_titlelabel];
    [self.view addSubview:_textlabel];
    
    UIButton* button=[self makeButton:CGRectMake(115, 420, 90, 40) text:@"確認"];
    button.tag = 1;
    UIButton* photobutton=[self makeButton:CGRectMake(115, 450, 90, 40) text:@"写真も投稿"];
    photobutton.tag = 2;
    [self.view addSubview:button];
    [self.view addSubview:photobutton];

    [db close];
	// Do any additional setup after loading the view.
}


- (UITextView*)makeTextView:(CGRect)rect text:(NSString*)text{
    UITextView* textView=[[UITextView alloc] init];
    [textView setEditable:NO];
    [textView setFrame:rect];
    [textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setReturnKeyType:UIReturnKeyDefault];
    return textView;
    
}



- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:)
     forControlEvents: UIControlEventTouchUpInside];
    return button;
}

- (void)clickButton:(UIButton*)sender{
    
    if(sender.tag == 1){
    //ページ移動
        if(self.tabBarController.selectedIndex == 0){
            UIViewController *next = [[Readdaily alloc] init];
            NSArray *new =[NSArray arrayWithObjects:next, nil];
            [self.navigationController setViewControllers:new];
            
        }
        else{
    [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    else if (sender.tag){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library",nil];
        [actionSheet showInView:self.view];
    }
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            return;
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

//画像選択時に呼び出す
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    // オリジナル画像を取得する
    UIImage*    originalImage;
    originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *imageData;
    // データベースに入れるためにNSDataに変換、保存のときに使う
    imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation(originalImage, 0.8)];
    
    AppDelegate *days = [[UIApplication sharedApplication] delegate];
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
        NSString *sql = @"CREATE TABLE diary (id INTEGER PRIMARY KEY AUTOINCREMENT,day TEXT,kiji TEXT,title TEXT,photo BLOB);";
        [db open]; //DB開く
        [db executeUpdate:sql]; //SQL実行
        [db close]; //DB閉じる
    }
    //画像をデータベースに格納
    FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
    NSString *up=@"update diary set photo = ? where day = ?;";
    [db open];
    [db executeUpdate:up,imageData,days.str];
    
    UIViewController *next = [[Photo alloc] init];
    [self.navigationController pushViewController:next animated:NO];
    

    
}

//画像の選択がキャンセルされた時に呼ばれる
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];  // モーダルビューを閉じる
	// 何かの処理
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
