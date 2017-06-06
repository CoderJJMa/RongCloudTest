//
//  ViewController.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/5.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "ViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "KGConversationListVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



- (IBAction)jackAction:(id)sender {
    
    
    // jack   zTqG4tuECwwNZNzQAg6vDSb5NDtUcwko6Dg8ItLlzZF9p/sxAmbqAj1FeCQ1LsDp1gOFHHIWkA/xCWT+QLCgKQ==
    
    
    [[RCIM sharedRCIM] connectWithToken:@"zTqG4tuECwwNZNzQAg6vDSb5NDtUcwko6Dg8ItLlzZF9p/sxAmbqAj1FeCQ1LsDp1gOFHHIWkA/xCWT+QLCgKQ==" success:^(NSString *userId) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            KGConversationListVC *vc = [[KGConversationListVC alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];

            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = nav;
            
            
        });
        
        
        
    } error:^(RCConnectErrorCode status) {
        
        
    } tokenIncorrect:^{
        
        NSLog(@"[Error] tokenincorrect");
        
    }];
    
}

- (IBAction)johnAction:(id)sender {
    
    // john

    
    [[RCIM sharedRCIM] connectWithToken:@"9GMnw9RDHP7qQ/0SNrl/PCb5NDtUcwko6Dg8ItLlzZF9p/sxAmbqAoGY6kRFRMHQv+rZ3OA2ic8ODro5juzvMw==" success:^(NSString *userId) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            KGConversationListVC *vc = [[KGConversationListVC alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = nav;
            
            
        });
        
        
        
    } error:^(RCConnectErrorCode status) {
        
        
    } tokenIncorrect:^{
        
        NSLog(@"[Error] tokenincorrect");
        
    }];
}


@end
