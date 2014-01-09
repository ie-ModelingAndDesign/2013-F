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
  
    
   
    
    UIBarButtonItem* del=[[UIBarButtonItem alloc] initWithTitle:@"削除" style:UIBarButtonItemStyleBordered target:self action:@selector(clickButton:)];
    self.navigationItem.rightBarButtonItem=del;
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    //navigationcontrollerの表示
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //ナビゲーションタイトルを付ける
    self.navigationItem.title = appDelegate.readday;
    
    //テキストビューの作成
    _textView =[self makeTextView:CGRectMake(50, 100, 200, 200)text:@""];
    [_textView setText:appDelegate.read];
    [_textView setDelegate:self];
    [self.view addSubview:_textView];

    
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
    
   [self showAlert:@"" text:[NSString stringWithFormat:@"削除しますか？"]];
    
}

- (void)showAlert:(NSString*)title text:(NSString*)text{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = title;
    alert.message = text;
    alert.tag= firstAlertTag;
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
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
            NSString *sql = @"CREATE TABLE diary (id INTEGER PRIMARY KEY AUTOINCREMENT,day TEXT,kiji TEXT,photo BLOB);";
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
