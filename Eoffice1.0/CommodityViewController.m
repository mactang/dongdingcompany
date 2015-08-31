//
//  CommodityViewController.m
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CommodityViewController.h"
#import "LeftSlideViewController.h"
#import "LeftSortsViewController.h"
#import "MainViewController.h"
#import "ComputerViewController.h"
#import "BottonTabBarController.h"
#import "RDVTabBarController.h"
#import "AFNetworking.h"
#import "CategoryBig.h"
#import "SingleModel.h"
#import "CMDetailsViewController.h"

@interface CommodityViewController ()

@property(nonatomic, strong)UISearchBar *searchBar;

@property(nonatomic, strong)NSMutableArray *datas;
@property(nonatomic, strong)UIButton *userBtn;
@end

@implementation CommodityViewController
{

    UITextField *searchField;
}

//懒加载
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self data];
    self.view.backgroundColor = [UIColor whiteColor];
    //    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"＜商品" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtn)];
    //    [self.navigationItem setLeftBarButtonItem:logoutItem];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cbt = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 20, 40)];
    [cbt addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    [cbt setImage:[UIImage imageNamed:@"椭圆-5.png"] forState:UIControlStateNormal];
    cbt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cbt];
//    
//    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 64, 300, 40)];
//    [self.view addSubview:self.searchBar];
//    self.searchBar.clipsToBounds = YES;
//    //self.searchBar.layer.cornerRadius = 10;
////    self.searchBar.layer.borderColor = [[UIColor whiteColor]CGColor];
////    self.searchBar.layer.borderWidth = 5;
//
//    // self.searchBar.backgroundImage = [UIImage imageNamed:@"sousuobeijing"];
//    // [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"sousuobeijing"] forState:UIControlStateNormal];
//    
//    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
//    self.searchBar.autocapitalizationType = UIKeyboardAppearanceDefault;
//   // [self.searchBar setShowsCancelButton:YES animated:YES];
//    self.searchBar.backgroundColor = [UIColor grayColor];
//    self.searchBar.delegate = self;
//    self.searchBar.placeholder = @"输入商家、分类和产品";
//   // self.searchBar.backgroundImage = [UIImage imageNamed:@"link.jpg"];
//   // self.searchBar.tintColor = [UIColor grayColor];
//    NSUInteger numViews = [self.searchBar.subviews count];
//    for(int i = 0; i < numViews; i++) {
//        if([[self.searchBar.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
//            searchField = [self.searchBar.subviews objectAtIndex:i];
//        }
//    }
//    if(!(searchField == nil)) {
//        searchField.textColor = [UIColor whiteColor];
//        [searchField setBackground: [UIImage imageNamed:@"link.jpg"]];//在这添加灰色的图片
//        [searchField setBorderStyle:UITextBorderStyleNone];
//    }

    [self createSearch];
    [self button];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 280, 320, 80)];
    imageview.image = [UIImage imageNamed:@"heibaiyitiji"];
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    [btn addTarget:self action:@selector(btntuPress) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:btn];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 360, 320, 220)];
    view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.view addSubview:view];
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 150, 180)];
    imageview1.image = [UIImage imageNamed:@"air.jpg"];
    imageview1.userInteractionEnabled = YES;
    [view addSubview:imageview1];
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview1.frame)+10, 10, 150, 180)];
    imageview2.image = [UIImage imageNamed:@"Lenovo.jpg"];
    imageview2.userInteractionEnabled = YES;
    [view addSubview:imageview2];
    
}
-(void)createSearch{
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(20, 44, 300, 60)];
    //蓝色
    //    searchView.backgroundColor = [UIColor colorWithRed:0.24f green:0.67f blue:0.91f alpha:1.00f];
    
    searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchView];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20,  300 , 40)];
    _searchBar.backgroundColor = [UIColor clearColor];
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"qq"]];
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UIKeyboardAppearanceDefault;
    _searchBar.placeholder = @"输入商家、分类和产品";
    _searchBar.delegate = self;
    
    for (UIView *subView in _searchBar.subviews) {
        //如果 子视图是uiview 并且子视图数量大于0,那么删除子视图
        if ([subView isKindOfClass:NSClassFromString(@"UIView")] && subView.subviews.count > 0) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    
    
    [searchView addSubview:_searchBar];
}
-(void)btntuPress{
    CMDetailsViewController *cm = [[CMDetailsViewController alloc]init];
    [self.navigationController pushViewController:cm animated:YES];
}
-(void)openOrCloseLeftList{
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc]init];
    
    //    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"商品" style:UIBarButtonItemStylePlain target:nil action:nil];
    //    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:leftVC animated:YES];
    
}


-(void)data{
    
    NSString *path= COMMODITYMIDDLE;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"data"];
        NSLog(@"array--%@",array);
        for(NSDictionary *subDict in array)
        {
            CategoryBig *model = [CategoryBig modelWithDic:subDict];
            [self.datas addObject:model];
            NSLog(@"model.name--%@",self.datas);
        }
        //刷新表
        
        [self button];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
}

- (void)leftBtn{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)button{
    int x = 40;
    int y = 120;
    int m = 20;
    int n = 160;
    
    
    NSArray *imageName = @[@"pos1",@"zhizhang1",@"diannao1",@"dayingji1",@"chuanzhengji1"];
    for (int i = 0; i<self.datas.count; i++) {
        if (i == 0 || i%3 != 0) {
            
            CategoryBig *model = self.datas[i];
            NSLog(@"%@",model.name);
            UIButton *paperBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 24, 24)];
            [paperBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            [paperBtn setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
            paperBtn.tag = 1000+i;
            
            [self.view addSubview:paperBtn];
            x = x +50+50;
            
            UILabel *paperLB = [[UILabel alloc]initWithFrame:CGRectMake(m, n, 80, 20)];
            paperLB.font = [UIFont systemFontOfSize:12];
            [paperLB setText:model.name];
            [self.view addSubview:paperLB];
            m = 80 + m +30;
            
        }
        else{
            CategoryBig *model = self.datas[i];
            
            x = 40;
            y = 180  + 25;
            UIButton *paperBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 24, 24)];
            [paperBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            [paperBtn setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
            paperBtn.tag = 1000 + i;
            [self.view addSubview:paperBtn];
            x = x +50+50;
            
            m = 20;
            n = 244;
            UILabel *paperLB = [[UILabel alloc]initWithFrame:CGRectMake(m, n, 80, 20)];
            paperLB.font = [UIFont systemFontOfSize:12];
            [paperLB setText:model.name];
            [self.view addSubview:paperLB];
            m = 80 + m +30;
            
        }
        
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

-(void)btnPress:(UIButton *)btn{
    SingleModel *single = [SingleModel sharedSingleModel];
    
    CategoryBig *model = self.datas[btn.tag-1000];
    
    NSLog(@"%@",model.MProductMedcategoryId);
    //将值存储到单例对象里面
    single.ids = model.MProductMedcategoryId;
    ComputerViewController *cmp = [[ComputerViewController alloc]init];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"办公电脑" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    [self.navigationController pushViewController:cmp animated:YES];
    
    
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
