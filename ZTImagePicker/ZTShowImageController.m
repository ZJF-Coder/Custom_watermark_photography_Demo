//
//  ZTShowImageController.m
//  ZTImagePicker
//
//  Created by sth on 2018/6/20.
//  Copyright © 2018年 ZT. All rights reserved.
//

#import "ZTShowImageController.h"

@interface ZTShowImageController ()

@end

@implementation ZTShowImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"<" forState:0];
    [btn setTitleColor:[UIColor redColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    btn.frame = CGRectMake(0, 0, 26, 26);
    [btn addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItem=[[UIBarButtonItem alloc] initWithCustomView:btn];
    //使用弹簧控件缩小菜单按钮和边缘距离
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 0;
    self.navigationItem.leftBarButtonItems = @[spaceItem,menuItem];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2-0.4*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width, 0.8*[UIScreen mainScreen].bounds.size.width)];
    imageView.image = self.image;
    [self.view addSubview:imageView];
}

- (void)btnDidClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
