//
//  ViewController.m
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/07.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    UIButton* button=[self makeButton:CGRectMake(115, 320, 90, 40) text:@"一番最初"];
    [self.view addSubview:button];
    
	// Do any additional setup after loading the view, typically from a nib.
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
