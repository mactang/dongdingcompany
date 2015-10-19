//
//  ComRuleController.m
//  Eoffice1.0
//
//  Created by gyz on 15/10/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ComRuleController.h"
#import "RDVTabBarController.h"
#import "LetfWordButton.h"
@interface ComRuleController ()

@end

@implementation ComRuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@"返现规则"];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 520)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSString *labelText = @"1、将自己的优惠码推荐给好友进行注册，好友首次下单成功购买商品后，即可获得1%返现，购买第二次及以后，可获得0.5%返现；\n2、可提现金额累计到10元及以上，即可提取现金；\n3、	返现活动在推广期间有效，推广期暂定三年；\n4、	如果提现金额没有及时到账，请联系客服。	";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:15];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    UILabel *recommendExplaiLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 280, 260)];
    recommendExplaiLb.attributedText = attributedString;
    recommendExplaiLb.numberOfLines = 0;
    recommendExplaiLb.font = [UIFont systemFontOfSize:12];
    recommendExplaiLb.userInteractionEnabled = YES;
    [view addSubview:recommendExplaiLb];
    
    UILabel *phoneLb = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(recommendExplaiLb.frame)-20, 60, 20)];
    phoneLb.text = @"客服电话：";
    phoneLb.font = [UIFont systemFontOfSize:12];
    phoneLb.userInteractionEnabled = YES;
    [view addSubview:phoneLb];
    
    LetfWordButton *photoBtn = [[LetfWordButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLb.frame), phoneLb.frame.origin.y-10, 120, 40)];
    [photoBtn setTitle:@"400888888" forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    photoBtn.font = [UIFont systemFontOfSize:18];
    [photoBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(photoPress:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:photoBtn];
    

}
-(void)photoPress:(UIButton *)btn{
    NSLog(@"%@",btn.titleLabel.text);
    NSString *string = [NSString stringWithFormat:@"%@",btn.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    
    
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
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
