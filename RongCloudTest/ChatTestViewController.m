//
//  ChatTestViewController.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/5.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "ChatTestViewController.h"
#import "JJLuckMoneyMessageCell.h"
#import "JJLuckMoneyMessage.h"
#import "JJRecalMessage.h"
#import "JJRecalMessageCell.h"

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
    [self registerClass:[JJLuckMoneyMessageCell class] forMessageClass:[JJLuckMoneyMessage class]];
    
    [self registerClass:[JJRecalMessageCell class] forMessageClass:[JJRecalMessage class]];

    [self.conversationMessageCollectionView registerClass:[JJLuckMoneyMessageCell class] forCellWithReuseIdentifier:NSStringFromClass([JJLuckMoneyMessageCell class])];
    [self.conversationMessageCollectionView registerClass:[JJRecalMessageCell class] forCellWithReuseIdentifier:NSStringFromClass([JJRecalMessageCell class])];

    
}


- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    
    if (tag == 2000) {
        
        [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content:[[JJLuckMoneyMessage alloc] initWith:200 description:@"工作顺利"] pushContent:@"锁屏收到的信息" pushData:@"{\"cid\":12345678}" success:^(long messageId) {
            
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

// cell 的内容
- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RCMessageModel *m = self.conversationDataRepository[indexPath.item];
    if ([m.objectName isEqualToString:[JJLuckMoneyMessage getObjectName]]) {
        
        JJLuckMoneyMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[JJLuckMoneyMessageCell identifier] forIndexPath:indexPath];
        
        [cell setDataModel:m];
        cell.conversationVC = self;
        return cell;
        
    } else if([m.objectName isEqualToString:[JJRecalMessage getObjectName]]) {
    
        
        JJRecalMessageCell *cell = [[JJRecalMessageCell alloc] init];
        return cell;
    
    }else{
    
        return [self rcUnkownConversationCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    
}

//// cell的高度
//- (CGSize)rcConversationCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    RCMessageModel *m = self.conversationDataRepository[indexPath.item];
//    
//    if ([m.objectName isEqualToString:[JJLuckMoneyMessage getObjectName]]) {
//        
//        CGFloat h = 110 + (m.isDisplayNickname ? 20 : 0) + (m.isDisplayMessageTime ? 20 : 0);
//        
//        return CGSizeMake(collectionView.frame.size.width, h);
//        
//    }else if ([m.objectName isEqualToString:[JJRecalMessage getObjectName]]){
//        
//        return CGSizeMake(collectionView.frame.size.width, 40 + (m.isDisplayMessageTime ? 20 : 0));
//    
//      }else{
//      
//          return [self rcUnkownConversationCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
//          
//      }
//    
//}


- (void)didTapMessageCell:(RCMessageModel *)model{
    
    NSLog(@"%@",model);
    [super didTapMessageCell:model];

}


@end
