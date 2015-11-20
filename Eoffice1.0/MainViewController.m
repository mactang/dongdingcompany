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
#import "SDCycleScrollView.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MainBanner.h"
@interface MainViewController ()<SDCycleScrollViewDelegate>
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
    
//    NSDictionary *parameter = [NSDictionary dictionaryWithObjectsAndKeys: nil];
//    NSDictionary *url = [NSDictionary dictionaryWithObjectsAndKeys:@"轮播接口",@"URL", nil];
//    NSArray *arrayParameter = [NSArray arrayWithObjects:parameter,url, nil];
//    ImageCarousel *imagecarousel = [[ImageCarousel alloc] initWithFrame:CGRectMake(12, 80,SCREEN_WIDTH-24, SCREEN_WIDTH/2-30) andDataSource:arrayParameter];
//    imagecarousel.backgroundColor = [UIColor whiteColor];
  //  [self.view addSubview:imagecarousel];
    
    [self bannerData];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}
-(void)bannerData{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    NSString *path= [NSString stringWithFormat:HOMECAROUSEL,COMMON];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            
            NSArray *array = dic[@"data"];
            NSLog(@"%lu",(unsigned long)array.count);
            for (int i = 0; i<array.count; i++) {
                
                MainBanner *banner = [MainBanner modelWithDic:dic[@"data"][i]];
                [self.datas addObject:banner];
            }
            [self banner];
            NSLog(@"%lu",(unsigned long)self.datas.count);
            [hud hide:YES];
        }else{
        
        NSLog(@"...");
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];

}
-(void)banner{

    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    
    NSLog(@"%@",self.datas);
    for (int i= 0; i<self.datas.count; i++) {
        MainBanner *model = self.datas[i];
        [imagesURLStrings addObject:model.imgurl];
    }
    NSLog(@"%@",imagesURLStrings);
    // 情景二：采用网络图片实现
//     imagesURLStrings = @[
//                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                  ];
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(12, 80, SCREEN_WIDTH-24,SCREEN_WIDTH/2-30) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    //cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.autoScrollTimeInterval = 4.0;
    //cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:cycleScrollView2];
    
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    [self button:cycleScrollView2];
    
    
}
-(void)rightItemClicked:(UIBarButtonItem *)item{
    NewsViewController *news = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:news animated:YES];
}
-(void)button:(SDCycleScrollView *)image{
    
    
    UIButton *MaintainBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 220, SCREEN_WIDTH-20, (SCREEN_HEIGHT-CGRectGetMaxY(image.frame)-30-49)/2)];
    [MaintainBtn setTitle:@"保养维修" forState:UIControlStateNormal];
    [MaintainBtn setImage:[UIImage imageNamed:@"保养维修"] forState:UIControlStateNormal];
    [MaintainBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [MaintainBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    MaintainBtn.tag = 1002;
    MaintainBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    MaintainBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:MaintainBtn];
    
    UIButton *ComodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(MaintainBtn.frame)+10,SCREEN_WIDTH-20, widgetboundsHeight(MaintainBtn))];
//    [ComodityBtn setTitle:@"商品" forState:UIControlStateNormal];
    [ComodityBtn setImage:[UIImage imageNamed:@"办公商品"] forState:UIControlStateNormal];
    [ComodityBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ComodityBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    ComodityBtn.tag = 1000;
    ComodityBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    ComodityBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ComodityBtn];
    
    
//    UILabel *ComodityLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 130, 20)];
//    ComodityLb.text = @"各种办公设备和周边器材";
//    ComodityLb.font = [UIFont systemFontOfSize:10];
//    ComodityLb.textColor = [UIColor grayColor];
//    [ComodityBtn addSubview:ComodityLb];
    
    
    
//    UILabel *MaintainLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
//    MaintainLb.text = @"自营上门服务，足不出户";
//    MaintainLb.font = [UIFont systemFontOfSize:10];
//    MaintainLb.textColor = [UIColor grayColor];
//    [MaintainBtn addSubview:MaintainLb];
    
    
//    UIButton *logisticsBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ComodityBtn.frame) + 10, 230, 145, 85)];
//    [logisticsBtn setTitle:@"物业" forState:UIControlStateNormal];
//    [logisticsBtn setImage:[UIImage imageNamed:@"wuye1"] forState:UIControlStateNormal];
//    [logisticsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [logisticsBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
//    logisticsBtn.tag = 1001;
//    logisticsBtn.font = [UIFont systemFontOfSize:22];
//    logisticsBtn.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:logisticsBtn];
//    
//    UIButton *logisticsName = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
//    
//    logisticsName.font = [UIFont systemFontOfSize:10];
//    
//    
//    [logisticsName setImage:[UIImage imageNamed:@"wuye4"] forState:UIControlStateNormal];
//   // [logisticsBtn addSubview:logisticsName];
//    
//    UILabel *logisticsLb = [[UILabel alloc]initWithFrame:CGRectMake(25, 60, 130, 20)];
//    logisticsLb.text = @"快速运送 到门服务";
//    logisticsLb.font = [UIFont systemFontOfSize:10];
//    logisticsLb.textColor = [UIColor grayColor];
//    [logisticsBtn addSubview:logisticsLb];
//    
//    
//    
//    
//    UIButton *leaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MaintainBtn.frame)+10, CGRectGetMaxY(ComodityBtn.frame)+10,145, 85)];
//    [leaseBtn setTitle:@"办公租赁" forState:UIControlStateNormal];
//    [leaseBtn setImage:[UIImage imageNamed:@"zulin"] forState:UIControlStateNormal];
//    [leaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [leaseBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
//    leaseBtn.tag = 1003;
//    leaseBtn.font = [UIFont systemFontOfSize:22];
//    leaseBtn.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:leaseBtn];
//    
//    UILabel *leaseLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
//    leaseLb.text = @"各种办公设备和周边器材";
//    leaseLb.font = [UIFont systemFontOfSize:10];
//    leaseLb.textColor = [UIColor grayColor];
//    [leaseBtn addSubview:leaseLb];
//    
//    UIButton *fixBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(MaintainBtn.frame)+10, 145, 85)];
//    [fixBtn setTitle:@"装修" forState:UIControlStateNormal];
//    [fixBtn setImage:[UIImage imageNamed:@"zhuangxiu"] forState:UIControlStateNormal];
//    [fixBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [fixBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
//    fixBtn.tag = 1004;
//    fixBtn.font = [UIFont systemFontOfSize:22];
//    fixBtn.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:fixBtn];
//    
//    UILabel *fixLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
//    fixLb.text = @"各种办公设备和周边器材";
//    fixLb.font = [UIFont systemFontOfSize:10];
//    fixLb.textColor = [UIColor grayColor];
//    [fixBtn addSubview:fixLb];
//
//    
//    UIButton *personBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fixBtn.frame)+10, CGRectGetMaxY(MaintainBtn.frame)+10, 145, 85)];
//    [personBtn setTitle:@"人事" forState:UIControlStateNormal];
//    [personBtn setImage:[UIImage imageNamed:@"renshi"] forState:UIControlStateNormal];
//    [personBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [personBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
//    personBtn.tag = 1005;
//    personBtn.font = [UIFont systemFontOfSize:22];
//    personBtn.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:personBtn];
//    
//    UILabel *personLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
//    personLb.text = @"各种办公设备和周边器材";
//    personLb.font = [UIFont systemFontOfSize:10];
//    personLb.textColor = [UIColor grayColor];
//    [personBtn addSubview:personLb];
    
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
