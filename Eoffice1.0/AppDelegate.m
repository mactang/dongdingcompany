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
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize nav_controller;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    //#import "IQKeyboardReturnKeyHandler.h"
//    IQKeyboardReturnKeyHandler *heare;
//    heare = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    heare.lastTextFieldReturnKeyType = UIReturnKeyDone;
//    heare.toolbarManageBehaviour = IQAutoToolbarBySubviews;
//    - (void)dealloc
//    {
//        self.returnKeyHandler = nil;
//    }
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    LoginViewController *login = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
//    
//    self.nav_controller = nav;
    
    
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    
    
    [self customizeInterface];
    // self.window.rootViewController = self.nav_controller;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
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
    NSArray *tabBarItemImages = @[@"shouye", @"dingdan", @"wode"];
     NSArray *tabBarItemImages1 = @[@"shouye1", @"dingdan1", @"wode1"];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
