//
//  MainViewController.m
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "MainViewController.h"
#import "CommodityViewController.h"
#import "LogisticsController.h"
#import "MaintainController.h"
#import "LeaseController.h"
#import "FixController.h"
#import "PersonController.h"
#import "LeftSortsViewController.h"
#import "BottonTabBarController.h"
#import "NewsViewController.h"
#import "GoodsBigViewController.h"
#import "NewButton.h"
#import "ImageCarousel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MainBanner.h"
@interface MainViewController ()
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)NSMutableArray *datas;
@end

@implementation MainViewController

{
    // 记录当前是第几页
    int _currentIndex;
    // 装载所有的image
    NSMutableArray *_imagesArray;
    
    
}
-(NSMutableArray *)datas{
    
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = @"首页";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"logo1(3)"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    NewButton *rightButton = [[NewButton alloc]initWithFrame:CGRectMake(270, 30, 22, 22)];
    [rightButton addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    //设置背景图片
    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    UIImage *rightImage = [UIImage imageNamed:@"xiaoxi"];
    [rightButton setBackgroundImage:rightImage forState:UIControlStateNormal];
    [rightButton setTitle:@"消息" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:rightButton];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //设置背景图片
    UIImage *leftImage = [UIImage imageNamed:@"logo"];
    [leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
    //自定义的按钮要设置frame
    leftButton.frame = CGRectMake(12, 30, 73, 24);
    //leftButton.selected = NO;
    [view addSubview:leftButton];
    
    //设置标签栏的标题
   // viewController.title = @"首页";
    [self.navigationItem setTitle:@""];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys: nil];
    NSDictionary *url = [NSDictionary dictionaryWithObjectsAndKeys:@"轮播接口",@"URL", nil];
    NSArray *arrayParameter = [NSArray arrayWithObjects:parameter,url, nil];
    ImageCarousel *imagecarousel = [[ImageCarousel alloc] initWithFrame:CGRectMake(12, 80,SCREEN_WIDTH-24, SCREEN_WIDTH/2-30) andDataSource:arrayParameter];
    imagecarousel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imagecarousel];
    
    
    UIButton *MaintainBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 220, SCREEN_WIDTH-20, (SCREEN_HEIGHT-CGRectGetMaxY(imagecarousel.frame)-30-49)/2)];
    [MaintainBtn setTitle:@"保养维修" forState:UIControlStateNormal];
    [MaintainBtn setImage:[UIImage imageNamed:@"保养维修"] forState:UIControlStateNormal];
    [MaintainBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [MaintainBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    MaintainBtn.tag = 1002;
    MaintainBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    MaintainBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:MaintainBtn];
    
    UIButton *ComodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(MaintainBtn.frame)+10,SCREEN_WIDTH-20, widgetboundsHeight(MaintainBtn))];
    [ComodityBtn setImage:[UIImage imageNamed:@"办公商品"] forState:UIControlStateNormal];
    [ComodityBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ComodityBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    ComodityBtn.tag = 1000;
    ComodityBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    ComodityBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ComodityBtn];

    
}
//轮播图网络请求
//-(void)bannerData{
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"Loading";
//    
//    NSString *path= [NSString stringWithFormat:HOMECAROUSEL,COMMON];
//    NSLog(@"%@",path);
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        if (dic[@"data"] !=[NSNull null]){
//            
//            NSArray *array = dic[@"data"];
//            NSLog(@"%lu",(unsigned long)array.count);
//            for (int i = 0; i<array.count; i++) {
//                
//                MainBanner *banner = [MainBanner modelWithDic:dic[@"data"][i]];
//                [self.datas addObject:banner];
//            }
//            [self banner];
//            NSLog(@"%lu",(unsigned long)self.datas.count);
//            [hud hide:YES];
//        }else{
//        
//        NSLog(@"...");
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [hud hide:YES];
//        NSLog(@"%@",error);
//    }];
//
//}
-(void)rightItemClicked:(UIBarButtonItem *)item{
    NewsViewController *news = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:news animated:YES];
}
-(void)btnPress:(UIButton *)btn{
    NSLog(@"shangping");
    if (btn.tag == 1000) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"商品" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        GoodsBigViewController *good = [[GoodsBigViewController alloc]init];
        
        [self.navigationController pushViewController:good animated:YES];
       // [(BottonTabBarController*)self.tabBarController hideTabBar:NO];
        
    }
    else if (btn.tag == 1001){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"物业" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        LogisticsController *lg = [[LogisticsController alloc]init];
        [self.navigationController pushViewController:lg animated:YES];
    
    }
    
    else if (btn.tag == 1002){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"保养维修" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        MaintainController *main = [[MaintainController alloc]init];
        [self.navigationController pushViewController:main animated:YES];
    
    }
    else if (btn.tag == 1003){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"办公租赁" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        LeaseController *ls = [[LeaseController alloc]init];
        [self.navigationController pushViewController:ls animated:YES];
        
    
    }
    else if (btn.tag == 1004){
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"装修" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        FixController *fix = [[FixController alloc]init];
        [self.navigationController pushViewController:fix animated:YES];
        
    
    }
    else if (btn.tag == 1005){
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"人事" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        PersonController *ps = [[PersonController alloc]init];
        [self.navigationController pushViewController:ps animated:YES];
    
    }
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}
@end
