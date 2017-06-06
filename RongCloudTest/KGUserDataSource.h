//
//  KGUserDataSource.h
//  RongCloudDemo
//
//  Created by majianjie on 2017/6/3.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

//这个类是负责告诉SDKUI 头像和名字的   实现一个代理就可以了 
@interface KGUserDataSource : NSObject<RCIMUserInfoDataSource>

@end
