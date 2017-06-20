//
//  ChatTestViewController.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/5.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "ChatTestViewController.h"

@interface ChatTestViewController ()

@end

@implementation ChatTestViewController

//- (instancetype)init{
//    
//    if ( self == [super init]) {
//        self.defaultHistoryMessageCountOfChatRoom = 2;
//
//    }
//    return self;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //设置聊天背景
    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dlrb"]];
    
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"redpackage"] title:@"红包" tag:2000];
    // 注册自定义的cell
    
    
}

- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    
    if (tag == 2000) {
        
        [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content:nil pushContent:@"锁屏收到的信息" pushData:@"" success:^(long messageId) {
            
        } error:^(RCErrorCode nErrorCode, long messageId) {
            
        }];
        
        NSLog(@"click redpackage");
        
    }else{
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    }
    
}


// 消息的设置
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell isMemberOfClass:[RCTextMessageCell class]]) {
        
        RCTextMessageCell *textMEssageCell = (RCTextMessageCell *)cell;
        UILabel *textMsgLabel = (UILabel *)textMEssageCell.textLabel;
        textMsgLabel.textColor = [UIColor redColor];
        
    }
    
}

@end
