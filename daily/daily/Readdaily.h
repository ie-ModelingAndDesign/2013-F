//
//  Readdaily.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/16.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "diarydata.h"
#import "AppDelegate.h"
#import "Dataildiary.h"
@interface Readdaily : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray* array;
    UITableView* myTableView;
}

@end
