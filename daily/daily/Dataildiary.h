//
//  Dataildiary.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/18.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Readdaily.h"
@interface Dataildiary : UIViewController <UITextViewDelegate>{
    UITextView* _textView;
    NSInteger kTagAlert1;
    NSInteger kTagAlert2;
}

@end
