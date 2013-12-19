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

@implementation Dataildiary

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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
