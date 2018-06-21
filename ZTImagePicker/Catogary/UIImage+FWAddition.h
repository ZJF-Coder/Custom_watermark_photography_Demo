//
//  UIImage+FWAddition.h
//  Fieldworks
//
//  Created by ZT0526 on 2017/4/21.
//  Copyright © 2017年 小步创想. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTLocationModel.h"
#import "NSFileManager+XIMAddition.h"

#import "XBWatermarkScrollView.h"

#define FW_BUTTON_SHADOW_OFFSET 4.0

@interface UIImage (FWAddition)

+ (instancetype)separatorImage;

+ (instancetype)resizableRoundButtonImage;
+ (instancetype)resizableRoundButtonImageHighlighted;

+ (instancetype)resizableLeftButtonImage;
+ (instancetype)resizableLeftButtonImageHighlighted;

+ (instancetype)resizableRightButtonImage;
+ (instancetype)resizableRightButtonImageHighlighted;

+ (instancetype)resizableFormCellTopImage;
+ (instancetype)resizableFormCellMiddleImage;
+ (instancetype)resizableFormCellBottomImage;
+ (instancetype)resizableFormCellSingleImage;

+ (instancetype)thumbnailAvatarPlaceholder;

- (UIImage *)thumbnailWithSize:(CGSize)asize ;
- (UIImage *)getImageFromRect:(CGRect)rect ;

// 存储图片
- (UIImage *)markedImageWithType:(XBWaterMark )waterMarkType date:(NSDate *)date user:(NSString *)user addressString:(NSString *)addressString actionString:(NSString *)actionString placLocation:(ZTLocationModel *)locationModel withPhone:(NSString *)phone xmType:(NSString *)xmType;

- (UIImage *)markedImageWithText:(NSString *)text;


- (UIImage *)imageMaskWithColor:(UIColor *)maskColor;

+ (NSString*)alarmPhotoPath;
+ (NSString*)tempPhotoPath;
+ (void)deleteAlarmPhotoAlbum;
- (void)saveImageToAlarmPhotoAlbum;
- (void)saveImageToCache:(NSString *)time;
- (void)saveImageToAlarmPhotoAlbumWithQuality:(CGFloat)quality;
+ (UIImage *)imageFromColor:(UIColor *)color;

@end
