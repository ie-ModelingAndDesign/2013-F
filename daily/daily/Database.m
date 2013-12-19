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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    AppDelegate *days = [[UIApplication sharedApplication] delegate];
    
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
    NSString *ins=@"insert into diary (day,kiji) values (?,?);";
    NSString *sel=@"select * from diary where day = ?;";
    [db open];
    FMResultSet *olddiary = [db executeQuery:sel,days.str];
    
    if([olddiary next]) {
        NSString* del = @"DELETE FROM diary WHERE day = ?;";
        [db executeUpdate:del,days.str];
    }
    
    [db executeUpdate:ins,days.str,days.moji];
    FMResultSet *results = [db executeQuery:sel,days.str];
    
    
    while( [results next] ){
        NSString *testname = [results stringForColumn:@"kiji"];
        _textView =[self makeTextView:CGRectMake(50, 100, 200, 200)text:@""];
        [_textView setDelegate:self];
        [_textView setText:testname];
        [self.view addSubview:_textView];
        NSLog(@"%@", [results stringForColumn:@"kiji"]);
    }

    
    

    UIButton* button=[self makeButton:CGRectMake(115, 320, 90, 40) text:@"確認"];
    [self.view addSubview:button];


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
    
    //ページ移動
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
