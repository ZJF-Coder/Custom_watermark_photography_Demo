//
//  NSObject+Extension.m
//  yonbb
//
//  Created by sth on 16/12/22.
//  Copyright © 2016年 Yonbb. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

/**
 * 获取当前的控制器
 */
+ (UIViewController*)getTopViewController {
    UIViewController *vc = [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
//    NSLog(@"controller's name = %@",NSStringFromClass([vc class]));
    return vc;
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}



@end
