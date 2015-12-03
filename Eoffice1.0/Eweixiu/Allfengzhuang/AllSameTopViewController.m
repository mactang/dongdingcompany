//
//  AllSameTopViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/12/3.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AllSameTopViewController.h"
#import "TarBarButton.h"
#import "photoAlterView.h"
@interface AllSameTopViewController ()

@end

@implementation AllSameTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"zuo"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIButton *rightbutton = [UIButton buttonWithType: UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, 0, 30, 30);
    [rightbutton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    UIBarButtonItem *lightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    [rightbutton addTarget:self action:@selector(rightbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:lightItem];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = self.titleLabel;

}
-(void)rightbuttonClick{
    photoAlterView *alter=[[photoAlterView alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"呼叫"];
    alter.phoneNumber = @"4000-456-423";
    alter.rightBlock=^()
    {
        NSLog(@"右边按钮被点击");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000456423"]];
    };
    alter.leftBlock=^()
    {
        NSLog(@"左边按钮被点击");
    };
    alter.dismissBlock=^()
    {
        NSLog(@"窗口即将消失");
    };
    [alter show];
    
}
-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}
@end
