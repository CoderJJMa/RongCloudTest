//
//  JJLuckMoneyMessage.h
//  RongCloudTest
//
//  Created by majianjie on 2017/6/19.
//  Copyright © 2017年 majianjie. All rights reserved.
// 自自定义的红包的内容

#import <RongIMLib/RongIMLib.h>

@interface JJLuckMoneyMessage : RCMessageContent

@property (nonatomic,assign)double amount;
@property (nonatomic,strong)NSString *desc;

- (instancetype)initWith:(double)amonut description:(NSString *)desc;

@end
