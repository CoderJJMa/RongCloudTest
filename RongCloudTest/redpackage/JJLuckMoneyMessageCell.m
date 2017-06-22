//
//  JJLuckMoneyMessageCell.m
//  RongCloudTest
//
//  Created by majianjie on 2017/6/20.
//  Copyright © 2017年 majianjie. All rights reserved.
//  您的控件需要添加在 messageContentView 上，根据您自己的需求在画cell视图布局的时候调整 messageContentView 的 frame ，如果是接收方，您只需要修改 messageContentView 的 width 和 height，如果是发送方，您需要修改 messageContentView 的 x ， width 和 height



#import "JJLuckMoneyMessageCell.h"
#import "Masonry.h"
#import "JJLuckMoneyMessage.h"
#import "JJRecalMessage.h"

@interface JJLuckMoneyMessageCell()<RCMessageCellDelegate>


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
        
        _defaultSize = CGSizeMake(200, 60);
        [self commontInit];
        
    }
    
    return self;
    
}

- (void)commontInit{
    
    __weak typeof(&*self) weakSelf = self;
    
    self.delegate = self;
    
    // Frame发生变化的回调
    [self.messageContentView setEventBlock:^(CGRect rect){
        
        if (!CGSizeEqualToSize(rect.size, weakSelf.defaultSize)) { return ;}
        if (!weakSelf.model) { return ;}
        
        BOOL isOutgoing = weakSelf.model.messageDirection == MessageDirection_SEND;
        
        CGRect newRect = CGRectMake(isOutgoing ? 0 : 5 , 0, rect.size.width - 5, rect.size.height);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5];
        
        [path moveToPoint:CGPointMake(isOutgoing ? rect.size.width - 5 : 5 , 10)];
        
        [path addLineToPoint:CGPointMake(isOutgoing ? rect.size.width : 0, 14)];
        
        [path addLineToPoint:CGPointMake(isOutgoing ? rect.size.width - 5 : 5, 18)];
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        
        weakSelf.messageContentView.layer.mask = layer;
        
    }];
    
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView = bottomView;

    [self.messageContentView addSubview:bottomView];
    

    
    UILabel *descLabel = [UILabel new];
    [descLabel setFont:[UIFont systemFontOfSize:12]];
    [descLabel setTextColor:[UIColor darkGrayColor]];
    [descLabel setTextAlignment:NSTextAlignmentLeft];
    [bottomView addSubview:descLabel];
    
    self.descLabel = descLabel;
    
    
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        
    }];
    
    
    UILabel *amountLabel = [UILabel new];
    [amountLabel setFont:[UIFont systemFontOfSize:30]];
    [amountLabel setTextColor:[UIColor whiteColor]];
    [amountLabel setTextAlignment:NSTextAlignmentLeft];
    [self.messageContentView addSubview:amountLabel];
    
    self.amountLabel = amountLabel;

    
    [self.messageContentView setBackgroundColor:[UIColor orangeColor]];
    
    //点击红包
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapMessageContentView:)];
    [self.messageContentView addGestureRecognizer:tap];
    
    
}

// 点击红包时候
- (void)onTapMessageContentView:(UITapGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self didTapMessageCell:self.model];
    }
    
}

- (void)setDataModel:(RCMessageModel *)model{
    
    [super setDataModel:model];
    
    CGRect frame = self.messageContentView.frame;
    frame.size = self.defaultSize;
    JJLuckMoneyMessage *m = (JJLuckMoneyMessage *)model.content;
    self.descLabel.text = m.desc;
    
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
    [nf setNumberStyle:NSNumberFormatterCurrencyAccountingStyle];
    [nf setMinimumFractionDigits:2];
    
    self.amountLabel.text = [nf stringFromNumber:@(m.amount)];
    
}


- (void)updateConstraints{

    
    BOOL isOutgonig = self.model.messageDirection == MessageDirection_SEND;
    //更新bottoview的位置
    CGFloat w = 0;
    
    CGSize dSize = CGSizeMake(self.defaultSize.width - w , 34);
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(dSize);
        make.bottom.mas_equalTo(0);
        make.left.mas_offset(isOutgonig ? 0 : w);
        
    }];
    
    [self.amountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(isOutgonig ? 10 : 15);
        
    }];
    
    [super updateConstraints];
}

//- (void)setConversationVC:(ChatTestViewController *)conversationVC{
//    
//    _conversationVC = conversationVC;
//    
//}

/*!
 自定义消息Cell的Size
 
 @param model               要显示的消息model
 @param collectionViewWidth cell所在的collectionView的宽度
 @param extraHeight         cell内容区域之外的高度
 
 @return 自定义消息Cell的Size
 
 @discussion 当应用自定义消息时，必须实现该方法来返回cell的Size。
 其中，extraHeight是Cell根据界面上下文，需要额外显示的高度（比如时间、用户名的高度等）。
 一般而言，Cell的高度应该是内容显示的高度再加上extraHeight的高度。
 */
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight{
    
    RCMessageModel *m = model;
    
    if ([m.objectName isEqualToString:[JJLuckMoneyMessage getObjectName]]) {
        
        CGFloat h = 110 + (m.isDisplayNickname ? 20 : 0) + (m.isDisplayMessageTime ? 20 : 0);
        
        return CGSizeMake(collectionViewWidth, h);
        
    }else if ([m.objectName isEqualToString:[JJRecalMessage getObjectName]]){
        
        return CGSizeMake(collectionViewWidth, 40 + (m.isDisplayMessageTime ? 20 : 0));
        
    }else{
        
//        return [self rcUnkownConversationCollectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
        
        return [self sizeForMessageModel:model withCollectionViewWidth:collectionViewWidth referenceExtraHeight:extraHeight];
        
    }
    
}

- (void)didTapMessageCell:(RCMessageModel *)model{
    
    if ([model.content isKindOfClass:[JJLuckMoneyMessage class]]) {
    
        JJLuckMoneyMessage *luckModel = (JJLuckMoneyMessage *)model.content;
        NSLog(@"红包价格是: %f   描述是 : %@",luckModel.amount,luckModel.desc);
        
    }
    
    

    
}


@end
