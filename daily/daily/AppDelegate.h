//
//  AppDelegate.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/07.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selectdays.h"
#import "Readdaily.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString* str;
}

//選択した日付
@property (nonatomic,retain)NSString* str;

@property (nonatomic,retain)NSString* moji;

//選択した閲覧日
@property (nonatomic,retain)NSString* read;


@property (nonatomic,retain)NSString* readday;

@property (nonatomic,retain)NSString* title;

@property (nonatomic,retain)NSData* photo;


@property (strong, nonatomic) UIWindow *window;


@end
