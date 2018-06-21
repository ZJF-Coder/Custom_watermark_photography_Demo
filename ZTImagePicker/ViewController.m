//
//  ViewController.m
//  ZTImagePicker
//
//  Created by ZT0526 on 2017/5/13.
//  Copyright © 2017年 ZT. All rights reserved.
//

#import "ViewController.h"
#import "ZTImagePickerController.h"
#import "ZTImagePickerOverLayView.h"
#import "XBWaterMarkCameraHandler.h"
#import "UIImage+FWAddition.h"

@interface ViewController ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong) ZTImagePickerController *imagePicker;

@property (nonatomic, weak) UITextField *userNameText;
@property (nonatomic, weak) UITextField *actionText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITextField *userNameText = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.width-20, 30)];
    userNameText.text = @"朱建锋";
    userNameText.placeholder = @"请输入用户名字";
    userNameText.layer.borderColor = [UIColor grayColor].CGColor;
    userNameText.layer.borderWidth = 1;
    [self.view addSubview:userNameText];
    _userNameText = userNameText;
    
    UITextField *actionText = [[UITextField alloc] initWithFrame:CGRectMake(10, 140, self.view.width-20, 30)];
    actionText.text = @"尽调拍摄现场施工图片";
    actionText.placeholder = @"请输入要做的动作";
    actionText.layer.borderColor = [UIColor grayColor].CGColor;
    actionText.layer.borderWidth = 1;
    [self.view addSubview:actionText];
    _actionText = actionText;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonAction:(id)sender {
    
//    self.imagePicker = [[ZTImagePickerController alloc] init];
//    
//    
//    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该设备不支持相机功能" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    [[XBWaterMarkCameraHandler sharedHandler] showCameraPickerInController:self withUserName:_userNameText.text withAction:_actionText.text finishBlock:^(UIImage *originImage, NSString *address, ZTLocationModel *placemark, NSUInteger index,XBWaterMark markType, NSString *xmType) {
        //            [[originImage markedImageWithDate:[NSDate fixedDate] user:[FWUser currentUser].username type:@"" placemark:placemark withPhone:[FWUser currentUser].cellphone] saveImageToAlarmPhotoAlbum];
        [[originImage markedImageWithType:markType date:[NSDate date] user:_userNameText.text addressString:address actionString:_actionText.text placLocation:placemark withPhone:nil xmType:xmType] saveImageToAlarmPhotoAlbum];
    }];

}




@end
