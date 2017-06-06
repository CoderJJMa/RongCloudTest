//
//  AppDelegate.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/5.
//  Copyright © 2017年 majianjie. All rights reserved.
//


//官方文档:  http://www.rongcloud.cn/docs/ios.html#message_customize

#import "AppDelegate.h"
#import "KGConversationListVC.h"
#import <RongIMKit/RongIMKit.h>
#import "KGUserDataSource.h"

@interface AppDelegate ()


@property (nonatomic,strong)KGUserDataSource *dataSource;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[RCIM sharedRCIM] initWithAppKey:@"0vnjpoad0cpbz"];

    
    _dataSource = [[KGUserDataSource alloc] init];
    
    [[RCIM sharedRCIM] setUserInfoDataSource:_dataSource];
  
    // john   9GMnw9RDHP7qQ/0SNrl/PCb5NDtUcwko6Dg8ItLlzZF9p/sxAmbqAoGY6kRFRMHQv+rZ3OA2ic8ODro5juzvMw==
    
    // jack   zTqG4tuECwwNZNzQAg6vDSb5NDtUcwko6Dg8ItLlzZF9p/sxAmbqAj1FeCQ1LsDp1gOFHHIWkA/xCWT+QLCgKQ==
    
    
    [[RCIM sharedRCIM] connectWithToken:@"9GMnw9RDHP7qQ/0SNrl/PCb5NDtUcwko6Dg8ItLlzZF9p/sxAmbqAoGY6kRFRMHQv+rZ3OA2ic8ODro5juzvMw==" success:^(NSString *userId) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            KGConversationListVC *vc = [[KGConversationListVC alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            self.window.rootViewController = nav;
            
        });
        
        
        
    } error:^(RCConnectErrorCode status) {
        
        
    } tokenIncorrect:^{
        
        NSLog(@"[Error] tokenincorrect");
        
    }];
    
    
    return YES;
}




@end
