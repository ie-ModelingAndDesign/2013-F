//
//  Writedaily.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/08.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "Writedaily.h"

@interface Writedaily ()

@end




@implementation Writedaily

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

#define MAX_LENGTH 1000

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate* days = [[UIApplication sharedApplication] delegate];

    UILabel *label =[[UILabel alloc] init];
    [label setText:[NSString stringWithFormat:@"%@の日記",days.str]];
    label.frame = CGRectMake(50, 70, 200,25);
    [self.view addSubview:label];
    
    UILabel *titlelabel =[[UILabel alloc] init];
    [titlelabel setText:[NSString stringWithFormat:@"タイトル:"]];
    titlelabel.frame = CGRectMake(50, 90, 200,25);
    [self.view addSubview:titlelabel];
    
    UILabel *mainlabel =[[UILabel alloc] init];
    [mainlabel setText:[NSString stringWithFormat:@"本文:"]];
    mainlabel.frame = CGRectMake(50, 160, 200,25);
    [self.view addSubview:mainlabel];
    
    //navigationcontrollerの表示
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //ナビゲーションタイトルを付ける
    self.navigationItem.title = days.str;
    //ナビゲーションボタン
    UIBarButtonItem* button=[[UIBarButtonItem alloc] initWithTitle:@"投稿" style:UIBarButtonItemStyleBordered target:self action:@selector(clickButton:)];
    self.navigationItem.rightBarButtonItem=button;
    
    //NSLog(@"%@",days.str);
    

    //テキストビューの作成
    _titleView =[self makeTextView:CGRectMake(50, 120, 200, 30)text:@""];
    [_titleView setDelegate:self];
    [_titleView setReturnKeyType:UIReturnKeyDone];
    _titleView.tag = 1;
    
   //viewの作成
    UIView* titleview =[[UIView alloc] initWithFrame:CGRectMake(49, 119, 202, 32)];
    [titleview setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:titleview];
    
    
    //viewの作成
    UIView* view =[[UIView alloc] initWithFrame:CGRectMake(49, 199, 202, 202)];
    [view setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:view];
    
    
    //テキストビューの作成
    _textView =[self makeTextView:CGRectMake(50, 200, 200, 200)text:@""];
    [_textView setDelegate:self];
    _textView.tag = 2;
    
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
    NSString *sel=@"select * from diary where day = ?;";
    [db open];
    
    
    
    FMResultSet *results = [db executeQuery:sel,days.str];
    if([results next]) {
        //while( [results next] ){
        NSString *kiji = [results stringForColumn:@"kiji"];
        NSString *title = [results stringForColumn:@"title"];
        [_textView setText:kiji];
        [_titleView setText:title];
            NSLog(@"%@",kiji);
            
    //}
    }

    
    
    
    [self.view addSubview:_titleView];
    [self.view addSubview:_textView];

    
    [db close];
    
   /* UIButton* button=[self makeButton:CGRectMake(115, 320, 90, 40) text:@"日記を投稿"];
    [self.view addSubview:button];*/
    
    
}

- (UIButton*)makeButton:(CGRect)rect text:(NSString*)text{
    UIButton* button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:rect];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:)
     forControlEvents: UIControlEventTouchUpInside];
    return button;
}


- (UITextView*)makeTextView:(CGRect)rect text:(NSString*)text{
    UITextView* textView=[[UITextView alloc] init];
    [textView setEditable:YES];
    [textView setFrame:rect];
    //[textView setText:text];
    [textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setReturnKeyType:UIReturnKeyDefault];
    return textView;

}


- (void)showAlert:(NSString*)title text:(NSString*)text{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:title message:text delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)showAlertNostring:(NSString*)title text:(NSString*)text{
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:title message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}



//アラートクリック時に呼ばれる
- (void)alertView:(UIAlertView*)alertView didDismissWithButtonIndex:(NSInteger)index{
    
    if (index == 1) {
        UIViewController *next = [[Database alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
}

	// Do any additional setup after loading the view.
/*-(void)write:(UITextView*)textfield{

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //[textfield resignFirstResponder];

    //appDelegate.moji = textfield.text;

    NSLog(@"%@",appDelegate.moji);
    
}*/



- (void)clickButton:(UIButton*)sender{
    AppDelegate *days = [[UIApplication sharedApplication] delegate];
    //[textfield resignFirstResponder];
    
    if ([_textView hasText] == NO || [_titleView hasText] == NO) {
        NSLog(@"nostring");
        [self showAlertNostring:@"" text:@"タイトルか本文が入力されていません"];
    }
    

    
 
    else{
        days.moji = _textView.text;
        days.title = _titleView.text;
        NSLog(@"%@",days.moji);
        [self showAlert:@"" text:[NSString stringWithFormat:@"%@の日記を投稿しますか？",days.str]];
        }
    }







//textViewの文字数、キーボード
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    int maxInputLength = 0;
    switch (textView.tag) {
        case 1:
            maxInputLength = 20;
            if ([text isEqualToString:@"\n"]) {
                // ここにtextのデータ(記録)処理など
                
                // キーボードを閉じる
                [textView resignFirstResponder];
                return NO;
            }

            break;
        case 2:
            maxInputLength = 5000;
            break;
        default:
            break;
    }
    
    
    
    // 入力済みのテキストを取得
    NSMutableString *str = [textView.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:text];
    
    if ([str length] > maxInputLength) {
        return NO;
    }
    

        return YES;
    // YES if the old text should be replaced by the new text;
    // NO if the replacement operation should be aborted. (Apple's Reference より)
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
