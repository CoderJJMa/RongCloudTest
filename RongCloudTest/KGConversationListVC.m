//
//  KGConversationListVC.m
//  RongCloudDemo
//
//  Created by majianjie on 2017/6/2.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "KGConversationListVC.h"
#import <RongIMKit/RongIMKit.h>
#import "ViewController.h"
#import "ChatTestViewController.h"

@interface KGConversationListVC ()

@end

@implementation KGConversationListVC

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
//        [self setCollectionConversationType:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];// 加上这句 下面 selected 时候 就得单独处理
        
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
    
}

//cell将要显示时候, 可以修改 cell上的字体颜色之类的内容
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    
    if (model.conversationType == ConversationType_PRIVATE) {
        
        RCConversationCell *conversationCell = (RCConversationCell *)cell;
        conversationCell.conversationTitle.textColor = [UIColor redColor];
        
    }
    
    
}

- (void)setupUI{
    
    
    self.cellBackgroundColor = [UIColor yellowColor];
    self.conversationListTableView.tableFooterView = [UIView new];
    
    self.showConnectingStatusOnNavigatorBar = YES;
    
    self.isShowNetworkIndicatorView = YES;
 
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    
    self.navigationItem.leftBarButtonItem = left;

    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup)];
                               
    self.navigationItem.rightBarButtonItem = right;
    
    
}



- (void)addGroup{
    
//    - (void)createDiscussion:(NSString *)name
//userIdList:(NSArray *)userIdList
//success:(void (^)(RCDiscussion *discussion))successBlock
//error:(void (^)(RCErrorCode status))errorBlock;

    
    [[RCIMClient sharedRCIMClient] createDiscussion:@"讨论组1" userIdList:@[@"jack",@"john"] success:^(RCDiscussion *discussion) {
       
        NSLog(@"成功创建  %@  讨论组",discussion.discussionName);
        NSLog(@"%@",discussion.discussionId);
        NSLog(@"%@",discussion.discussionId);

        
    } error:^(RCErrorCode status) {
        
    }];
    
/*
    NSString *targetId = @"jack";
 
    if ([[[RCIMClient sharedRCIMClient] currentUserInfo].userId isEqualToString:targetId]) {
        
        targetId = @"john";
        
    }
    
    RCConversationViewController *vc = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetId];
    vc.title = targetId;
    vc.targetId = targetId;
    [self.navigationController pushViewController:vc animated:YES];
    
 */
}

- (void)logout{
    
    [[RCIM sharedRCIM] logout];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"com.dingding.rongclouddemo"];
    

    UIStoryboard *sto = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *nav = [sto instantiateViewControllerWithIdentifier:@"ViewController"];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = nav;
    
}

- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    
    if(conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION){
        
        KGConversationListVC *temp = [[KGConversationListVC alloc] init];
        NSArray *array = [NSArray arrayWithObject:[NSNumber numberWithInt:model.conversationType]];
        
        [temp setDisplayConversationTypeArray:array];
        [temp setCollectionConversationType:nil];
        
        temp.isEnteredToCollectionViewController = YES;
        
        [self.navigationController pushViewController:temp animated:YES];
        
    }else if(conversationModelType == ConversationType_PRIVATE){
        
        ChatTestViewController *vc = [[ChatTestViewController alloc] init];;
        
        vc.conversationType = model.conversationType;
        vc.targetId = model.targetId;
        vc.title = model.targetId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

- (void)didTapCellPortrait:(RCConversationModel *)model{
    
    
    
}


@end
