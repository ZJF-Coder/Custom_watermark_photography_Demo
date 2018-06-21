//
//  XBWaterMarkModel.h
//  Fieldworks
//
//  Created by ZT0526 on 2017/4/24.
//  Copyright © 2017年 小步创想. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBWaterMarkHandleProblemModel : NSObject

@property (nonatomic, copy)   NSString  *userName;      // 拍摄用户名
@property (nonatomic, copy)   NSString  *address;       // 拍摄地址
@property (nonatomic, strong) NSDate    *date;          // 拍摄日期
@property (nonatomic, copy)   NSString  *action;        // 拍摄动作

@end


