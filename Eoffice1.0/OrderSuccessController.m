//
//  OrderSuccessController.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderSuccessController.h"
#import "TarBarButton.h"
#import "RDVTabBarController.h"
#import "OrderViewController.h"
#import "MainViewController.h"

@interface OrderSuccessController ()

@end

@implementation OrderSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    TarBarButton *ligthButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    ligthButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    self.navigationItem.title = @"订单成功";
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 75, 300, 330)];
    view.backgroundColor = [UIColor whiteColor];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 4;
    [self.view addSubview:view];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 40, 30, 30)];
    [button setImage:[UIImage imageNamed:@"大勾"] forState:UIControlStateNormal];
    button.selected = NO;
    [view addSubview:button];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+10, 30, 130, 22)];
    lb1.text = @"订单提交成功 !";
    lb1.font = [UIFont systemFontOfSize:18];
    lb1.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [view addSubview:lb1];
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(lb1.frame.origin.x, CGRectGetMaxY(lb1.frame)+7, 180, 20)];
    lb2.text = @"我们的客服会尽快给你准备发货 ! !";
    lb2.font = [UIFont systemFontOfSize:11];
    lb2.textColor = [UIColor grayColor];
    [view addSubview:lb2];
    
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lb2.frame)+7, 280, 0.5)];
    lb3.backgroundColor = [UIColor grayColor];
    [view addSubview:lb3];
    
    UILabel *orderLb = [[UILabel alloc]initWithFrame:CGRectMake(lb3.frame.origin.x, CGRectGetMaxY(lb3.frame)+7, 40, 20)];
    orderLb.text = @"订单号:";
    orderLb.font = [UIFont systemFontOfSize:12];
    orderLb.textColor = [UIColor blackColor];
    [view addSubview:orderLb];
    
    UILabel *order = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(orderLb.frame)+4, CGRectGetMaxY(lb3.frame)+7, 150, 20)];
    order.text = @"123456331241213117";
    order.font = [UIFont systemFontOfSize:12];
    order.textColor = [UIColor blackColor];
    [view addSubview:order];
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(lb3.frame.origin.x, CGRectGetMaxY(order.frame)+7, 40, 20)];
    nameLb.text = @"收件人:";
    nameLb.font = [UIFont systemFontOfSize:12];
    nameLb.textColor = [UIColor blackColor];
    [view addSubview:nameLb];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLb.frame)+4, CGRectGetMaxY(order.frame)+7, 150, 20)];
    name.text = @"东鼎泰和";
    name.font = [UIFont systemFontOfSize:12];
    name.textColor = [UIColor blackColor];
    [view addSubview:name];
    
    UILabel *phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(lb3.frame.origin.x, CGRectGetMaxY(name.frame)+7, 58, 20)];
    phoneLb.text = @"手机号码:";
    phoneLb.font = [UIFont systemFontOfSize:12];
    phoneLb.textColor = [UIColor blackColor];
    [view addSubview:phoneLb];
    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLb.frame)+2, CGRectGetMaxY(name.frame)+7, 150, 20)];
    phone.text = @"12345678901";
    phone.font = [UIFont systemFontOfSize:12];
    phone.textColor = [UIColor blackColor];
    [view addSubview:phone];
    
    UILabel *addressLb = [[UILabel alloc]initWithFrame:CGRectMake(lb3.frame.origin.x, CGRectGetMaxY(phone.frame)+7, 58, 20)];
    addressLb.text = @"收货地址:";
    addressLb.font = [UIFont systemFontOfSize:12];
    addressLb.textColor = [UIColor blackColor];
    [view addSubview:addressLb];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressLb.frame)+2, CGRectGetMaxY(phone.frame)+7, 200, 20)];
    address.text = @"成都市丰德国际广场B1座12楼";
    address.font = [UIFont systemFontOfSize:12];
    address.textColor = [UIColor blackColor];
    [view addSubview:address];
    
    UILabel *payWayLb = [[UILabel alloc]initWithFrame:CGRectMake(lb3.frame.origin.x, CGRectGetMaxY(address.frame)+7, 58, 20)];
    payWayLb.text = @"支付方式:";
    payWayLb.font = [UIFont systemFontOfSize:12];
    payWayLb.textColor = [UIColor blackColor];
    [view addSubview:payWayLb];
    
    UILabel *payWay = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(payWayLb.frame)+2, CGRectGetMaxY(address.frame)+7, 150, 20)];
    payWay.text = @"货到付款";
    payWay.font = [UIFont systemFontOfSize:12];
    payWay.textColor = [UIColor blackColor];
    [view addSubview:payWay];
    
    UILabel *amountLb = [[UILabel alloc]initWithFrame:CGRectMake(lb3.frame.origin.x, CGRectGetMaxY(payWay.frame)+7, 40, 20)];
    amountLb.text = @"金额:￥";
    amountLb.font = [UIFont systemFontOfSize:12];
    amountLb.textColor = [UIColor blackColor];
    [view addSubview:amountLb];
    
    UILabel *amount = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(amountLb.frame)+4, CGRectGetMaxY(payWay.frame)+7, 150, 20)];
    amount.text = @"888888.000";
    amount.font = [UIFont systemFontOfSize:12];
    amount.textColor = [UIColor blackColor];
    [view addSubview:amount];
    
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(amount.frame)+7, 280, 0.5)];
    lb4.backgroundColor = [UIColor grayColor];
    [view addSubview:lb4];

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lb4.frame)+15, 130,40)];
    backBtn.clipsToBounds = YES;
    backBtn.layer.cornerRadius = 5;
    backBtn.layer.borderWidth = 1;
    backBtn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1]CGColor];
    [backBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backOrderPress) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor whiteColor];
    [view addSubview:backBtn];
    
    UIButton *contBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backBtn.frame)+20, backBtn.frame.origin.y, 130, 40)];
    contBtn.clipsToBounds = YES;
    contBtn.layer.cornerRadius = 5;
    [contBtn setTitle:@"继续购物" forState:UIControlStateNormal];
    [contBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contBtn addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
    contBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [view addSubview:contBtn];
    
    
    UIButton *view1 = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame)+10, 300, 80)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.clipsToBounds = YES;
    view1.layer.cornerRadius = 5;
    [self.view addSubview:view1];
    
    UILabel *photoLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    photoLB.font = [UIFont systemFontOfSize:12];
    photoLB.text = @"如有疑问，您可以拨打客服热线";
    photoLB.textColor = [UIColor grayColor];
    [view1 addSubview:photoLB];
    
    
    UILabel *photoLB1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(photoLB.frame)-20, 300, 80)];
    photoLB1.font = [UIFont systemFontOfSize:22];
    photoLB1.text = @"400-88888888";
    photoLB1.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [view1 addSubview:photoLB1];
    // Do any additional setup after loading the view.
}
-(void)backOrderPress{

    OrderViewController *order = [[OrderViewController alloc]init];
    
    [self.navigationController pushViewController:order animated:YES];
}
-(void)surePress{
    MainViewController *main = [[MainViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];

    
}
-(void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
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
