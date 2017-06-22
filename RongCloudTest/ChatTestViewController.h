//
//  ChatTestViewController.h
//  RongCloudTest
//
//  Created by majianjie on 2017/6/5.
//  Copyright © 2017年 majianjie. All rights reserved.
//

// 这个界面是 聊天的界面的  可以添加聊天背景之类的

#import <RongIMKit/RongIMKit.h>
#import "MMInputToolBarView.h"

@interface ChatTestViewController : RCConversationViewController


@property(strong, nonatomic) MMInputToolBarView *inputToolBar;



@end
