//
//  JJLuckMoneyMessage.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/19.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "JJLuckMoneyMessage.h"

@implementation JJLuckMoneyMessage


- (instancetype)initWith:(double)amonut description:(NSString *)desc{
    
    if (self = [super init]) {
        self.amount = amonut;
        self.desc = desc;
    }
    
    return  self;
}

/** RCMessageCoding 协议*/
- (NSData *)encode{
    
    return [NSJSONSerialization dataWithJSONObject:@{@"amount":@(self.amount),@"desc":self.desc} options:NSJSONWritingPrettyPrinted error:nil];
}

// 服务器收到data 转换出来
- (void)decodeWithData:(NSData *)data{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    self.amount = [(NSNumber *)dic[@"amount"] doubleValue];
    self.desc = (NSString *)dic[@"desc"];
    
}

//获取消息的名字
+ (NSString *)getObjectName{
    return NSStringFromClass([self class]);
}

/** RCMessagePersistentCompatible 存储 协议*/
+ (RCMessagePersistent)persistentFlag{
    return MessagePersistent_ISCOUNTED;
}



// 用于在回话列表和本地通知中显示消息的摘要
/** RCMessageContentView 协议*/
- (NSString *)conversationDigest{
    
    return @"[融云 红包]";
    
}








@end
