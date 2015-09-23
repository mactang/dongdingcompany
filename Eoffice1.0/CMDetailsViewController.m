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

#import "SingleModel.h"
#import "LoginViewController.h"

#import "OrderController.h"
#import "MenuPopover.h"
#import "ContrastViewController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "detailsModel.h"
#import "BBBadgeBarButtonItem.h"

#import "HMSegmentedControl.h"
#import "ButtonImageWithTitle.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/TencentOAuth.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "TarBarButton.h"
#import "LoginViewController.h"
#import "ShoppingCarController.h"
#define kWidthOfScreen [UIScreen mainScreen].bounds.size.width
@interface CMDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MenuPopoverDelegate,UMSocialUIDelegate,logindelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *immgeView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong)UIButton *detailButton;

@property(nonatomic, strong)UIPageControl *pageControl;

@property(nonatomic, strong)UIView *detailView;

@property(nonatomic,strong) MenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;

@property(nonatomic,strong)UIView *carView;

@property(nonatomic,strong)UIButton *numberbutton;

@property (nonatomic, strong) BBBadgeBarButtonItem *messageItem;

@property(nonatomic, strong)NSMutableArray *datas;

//@property(nonatomic, assign) BOOL isLogin;

@property(nonatomic, strong)NSString *back;

@property(nonatomic, strong)NSMutableArray *parameterDatas;

@end

@implementation CMDetailsViewController
{
    // 记录当前是第几页
    int _currentIndex;
    // 装载所有的image
    NSMutableArray *_imagesArray;
    
    int number;
    LoginViewController *login;
    BOOL loginsucess;
    NSInteger  product;
    NSMutableDictionary *dictionary;
    detailsModel *model1;
    
    
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

-(NSMutableArray *)parameterDatas{
    if (_parameterDatas == nil) {
        _parameterDatas = [NSMutableArray array];
    }
    return _parameterDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    number = 0;
    dictionary = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.hidesBottomBarWhenPushed = YES;
    
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    [self data];
    [self parameterData];
    //商品参数
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
    
    _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 470, 320, 480)];
    _detailView.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    [_tableView addSubview:_detailView];
    
    _carView = [[UIView alloc]initWithFrame:CGRectMake(0, 450, 320, 100)];
    _carView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_carView];
    [self shopTabBar];
    
    
    // Do any additional setup after loading the view.
}

-(void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
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
    shopCarBtn.titleLabel.font = [UIFont systemFontOfSize:12];
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
    shopCarBtn1.userInteractionEnabled = NO;
    [shopCarBtn addSubview:shopCarBtn1];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 22, 30, 20)];
    lb1.font = [UIFont systemFontOfSize:10];
    lb1.text = @"购物车";
    lb1.userInteractionEnabled = NO;
    lb1.textColor = [UIColor whiteColor];
    [shopCarBtn addSubview:lb1];
    
    
    _numberbutton = [[UIButton alloc]initWithFrame:CGRectMake(32, 1, 20, 20)];
    _numberbutton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_numberbutton setTitle:[NSString stringWithFormat:@"%d",number
                             ] forState:UIControlStateNormal];
    _numberbutton.clipsToBounds = YES;
    _numberbutton.layer.cornerRadius = 10;
    [_numberbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _numberbutton.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1];
    [_carView addSubview:_numberbutton];
    
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
        [self clickshopcratbutton];
    }
    else if (btn.tag == 2001){
        self.menuPopover = [[MenuPopover alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-64) menuItems:self.menuItems];
        self.menuPopover.intcart = YES;
        self.menuPopover.Distinguish = YES;
        self.menuPopover.delegate = self;
        
        self.menuPopover.dic = dictionary;
        
        [UIView animateWithDuration:0.4f animations:^{
            self.menuPopover.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        }];
        [self.view addSubview:self.menuPopover];
        [_numberbutton setTitle:[NSString stringWithFormat:@"%d",number+1] forState:UIControlStateNormal];
        number = number +1;
    }
    else if (btn.tag == 2002){
        self.menuPopover = [[MenuPopover alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-64) menuItems:self.menuItems];
        self.menuPopover.delegate = self;
        self.menuPopover.intcart = YES;
        self.menuPopover.Distinguish = NO;
        self.menuPopover.dic = dictionary;
        [UIView animateWithDuration:0.4f animations:^{
            self.menuPopover.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        }];
        [self.view addSubview:self.menuPopover];
    }
}
-(void)data{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path = [NSString stringWithFormat:MAINTAINDETAIL,COMMON,model.paraId,model.goodsId,model.cPartnerId];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (dic[@"data"] !=[NSNull null]){
            [dictionary setDictionary:dic[@"data"]];
            NSDictionary *array = dic[@"data"];
            detailsModel *model = [detailsModel modelWithDic:array];
            [self.datas addObject:model];
        }
        [hud hide:YES];
        //[self parameterData];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4*self.datas.count;
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        detailsModel *model = self.datas[indexPath.section];
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 40)];
        description.font = [UIFont systemFontOfSize:12];
        //lb3.backgroundColor = [UIColor redColor];
        description.lineBreakMode = NSLineBreakByWordWrapping;
        description.numberOfLines = 0;
        NSLog(@"%@",model.name);
        // description.text = model.name;
        description.text = @"Mac";
        [cell addSubview:description];
        
        UILabel *priceFLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(description.frame)+5, 10, 20)];
        priceFLb.font = [UIFont systemFontOfSize:15];
        priceFLb.textColor = [UIColor colorWithRed:200/255.0 green:3/255.0 blue:3/255.0 alpha:1];
        priceFLb.text = @"￥";
        [cell addSubview:priceFLb];
        
        SingleModel *single = [SingleModel sharedSingleModel];
        UILabel *priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceFLb.frame)+2, priceFLb.frame.origin.y, 80, 20)];
        priceLb.font = [UIFont systemFontOfSize:15];
        priceLb.textColor = [UIColor colorWithRed:200/255.0 green:3/255.0 blue:3/255.0 alpha:1];
        NSLog(@"%@",single.price);
        priceLb.text = [NSString stringWithFormat:@"%@",model.price];
        
        [cell addSubview:priceLb];
        
        ButtonImageWithTitle  *fenxBtb = [[ButtonImageWithTitle alloc]initWithFrame:CGRectMake(250, 30, 50, 50)];
        
        [fenxBtb setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        [fenxBtb addTarget:self action:@selector(fenxClicked) forControlEvents:UIControlEventTouchUpInside];
        [fenxBtb setTitle:@"分享" forState:UIControlStateNormal];
        [fenxBtb setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        fenxBtb.titleLabel.font = [UIFont systemFontOfSize:12];
        fenxBtb.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:fenxBtb];
        
        
        
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
        HMSegmentedControl *segmentedControl2 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"图文详情", @"产品参数",@"推荐产品"]];
        segmentedControl2.frame = CGRectMake(0, 10, self.view.frame.size.width, 40);
        segmentedControl2.selectionIndicatorHeight = 4.0f;
        segmentedControl2.backgroundColor = [UIColor whiteColor];
        segmentedControl2.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl2.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        [segmentedControl2 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:segmentedControl2];
    }
    
    return cell;
    
}


-(void)fenxClicked{
    
    NSLog(@",,");
    //            //友盟分享的appKey
    //        [UMSocialData setAppKey:@"5211818556240bc9ee01db2f"];
    //
    //    //设置微信AppId，设置分享url，默认使用友盟的网址
    //    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    //
    //    //设置手机QQ的AppId，指定你的分享url，若传nil，将使用友盟的网址
    //    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    
    //        注意：要想进行qq微信分享，下面的设置是必须的
    //       设置微信的appId url设置为空，默认使用友盟的网址
    //        [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:nil];
    //
    //        [UMSocialConfig setQQAppId:@"100424468" url:nil importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5211818556240bc9ee01db2f"
                                      shareText:nil
                                     shareImage:nil
                                shareToSnsNames:nil
                                       delegate:self];
    
    
}
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentedControl{
    
    
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        
        [self btnPress1];
        
    }
    if (segmentedControl.selectedSegmentIndex == 1) {
        
        
        NSLog(@"bbb");
        
        
    }
    if (segmentedControl.selectedSegmentIndex == 2) {
        
        
        NSLog(@"bbb");
        
        
    }
    // [_tableView reloadData];
    
    
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
    self.menuPopover = [[MenuPopover alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-64) menuItems:self.menuItems];
    self.menuPopover.intcart = NO;
    self.menuPopover.delegate = self;
    self.menuPopover.dic = dictionary;
    [UIView animateWithDuration:0.4f animations:^{
        self.menuPopover.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    }];
    [self.view addSubview:self.menuPopover];
}

-(void)parameterData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path = [NSString stringWithFormat:PARAMETER,COMMON,model.paraId];
    NSLog(@"path--%@",path);
    NSLog(@"wGoodsId--%@",_numberbutton.titleLabel.text);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (dic[@"data"] !=[NSNull null]){
            
            detailsModel *model = [detailsModel modelWithDic:dic];
            [self.parameterDatas addObject:model];
            NSLog(@"%@",model.data[@"转速"]);
        }
        model1 = self.parameterDatas[0];
        NSLog(@"%@",model1);
        [hud hide:YES];
        
        //默认选中图文详情
        [self btnPress1];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
#pragma mark MLKMenuPopoverDelegate
-(void)pushlogincontroller:(BOOL)sucess shopnumber:(NSInteger)shopnumber{
    loginsucess = sucess;
    product = shopnumber;
    SingleModel *model = [SingleModel sharedSingleModel];
    if (model.userkey !=nil&&!sucess) {
        [self addData:NO];
    }
    if (model.userkey!=nil&&sucess) {
        [self addData:YES];
    }
    if (model.userkey==nil) {
        login = [[LoginViewController alloc]init];
        login.delegate = self;
        login.iflogin = NO;
        [self.navigationController pushViewController:login animated:YES];
        
    }
}
#pragma mark logindelegate mathds
-(void)reloadata{
    if (loginsucess) {
        [login.navigationController popViewControllerAnimated:NO];
        [self addData:YES];
    }
    else{
        [login.navigationController popViewControllerAnimated:NO];
        [self addData:NO];
        
    }
}
-(void)ordercpntroller:(NSNumber *)orderid{
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"确认订单" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    OrderController *order = [[OrderController alloc]init];
    order.shopCartId = [NSString stringWithFormat:@"%@",orderid];
    [self.navigationController pushViewController:order animated:YES];
    
}
#pragma mark  加入购物车网络请求
-(void)addData:(BOOL)sucess{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%ld",product]];
    NSString *path = [NSString stringWithFormat:ADDMAINTAIN,COMMON,model.userkey,model.goodsId,string];
    NSLog(@"path--%@",path);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        UIAlertView *alertview;
        if ([dic[@"status"] integerValue]==1) {
            if (sucess) {
                alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"info"] delegate:self cancelButtonTitle:@"去购物车" otherButtonTitles:@"继续逛逛", nil];
            }
            else{
                [self.menuPopover removeFromSuperview];
                [self ordercpntroller:dic[@"data"]];
                
            }
        }
        else{
            if (sucess) {
                alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"info"] delegate:self cancelButtonTitle:@"重新提交" otherButtonTitles:@"取消", nil];
            }
            else{
                alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"订单提交失败" delegate:self cancelButtonTitle:@"重新提交" otherButtonTitles:@"取消", nil];
            }
            
        }
        [alertview show];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
#pragma mark  购物车点击事件以及代理
-(void)clickshopcratbutton{
    SingleModel *model = [SingleModel sharedSingleModel];
    if (model.userkey==nil) {
        login = [[LoginViewController alloc]init];
        login.delegate = self;
        login.iflogin = YES;
        [self.navigationController pushViewController:login animated:YES];
    }
    else{
        ShoppingCarController *shopcart = [[ShoppingCarController alloc]init];
        [self.navigationController pushViewController:shopcart animated:YES];
        
    }
}
-(void)reloadshopcart{
    [login.navigationController popViewControllerAnimated:NO];
    ShoppingCarController *shopcart = [[ShoppingCarController alloc]init];
    [self.navigationController pushViewController:shopcart animated:YES];
    
    
}
-(void)btnPress1{
    
    
    NSLog(@"%@",model1.data[@"转速"]);
    UILabel *goodsNameLb = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 50, 20)];
    goodsNameLb.text = @"商品名称:";
    goodsNameLb.font = [UIFont systemFontOfSize:10];
    goodsNameLb.textColor = [UIColor grayColor];
    [_detailView addSubview:goodsNameLb];
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNameLb.frame)-3, 10, 80, 20)];
    nameLb.text = @"明基KL1220E";
    nameLb.font = [UIFont systemFontOfSize:10];
    nameLb.textColor = [UIColor grayColor];
    [_detailView addSubview:nameLb];
    
    //
    UILabel *BrandLb = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(goodsNameLb.frame)+5, 40, 20)];
    BrandLb.text = @"品牌:";
    BrandLb.font = [UIFont systemFontOfSize:10];
    BrandLb.textColor = [UIColor grayColor];
    [_detailView addSubview:BrandLb];
    
    UILabel *Brand = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(BrandLb.frame)-3, BrandLb.frame.origin.y, 80, 20)];
    Brand.text = @"明基（BenQ）";
    Brand.font = [UIFont systemFontOfSize:10];
    Brand.textColor = [UIColor grayColor];
    [_detailView addSubview:Brand];
    
    UILabel *WeightLb = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(BrandLb.frame)+5, 60, 20)];
    WeightLb.text = @"商品毛重:";
    WeightLb.font = [UIFont systemFontOfSize:10];
    WeightLb.textColor = [UIColor grayColor];
    [_detailView addSubview:WeightLb];
    
    UILabel *Weight = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(WeightLb.frame)-3, WeightLb.frame.origin.y, 80, 20)];
    Weight.text = @"4.0kg";
    Weight.font = [UIFont systemFontOfSize:10];
    Weight.textColor = [UIColor grayColor];
    [_detailView addSubview:Weight];
    
    UILabel *panelLb = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(WeightLb.frame)+5, 40, 20)];
    panelLb.text = @"面板:";
    panelLb.font = [UIFont systemFontOfSize:10];
    panelLb.textColor = [UIColor grayColor];
    [_detailView addSubview:panelLb];
    
    UILabel *panel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(panelLb.frame)-3, panelLb.frame.origin.y, 80, 20)];
    panel.text = @"TN";
    panel.font = [UIFont systemFontOfSize:10];
    panel.textColor = [UIColor grayColor];
    [_detailView addSubview:panel];
    
    UILabel *sizeLb = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(panelLb.frame)+5, 40, 20)];
    sizeLb.text = @"尺寸:";
    sizeLb.font = [UIFont systemFontOfSize:10];
    sizeLb.textColor = [UIColor grayColor];
    [_detailView addSubview:sizeLb];
    
    UILabel *size = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sizeLb.frame)-3, sizeLb.frame.origin.y, 80, 20)];
    size.text = [NSString stringWithFormat:@"%@",model1.data[@"尺寸"]];
    size.font = [UIFont systemFontOfSize:10];
    size.textColor = [UIColor grayColor];
    [_detailView addSubview:size];
    
    
    UILabel *goodsNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNameLb.frame)+80, 10, 50, 20)];
    goodsNumberLb.text = @"商品编码:";
    goodsNumberLb.font = [UIFont systemFontOfSize:10];
    goodsNumberLb.textColor = [UIColor grayColor];
    [_detailView addSubview:goodsNumberLb];
    
    UILabel *numberLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(goodsNumberLb.frame)-3, 10, 80, 20)];
    numberLb.text = @"明基KL1220E";
    numberLb.font = [UIFont systemFontOfSize:10];
    numberLb.textColor = [UIColor grayColor];
    [_detailView addSubview:numberLb];
    
    //
    UILabel *timeLb = [[UILabel alloc]initWithFrame:CGRectMake(goodsNumberLb.frame.origin.x, CGRectGetMaxY(goodsNumberLb.frame)+5, 60, 20)];
    timeLb.text = @"上架时间:";
    timeLb.font = [UIFont systemFontOfSize:10];
    timeLb.textColor = [UIColor grayColor];
    [_detailView addSubview:timeLb];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(timeLb.frame)-3,timeLb.frame.origin.y, 100, 20)];
    time.text = @"2014-05-04 09:33:48";
    time.font = [UIFont systemFontOfSize:10];
    time.textColor = [UIColor grayColor];
    [_detailView addSubview:time];
    
    UILabel *fromLb = [[UILabel alloc]initWithFrame:CGRectMake(goodsNumberLb.frame.origin.x, CGRectGetMaxY(timeLb.frame)+5, 60, 20)];
    fromLb.text = @"商品产地:";
    fromLb.font = [UIFont systemFontOfSize:10];
    fromLb.textColor = [UIColor grayColor];
    [_detailView addSubview:fromLb];
    
    UILabel *from = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fromLb.frame)-3, fromLb.frame.origin.y, 80, 20)];
    from.text = @"中国大陆";
    from.font = [UIFont systemFontOfSize:10];
    from.textColor = [UIColor grayColor];
    [_detailView addSubview:from];
    
    UILabel *interfaceLb = [[UILabel alloc]initWithFrame:CGRectMake(goodsNumberLb.frame.origin.x, CGRectGetMaxY(fromLb.frame)+5, 40, 20)];
    interfaceLb.text = @"接口:";
    interfaceLb.font = [UIFont systemFontOfSize:10];
    interfaceLb.textColor = [UIColor grayColor];
    [_detailView addSubview:interfaceLb];
    
    UILabel *interface = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(interfaceLb.frame)-3, interfaceLb.frame.origin.y, 80, 20)];
    interface.text = @"DVI.VGA";
    interface.font = [UIFont systemFontOfSize:10];
    interface.textColor = [UIColor grayColor];
    [_detailView addSubview:interface];
    
    UILabel *proportionLb = [[UILabel alloc]initWithFrame:CGRectMake(goodsNumberLb.frame.origin.x, CGRectGetMaxY(interfaceLb.frame)+5, 40, 20)];
    proportionLb.text = @"比例:";
    proportionLb.font = [UIFont systemFontOfSize:10];
    proportionLb.textColor = [UIColor grayColor];
    [_detailView addSubview:proportionLb];
    
    UILabel *proportion = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(proportionLb.frame)-3, proportionLb.frame.origin.y, 80, 20)];
    proportion.text = @"16:9";
    proportion.font = [UIFont systemFontOfSize:10];
    proportion.textColor = [UIColor grayColor];
    [_detailView addSubview:proportion];
    
    
    
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
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
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
