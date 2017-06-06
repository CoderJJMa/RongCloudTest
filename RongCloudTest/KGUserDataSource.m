//
//  KGUserDataSource.m
//  RongCloudDemo
//
//  Created by majianjie on 2017/6/3.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "KGUserDataSource.h"

@interface KGUserDataSource()

@property (nonatomic,strong)RCUserInfo *jack;
@property (nonatomic,strong)RCUserInfo *john;


@end

@implementation KGUserDataSource


- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    
    if ([[userId lowercaseString] isEqualToString:@"jack"]) {
        
        completion(self.jack);
        
    }else{
        completion(self.john);
    }
    
}

- (RCUserInfo *)jack{
    
    if (!_jack) {
        _jack = [[RCUserInfo alloc] initWithUserId:@"jack" name:@"jack" portrait:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496472966346&di=1ac9aa95f6005627c7f4f8c6ff40c328&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D4171236613%2C688580759%26fm%3D214%26gp%3D0.jpg"];
    }
    return _jack;
}

- (RCUserInfo *)john{
    
    
    if (!_john) {
        _john = [[RCUserInfo alloc] initWithUserId:@"john" name:@"john" portrait:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496473055560&di=ddd1b1aa50419f6bcd19b107d250aed8&imgtype=0&src=http%3A%2F%2Fpic.baike.soso.com%2Fp%2F20130821%2F20130821212731-1854277405.jpg"];
    }
    return _john;
    
}

@end
