//
//  Dataildiary.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/18.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "Dataildiary.h"

@interface Dataildiary ()

@end

static const NSInteger firstAlertTag = 1;
static const NSInteger secondAlertTag = 2;

@implementation Dataildiary{

}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  //self.view.backgroundColor = [UIColor blueColor];
    
   
    
    UIBarButtonItem* del=[[UIBarButtonItem alloc] initWithTitle:@"削除/編集" style:UIBarButtonItemStyleBordered target:self action:@selector(clickButton:)];
    self.navigationItem.rightBarButtonItem=del;
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    //navigationcontrollerの表示
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //ナビゲーションタイトルを付ける
    self.navigationItem.title = appDelegate.readday;
    
    
    _titlelabel =[self makeTextView:CGRectMake(50, 65, 200, 30)text:@""];
    [_titlelabel setDelegate:self];
    [_titlelabel setText:@"タイトル:"];

    
    _titleView =[self makeTextView:CGRectMake(50, 30, 200, 200)text:@""];
    [_titleView setText:appDelegate.title];
    [_titleView setDelegate:self];
//    _titleView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
    [_titleView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:_titleView];

    
    _textlabel =[self makeTextView:CGRectMake(50, 130, 200, 25)text:@""];
    [_textlabel setDelegate:self];
    [_textlabel setText:@"本文:"];

    
    _textView =[self makeTextView:CGRectMake(50, 150, 200, 150)text:@""];
    [_textView setText:appDelegate.read];
    [_textView setDelegate:self];
    _textView.backgroundColor =  [UIColor groupTableViewBackgroundColor	];

    [self.view addSubview:_textView];

    
    NSData *imagedata = appDelegate.photo;
    UIImage *image =  [[UIImage alloc] initWithData:imagedata];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    
    CGRect rect = CGRectMake(50,308,self.view.frame.size.width-100, self.view.frame.size.height-360);
    iv.frame = rect;
    
    [self.view addSubview:iv];
    
    
    [self.view addSubview:_titlelabel];
    [self.view addSubview:_textlabel];
   
}

- (UITextView*)makeTextView:(CGRect)rect text:(NSString*)text{
    UITextView* textView=[[UITextView alloc] init];
    [textView setEditable:NO];
    [textView setFrame:rect];
    //[textView setText:text];
    [textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setReturnKeyType:UIReturnKeyDefault];
    return textView;
    
}


- (void)clickButton:(UIButton*)sender{
    
   [self showAlert:@"" text:[NSString stringWithFormat:@"削除/編集しますか？"]];
    
}

- (void)showAlert:(NSString*)title text:(NSString*)text{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = title;
    alert.message = text;
    alert.tag= firstAlertTag;
    [alert addButtonWithTitle:@"編集"];
    [alert addButtonWithTitle:@"削除"];
    [alert addButtonWithTitle:@"キャンセル"];
    [alert show];
}


- (void)showAlertTop:(NSString*)title text:(NSString*)text{
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:title message:text
    delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
    [alert show];
}


//アラートクリック時に呼ばれる
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
        if (alertView.tag == firstAlertTag) {
        if (buttonIndex == 1) {
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

        
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
        NSString *dir   = [paths objectAtIndex:0];
        //DBファイルがあるかどうか確認
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
        {
            //なければ新規作成
            FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
            NSString *sql = @"CREATE TABLE diary (id INTEGER PRIMARY KEY AUTOINCREMENT,day TEXT,kiji TEXT,tilte TEXT,photo BLOB);";
            [db open]; //DB開く
            [db executeUpdate:sql]; //SQL実行
            [db close]; //DB閉じる
        }
        
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
        NSString *del=@"delete  from diary where day = ?;";

        [db open];
        [db executeUpdate:del, appDelegate.readday];
        [db close];

         [self showAlertTop:@"" text:[NSString stringWithFormat:@"削除しました"]];
        }
            else if (buttonIndex == 0){
                UIViewController *next = [[Writedaily alloc] init];
                [self.navigationController pushViewController:next animated:NO];
            
            }
        }
    
    else
    {
        UIViewController *next = [[Readdaily alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
