//
//  Readdaily.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/16.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "Readdaily.h"

@interface Readdaily ()

@end

@implementation Readdaily

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //navigationcontrollerの表示
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        //ナビゲーションタイトルを付ける
        self.navigationItem.title = @"日記を閲覧";
        [self.navigationItem setHidesBackButton:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //myTableView.dataSource = self;
    
   // AppDelegate *days = [[UIApplication sharedApplication] delegate];
    
    //navigationbutton
    UIBarButtonItem* button=[[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStyleBordered target:self action:@selector(clickButton:)];
    self.navigationItem.rightBarButtonItem=button;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
        NSString *sql = @"CREATE TABLE diary (id INTEGER PRIMARY KEY AUTOINCREMENT,day TEXT,kiji TEXT,title,TEXT,photo BLOB);";
        [db open]; //DB開く
        [db executeUpdate:sql]; //SQL実行
        [db close]; //DB閉じる
    }
    
    FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
    NSString *sel=@"select * from diary order by day asc;";
    [db open];
    FMResultSet *results = [db executeQuery:sel];
    array = [[NSMutableArray alloc] init];
     while( [results next] ){
     diarydata* data = [[diarydata alloc] init];
         data.diary = [results stringForColumn:@"kiji"];
         data.day = [results stringForColumn:@"day"];
         data.title = [results stringForColumn:@"title"];
         data.photo = [results dataForColumn:@"photo"];
         [array addObject:data];
     }

    
    
    [db close];
    
    //UITableView *myTableView;

    myTableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
//    myTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [myTableView setDelegate:self];
    [myTableView setDataSource:self];
    [self.view addSubview:myTableView];
	// Do any additional setup after loading the view.
}

//テーブルに含まれるセクションの数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//セクションに含まれる行の数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [array count];
}

//行に表示するデータの生成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
    diarydata *data = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = data.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@の日記",data.day];
    cell.imageView.image = [[UIImage alloc] initWithData:data.photo];
    
    NSLog(@"%ld",indexPath.row);
    return cell;
}

//セルが選択された時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *days = [[UIApplication sharedApplication] delegate];

    diarydata *data = [array objectAtIndex:indexPath.row];
    
    days.read = data.diary;
    days.readday = data.day;
    
    NSLog(@"%@",days.read);
    
    UIViewController *next = [[Dataildiary alloc] init];
    [self.navigationController pushViewController:next animated:NO];
    
    
    
}

- (void)clickButton:(UIButton*)sender{
    
    UIViewController *next = [[Readdaily alloc] init];
    [self.navigationController pushViewController:next animated:NO];
   
   // [myTableView reloadData]; //テーブルをリロードして更新
    //[myTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
