//
//  diarydata.h
//  daily
//
//  Created by Daisuke YOKOJI on 2013/12/18.
//  Copyright (c) 2013年 Daisuke YOKOJI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface diarydata : NSObject
{
    NSString *day;
    NSString *diary;
    NSString *title;
    NSData *photo;
}

@property(nonatomic,retain)NSString *day;
@property(nonatomic,retain)NSString *diary;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSData *photo;


@end
