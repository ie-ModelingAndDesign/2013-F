//
//  ViewController.m
//  MyForthApp
//
//  Created by e125748 on 2013/11/14.
//  Copyright (c) 2013年 e125748. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)button:(id)sender {
   // self.label.text = @"You pushed me!";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *now = [NSDate date];
    self.label.text = [formatter stringFromDate:now];
}
@end
