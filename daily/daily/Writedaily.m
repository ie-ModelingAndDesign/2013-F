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

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    AppDelegate* days = [[UIApplication sharedApplication] delegate];
    UILabel *label =[[UILabel alloc] init];
    label.text = days.str;
    label.frame = CGRectMake(50, 50, 200,50);
    [self.view addSubview:label];
    
    //navigationcontrollerの表示
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //ナビゲーションタイトルを付ける
    self.navigationItem.title = days.str;
    
    
    NSLog(@"%@",days.str);
    
    // UITextFieldのインスタンスを生成
    CGRect rect = CGRectMake(50, 100, 200, 25);
    UITextField *textField = [[UITextField alloc]initWithFrame:rect];
    
    // 枠線のスタイルを設定
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    // テキストを左寄せにする
   // textField.textAlignment = UITextAlignmentLeft;
    
    // ラベルのテキストのフォントを設定
    textField.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    // プレースホルダ
    textField.placeholder = @"日記を投稿して下さい";
    
    
    // キーボードの種類を設定
    textField.keyboardType = UIKeyboardTypeDefault;
    
    // リターンキーの種類を設定
    textField.returnKeyType = UIReturnKeyDone;
    
    // 編集中にテキスト消去ボタンを表示
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    // デリゲートを設定
    textField.delegate = self;
    
    // UITextFieldのインスタンスをビューに追加
    [self.view addSubview:textField];
    
}



    
	// Do any additional setup after loading the view.



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを隠す
    [self.view endEditing:YES];
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
