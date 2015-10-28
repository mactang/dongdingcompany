//
//  ServiceSuccessController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ServiceSuccessController.h"
#import "RDVTabBarController.h"
#import "MainViewController.h"
@interface ServiceSuccessController ()

@end

@implementation ServiceSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"申请成功";
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    // UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    // [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 0, 0);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(10, 70, 300, 260)];
    view.backgroundColor = [UIColor whiteColor];
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];
    
    UILabel *validateLB = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 200, 30)];
    validateLB.font = [UIFont systemFontOfSize:17];
    validateLB.text = @"您的维修申请已提交成功!";
    validateLB.textColor = [UIColor redColor];
    [view addSubview:validateLB];
    
    UILabel *validateLB1 = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(validateLB.frame), 250, 30)];
    validateLB1.font = [UIFont systemFontOfSize:12];
    validateLB1.text = @"我们的客服会在24小时内为您安排解决问题!!";
    validateLB1.textColor = [UIColor grayColor];
    [view addSubview:validateLB1];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(validateLB1.frame)+10, 60, 30)];
    lb.font = [UIFont systemFontOfSize:11];
    lb.text = @"维修编号:";
    lb.textColor = [UIColor blackColor];
    [view addSubview:lb];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb.frame), CGRectGetMaxY(validateLB1.frame)+10, 250, 30)];
    lb2.font = [UIFont systemFontOfSize:11];
    lb2.text = @"123243253655674";
    
    lb2.textColor = [UIColor blackColor];
    [view addSubview:lb2];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lb.frame), 300, 150)];
    lb1.font = [UIFont systemFontOfSize:12];
    lb1.numberOfLines = 0;
    
    
    NSString * cLabelString = @"如果您已维修成功请点击维修成功，如果没有请点击\n维修中心";
    
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
    [lb1 setAttributedText:attributedString1];
    [lb1 sizeToFit];
    lb1.textColor = [UIColor grayColor];
    [view addSubview:lb1];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lb1.frame)+40, 130,40)];
    backBtn.clipsToBounds = YES;
    backBtn.layer.cornerRadius = 5;
    [backBtn setTitle:@"返回订单" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backOrderPress) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [view addSubview:backBtn];
    
    UIButton *contBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backBtn.frame)+20, backBtn.frame.origin.y, 130, 40)];
    contBtn.clipsToBounds = YES;
    contBtn.layer.cornerRadius = 5;
    contBtn.layer.borderWidth = 1;
    contBtn.layer.borderColor = [[UIColor redColor]CGColor];
    [contBtn setTitle:@"继续购物" forState:UIControlStateNormal];
    [contBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [contBtn addTarget:self action:@selector(continuePress) forControlEvents:UIControlEventTouchUpInside];
    contBtn.backgroundColor = [UIColor whiteColor];
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
    photoLB1.textColor = [UIColor redColor];
    [view1 addSubview:photoLB1];
    
    // Do any additional setup after loading the view.
}
-(void)continuePress{
    
    NSLog(@";;;");
    MainViewController *main = [[MainViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];
    
}

-(void)backOrderPress{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
