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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *myTableView;
    
    myTableView = [[UITableView alloc] initWithFrame:[self.view bounds]];
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
    return 50;
}

//行に表示するデータの生成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
	
    cell.text = [NSString stringWithFormat:@"%@ %i", @"row", indexPath.row];
    NSLog(@"%d",indexPath.row);
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
