//
//  JJLuckMoneyMessageCell.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/20.
//  Copyright © 2017年 majianjie. All rights reserved.
//

#import "JJLuckMoneyMessageCell.h"

@interface JJLuckMoneyMessageCell()


@property (nonatomic,assign) CGSize defaultSize;

@property (nonatomic,weak) UILabel *descLabel;

@property (nonatomic,weak) UIView *bottomView;

@property (nonatomic,weak) UILabel *amountLabel;

@end

@implementation JJLuckMoneyMessageCell




+ (NSString *)identifier{
    return NSStringFromClass([self class]);
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _defaultSize = CGSizeMake(200, 90);
        [self commontInit];
        
    }
    
    return self;
    
}

- (void)commontInit{
    
    __weak typeof(&*self) weakSelf = self;
    
    [self.messageContentView setEventBlock:^(CGRect rect){
        
        if (!CGSizeEqualToSize(rect.size, weakSelf.defaultSize)) { return ;}
        if (!weakSelf.model) { return ;}
        
        BOOL isOutgoing = weakSelf.model.messageDirection == MessageDirection_SEND;
        CGRect newRect = CGRectMake(isOutgoing ? 0 : 5 , 0, rect.size.width - 5, rect.size.height);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:newRect];
        
        [path moveToPoint:CGPointMake(isOutgoing ? rect.size.width - 5 : 5 , 10)];
        
        [path addLineToPoint:CGPointMake(isOutgoing ? rect.size.width : 0, 14)];
        
        [path addLineToPoint:CGPointMake(isOutgoing ? rect.size.width - 5 : 5, 18)];
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        
        
    }];
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UILabel *descLabel = [UILabel new];
    [descLabel setFont:[UIFont systemFontOfSize:12]];
    [descLabel setTextColor:[UIColor darkGrayColor]];
    [descLabel setTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:descLabel];
    
    self.descLabel = descLabel;
    
    
    
}


- (void)updateConstraints{

    
    BOOL isOutgonig = self.model.messageDirection == MessageDirection_SEND;
    //更新bottoview的位置
    CGSize dSize = CGSizeMake(self.defaultSize.width - 5 , 34);
    
    
    
    
    [super updateConstraints];
}


@end
