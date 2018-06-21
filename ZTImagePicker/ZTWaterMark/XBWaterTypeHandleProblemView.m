//
//  XBWaterTypeHandleProblemView.m
//  Fieldworks
//
//  Created by ZT0526 on 2017/4/21.
//  Copyright © 2017年 小步创想. All rights reserved.
//

#import "XBWaterTypeHandleProblemView.h"
#import "NSDate+FWAddition.h"

#define Uwidth   [[UIScreen mainScreen] bounds].size.width
#define KScreen  Uwidth/320

@interface XBWaterTypeHandleProblemView ()

@property (nonatomic , assign) CGFloat  vertcalSpace;

@end

@implementation XBWaterTypeHandleProblemView

- (instancetype)init{
    if(self = [super init]){
        [self p_config];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self p_config];
    }
    
    return self;
}


- (void)p_config{
    // 拍摄人
    [self userLb];
    // 拍摄时间
    [self timeLb];
    // 定位图标
    [self locationIcon];
    // 拍摄地址
    [self locationLb];
    // 拍摄动作
    [self actionLb];
    
    // 设置间隔
    self.vertcalSpace = 10;
}

- (void)setProblemModel:(XBWaterMarkHandleProblemModel *)problemModel
{
    _problemModel = problemModel;
    _userLb.text = [NSString stringWithFormat:@"%@",_problemModel.userName];
    _timeLb.text = [NSString stringWithFormat:@"拍摄时间：%@",_problemModel.date.timeStringUsedToMark];
    _locationLb.text = _problemModel.address;
    _actionLb.text = _problemModel.action;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height;
    height = self.height;
    
    [self.userLb sizeToFit];
    self.userLb.frame = CGRectMake(10, height - 140, self.width-30, 30);
    
    self.timeLb.frame = CGRectMake(10, height-110, self.userLb.width, 30);
    
    self.locationIcon.frame = CGRectMake(10, height - 80+9, 12, 12);
    [self.locationLb sizeToFit];
    self.locationLb.frame = CGRectMake(25, height - 80 , self.userLb.width, 30);
    
    
    self.actionLb.frame = CGRectMake(10, height - 50, self.userLb.width, 30);

}

#pragma mark setters && getters

- (UILabel *)userLb{
    if(!_userLb){
        _userLb = [UILabel new];
        _userLb.textColor = [UIColor whiteColor];
        _userLb.font = [UIFont systemFontOfSize:14*KScreen];
        _userLb.numberOfLines = 0;
        [self addSubview:_userLb];
    }
    return _userLb;
}

- (UIImageView *)locationIcon{
    if(!_locationIcon){
        _locationIcon = [[UIImageView alloc] init];
        _locationIcon.image = [UIImage imageNamed:@"address"];
        [self addSubview:_locationIcon];
    }
    return _locationIcon;
}


- (UILabel *)locationLb{
    if(!_locationLb){
        _locationLb = [UILabel new];
        _locationLb.numberOfLines = 0;
        _locationLb.textColor = [UIColor whiteColor];
        _locationLb.font = [UIFont systemFontOfSize:14*KScreen];
        [self addSubview:_locationLb];
    }
    
    return _locationLb;
}

- (UILabel *)timeLb
{
    if (!_timeLb) {
        _timeLb = [UILabel new];
        _timeLb.numberOfLines = 0;
        _timeLb.textColor = [UIColor whiteColor];
        _timeLb.font = [UIFont systemFontOfSize:14*KScreen];
        [self addSubview:_timeLb];
    }
    return _timeLb;
}

- (UILabel *)actionLb
{
    if (!_actionLb) {
        _actionLb = [UILabel new];
        _actionLb.numberOfLines = 0;
        _actionLb.textColor = [UIColor whiteColor];
        _actionLb.font = [UIFont systemFontOfSize:14*KScreen];
        [self addSubview:_actionLb];
    }
    return _actionLb;
}

@end
