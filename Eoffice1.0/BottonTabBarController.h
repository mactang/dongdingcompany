//
//  BottonTabBarController.h
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"
#import "OrderViewController.h"
#import "MemberViewController.h"
#import "PersonViewController.h"
@interface BottonTabBarController : UITabBarController
{
    UITabBarItem *currentItem;
    UITabBarItem *mainItem;
    UITabBarItem *orderItem;
    UITabBarItem *memberItem;
    
    
    UITabBarItem * personTableItem;
    NSArray *tabBarItemArray;
    UITabBar *bottomTabBar;
    
}
//- (void)hideTabBar:(BOOL)hidden;
////作用:将视图控制器添加到标签栏控制器上
//-(UIViewController *)addViewController:(NSString *)name title:(NSString *)title image:(NSString *)image;
@end
