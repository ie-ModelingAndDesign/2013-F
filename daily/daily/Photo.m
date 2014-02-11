//
//  Photo.m
//  daily
//
//  Created by Daisuke YOKOJI on 2014/02/02.
//  Copyright (c) 2014年 Daisuke YOKOJI. All rights reserved.
//

#import "Photo.h"

@interface Photo ()

@end

@implementation Photo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //戻るボタン非表示
        [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.title = @"写真を投稿しました！";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AppDelegate *days = [[UIApplication sharedApplication] delegate];

    
    if (self.tabBarController.selectedIndex == 0) {
        NSLog(@"00000");
        day = days.readday;
        
    }
    
    else if (self.tabBarController.selectedIndex ==1){
        NSLog(@"111111");
        day = days.str;
    }
    

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
    NSString *sel=@"select photo from diary where day = ?;";
     [db open];
    FMResultSet *results = [db executeQuery:sel,day];
    
    
    while( [results next] ){
        NSData *imagedata = [results dataForColumn:@"photo"];
        UIImage *image =  [[UIImage alloc] initWithData:imagedata];
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = CGRectMake(0, 70, self.view.frame.size.width-100, self.view.frame.size.height-300);
        iv.frame = rect;

        [self.view addSubview:iv];
    
        
}

    
    UIButton* button=[self makeButton:CGRectMake(115, 420, 90, 40) text:@"確認"];
    [self.view addSubview:button];
    
    
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
    

    if(self.tabBarController.selectedIndex == 0){
        UIViewController *next = [[Readdaily alloc] init];
        NSArray *new =[NSArray arrayWithObjects:next, nil];
        [self.navigationController setViewControllers:new];
        
    }
    else{
    [self.navigationController popToRootViewControllerAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
