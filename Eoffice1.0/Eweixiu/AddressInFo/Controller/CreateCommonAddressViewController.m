//
//  CreateCommonAddressViewController.m
//  Eoffice1.0
//
//  Created by Janice on 15/12/2.
//  Copyright © 2015年 gl. All rights reserved.
//

#import "CreateCommonAddressViewController.h"
#import "TarBarButton.h"

@interface CreateCommonAddressViewController ()

@end

@implementation CreateCommonAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    //标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = @"选择常用地址";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = label;
    
    //返回按钮
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"zuo"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    //保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveInFo)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor lightGrayColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]}          forState:UIControlStateNormal];
}

- (void) saveInFo{
    NSLog(@"点击保存啦");
}

-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
