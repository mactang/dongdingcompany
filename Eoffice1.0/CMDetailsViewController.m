//
//  CMDetailsViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/13.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CMDetailsViewController.h"
#import "CMdetailCell.h"
#import "Model.h"
#import "BigPhotoCell.h"
#import "BuyInfoCell.h"
#import "CommentCell.h"
#import "SellerInfoCell.h"
#import "UIView+Shortcut.h"
#import "JHCellConfig.h"
#import "AdvanceCommentCell.h"
#import "GeneralDetailViewController.h"
#import "BottonTabBarController.h"
#import "RDVTabBarController.h"

#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"

#import "OrderController.h"
#import "GYZViewController.h"
#import "MenuPopover.h"
#import "ContrastViewController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "detailsModel.h"


#define MENU_POPOVER_FRAME  CGRectMake(8, 0, 140, 88)
#define kWidthOfScreen [UIScreen mainScreen].bounds.size.width
@interface CMDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MenuPopoverDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *immgeView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong)UIButton *detailButton;

@property(nonatomic, strong)UIPageControl *pageControl;

@property(nonatomic, strong)UIView *detailView;

@property(nonatomic,strong) MenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;

@property(nonatomic,strong)UIView *carView;

@property(nonatomic,strong)UILabel *number;

@end

@implementation CMDetailsViewController
{
    // 记录当前是第几页
    int _currentIndex;
    // 装载所有的image
    NSMutableArray *_imagesArray;
    
    int number;
    
    
}
-(NSArray *)datas{
    if (_datas == nil) {
        _datas = [NSArray array];
    }
    return _datas;
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"＜" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtn)];
//    [self.navigationItem setLeftBarButtonItem:logoutItem];
   // [(BottonTabBarController*)self.tabBarController hideTabBar:YES];
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hidesBottomBarWhenPushed = YES;
  
    
    _datas = @[@"cell_01"];
    
    _immgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    _immgeView.backgroundColor = [UIColor greenColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
   // _tableView.showsVerticalScrollIndicator = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 600, 320, 480)];
    _detailView.backgroundColor = [UIColor whiteColor];
    [_tableView addSubview:_detailView];
    
    _carView = [[UIView alloc]initWithFrame:CGRectMake(0, 450, 320, 100)];
    _carView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_carView];
    [self shopTabBar];
    
    //默认选中图文详情
    [self btnPress1];
    
    
    

    // Do any additional setup after loading the view.
}
- (void)leftBtn{
    
    // [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
  //  [(BottonTabBarController*)self.tabBarController hideTabBar:NO];
    
}
-(void)buttonClicked:(UIButton *)btn{

    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int gap = scrollView.contentOffset.x/320.0;
    
    self.pageControl.currentPage = gap;
}



-(void)shopTabBar{
    UIButton *shopCarBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
   // [shopCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
    shopCarBtn.backgroundColor = [UIColor colorWithRed:200/255.0 green:3/255.0 blue:3/255.0 alpha:1];
    shopCarBtn.font = [UIFont systemFontOfSize:12];
    shopCarBtn.clipsToBounds = YES;
    shopCarBtn.layer.cornerRadius = 6;
    shopCarBtn.tag = 2000;
    shopCarBtn.selected = YES;
   // [shopCarBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    [shopCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopCarBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
    [_carView addSubview:shopCarBtn];
    
    UIButton *shopCarBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, 20, 20)];
    [shopCarBtn1 setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
    [shopCarBtn addSubview:shopCarBtn1];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 22, 30, 20)];
    lb1.font = [UIFont systemFontOfSize:10];
    lb1.text = @"购物车";
    lb1.textColor = [UIColor whiteColor];
    [shopCarBtn addSubview:lb1];
    
    
    _number = [[UILabel alloc]initWithFrame:CGRectMake(15, 3, 30, 10)];
    _number.font = [UIFont systemFontOfSize:10];
    _number.text = [NSString stringWithFormat:@"%d",number
                    ];;
    _number.textColor = [UIColor orangeColor];
    [shopCarBtn1 addSubview:_number];
    
    UIButton *InShopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shopCarBtn.frame)+8, 5, 120, 40)];
    [InShopBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    InShopBtn.backgroundColor = [UIColor colorWithRed:203/255.0 green:103/255.0 blue:103/255.0 alpha:1];
    InShopBtn.clipsToBounds = YES;
    InShopBtn.layer.cornerRadius = 6;
    InShopBtn.tag = 2001;
    InShopBtn.selected = YES;
    [InShopBtn setImage:[UIImage imageNamed:@"jiaru"] forState:UIControlStateNormal];
    [InShopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [InShopBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
    [_carView addSubview:InShopBtn];
    
    UIButton *shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(InShopBtn.frame)+8, 5, 120, 40)];
    [shopBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
    shopBtn.backgroundColor = [UIColor colorWithRed:207/255.0 green:134/255.0 blue:65/255.0 alpha:1];
    shopBtn.clipsToBounds = YES;
    shopBtn.layer.cornerRadius = 6;
    shopBtn.tag = 2002;
   [shopBtn setImage:[UIImage imageNamed:@"lijigoumai"] forState:UIControlStateNormal];
    [shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
    [_carView addSubview:shopBtn];
}
-(void)shopPress:(UIButton *)btn{
    if (btn.tag == 2000) {
        
    }
    else if (btn.tag == 2001){
        
        _number.text = [NSString stringWithFormat:@"%d",number
                        +1];
        number = number +1;
        
        [self data];
    
    }
    else if (btn.tag == 2002){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"确认订单" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        OrderController *order = [[OrderController alloc]init];
        [self.navigationController pushViewController:order animated:YES];
    }
    
}

-(void)data{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path = [NSString stringWithFormat:MAINTAINDETAIL,model.jsessionid,model.userkey,model.wGoodsId];
    NSLog(@"path--%@",path);
    NSLog(@"wGoodsId--%@",model.wGoodsId);
    NSLog(@"_number--%@",_number.text);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
       [manager POST:path parameters:@{@"count":_number.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3&&indexPath.row == 0) {
        return 480;
    }
    else if(indexPath.section == 0&&indexPath.row == 0){
        return 170;
    }
    else if(indexPath.section == 0&&indexPath.row == 1){
        return 90;
    }

    else{
        return 60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.frame = CGRectMake(0, 0, 320, 130);
        scrollView.contentSize = CGSizeMake(320*5, 130);
        //scrollView.backgroundColor = [UIColor redColor];
        // 一页的大小应该是frame的大小
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [cell addSubview:scrollView];
        scrollView.tag = 3001;
        [scrollView setContentOffset:CGPointMake(320, 0)];
        
        _currentIndex = 0;
        _imagesArray = [[NSMutableArray alloc] init];
        
        
        
        for(int i=0;i<5;i++)
        {
            
            //前置图
            NSString *string = [NSString stringWithFormat:@"%d.jpg",i+1];
            UIImage *forImage = [UIImage imageNamed:string];
            
            UIImageView *forImageView = [[UIImageView alloc]initWithImage:forImage];
            
            forImageView.frame = CGRectMake(320*i, 0, 320, 130);
            
            [scrollView addSubview:forImageView];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(320*i, 0, 320, 130);
            // button.backgroundColor = [UIColor redColor];
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i+10;
            //添加到滚动视图
            [scrollView addSubview:button];
            
        }
        
        //分页控制控件
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110, 100, 120, 0)];
        self.pageControl.backgroundColor = [UIColor redColor];
        //分页的页数
        self.pageControl.numberOfPages = 5;
        //当前显示的分页
        self.pageControl.currentPage = 0;
        //将分页控制控件加在本视图上面
        [cell addSubview:self.pageControl];

    }
     if (indexPath.row == 1 &&indexPath.section == 0) {
        cell.textLabel.text = @"寸宽屏笔记本";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 0 && indexPath.section == 1) {
        cell.textLabel.text = @"商家对比";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 0 &&indexPath.section == 2) {
        
        self.menuItems = [NSArray arrayWithObjects:@"Menu Item 1", @"Menu Item 2", nil];
        cell.textLabel.text = @"购买信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 320, 60)];
        //[btn setTitle:@"图文详情" forState:UIControlStateNormal];
       
       // btn.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [btn addTarget:self action:@selector(showMenuPopOver:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];

        
    }
    else if (indexPath.row == 0 &&indexPath.section == 3) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 100, 20)];
        [btn setTitle:@"图文详情" forState:UIControlStateNormal];
        btn.tag = 1000;
        btn.selected = YES;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [btn addTarget:self action:@selector(btnPress1) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 10, 100, 20)];
        [btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 1001;
        [btn1 setTitle:@"产品参数" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), 10, 100, 20)];
        [btn2 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 1002;
        [btn2 setTitle:@"推荐产品" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:btn2];
    }
    
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0 && indexPath.section == 1) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;

        ContrastViewController *contrast = [[ContrastViewController alloc]init];
        
        [self.navigationController pushViewController:contrast animated:NO];
    }
}
- (void)showMenuPopOver:(id)sender
{
    // Hide already showing popover
    [self.menuPopover dismissMenuPopover];
    
    self.menuPopover = [[MenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
    
    self.menuPopover.menuPopoverDelegate = self;
    [self.menuPopover showInView:self.view];
}

#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(MenuPopover *)menuPopover
{
    [self.menuPopover dismissMenuPopover];
    
    OrderController *order = [[OrderController alloc]init];
    [self.navigationController pushViewController:order animated:YES];
}


-(void)btnPress1{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_02"]];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.frame = CGRectMake(0, -140, 320, 300);
    
    [_detailView addSubview:imageView];
    
}
-(void)btnPress:(UIButton *)btn{
    
    if (btn.tag == 1001) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_03"]];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.frame = CGRectMake(0, -140, 320, 300);
        
        [_detailView addSubview:imageView];
    }

    else if (btn.tag == 1002) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_04"]];
        imageView.frame = CGRectMake(0, -140, 320, 300);
        imageView.backgroundColor = [UIColor clearColor];
        [_detailView addSubview:imageView];
    }
   
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
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
