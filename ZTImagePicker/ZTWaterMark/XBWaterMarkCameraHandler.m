//
//  XBCameraHandler.m
//  Fieldworks
//
//  Created by Ethan on 15/11/23.
//  Copyright © 2015年 小步创想. All rights reserved.
//

#import "XBWaterMarkCameraHandler.h"



#import "UIImage+FWAddition.h"


#import "ZTImagePickerController.h"
#import "UIImage+XIMAddition.h"
#import "UIImage+FWAddition.h"

#import <MapKit/MapKit.h>
#import "NSObject+Extension.h"
#import "ZTShowImageController.h"
#import "XBWatermarkScrollView.h"

@interface XBWaterMarkCameraHandler() <UINavigationControllerDelegate,ZTImagePickerControllerDelegate,CLLocationManagerDelegate>

@property (nonatomic, weak) UIViewController *viewcontroller;
@property (nonatomic,copy) NSString *userNameString;
@property (nonatomic,copy) NSString *actionString;
@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, copy) CameraFinishBlock finishBlock;
@property (nonatomic, copy) void(^cancelBlock)(void);


@property (nonatomic, copy) ZTLocationModel *locationModel;
@property (nonatomic, assign) BOOL cameraShowed;


@property (strong,nonatomic) CLLocationManager* locationManager;

@end

@implementation XBWaterMarkCameraHandler
{
    NSString *_address; //记录的地址
}


+ (instancetype)sharedHandler {
    static dispatch_once_t once;
    static XBWaterMarkCameraHandler *handler;
    dispatch_once(&once, ^{
        handler = [[XBWaterMarkCameraHandler alloc] init];
    });
    handler.cameraShowed = NO;
    return handler;
}


- (NSString *)placemark {
    return _locationModel.placemark.length ? _locationModel.placemark : @"地理位置获取失败";
}

- (void)showCameraPickerInController:(UIViewController*)viewcontroller withUserName:(NSString *)userName withAction:(NSString *)actionString finishBlock:(CameraFinishBlock)block {
    [self showCameraPickerInController:viewcontroller withUserName:userName withAction:actionString finishBlock:block cancelBlock:nil];
}

- (void)showCameraPickerInController:(UIViewController*)viewcontroller withUserName:(NSString *)userName withAction:(NSString *)actionString finishBlock:(CameraFinishBlock)block cancelBlock:(void (^)(void))cancelBlock {
    
    self.cameraShowed = YES;
    _userNameString = userName;
    _actionString = actionString;
    self.viewcontroller = viewcontroller;
    self.index = 0;
    self.finishBlock = block;
    self.cancelBlock = cancelBlock;
    
    //开始定位
    [self startLocation];
    
}

- (BOOL)cameraAuthorized
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
//            NSArray *items;
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"需要访问您的相机。\n请启用设置-隐私-相机" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alert show];
            return NO;
        }
    }
    return YES;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
//    NSLog(@"asd");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.tag = 1209;
    [[UIApplication sharedApplication].delegate.window addSubview:view];
//    [UIHelper showHUDAddedTo:view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [[[info objectForKey:UIImagePickerControllerOriginalImage] orientationFixedImage] thumbnailForMaxWidth:1024/[UIScreen mainScreen].scale maxHeight:1024/[UIScreen mainScreen].scale];
        if (self.finishBlock) {
            if([picker isKindOfClass:[XBImagePickerController class]])
                self.finishBlock(image, _actionString,self.locationModel, self.index, ((XBImagePickerController *)picker).waterMarkType,((XBImagePickerController *)picker).scrollView.xmReportType);
            else
                self.finishBlock(image, _actionString,self.locationModel, self.index, XBWaterMarkDefault , nil);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:NO completion:^{
                [self performSelector:@selector(showCameraWithView:) withObject:view afterDelay:0.2f];
            }];
        });
        
    });
}

#pragma mark ZTImagePickerDelegate

- (void)backWithImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ZTShowImageController *photoVC = [[ZTShowImageController alloc] init];
        photoVC.image = image;
        
        UIViewController *currentVc = [NSObject getTopViewController];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:photoVC];
        [currentVc presentViewController:navi animated:NO completion:nil];
    });
}

- (void)imagePickerControllerUseImage:(ZTImagePickerController *)picker image:(UIImage *)image{
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.tag = 1209;
    [[UIApplication sharedApplication].delegate.window addSubview:view];
    //[UIHelper showHUDAddedTo:view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image2 = [[image orientationFixedImage] thumbnailForMaxWidth:1024/[UIScreen mainScreen].scale maxHeight:1024/[UIScreen mainScreen].scale];
        if (self.finishBlock) {
            if([picker isKindOfClass:[XBImagePickerController class]])
                self.finishBlock(image2,_actionString, self.locationModel, self.index, ((XBImagePickerController *)picker).waterMarkType,((XBImagePickerController *)picker).scrollView.xmReportType);
            else
                self.finishBlock(image2,_actionString, self.locationModel, self.index, XBWaterMarkDefault , nil);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:NO completion:^{
                [self performSelector:@selector(showCameraWithView:) withObject:view afterDelay:0.2f];
            }];
        });
        
    });

}

- (void)imagePickerControllerDidCancel:(ZTImagePickerController *)picker{
   
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)showCameraWithView:(UIView*)view {
    self.index++;
    
    XBImagePickerController *newPicker = [[XBImagePickerController alloc] init];
    newPicker.waterMarkType = XBWaterMarkDefault;
    newPicker.delegate = self;
    //newPicker.allowsEditing = NO;
    newPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [newPicker setLongitude:0.0 andLatitude:0.0 andUserNameString:_userNameString andAddressString:_address andActionString:_actionString];
    [self.viewcontroller presentViewController:[[UINavigationController alloc] initWithRootViewController:newPicker] animated:NO completion:^{
        //[UIHelper hideAllHUDsForView:view animated:YES];
        [view removeFromSuperview];
    }];
}

#pragma mark - 开始定位

-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] >8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
    //        _locationManager.allowsBackgroundLocationUpdates =YES;
    //    }
    [self.locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }break;
        case kCLAuthorizationStatusDenied:{
            // 地理位置权限没打开,用户关闭了权限，提示用户去打开
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您暂未开放地理位置授权\n请在iPhone的「设置」-「通知」中，找到「小贷系统」进行设置。" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            [alert addAction:action];
            [self.viewcontroller presentViewController:alert animated:YES completion:nil];
        }
        default:break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    [manager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *place in placemarks) {
            NSLog(@"name,%@",place.name);                               // 位置名
            NSLog(@"thoroughfare,%@",place.thoroughfare);               // 街道
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);         // 子街道
            NSLog(@"subLocality,%@",place.subLocality);                 // 区
            NSLog(@"country,%@",place.country);                         // 国家
            NSLog(@"administrativeArea,%@",place.administrativeArea);   // 省
            NSLog(@"locality,%@",place.locality);                       // 市
            
            
            if (![self cameraAuthorized]) {
                // 相机权限没打开,用户关闭了权限，提示用户去打开
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您暂未开放相机权限授权\n请在iPhone的「设置」-「通知」中，找到「小贷系统」进行设置。" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
                [alert addAction:action];
                [self.viewcontroller presentViewController:alert animated:YES completion:nil];
            }
            
            //UIImagePickerController
            XBImagePickerController *picker = [[XBImagePickerController alloc] init];
            picker.waterMarkType = XBWaterMarkDefault;
            picker.delegate = self;
            //picker.allowsEditing = NO;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _address = [NSString stringWithFormat:@"%@-%@-%@-%@",place.administrativeArea,place.locality,place.subLocality,place.name];
            [picker setLongitude:oldCoordinate.longitude andLatitude:oldCoordinate.latitude andUserNameString:_userNameString andAddressString:_address andActionString:_actionString];
            [self.viewcontroller presentViewController:[[UINavigationController alloc] initWithRootViewController:picker] animated:YES completion:nil];
        }
        
    }];
    
}


@end
