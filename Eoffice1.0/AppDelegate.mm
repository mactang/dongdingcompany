//
//  AppDelegate.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AppDelegate.h"
#import "BottonTabBarController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "OrderViewController.h"
#import "PersonViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "LoginViewController.h"
#import "SingleModel.h"
#import "IQKeyboardManager.h"
#import "AFNetworking.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AppDelegate (){
    BMKMapManager *_mapManager;
}
@end

@implementation AppDelegate

@synthesize nav_controller;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"TLGTcH0bNmdmdo289V2wFtZv" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self customizeInterface];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
//    [self versionData];
   
    return YES;
}
-(void)versionData{
    
    NSString *path= [NSString stringWithFormat:VERSION,COMMON];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            
            SingleModel *model = [SingleModel sharedSingleModel];
            NSDictionary *array = dic[@"data"];
            model.version = array[@"versionFullName"];
            
            NSLog(@"version--%@",model.version);
            NSString *versionString = [NSString stringWithFormat:@"%@",model.version];
             NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            if ([model.version compare:[infoDic objectForKey:@"CFBundleVersion"] options:NSNumericSearch] == NSOrderedDescending) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *versionAlertView = [[UIAlertView alloc]initWithTitle:@"提示" message: [NSString stringWithFormat:@"当前应用版本:%@\n检测到新版本:%@\n是否立即升级至最新版?",[infoDic objectForKey:@"CFBundleVersion"],versionString] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
                    versionAlertView.tag = 2000;
                    [versionAlertView show];
                });
        }
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];

    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 2000) {
        if (buttonIndex == 0) {
            SingleModel *model = [SingleModel sharedSingleModel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
        }
    }
    else if (alertView.tag == 3000) {
        exit(0);
    }
    
}
#pragma mark - Methods

- (void)setupViewControllers {
    
    UIViewController *MainView = [[MainViewController alloc]init];
    MainView.title = @"首页";
    UIViewController *MainNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:MainView];
    
    UIViewController *secondViewController = [[OrderViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    secondViewController.title = @"订单";

    UIViewController *thirdViewController = [[PersonViewController alloc] init];
    thirdViewController.title = @"我的";
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];

    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[MainNavigationController, secondNavigationController,
                                           thirdNavigationController]];
    
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    UIImage *finishedImage = [UIImage imageNamed:@"bg"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"bg"];
    NSArray *tabBarItemImages1 = @[@"chating", @"order", @"myself"];
     NSArray *tabBarItemImages = @[@"chating_select", @"order_select", @"myself_select"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages1 objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
                          
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    
    
    BottonTabBarController *btbc = [[BottonTabBarController alloc]init];
    [self.nav_controller pushViewController:btbc animated:NO];
    
    return YES;
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
