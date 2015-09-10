//
//  PassWordViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PassWordViewController.h"
#import "RDVTabBarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
@interface PassWordViewController ()<UITextFieldDelegate>

@end

@implementation PassWordViewController
{

    UITextField *validateField;
    UITextField *sureValidateField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"修改密码";
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 290)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UILabel *photoLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 150, 20)];
    photoLB.font = [UIFont systemFontOfSize:14];
    photoLB.text = @"手机号：13618090081";
    photoLB.textColor = [UIColor blackColor];
    [self.view addSubview:photoLB];
    
    UIButton *validateButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoLB.frame)+10,photoLB.frame.origin.y-5, 100, 35)];
    validateButton.backgroundColor = [UIColor whiteColor];
    validateButton.clipsToBounds = YES;
    validateButton.layer.cornerRadius = 3;
    validateButton.layer.borderColor = [[UIColor grayColor]CGColor];
    validateButton.layer.borderWidth = 1;
    validateButton.font = [UIFont systemFontOfSize:14];
    
    [validateButton addTarget:self action:@selector(validatePress) forControlEvents:UIControlEventTouchUpInside];
    [validateButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [validateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:validateButton];
    
    UILabel *validateLB = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(photoLB.frame)+30, 60, 20)];
    validateLB.font = [UIFont systemFontOfSize:14];
    validateLB.text = @"验证码：";
    validateLB.textColor = [UIColor blackColor];
    [self.view addSubview:validateLB];
    
    validateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(validateLB.frame), CGRectGetMaxY(photoLB.frame)+23, 220, 35)];
    validateField.backgroundColor = [UIColor whiteColor];
    validateField.clipsToBounds = YES;
    validateField.delegate = self;
    validateField.layer.cornerRadius = 3;
    validateField.layer.borderWidth = 1;
    validateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:validateField];
    
    UILabel *newValidateLB = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(validateLB.frame)+30, 60, 20)];
    newValidateLB.font = [UIFont systemFontOfSize:14];
    newValidateLB.text = @"新密码：";
    newValidateLB.textColor = [UIColor blackColor];
    [self.view addSubview:newValidateLB];
    
    UITextField *newValidateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newValidateLB.frame), CGRectGetMaxY(validateField.frame)+15, 220, 35)];
    newValidateField.backgroundColor = [UIColor whiteColor];
    newValidateField.clipsToBounds = YES;
    newValidateField.delegate = self;
    newValidateField.clearButtonMode = UITextFieldViewModeAlways;
    newValidateField.secureTextEntry = YES;
    newValidateField.layer.cornerRadius = 3;
    newValidateField.layer.borderWidth = 1;
    newValidateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:newValidateField];
    
    UILabel *sureValidateLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(newValidateLB.frame)+30, 70, 20)];
    sureValidateLB.font = [UIFont systemFontOfSize:14];
    sureValidateLB.text = @"确认密码：";
    sureValidateLB.textColor = [UIColor blackColor];
    [self.view addSubview:sureValidateLB];
    
    sureValidateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sureValidateLB.frame), CGRectGetMaxY(newValidateField.frame)+15, 220, 35)];
    sureValidateField.backgroundColor = [UIColor whiteColor];
    sureValidateField.clipsToBounds = YES;
    sureValidateField.delegate = self;
    sureValidateField.secureTextEntry = YES;
    sureValidateField.clearButtonMode = UITextFieldViewModeAlways;
    sureValidateField.layer.cornerRadius = 3;
    sureValidateField.layer.borderWidth = 1;
    sureValidateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:sureValidateField];
    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(sureValidateField.frame)+20, 300, 40)];
    sureButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    
    sureButton.font = [UIFont systemFontOfSize:15];
    
    [sureButton addTarget:self action:@selector(revisePassword) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureButton];
    // Do any additional setup after loading the view.
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)validatePress{

    [self valiData];
}

-(void)valiData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SAFEVALIDATE,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"phoneNo":@"13618090081"} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void) revisePassword{
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SAFERIVESE,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"phone":@"13618090081",@"rand":validateField.text,@"password":sureValidateField.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
        NSLog(@"array--%@",string);
        if ([string isEqualToString:@"1"]) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        else{
            
        }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
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
