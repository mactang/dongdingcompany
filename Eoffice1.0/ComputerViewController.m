//
//  ComputerViewController.m
//  EOffice
//
//  Created by gyz on 15/7/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//



#import "ComputerViewController.h"
#import "ComputerCell.h"
#import "CMDetailsViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "BottonTabBarController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "ScreenViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "SingleModel.h"
#import "detailsModel.h"
#import "SDRefresh.h"
#import "TarBarButton.h"
#import "MJRefresh.h"
#import "classifyDetailaModel.h"
/**
 *  随机颜色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
static const CGFloat MJDuration = 2.0;

@interface ComputerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic)UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *datas;

@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;


@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;
@property(nonatomic,strong)NSString *string;
@end

@implementation ComputerViewController
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self character];
    [self data];
    
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setTitle:@"电脑及周边产品" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
}
-(void)initappreance{
    
    // 1.设置布局模式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 1.1设置item的大小
    [flowLayout setItemSize:CGSizeMake(150, 200)];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 1.2设置横向或者纵向排列
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // 2.实例化collectionView控件
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 124, SCREEN_WIDTH, SCREEN_HEIGHT-64-60) collectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    _collectionView.alwaysBounceVertical = YES;
    // 3.注册cell类型
    [_collectionView registerClass:[ComputerCell class] forCellWithReuseIdentifier:@"cell"];
    __weak __typeof(self) weakSelf = self;
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footrefreshdata];
        [weakSelf.collectionView.footer endRefreshing];
        
        }];
    [self.view addSubview:_collectionView];

    // 2.集成刷新控件
    [self setupHeader];

}
- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshViewWithStyle:SDRefreshViewStyleCustom];
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:self.collectionView];
    _refreshHeader = refreshHeader;
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self  refreshdata];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    //normal状态执行的操作
    refreshHeader.normalStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        refreshView.hidden = NO;
        if (progress == 0) {
            _animationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            _boxView.hidden = NO;
            _label.text = @"下拉加载数据";
            [_animationView stopAnimating];
        }
        
        self.animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(progress * 10, -20 * progress), CGAffineTransformMakeScale(progress, progress));
        self.boxView.transform = CGAffineTransformMakeTranslation(- progress * 85, progress * 35);
    };
    
    //willRefresh状态执行的操作
    refreshHeader.willRefreshStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        _boxView.hidden = YES;
        _label.text = @"放手刷新数据";
        _animationView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(10, -20), CGAffineTransformMakeScale(1, 1));
        NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                            [UIImage imageNamed:@"deliveryStaff1"],
                            [UIImage imageNamed:@"deliveryStaff2"],
                            [UIImage imageNamed:@"deliveryStaff3"]
                            ];
        _animationView.animationImages = images;
        [_animationView startAnimating];
    };
    
    //refreshing状态执行的操作
    refreshHeader.refreshingStateOperationBlock = ^(SDRefreshView *refreshView, CGFloat progress){
        _label.text = @"正在加载数据";
        [UIView animateWithDuration:1.5 animations:^{
            self.animationView.transform = CGAffineTransformMakeTranslation(200, -20);
        }];
    };
    // 动画view
    UIImageView *animationView = [[UIImageView alloc] init];
    animationView.frame = CGRectMake(30, 45, 40, 40);
    animationView.image = [UIImage imageNamed:@"staticDeliveryStaff"];
    [refreshHeader addSubview:animationView];
    _animationView = animationView;
    NSArray *images = @[[UIImage imageNamed:@"deliveryStaff0"],
                        [UIImage imageNamed:@"deliveryStaff1"],
                        [UIImage imageNamed:@"deliveryStaff2"],
                        [UIImage imageNamed:@"deliveryStaff3"]
                        ];
    _animationView.animationImages = images;
    UIImageView *boxView = [[UIImageView alloc] init];
    boxView.frame = CGRectMake(150, 10, 15, 8);
    boxView.image = [UIImage imageNamed:@"box"];
    [refreshHeader addSubview:boxView];
    _boxView = boxView;

    UILabel *label= [[UILabel alloc] init];
    label.frame = CGRectMake((self.view.bounds.size.width - 200) * 0.5, 5, 200, 20);
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [refreshHeader addSubview:label];
    _label = label;
    
    // 进入页面自动加载一次数据
//    [refreshHeader beginRefreshing];
}
-(void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)data{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *single = [SingleModel sharedSingleModel];
    NSLog(@"single.name--%@",single.ids);
    NSString *path= [NSString stringWithFormat:COMPUTER,COMMON,single.ids,@"0"];
    NSLog(@"path--%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        [self.datas removeAllObjects];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
        for(NSDictionary *subDict in array)
        {
            detailsModel *model = [detailsModel modelWithDic:subDict];
            [self.datas addObject:model];
            NSLog(@"model.name--%@",self.datas);
        }
        }
        [self initappreance];
        [_collectionView reloadData];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}
-(void)refreshdata{
    SingleModel *single = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:COMPUTER,COMMON,single.ids,@"0"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
          [self.datas removeAllObjects];
        if (dic[@"data"] !=[NSNull null]){
            NSArray *array = dic[@"data"];
            NSLog(@"array--%@",array);
            for(NSDictionary *subDict in array)
            {
                detailsModel *model = [detailsModel modelWithDic:subDict];
                [self.datas addObject:model];
                NSLog(@"model.name--%@",self.datas);
            }
            //刷新表
            [_collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)footrefreshdata{
    SingleModel *single = [SingleModel sharedSingleModel];
    NSInteger pageNumber = [self.datas count] / 6 + 1;
    self.string = [NSString stringWithFormat:@"%ld",(long)pageNumber];
    NSLog(@"%@",self.string);
    NSString *path= [NSString stringWithFormat:COMPUTER,COMMON,single.ids,self.string];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
        if (dic[@"data"] !=[NSNull null]){
            NSArray *array = dic[@"data"];
            for(NSDictionary *subDict in array)
            {
                detailsModel *model = [detailsModel modelWithDic:subDict];
                [self.datas addObject:model];
            }
            //刷新表
            [_collectionView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)leftBtn{
    
    // [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    // [(BottonTabBarController*)self.tabBarController hideTabBar:NO];
    
}

// 设置每一组有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return self.datas.count;
    
}

// 设置一共有多少个分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cell";
    // 如复用池中没有则会自动实例化
    ComputerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellName forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld - %ld",(long)indexPath.section,(long)indexPath.row);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    detailsModel *model = self.datas[indexPath.row];
    SingleModel *sing = [SingleModel sharedSingleModel];
    
    sing.wGoodsId = model.wGoodsId;
    sing.paraId = model.productId;
    sing.goodsId = model.wGoodsId;
    NSLog(@"%@",sing.goodsId);
    sing.cPartnerId = model.bparterId;
    sing.price = model.price;
    CMDetailsViewController *detail = [[CMDetailsViewController alloc]init];
    
    [self.navigationController pushViewController:detail animated:YES];
    //  [(BottonTabBarController*)self.tabBarController hideTabBar:YES];
}
-(void)character{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    classifyDetailaModel *syntBT = [[classifyDetailaModel alloc]initWithFrame:CGRectMake(40, 20, 50, 30)];
    //syntBT.backgroundColor = [UIColor brownColor];
    [syntBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [syntBT setImage:[UIImage imageNamed:@"classify"] forState:UIControlStateNormal];
    [syntBT setTitle:@"综合" forState:UIControlStateNormal];
    syntBT.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:syntBT];
    
    UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(syntBT.frame)-10, syntBT.frame.origin.y+12, 13, 13)];
    [button setImage:[UIImage imageNamed:@"clBelow"] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:@"below2"] forState:UIControlStateSelected];
    button.tag = 100;
    [view addSubview:button];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+8, syntBT.frame.origin.y+5, 0.5, 25)];
    lb.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    [view addSubview:lb];
    
    UIButton *volumBT = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(syntBT.frame)+20, syntBT.frame.origin.y+3, 50, 30)];
    // volumBT.backgroundColor = [UIColor brownColor];
    [volumBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [volumBT setTitle:@"销量" forState:UIControlStateNormal];
    volumBT.titleLabel.font = [UIFont systemFontOfSize:15];;
    [view addSubview:volumBT];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(volumBT.frame)+8, syntBT.frame.origin.y+5, 0.5, 25)];
    lb1.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    [view addSubview:lb1];
    
    UIButton *priceBT = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(volumBT.frame)+20, volumBT.frame.origin.y, 50, 30)];
    //priceBT.backgroundColor = [UIColor brownColor];
    [priceBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [priceBT setTitle:@"价格" forState:UIControlStateNormal];
    priceBT.titleLabel.font = [UIFont systemFontOfSize:15];
    priceBT.tag = 30;
    [priceBT addTarget:self action:@selector(screenPress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:priceBT];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceBT.frame)+8, syntBT.frame.origin.y+5, 0.5, 25)];
    lb2.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    [view addSubview:lb2];
    
    UIButton *screenBT = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceBT.frame)+20, priceBT.frame.origin.y, 50, 30)];
    //  screenBT.backgroundColor = [UIColor brownColor];
    [screenBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [screenBT addTarget:self action:@selector(screenPress:) forControlEvents:UIControlEventTouchUpInside ];
    [screenBT setTitle:@"筛选" forState:UIControlStateNormal];
    screenBT.tag = 31;
    screenBT.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:screenBT];
    
    UIButton *button1  = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(screenBT.frame), screenBT.frame.origin.y+12, 13, 13)];
    [button1 setImage:[UIImage imageNamed:@"clBelow"] forState:UIControlStateNormal];
   // [button1 setImage:[UIImage imageNamed:@"below2"] forState:UIControlStateSelected];
    [view addSubview:button1];
    
    [self.view addSubview:view];
}
-(void)screenPress:(UIButton *)button{
    if (button.tag==30) {
        [self pricerelodata];
    }
    if (button.tag==31) {
        ScreenViewController *scr = [[ScreenViewController alloc]init];
        
        [self.navigationController pushViewController:scr animated:YES];
    }
}
-(void)pricerelodata{
    
    SingleModel *single = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:COMPUTER,COMMON,single.ids,@"0"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.datas removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.datas removeAllObjects];
        if (dic[@"data"] !=[NSNull null]){
            NSArray *array = dic[@"data"];
       
            for(NSDictionary *subDict in array)
            {
                detailsModel *model = [detailsModel modelWithDic:subDict];
                [self.datas addObject:model];

            }
        }
     
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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


@end
