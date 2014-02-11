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
    
    UIDatePicker *datePicker= [[UIDatePicker alloc]init];

    
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
    
    UIButton* button=[self makeButton:CGRectMake(115, 220, 90, 40) text:@"日記を作成"];
  

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

- (void)clickButton:(UIButton*)sender{
    

    UIBarButtonItem *back_button = [[UIBarButtonItem alloc] initWithTitle:@"日付" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = back_button;
    
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
