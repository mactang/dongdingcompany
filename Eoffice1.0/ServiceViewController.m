//
//  ServiceViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ServiceViewController.h"
#import "RDVTabBarController.h"
#import "ServiceSuccessController.h"
@interface ServiceViewController ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"申请维修";
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 530)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UILabel *validateLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 70, 20)];
    validateLB.font = [UIFont systemFontOfSize:12];
    validateLB.text = @"维修原因：";
    validateLB.textColor = [UIColor blackColor];
    [view addSubview:validateLB];
    
    UITextField *validateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(validateLB.frame)-10,70, 240, 35)];
    validateField.backgroundColor = [UIColor whiteColor];
    validateField.clipsToBounds = YES;
    validateField.delegate = self;
    validateField.layer.cornerRadius = 3;
    validateField.layer.borderWidth = 1;
    validateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [view addSubview:validateField];
    
    UILabel *explainLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(validateField.frame)+20, 70, 20)];
    explainLB.font = [UIFont systemFontOfSize:12];
    explainLB.text = @"维修说明：";
    explainLB.textColor = [UIColor blackColor];
    [view addSubview:explainLB];
    
    UITextView *explainTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(explainLB.frame)-10, CGRectGetMaxY(validateField.frame)+10, 240, 120)];
    explainTextView.clipsToBounds = YES;
    explainTextView.layer.cornerRadius = 5;
    explainTextView.layer.borderWidth = 1;
    explainTextView.layer.borderColor = [[UIColor grayColor]CGColor];
    explainTextView.delegate = self;
    // TextView.text = @"最多输入100个汉字";
    [view addSubview:explainTextView];
    
    UILabel *phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(explainTextView.frame)+15, 120, 20)];
    phoneLB.font = [UIFont systemFontOfSize:12];
    phoneLB.text = @"上传问题商品图片：";
    phoneLB.textColor = [UIColor blackColor];
    [view addSubview:phoneLB];
    
    UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLB.frame), CGRectGetMaxY(explainTextView.frame)+5, 30, 30)];
    photoBtn.backgroundColor = [UIColor redColor];
    [view addSubview:photoBtn];
    
    UILabel *addressLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(photoBtn.frame)+70, 70, 20)];
    addressLB.font = [UIFont systemFontOfSize:12];
    addressLB.text = @"你的地址：";
    addressLB.textColor = [UIColor blackColor];
    [view addSubview:addressLB];
    
    UITextView *addressTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressLB.frame)-10, CGRectGetMaxY(photoBtn.frame)+60, 240, 80)];
    addressTextView.clipsToBounds = YES;
    addressTextView.layer.cornerRadius = 5;
    addressTextView.layer.borderWidth = 1;
    addressTextView.layer.borderColor = [[UIColor grayColor]CGColor];
    addressTextView.delegate = self;
    // TextView.text = @"最多输入100个汉字";
    [view addSubview:addressTextView];
    
    UILabel *reasonLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(addressTextView.frame)+20, 70, 20)];
    reasonLB.font = [UIFont systemFontOfSize:12];
    reasonLB.text = @"联系电话：";
    reasonLB.textColor = [UIColor blackColor];
    [view addSubview:reasonLB];
    
    UITextField *reasonField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(reasonLB.frame)-10,CGRectGetMaxY(addressTextView.frame)+10, 240, 35)];
    reasonField.backgroundColor = [UIColor whiteColor];
    reasonField.clipsToBounds = YES;
    reasonField.delegate = self;
    reasonField.layer.cornerRadius = 3;
    reasonField.layer.borderWidth = 1;
    reasonField.layer.borderColor = [[UIColor grayColor]CGColor];
    [view addSubview:reasonField];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(reasonField.frame)+15, 300, 40)];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [view addSubview:sureBtn];
    // Do any additional setup after loading the view.
}

-(void)surePress{
    ServiceSuccessController *sers = [[ServiceSuccessController alloc]init];
    [self.navigationController pushViewController:sers animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
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
