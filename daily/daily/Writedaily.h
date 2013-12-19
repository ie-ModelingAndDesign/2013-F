//
//  Writedaily.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/08.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selectdays.h"
#import "AppDelegate.h"
#import "Database.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMResultSet.h"


@interface Writedaily : UIViewController <UITextViewDelegate>{
    UITextView* _textView;
}//<UITextFieldDelegate>

@end
