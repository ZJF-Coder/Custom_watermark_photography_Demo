//
//  XBWaterTypeHandleProblemView.h
//  Fieldworks
//
//  Created by ZT0526 on 2017/4/21.
//  Copyright © 2017年 小步创想. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBWaterMarkHandleProblemModel.h"
#import "UIView+Category.h"

@interface XBWaterTypeHandleProblemView : UIView

@property (nonatomic, strong) XBWaterMarkHandleProblemModel *problemModel;

@property (nonatomic , strong) UILabel      *userLb;        // 拍摄人
@property (nonatomic , strong) UIImageView  *locationIcon;  // 地理位置图标
@property (nonatomic , strong) UILabel      *locationLb;    // 地理位置文本
@property (nonatomic , strong) UILabel      *timeLb;        // 拍摄时间
@property (nonatomic , strong) UILabel      *actionLb;      // 拍摄动作


@end
