//
//  Database.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/17.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMResultSet.h"
#import "AppDelegate.h"


@interface Database : UIViewController <UITextViewDelegate>{
    UITextView* _textView;
    UITextView* _titleView;
}

@end
