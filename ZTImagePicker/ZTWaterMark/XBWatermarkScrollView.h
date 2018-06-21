//
//  XBWatermarkScrollView.h
//  Fieldworks
//
//  Created by ZT0526 on 2017/4/21.
//  Copyright © 2017年 小步创想. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBWaterTypeWorkReportView.h"
#import "XBWaterTypeHandleProblemView.h"
#import "UIView+Category.h"
typedef NS_ENUM(NSUInteger, XBWaterMark) {
    XBWaterMarkDefault = 0,
    XBWaterMarkDepartMent = 1,
};

@protocol XBWatermarkScrollViewDlegate <NSObject>

- (void)waterMarkFixed;
- (void)waterMarkUnFixed;

@end

@interface XBWatermarkScrollView : UIScrollView

//@property (nonatomic , weak) id<XBWatermarkScrollViewDlegate> waterDelegate;

@property (nonatomic , strong) XBWaterTypeWorkReportView *reportView;

@property (nonatomic , strong) XBWaterTypeHandleProblemView *handleProblemView;

@property (nonatomic , strong) NSString   *xmReportType;

@property (nonatomic, copy) NSString *deFaultPlacemark;
@property (nonatomic, copy) NSString *departMentPlacemark;

@property (nonatomic, assign) XBWaterMark waterMarkType;

- (void)setDefaultPlacemark:(NSString *)placemark departMentplaceMark:(NSString *)departMentplaceMark andUserNameString:(NSString *)userNameString andAddressString:(NSString *)addressString andActionString:(NSString *)actionString;

@end
