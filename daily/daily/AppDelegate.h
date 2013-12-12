//
//  AppDelegate.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/07.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selectdays.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString* str;
}

//選択した日付
@property (nonatomic,retain)NSString* str;


@property (strong, nonatomic) UIWindow *window;

@end
