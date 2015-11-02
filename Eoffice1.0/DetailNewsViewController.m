//
//  DetailNewsViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "TarBarButton.h"
#import "RDVTabBarController.h"
@interface DetailNewsViewController ()

@end

@implementation DetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 320, 20)];
    titleLB.font = [UIFont systemFontOfSize:15];
    titleLB.text = @"下一个主角就是你，E办公在等你";
    titleLB.textColor = [UIColor blackColor];
    [self.view addSubview:titleLB];
    
    UILabel *dateLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLB.frame), 70, 40)];
    dateLB.font = [UIFont systemFontOfSize:12];
    dateLB.text = @"2015-01-15";
    dateLB.textColor = [UIColor grayColor];
    //dateLB.backgroundColor = [UIColor redColor];
    [self.view addSubview:dateLB];
    
    UILabel *authorLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dateLB.frame)+5,dateLB.frame.origin.y, 80, 40)];
    authorLB.font = [UIFont systemFontOfSize:14];
    authorLB.text = @"E办公客服组";
    authorLB.textColor = [UIColor redColor];
    //dateLB.backgroundColor = [UIColor redColor];
    [self.view addSubview:authorLB];
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(authorLB.frame),dateLB.frame.origin.y, 100, 40)];
    shareButton.backgroundColor = [UIColor whiteColor];
    shareButton.clipsToBounds = YES;
    shareButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [shareButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(detailPress) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    
    UILabel *deatailLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(dateLB.frame)+10, 300, 60)];
    deatailLB.font = [UIFont systemFontOfSize:12];
    NSString * cLabelString = @"  成都东鼎泰和科技有限公司前身系成都东华贸易中心,成立于1996年,前期以主营二手电脑、办公耗材卖场为主,在数码市场管理日趋成熟,结合现有市场分析,公司从新定位,";
    deatailLB.lineBreakMode = NSLineBreakByTruncatingTail;
    deatailLB.numberOfLines = 0;
    deatailLB.textColor = [UIColor blackColor];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
    [deatailLB setAttributedText:attributedString1];
    [deatailLB sizeToFit];
    [self.view addSubview:deatailLB];
    
    UIImageView *detailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(deatailLB.frame)+10, 300, 100)];
    detailImageView.image = [UIImage imageNamed:@"xiangqingtu"];
    [self.view addSubview:detailImageView];
    
    // Do any additional setup after loading the view.
}

- (void)leftItemClicked{
    
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(void)detailPress{
}
- (void)leftBtn{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
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
