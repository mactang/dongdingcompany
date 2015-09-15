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
#import "MJRefresh.h"
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
/**
 *  随机颜色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
static const CGFloat MJDuration = 2.0;

@interface ComputerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeColors;
@property (strong,nonatomic)UICollectionView *collectionView;
/** 存放假数据 */
@property (strong, nonatomic) NSMutableArray *colors;
@property (strong, nonatomic) NSMutableArray *datas;



@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic, assign) NSInteger totalRowCount;

@property (nonatomic, weak) UIImageView *animationView;
@property (nonatomic, weak) UIImageView *boxView;
@property (nonatomic, weak) UILabel *label;

@end

@implementation ComputerViewController
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
- (NSMutableArray *)fakeColors
{
    if (!_fakeColors) {
        self.fakeColors = [NSMutableArray array];
        
        for (int i = 0; i<5; i++) {
            // 添加随机色
            [self.fakeColors addObject:MJRandomColor];
        }
    }
    return _fakeColors;
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    _totalRowCount = 3;
    [super viewDidLoad];
    [self data];
    [self character];
    
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setTitle:@"电脑及周边产品" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.font = [UIFont systemFontOfSize:14];
    // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
     [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    // 1.设置布局模式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 1.1设置item的大小
    [flowLayout setItemSize:CGSizeMake(150, 220)];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    // 1.2设置横向或者纵向排列
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    // 2.实例化collectionView控件
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 120, 320, 480) collectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    _collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_collectionView];
    // 2.集成刷新控件
   // [self addHeader];
    //[self addFooter];
    
    // 3.注册cell类型
    [_collectionView registerClass:[ComputerCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self setupHeader];
    [self setupFooter];
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
            self.totalRowCount += 3;
            [self.collectionView reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    //    normal状态执行的操作
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
    
    //    willRefresh状态执行的操作
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
    
    //    refreshing状态执行的操作
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

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshViewWithStyle:SDRefreshViewStyleClassical];
    [refreshFooter addToScrollView:self.collectionView];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.totalRowCount += 2;
        [self.collectionView reloadData];
        [self.refreshFooter endRefreshing];
    });
}

-(void)data{
    
    SingleModel *single = [SingleModel sharedSingleModel];
    NSLog(@"single.name--%@",single.ids);
    
    NSString *path= [NSString stringWithFormat:COMPUTER,single.ids];
    NSLog(@"path--%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
        NSLog(@"array--%@",array);
        for(NSDictionary *subDict in array)
        {
            detailsModel *model = [detailsModel modelWithDic:subDict];
            [self.datas addObject:model];
            NSLog(@"model.name--%@",self.datas);
        }
        }
        //刷新表
        [_collectionView reloadData];
      //  [self addHeader];
        
        
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
- (void)addHeader
{
    __weak __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 增加5条假数据
        for (int i = 0; i<4; i++) {
            detailsModel *model = self.datas[i];
            [weakSelf.datas insertObject:model atIndex:0];
            [_collectionView reloadData];
            
        }
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.header endRefreshing];
        });
    }];
    [_collectionView.header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 增加5条假数据
        for (int i = 0; i<4; i++) {
            detailsModel *model = self.datas[i];
            [weakSelf.datas addObject:model];
            
            [_collectionView reloadData];
            
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            
            // 结束刷新
            [weakSelf.collectionView.footer endRefreshing];
        });
    }];
    // [_collectionView.header beginRefreshing];
    // 默认先隐藏footer
    _collectionView.footer.hidden = YES;
}


#pragma mark - 数据相关
- (NSMutableArray *)colors
{
    if (!_colors) {
        self.colors = [NSMutableArray array];
    }
    return _colors;
}

// 设置每一组有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 设置尾部控件的显示和隐藏
    _collectionView.footer.hidden = self.colors.count ==2;
//    NSLog(@"%lu",(unsigned long)self.colors.count);
//    if (self.colors.count==0) {
//        return 8;
//    }else
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
  //  cell.titleLabel.text = [NSString stringWithFormat:@"%ld - %ld",(long)indexPath.section,(long)indexPath.row];
//    if (indexPath.row < 4) {
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    detailsModel *model = self.datas[indexPath.row];
    //  NSLog(@"%@",model.price);
    UIImageView *imageView = [[UIImageView  alloc]initWithFrame:CGRectMake(10, 5, 130, 140)];
    
    NSString *string = OFFICE
    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",string,model.imgUrl]]];
    NSLog(@"%@",imageView.image);
    [cell addSubview:imageView];
    
    UIButton *price = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+20, 80, 20)];
    //[price setTitle:@"322" forState:UIControlStateNormal];
    [price setTitle:[NSString stringWithFormat: @"￥%@",model.price]forState:UIControlStateNormal];
    [price setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    price.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell addSubview:price];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(price.frame), 130, 30)];
    lb1.font = [UIFont systemFontOfSize:10];
    lb1.lineBreakMode = NSLineBreakByTruncatingTail;
    lb1.numberOfLines = 2;
    lb1.text = @"Apple MacBook Pro MF839CH/A 13.3英寸宽屏笔记本电脑 128GB 闪存";
    [cell addSubview:lb1];
 //   }
    
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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *syntBT = [[UIButton alloc]initWithFrame:CGRectMake(40, 20, 50, 30)];
    //syntBT.backgroundColor = [UIColor brownColor];
    [syntBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [syntBT setTitle:@"综合" forState:UIControlStateNormal];
    [view addSubview:syntBT];
    
    UIButton *volumBT = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(syntBT.frame)+20, syntBT.frame.origin.y, 50, 30)];
    // volumBT.backgroundColor = [UIColor brownColor];
    [volumBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [volumBT setTitle:@"销量" forState:UIControlStateNormal];
    [view addSubview:volumBT];
    
    UIButton *priceBT = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(volumBT.frame)+20, volumBT.frame.origin.y, 50, 30)];
    //priceBT.backgroundColor = [UIColor brownColor];
    [priceBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [priceBT setTitle:@"价格" forState:UIControlStateNormal];
    [view addSubview:priceBT];
    
    UIButton *screenBT = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceBT.frame)+20, priceBT.frame.origin.y, 50, 30)];
    //  screenBT.backgroundColor = [UIColor brownColor];
    [screenBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [screenBT addTarget:self action:@selector(screenPress) forControlEvents:UIControlEventTouchUpInside ];
    [screenBT setTitle:@"筛选" forState:UIControlStateNormal];
    [view addSubview:screenBT];
    
    
    [self.view addSubview:view];
}
-(void)screenPress{
    
    ScreenViewController *scr = [[ScreenViewController alloc]init];
    
    [self.navigationController pushViewController:scr animated:YES];
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
