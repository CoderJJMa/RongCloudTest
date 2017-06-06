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

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //设置聊天背景
//    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dlrb"]];
    
    
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
