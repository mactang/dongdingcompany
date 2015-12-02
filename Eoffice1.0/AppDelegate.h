//
//  AppDelegate.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    UINavigationController *nav_controller;
}
@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic) UINavigationController *nav_controller;
@property (strong, nonatomic) UIViewController *viewController;
@end

