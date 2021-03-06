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
#import "UIKit+AFNetworking.h"
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
#import "CalculateStringSpace.h"
#import "UIKit+AFNetworking.h"

#import "OneSectionTableViewCell.h"
#import "CMDetailsTableviewCell.h"
#import "CMDimageTableViewCell.h"

#import "ShopCarModel.h"
#import "RegisterViewController.h"

#define kWidthOfScreen [UIScreen mainScreen].bounds.size.width
@interface CMDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MenuPopoverDelegate,UMSocialUIDelegate,logindelegate,sharedelegate,ShoppingCarControllerDeledate,registerdelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)UIImageView *immgeView;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong)UIButton *detailButton;

@property(nonatomic, strong)UIPageControl *pageControl;

@property(nonatomic,strong) MenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;

@property(nonatomic,strong)UIView *carView;

@property(nonatomic,strong)UIButton *numberbutton;

@property (nonatomic, strong) BBBadgeBarButtonItem *messageItem;

@property(nonatomic, strong)NSMutableArray *datas;

//@property(nonatomic, assign) BOOL isLogin;

@property(nonatomic, strong)NSString *back;

@property(nonatomic, strong)NSMutableArray *parameterDatas;
@property(nonatomic, strong)NSMutableArray *cartCount;

@end

@implementation CMDetailsViewController
{
    // 记录当前是第几页
    int _currentIndex;
    // 装载所有的image
    NSMutableArray *_imagesArray;
    
   
    LoginViewController *login;
    BOOL loginsucess;
    NSInteger  product;
    NSMutableDictionary *dictionary;
    detailsModel *model1;
    BOOL reloadsucess;
    NSArray *imageviewarray;
    UITableViewHeaderFooterView  *headerviewrelaod;
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)cartCount{

    if (_cartCount == nil) {
        _cartCount = [NSMutableArray array];
    }
    return _cartCount;
}
-(NSMutableArray *)parameterDatas{
    if (_parameterDatas == nil) {
        _parameterDatas = [NSMutableArray array];
    }
    return _parameterDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
   }
    reloadsucess = YES;
    dictionary = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
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
    self.navigationItem.title = @"商品详情";
    [self data];
    // Do any additional setup after loading the view.
}
-(void)initaliAppreance{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-50) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    // _tableView.showsVerticalScrollIndicator = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _carView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-114, SCREEN_HEIGHT, 50)];
    _carView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_carView];
    [self shopTabBar];
    SingleModel *model = [SingleModel sharedSingleModel];
    if (model.userkey!=nil) {
       [self cartCountData];
    }
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

- (void)cartCountData{

    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:SHOPCAR,COMMON,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            NSArray *array = dic[@"data"];
            if (array.count==0) {
                _numberbutton.backgroundColor = [UIColor clearColor];
            }
            else{
                _numberbutton.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1];
            }
            for(NSDictionary *subDict in array)
            {
                ShopCarModel *model = [ShopCarModel modelWithDic:subDict];
                [self.cartCount addObject:model];
                
            }
           
        [_numberbutton setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.cartCount.count] forState:UIControlStateNormal];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
    _numberbutton.clipsToBounds = YES;
    _numberbutton.layer.cornerRadius = 10;
    [_numberbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SingleModel *model = [SingleModel sharedSingleModel];
    if (model.userkey!=nil) {
        _numberbutton.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1];
    }
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
        
//        int addNum = [[NSString stringWithFormat:@"%@",_numberbutton.titleLabel.text]intValue] + number;
//        
//        [_numberbutton setTitle:[NSString stringWithFormat:@"%d",addNum+1] forState:UIControlStateNormal];
//        number = number +1;
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
        [self parameterData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
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
        if (reloadsucess) {
            if ([model1.data allKeys].count==1||[model1.data allKeys].count==2) {
                return 50.5+5;
            }
            if (([model1.data allKeys].count)%2==0) {
                return (([model1.data allKeys] .count)/2)*45+5;
            }
            else{
                return (([model1.data allKeys].count)/2)*45+50+5;
            }

        }
        return imageviewarray.count*(SCREEN_WIDTH/2)+imageviewarray.count*10;
    }
    else if(indexPath.section == 0&&indexPath.row == 0){
        return 170;
    }
    else if(indexPath.section == 0&&indexPath.row == 1){
        return 70;
    }
    
    else{
        return 60;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==3) {
        NSString *headerIndentifier = @"MyHeader";
        UITableViewHeaderFooterView *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIndentifier];
        if (!headerviewrelaod) {
            headerview = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIndentifier];
            headerview.contentView.backgroundColor =[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
            HMSegmentedControl *segmentedControl2 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"图文详情", @"产品参数",@"推荐产品"]];
            segmentedControl2.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
            segmentedControl2.selectionIndicatorHeight = 2.0f;
            segmentedControl2.backgroundColor = [UIColor whiteColor];
            segmentedControl2.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            segmentedControl2.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
            [segmentedControl2 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
            [headerview addSubview:segmentedControl2];
             headerviewrelaod = headerview;
        }
        return headerviewrelaod;

    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==3) {
        return 52;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==3) {
        return 0.5;
    }
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        OneSectionTableViewCell *cell = [OneSectionTableViewCell cellWithTableView:tableView cellnumber:indexPath.row];
        cell.model = self.datas[indexPath.section];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else{
        if (reloadsucess) {
            CMDetailsTableviewCell *cell = [CMDetailsTableviewCell cellWithTableView:tableView cellnumber:indexPath.section];
            cell.model = model1;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.section==1||indexPath.section==2) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else{
                cell.indexpathsection = indexPath.section;
                
            }
            return cell;
        }

        else{
            if (indexPath.section==1||indexPath.section==2) {
                CMDetailsTableviewCell *cell = [CMDetailsTableviewCell cellWithTableView:tableView cellnumber:indexPath.section];
                cell.model = model1;
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
            else{
                 CMDimageTableViewCell *cell = [CMDimageTableViewCell cellWithTableView:tableView];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
                 cell.model = self.datas[0];
                 return cell;
                
            }
        }
        
    }
    
}
#pragma mark sharedelegate methads
-(void)sharedelegate{
    [self fenxClicked];
}
-(void)fenxClicked{
    
    NSLog(@",,");
    //            //友盟分享的appKey
    //        [UMSocialData setAppKey:@"5211818556240bc9ee01db2f"];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    //    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
        //设置手机QQ的AppId，指定你的分享url，若传nil，将使用友盟的网址
        [UMSocialQQHandler setQQWithAppId:@"1104934732" appKey:@"3QLZa0n70Sfom2um" url:@"http://www.umeng.com/social"];
    
    
    //        注意：要想进行qq微信分享，下面的设置是必须的
    //       设置微信的appId url设置为空，默认使用友盟的网址
          //  [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:@""];
    [UMSocialWechatHandler setWXAppId:@"wxd20a08d7a7efd6b4" appSecret:@"7ac03523b9ee4296d2adf49648702c62" url:nil];
    
//            [UMSocialConfig setQQAppId:@"100424468" url:nil importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
    
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5631871667e58ebeff003677"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects: UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToTencent,UMShareToSms, nil]
                                       delegate:self];
}
- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentedControl{

    if (segmentedControl.selectedSegmentIndex == 0) {
        
        reloadsucess = YES;

        NSLog(@"aaa");
        
    }
    if (segmentedControl.selectedSegmentIndex == 1) {
        reloadsucess = NO;
        detailsModel *model = self.datas[0];
        imageviewarray = [model.detaiImgUrl componentsSeparatedByString:@","];
        NSLog(@"bbb");
        
    }
    if (segmentedControl.selectedSegmentIndex == 2) {
        
        
        NSLog(@"ccc");
        
        
    }
    [_tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        
        ContrastViewController *contrast = [[ContrastViewController alloc]init];
        
        [self.navigationController pushViewController:contrast animated:NO];
    }
    if (indexPath.section==2) {
        [self showMenuPopOver];
    }
}
- (void)showMenuPopOver
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            
            detailsModel *model = [detailsModel modelWithDic:dic];
            [self.parameterDatas addObject:model];
        }
        model1 = self.parameterDatas[0];
        [hud hide:YES];
        [self initaliAppreance];
        [_tableView reloadData];

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
        self.navigationController.navigationBarHidden = NO;
        [self addData:NO];
    }
    if (model.userkey!=nil&&sucess) {
        
        [self addData:YES];
        
    }
    if (model.userkey==nil) {
        
        login = [[LoginViewController alloc]init];
        login.delegate = self;
        login.iflogin = NO;
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:login animated:YES];
        
    }
}
#pragma mark logindelegate mathds
-(void)reloadata{
    
    [self.cartCount removeAllObjects];
    [self cartCountData];
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
    SingleModel *model = [SingleModel sharedSingleModel];
    OrderController *order = [[OrderController alloc]init];
    order.shopCartId = [NSString stringWithFormat:@"%@",orderid];
    order.goodsId = [NSString stringWithFormat:@"%@",model.goodsId];
    [self.navigationController pushViewController:order animated:YES];
    
}
#pragma mark  加入购物车网络请求
-(void)addData:(BOOL)sucess{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%ld",(long)product]];
    NSString *path = [NSString stringWithFormat:ADDMAINTAIN,COMMON,model.userkey,model.goodsId,string];
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
                alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:dic[@"info"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alertview.tag = 20;
                [self.menuPopover removeFromSuperview];
                
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        if (alertView.tag == 20) {
            
            [self.cartCount removeAllObjects];
            [self cartCountData];
            
        }
    }else{
        
        NSLog(@"oo");
    }
    
    
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
        shopcart.shopNumber = @"relead";
        shopcart.delegate = self;
        [self.navigationController pushViewController:shopcart animated:YES];
        
    }
}
-(void)reloadshopcart{
    
    [login.navigationController popViewControllerAnimated:NO];
    ShoppingCarController *shopcart = [[ShoppingCarController alloc]init];
    shopcart.delegate = self;
    [self.navigationController pushViewController:shopcart animated:YES];
}
-(void)releadCartNumber{
    [self.cartCount removeAllObjects];
    [self cartCountData];
}
-(void)toRegister{
    self.navigationController.navigationBarHidden = YES;
    RegisterViewController *registerview = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerview animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    SingleModel *model = [SingleModel sharedSingleModel];
    if (model.userkey!=nil) {
        _numberbutton.backgroundColor = [UIColor colorWithRed:255/255.0 green:204/255.0 blue:0/255.0 alpha:1];
    }
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
@end
