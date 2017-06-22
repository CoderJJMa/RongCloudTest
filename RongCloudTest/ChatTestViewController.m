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
#import <BQMM/BQMM.h>
#import "FastReplyVC.h"
#import "CHAvatarBrowser.h"

@interface ChatTestViewController ()<RCConnectionStatusChangeDelegate>

@property (nonatomic,strong)RCMessageModel *messageModel;

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
    
 
    [self config];
    
}

- (void)config{
    
    
    self.enableNewComingMessageIcon = YES;
    
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    [MMEmotionCentre defaultCentre].delegate = _inputToolBar; //set SDK delegate
    [[MMEmotionCentre defaultCentre] shouldShowShotcutPopoverAboveView:_inputToolBar.emojiButton withInput:_inputToolBar.inputTextView];
    
    //设置聊天背景
    //    self.conversationMessageCollectionView.backgroundColor = [UIColor clearColor];
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dlrb"]];
    
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"redpackage"] title:@"红包" tag:2000];
    // 注册自定义的cell
    [self registerClass:[JJLuckMoneyMessageCell class] forMessageClass:[JJLuckMoneyMessage class]];
    
    [self registerClass:[JJRecalMessageCell class] forMessageClass:[JJRecalMessage class]];
    
    [self.conversationMessageCollectionView registerClass:[JJLuckMoneyMessageCell class] forCellWithReuseIdentifier:NSStringFromClass([JJLuckMoneyMessageCell class])];
    [self.conversationMessageCollectionView registerClass:[JJRecalMessageCell class] forCellWithReuseIdentifier:NSStringFromClass([JJRecalMessageCell class])];

    
     // 开启该提示功能之后，当一个会话收到大量消息时（操作一个屏幕能显示的内容），进入该会话后，会在右上角提示用户上方存在的未读消息数，用户点击该提醒按钮，会跳转到最开始的未读消息
    self.enableUnreadMessageIcon = YES;
    
    // 撤回
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    // 导航栏显示正在输入状态
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
}


- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    
    if (tag == 2000) {
        
//        获取一个随机数范围在：[500,1000），包括500，包括1000
        
        double amout = (arc4random() % 150) + 50;
        
        [[RCIM sharedRCIM] sendMessage:self.conversationType targetId:self.targetId content:[[JJLuckMoneyMessage alloc] initWith:amout description:@"工作顺利"] pushContent:@"锁屏收到的信息" pushData:@"{\"cid\":12345678}" success:^(long messageId) {
            
        } error:^(RCErrorCode nErrorCode, long messageId) {
            
        }];
        
        NSLog(@"click redpackage");
        
    }else{
        [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    }
    
}

// 点击消息
- (void)didTapMessageCell:(RCMessageModel *)model{
    
    [super didTapMessageCell:model];
    
    if ([model.content isKindOfClass:[RCTextMessage class]]) {
        
        RCTextMessage *text = (RCTextMessage *)model.content;
        
        NSLog(@"点击消息  %@",text.content);
        
    }
    
}
// 长按消息
- (void)didLongTouchMessageCell:(RCMessageModel *)model
                         inView:(UIView *)view{

    [super didLongTouchMessageCell:model inView:view];
    
    if ([model.content isKindOfClass:[RCTextMessage class]]) {
        
        RCTextMessage *text = (RCTextMessage *)model.content;
        self.messageModel = model;
        NSLog(@"长按消息  %@",text.content);
        UIMenuController * menu = [UIMenuController sharedMenuController];
      
        UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyContent)];
        UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(deleteContent)];
        UIMenuItem * item2 = [[UIMenuItem alloc]initWithTitle:@"添加快速回复" action:@selector(longPressContent)];
        menu.menuItems = @[item0,item1,item2];
                
        [menu setMenuVisible:YES animated:YES];
    }
    
    
}

// 点击头像的回调
- (void)didTapCellPortrait:(NSString *)userId{

    if([[RCIM sharedRCIM].currentUserInfo.userId isEqualToString:userId]){
        return;
    }
    
    NSLog(@"点击头像的 Id  是 : %@",userId);
    
}

- (void)presentImagePreviewController:(RCMessageModel *)model{
    
//    [super presentImagePreviewController:model];
    
    if ([model.content isKindOfClass:[RCImageMessage class]]) {
    
        RCImageMessage *imageMess = (RCImageMessage *)model.content;
        
//        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageMess.imageUrl]];
        NSData *data =[NSData dataWithContentsOfFile:imageMess.imageUrl];
        UIImage *image = [[UIImage alloc] initWithData:data];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [CHAvatarBrowser showImage:imageView];//调用方法
        
    }
    

    
}


- (void)copyContent{

    if ([self.messageModel.content isKindOfClass:[RCTextMessage class]]) {
    
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];

        RCTextMessage *text = (RCTextMessage *)self.messageModel.content;
        pasteboard.string = text.content;
        
    }
    
}

- (void)deleteContent{

    [self deleteMessage:self.messageModel];
    
}


- (void)longPressContent{

    FastReplyVC *vc = [[FastReplyVC alloc] init];
    vc.title = @"快速回复";
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}


// 捕获消息内容
- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageCotent{
    
    //在此监听发送消息，返回nil则取消发送
    
        if ([messageCotent isKindOfClass:[RCImageMessage class]]) {
            
            [self.chatSessionInputBarControl.inputTextView resignFirstResponder];
            NSLog(@" 发送的图片是  %@",messageCotent);
            
        }else if([messageCotent isKindOfClass:[RCTextMessage class]]){
            
            RCTextMessage *text = (RCTextMessage *)messageCotent;
            NSLog(@" 发送的文字是:  %@",text.content);
            
        }else {
            
            [self.chatSessionInputBarControl.inputTextView resignFirstResponder];

            
        }
    
    return [super willSendMessage:messageCotent];
    
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

//废弃
/*
 // cell 的内容
 //- (RCMessageBaseCell *)rcConversationCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 //
 //
 //    RCMessageModel *m = self.conversationDataRepository[indexPath.item];
 //    if ([m.objectName isEqualToString:[JJLuckMoneyMessage getObjectName]]) {
 //
 //        JJLuckMoneyMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[JJLuckMoneyMessageCell identifier] forIndexPath:indexPath];
 //
 //        [cell setDataModel:m];
 //        cell.conversationVC = self;
 //        return cell;
 //
 //    } else if([m.objectName isEqualToString:[JJRecalMessage getObjectName]]) {
 //
 //
 //        JJRecalMessageCell *cell = [[JJRecalMessageCell alloc] init];
 //        return cell;
 //
 //    }else{
 //
 //        return [self rcUnkownConversationCollectionView:collectionView cellForItemAtIndexPath:indexPath];
 //    }
 //
 //}
 
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
 
 
 //- (void)didTapMessageCell:(RCMessageModel *)model{
 //
 //    NSLog(@"%@",model);
 //    [super didTapMessageCell:model];
 //
 //}
 */
