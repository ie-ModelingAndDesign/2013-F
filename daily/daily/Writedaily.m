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
    
    //navigationcontrollerの表示
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    //ナビゲーションタイトルを付ける
    self.navigationItem.title = days.str;
    //ナビゲーションボタン
    UIBarButtonItem* button=[[UIBarButtonItem alloc] initWithTitle:@"投稿" style:UIBarButtonItemStyleBordered target:self action:@selector(clickButton:)];
    self.navigationItem.rightBarButtonItem=button;
    
    //NSLog(@"%@",days.str);
    
    
    //viewの作成
    UIView* view =[[UIView alloc] initWithFrame:CGRectMake(49, 99, 202, 202)];
    [view setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:view];
  
    
    
    //テキストビューの作成
    _textView =[self makeTextView:CGRectMake(50, 100, 200, 200)text:@""];
    [_textView setDelegate:self];
    [self.view addSubview:_textView];
    
    
    
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
    [textView setText:text];
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
        UIViewController *next = [[ViewController alloc] init];
        [self.navigationController pushViewController:next animated:NO];
    }
}

	// Do any additional setup after loading the view.
-(void)write:(UITextView*)textfield{

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //[textfield resignFirstResponder];

    appDelegate.moji = textfield.text;
    NSLog(@"%@",appDelegate.moji);
    
}



- (void)clickButton:(UIButton*)sender{
    AppDelegate *days = [[UIApplication sharedApplication] delegate];
    //[textfield resignFirstResponder];
    
    if ([_textView hasText] == NO) {
        NSLog(@"nostring");
        [self showAlertNostring:@"" text:@"文字が入力されていない"];
    }

    else{
    days.moji = _textView.text;
    NSLog(@"%@",days.moji);
    [self showAlert:@"" text:[NSString stringWithFormat:@"%@の日記を投稿しますか？",days.str]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
