//
//  GoodsBigViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/1.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "GoodsBigViewController.h"
#import "RDVTabBarController.h"
#import "CommodityViewController.h"
#import "TarBarButton.h"
@interface GoodsBigViewController ()

@end

@implementation GoodsBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    
    //    [ligthButton setTitle:@"确认订单" forState:UIControlStateNormal];
    //    [ligthButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftButton.font = [UIFont systemFontOfSize:14];
    // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"商品";
    int m = 80;
    
    NSArray *arrayImage = @[@"办公设备",@"办公文具",@"办公家具",@"二手商品"];
    
    for (int i = 0; i<4; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, m, 300, 98)];
        [button setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(GoodsBigBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        m = CGRectGetMaxY(button.frame)+10;
        
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)leftItemClicked{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];

    
}
-(void)GoodsBigBtn:(UIButton *)btn{

    CommodityViewController *cmd = [[CommodityViewController alloc]init];
    
    [self.navigationController pushViewController:cmd animated:YES];
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
