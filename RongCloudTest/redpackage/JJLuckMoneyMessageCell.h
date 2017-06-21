//
//  JJLuckMoneyMessageCell.h
//  RongCloudTest
//
//  Created by majianjie on 2017/6/20.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "ChatTestViewController.h"


@interface JJLuckMoneyMessageCell : RCMessageCell



@property (nonatomic,weak)ChatTestViewController *conversationVC;

+ (NSString *)identifier;

@end
