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
#import "ButtonImageWithTitle.h"
#import "TarBarButton.h"
#import "UIAlertView+AlerViewBlocks.h"
@interface CommodityViewController ()

@property(nonatomic, strong)UISearchBar *searchBar;

@property(nonatomic, strong)NSMutableArray *datas;

@property(nonatomic,strong)UIScrollView *myscrollview;

@end

@implementation CommodityViewController
//懒加载
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(void)setIdstring:(NSString *)idstring{
    _idstring = idstring;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setTitle:@"办公设备" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIButton *cbt = [[UIButton alloc]initWithFrame:CGRectMake(5, 75, 30, 25)];
    [cbt addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    [cbt setImage:[UIImage imageNamed:@"classify1"] forState:UIControlStateNormal];
    cbt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cbt];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(CGRectGetMaxX(cbt.frame)+5, 71, SCREEN_WIDTH-60, 33)];
    [self.view addSubview:self.searchBar];
    
    self.myscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(self.searchBar.frame))];
    self.myscrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    self.myscrollview.showsVerticalScrollIndicator = YES;
    self.myscrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myscrollview];
    
    self.searchBar.backgroundColor = [UIColor colorWithRed:232./255 green:232./255 blue:232./255 alpha:1];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"输入商家、分类和产品";
    for (UIView *view in self.searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    for (UIView* subview in [[self.searchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)subview;
            textField.backgroundColor = [UIColor colorWithRed:232./255 green:232./255 blue:232./255 alpha:1];
        }
    }
    self.searchBar.clipsToBounds = YES;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.layer.cornerRadius = 15;
    [self data];
}
-(void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)btntuPress{
    CMDetailsViewController *cm = [[CMDetailsViewController alloc]init];
    [self.navigationController pushViewController:cm animated:YES];
}
-(void)openOrCloseLeftList{
    
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc]init];
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"商品" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:leftVC animated:NO];
    
}
-(void)data{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";

    NSString *path= [NSString stringWithFormat:COMMODITYMIDDLE,COMMON,_idstring];
    
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
        for (NSInteger i=0; i<self.datas.count; i++) {
            CategoryBig *model = [[CategoryBig alloc]init];
            model = self.datas[i];
            NSArray *imageName = @[@"pos1",@"zhizhang1",@"diannao1",@"dayingji1",@"chuanzhengji1"];
            ButtonImageWithTitle  *button = [[ButtonImageWithTitle alloc]initWithFrame:CGRectMake(15+(i%3)*((SCREEN_WIDTH-60)/3)+(i%3)*15, 25+(i/3)*70, (SCREEN_WIDTH-60)/3, (SCREEN_WIDTH-55)/4)];
            [button setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
            [button setTitle:model.name forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = 1000+i;
            [button addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor whiteColor];
//          button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
            [self.myscrollview addSubview:button];
            if (i==self.datas.count-1) {
                [self imageviewdata:button];
            }
        }
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        if (error.code==-1004) {
            
            [UIAlertView showMsgWithTitle:@"温馨提示" promptmessage:@"连接服务器失败" confirm:@"点击重试" cancel:@"取消" blocks:^(NSInteger index) {
                [self data];
            }];
            
        }
        if (error.code==-1001) {
            [UIAlertView showMsgWithTitle:@"温馨提示" promptmessage:@"连接超时" confirm:@"点击重试" cancel:@"取消" blocks:^(NSInteger index) {
                [self data];
            }];
        }
        if (error.code==-1005) {
            
            [UIAlertView showMsgWithTitle:@"温馨提示" promptmessage:@"网络连接失败" confirm:@"点击重试" cancel:@"取消" blocks:^(NSInteger index) {
                [self data];
            }];
            
        }

    }];
}
-(void)imageviewdata:(UIButton *)buttonframe{
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonframe.frame)+20, 320, 80)];
    imageview.image = [UIImage imageNamed:@"heibaiyitiji.png"];
    imageview.userInteractionEnabled = YES;
    [self.myscrollview addSubview:imageview];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/4)];
    [btn addTarget:self action:@selector(btntuPress) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:btn];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageview.frame), SCREEN_WIDTH, SCREEN_WIDTH*0.7)];
    view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.myscrollview addSubview:view];
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH/2-10, SCREEN_WIDTH*0.57)];
    imageview1.image = [UIImage imageNamed:@"air.jpg"];
    imageview1.userInteractionEnabled = YES;
    [view addSubview:imageview1];
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageview1.frame)+10, 10, SCREEN_WIDTH/2-10, SCREEN_WIDTH*0.57)];
    imageview2.image = [UIImage imageNamed:@"Lenovo.jpg"];
    imageview2.userInteractionEnabled = YES;
    [view addSubview:imageview2];
    
    self.myscrollview.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(view.frame));

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
    
    NSLog(@"%@",model.MProductCategoryId);
    //将值存储到单例对象里面
    single.ids = model.MProductCategoryId;
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

 */

@end
