//
//  Selectdays.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/07.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "Selectdays.h"

@interface Selectdays ()

@end

@implementation Selectdays


//@synthesize str;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //navigationcontrollerの表示
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        //ナビゲーションタイトルを付ける
        self.navigationItem.title = @"日付を選択";

        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button;
    UIDatePicker *datePicker= [[UIDatePicker alloc]init];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    
    //現在の日付取得
    NSDate *nowdate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    
    appDelegate.str = [formatter stringFromDate:nowdate];
    
    
    
    // 日付の表示モードを変更する(時分を表示)
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    // 分の刻みを10分おきにする
   // datePicker.minuteInterval = 10;
    
    // 日付ピッカーの値が変更されたときに呼ばれるメソッドを設定
    [datePicker addTarget:self
                   action:@selector(hoge:)
         forControlEvents:UIControlEventValueChanged];
    
    // UIDatePickerのインスタンスをビューに追加
    [self.view addSubview:datePicker];
    
    //ボタンの設定
    
    [button setTitle:@"日記作成" forState:UIControlStateNormal];
    
    // キャプションに合わせてサイズを自動調整
    [button sizeToFit];
    
    // ボタンを画面中心に移動
    button.center = self.view.center;
    
    // 画面変更時にボタンの位置を自動調整
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    // ボタン押下時のイベントを登録
    [button addTarget:self action:@selector(buttonDidPush:)
     forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}
    
- (void)hoge:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    UIDatePicker *datePicker = sender;
    
    // 日付の表示形式を設定
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"yyyy年MM月dd日";
    appDelegate.str = [df stringFromDate:datePicker.date];
    // ログに日付を表示
    //NSLog(@"%@", str);
}

- (void)buttonDidPush:(UIDatePicker*)dp
{
    //NSDateFormatter *df = [[NSDateFormatter alloc]init];
    //df.dateFormat = @"yyyy/MM/dd";
   // AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    //NSLog(@"%@",appDelegate.str);
    /*UILabel *label =[[UILabel alloc] init];
    label.text = appDelegate.str;
    label.frame = CGRectMake(10, 200, 200,50);
    [self.view addSubview:label];
    */
    

    
     //UIViewController *next = [[Writedaily alloc] init];
     //[self.view addSubview:next];
    //ページ移動
    UIViewController *next = [[Writedaily alloc] init];
   // next.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
   [self.navigationController pushViewController:next animated:NO];
}





	// Do any additional setup after loading the view.


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
