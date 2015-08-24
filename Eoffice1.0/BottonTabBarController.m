//
//  BottonTabBarController.m
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "BottonTabBarController.h"
#define iOS7  [[UIDevice currentDevice]systemVersion].floatValue>=7.0
@interface BottonTabBarController ()
{
  MainViewController *main_controller;
}
@end

@implementation BottonTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    main_controller = [[MainViewController alloc]init];
//    OrderViewController *order_controller = [[OrderViewController alloc]init];
//    MemberViewController *member_controller = [[MemberViewController alloc]init];
//    PersonViewController *person_controller = [[PersonViewController alloc]init];
//    
//    UINavigationController *main_nav = [[UINavigationController alloc]initWithRootViewController:main_controller];
//     UINavigationController *order_nav = [[UINavigationController alloc]initWithRootViewController:order_controller];
//    
//     UINavigationController *person_nav = [[UINavigationController alloc]initWithRootViewController:person_controller];
//    
//    main_nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:nil tag:10000];
//    order_nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:nil tag:10001];
//    person_nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:nil tag:10001];
//    [self setViewControllers:@[main_nav,order_nav,person_nav]];
//    
//    self.tabBar.alpha = 0;
//    
//    bottomTabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 48,SCREEN_WIDTH,48)];
//    
//    [self.view addSubview:bottomTabBar];
//    
//    UITabBarItem * tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"首页"
//                                                               image:[UIImage
//                                                                      imageNamed:@"calendar_tabbar_note.png"]
//                                                                 tag:0];
//    [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"calendar_tabbar_note_highlight.png"]];
//    
//    UITabBarItem * tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"订单"
//                                                               image:[UIImage
//                                                                      imageNamed:@"calendar_scheme.png"]
//                                                                 tag:1];
//    [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"calendar_scheme_highlight.png"]];
//    
//    
////    UITabBarItem * tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@" 会员"
////                                                               image:[UIImage
////                                                                      imageNamed:@"mission.png"]
////                                                                 tag:2];
//    
//    personTableItem = [[UITabBarItem alloc] initWithTitle:@" 我的"
//                                                  image:[UIImage
//                                                         imageNamed:@"calendar_tabbar_more.png"]
//                                                    tag:3];
//    [personTableItem setSelectedImage:[UIImage imageNamed:@"calendar_tabbar_more_highlight.png"]];
//    
//    tabBarItemArray = [[NSArray alloc] initWithObjects: tabBarItem1, tabBarItem2, personTableItem,nil];
//    
//    bottomTabBar.delegate = self;
//    //bottomTabBar.barTintColor = [UIColor redColor];
//    bottomTabBar.backgroundColor = [UIColor redColor];
//    [bottomTabBar setItems: tabBarItemArray];
//    
//    [bottomTabBar setSelectedItem:tabBarItem1];
//    mainItem = tabBarItem1;
//    orderItem = tabBarItem2;
//   // memberItem = tabBarItem3;
//    currentItem = mainItem;
    
//    // 创建页面
//    [self createViewControllers];
//    //创建item属性
//    [self createItems];
    // Do any additional setup after loading the view.
}

//- (void)createViewControllers
//{
//    
//    MainViewController * vc1 = [[MainViewController alloc]init];
//    UINavigationController * nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
//    vc1.navigationItem.title = @"首页";
//    vc1.tabBarItem.tag = 100;
//    
//    // 理财产品
//    OrderViewController * vc2 = [[OrderViewController alloc]init];
//    UINavigationController * nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
//    vc2.navigationItem.title = @"订单";
//    vc2.tabBarItem.tag = 101;
//    
//    //我的资产
//    PersonViewController * vc3 = [[PersonViewController alloc]init];
//    UINavigationController * nc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
//    vc3.navigationItem.title = @"我的";
//    vc3.tabBarItem.tag = 102;
//    
//    
//    self.viewControllers = @[nc1,nc2,nc3];
//    
//    //    UIView * tabView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 49)];
//    //    tabView.backgroundColor = [UIColor redColor];
//    //    [self.tabBarController.tabBar insertSubview:tabView atIndex:0];
//    //    self.tabBarController.tabBar.opaque = YES;
//    
//}
//
//- (void)createItems
//{
//    NSArray * titleArr = @[@"首页",@"订单",@"我的",@"更多"];
//    NSArray * selectedImgArr =@[@"tabbarsalClick.png",@"tabbarBuyClick.png",@"tabbarmonyClick.png",@"tabbargenClick.png"];
//    NSArray * unSelectedImgArr = @[@"tabbarsale.png",@"tabbarBuy.png",@"tabbarmony.png",@"tabbargen.png"];
//    for (int i = 0; i<self.tabBar.items.count; i++)
//    {
//        UITabBarItem * item = self.tabBar.items[i];
//        // 对图片进行处理
//        if (iOS7)
//        {
//            UIImage * selectedImage = [UIImage imageNamed:selectedImgArr[i]];
//            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            UIImage * unSelectedImage = [UIImage imageNamed:unSelectedImgArr[i]];
//            unSelectedImage = [unSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            // 上面是为了防止显示阴影而不是显示图片
//            item.selectedImage = selectedImage;
//            item.image = unSelectedImage;
//            item.title = titleArr[i];
//            
//        }
//        else
//        {
//            [item setFinishedSelectedImage:[UIImage imageNamed:selectedImgArr[i]] withFinishedUnselectedImage:[UIImage imageNamed:unSelectedImgArr[i]]];
//        }
//    }
//    
//    if (iOS7)
//    {
//        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor] } forState:UIControlStateSelected];
//    }
//    else
//    {
//        
//        [[UIBarButtonItem appearance]setTitleTextAttributes:@{UITextAttributeTextColor: [UIColor blackColor]} forState:UIControlStateSelected];
//        
//    }
//    
//}
//
////-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
////      currentItem = item;
////     [self setSelectedIndex:item.tag];
////    
////}
//- (void)hideTabBar:(BOOL)hidden{
//    
//    bottomTabBar.hidden = hidden;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
