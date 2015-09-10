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
@interface MainViewController ()
@property(nonatomic, strong)UIPageControl *pageControl;
@end

@implementation MainViewController
{
    // 记录当前是第几页
    int _currentIndex;
    // 装载所有的image
    NSMutableArray *_imagesArray;
    
    
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
    rightButton.font = [UIFont systemFontOfSize:12];
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
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(10, 80, 295, 150);
    scrollView.contentSize = CGSizeMake(280*3, 130);
    // 一页的大小应该是frame的大小
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    scrollView.tag = 1001;
    [scrollView setContentOffset:CGPointMake(280, 0)];
    
    _currentIndex = 0;
    _imagesArray = [[NSMutableArray alloc] init];
    
    for(int i=0;i<5;i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i+1]];
        [_imagesArray addObject:image];
    }
    
    [self loadPage];
    
    //分页控制控件
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120, 200, 120, 0)];
    //分页的页数
    self.pageControl.numberOfPages = 3;
    //当前显示的分页
    self.pageControl.currentPage = 0;
    //将分页控制控件加在本视图上面
    [self.view addSubview:self.pageControl];
    
    [self button];
    
    // Do any additional setup after loading the view.
}
-(void)rightItemClicked:(UIBarButtonItem *)item{
    NewsViewController *news = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:news animated:YES];
}
- (void)loadPage
{
    // 清空当前已有的imageVIew
    for(UIView *view in [self.view viewWithTag:1001].subviews)
    {
        if([view isKindOfClass:[UIImageView class]])
            [view removeFromSuperview];
    }
    UIImageView *currentImageView = [[UIImageView alloc] init];
    UIImageView *nextImageView = [[UIImageView alloc] init];
    UIImageView *preImageView = [[UIImageView alloc] init];
    
    // 当前页
    currentImageView.image = [_imagesArray objectAtIndex:_currentIndex];
    currentImageView.frame = CGRectMake(280, 0, 280, 130);
    [[self.view viewWithTag:1001] addSubview:currentImageView];
    
    // 右侧页
    nextImageView.image = [_imagesArray objectAtIndex:_currentIndex+1<_imagesArray.count?_currentIndex+1:0];
    nextImageView.frame = CGRectMake(560, 0, 280, 130);
    [[self.view viewWithTag:1001] addSubview:nextImageView];
    
    // 左侧页
    preImageView.image = [_imagesArray objectAtIndex:_currentIndex-1<0?_imagesArray.count-1:_currentIndex-1];
    preImageView.frame = CGRectMake(0, 0, 280, 130);
    [[self.view viewWithTag:1001] addSubview:preImageView];
    
    
}
// 当减速结束时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    /*
     int index = scrollView.contentOffset.x/320;
     if(index == 0)
     [scrollView setContentOffset:CGPointMake(320*5, 0)];
     if(index == 6)
     [scrollView setContentOffset:CGPointMake(320, 0)];
     */
    
    int index = scrollView.contentOffset.x/280;
    if(index == 0)
    {
        // 向左翻页
        _currentIndex = _currentIndex-1<0?_imagesArray.count-1:_currentIndex-1;
        [self loadPage];
        [scrollView setContentOffset:CGPointMake(280, 0)];
    }
    else if (index == 2)
    {
        // 向右翻页
        _currentIndex = _currentIndex+1==_imagesArray.count?0:_currentIndex+1;
        [self loadPage];
        [scrollView setContentOffset:CGPointMake(280, 0)];
        
    }
    else
        NSLog(@"没有翻页不做任何改变");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int gap = scrollView.contentOffset.x/280.0;
    
    self.pageControl.currentPage = gap;
}


-(void)button{
    
    UIButton *ComodityBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 230, 145, 85)];
    [ComodityBtn setTitle:@"商品" forState:UIControlStateNormal];
    [ComodityBtn setImage:[UIImage imageNamed:@"shangpin"] forState:UIControlStateNormal];
    [ComodityBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [ComodityBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    ComodityBtn.tag = 1000;
    ComodityBtn.font = [UIFont systemFontOfSize:22];
    ComodityBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ComodityBtn];
    
    UILabel *ComodityLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 130, 20)];
    ComodityLb.text = @"各种办公设备和周边器材";
    ComodityLb.font = [UIFont systemFontOfSize:10];
    ComodityLb.textColor = [UIColor grayColor];
    [ComodityBtn addSubview:ComodityLb];
    
    
    UIButton *logisticsBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ComodityBtn.frame) + 10, 230, 145, 85)];
    [logisticsBtn setTitle:@"物业" forState:UIControlStateNormal];
    [logisticsBtn setImage:[UIImage imageNamed:@"wuye1"] forState:UIControlStateNormal];
    [logisticsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [logisticsBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    logisticsBtn.tag = 1001;
    logisticsBtn.font = [UIFont systemFontOfSize:22];
    logisticsBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logisticsBtn];
    
    UIButton *logisticsName = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
    
    logisticsName.font = [UIFont systemFontOfSize:10];
    
    
    [logisticsName setImage:[UIImage imageNamed:@"wuye4"] forState:UIControlStateNormal];
   // [logisticsBtn addSubview:logisticsName];
    
    UILabel *logisticsLb = [[UILabel alloc]initWithFrame:CGRectMake(25, 60, 130, 20)];
    logisticsLb.text = @"快速运送 到门服务";
    logisticsLb.font = [UIFont systemFontOfSize:10];
    logisticsLb.textColor = [UIColor grayColor];
    [logisticsBtn addSubview:logisticsLb];
    
    
    UIButton *MaintainBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(ComodityBtn.frame)+10,145, 85)];
    [MaintainBtn setTitle:@"保养维修" forState:UIControlStateNormal];
    [MaintainBtn setImage:[UIImage imageNamed:@"weixiubaoyang"] forState:UIControlStateNormal];
    [MaintainBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];    [MaintainBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    MaintainBtn.tag = 1002;
    MaintainBtn.font = [UIFont systemFontOfSize:22];
    MaintainBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:MaintainBtn];
    
    UILabel *MaintainLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
    MaintainLb.text = @"自营上门服务，足不出户";
    MaintainLb.font = [UIFont systemFontOfSize:10];
    MaintainLb.textColor = [UIColor grayColor];
    [MaintainBtn addSubview:MaintainLb];
    
    UIButton *leaseBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(MaintainBtn.frame)+10, CGRectGetMaxY(ComodityBtn.frame)+10,145, 85)];
    [leaseBtn setTitle:@"办公租赁" forState:UIControlStateNormal];
    [leaseBtn setImage:[UIImage imageNamed:@"zulin"] forState:UIControlStateNormal];
    [leaseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [leaseBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    leaseBtn.tag = 1003;
    leaseBtn.font = [UIFont systemFontOfSize:22];
    leaseBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leaseBtn];
    
    UILabel *leaseLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
    leaseLb.text = @"各种办公设备和周边器材";
    leaseLb.font = [UIFont systemFontOfSize:10];
    leaseLb.textColor = [UIColor grayColor];
    [leaseBtn addSubview:leaseLb];
    
    UIButton *fixBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(MaintainBtn.frame)+10, 145, 85)];
    [fixBtn setTitle:@"装修" forState:UIControlStateNormal];
    [fixBtn setImage:[UIImage imageNamed:@"zhuangxiu"] forState:UIControlStateNormal];
    [fixBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [fixBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    fixBtn.tag = 1004;
    fixBtn.font = [UIFont systemFontOfSize:22];
    fixBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fixBtn];
    
    UILabel *fixLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
    fixLb.text = @"各种办公设备和周边器材";
    fixLb.font = [UIFont systemFontOfSize:10];
    fixLb.textColor = [UIColor grayColor];
    [fixBtn addSubview:fixLb];

    
    UIButton *personBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fixBtn.frame)+10, CGRectGetMaxY(MaintainBtn.frame)+10, 145, 85)];
    [personBtn setTitle:@"人事" forState:UIControlStateNormal];
    [personBtn setImage:[UIImage imageNamed:@"renshi"] forState:UIControlStateNormal];
    [personBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [personBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    personBtn.tag = 1005;
    personBtn.font = [UIFont systemFontOfSize:22];
    personBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:personBtn];
    
    UILabel *personLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 130, 20)];
    personLb.text = @"各种办公设备和周边器材";
    personLb.font = [UIFont systemFontOfSize:10];
    personLb.textColor = [UIColor grayColor];
    [personBtn addSubview:personLb];
    
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
    
    [super viewWillAppear:animated];
    
  //  [(BottonTabBarController*)self.tabBarController hideTabBar:NO];
    
}
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
