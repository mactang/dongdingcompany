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
#define kAlphaNum  @"0123456789"
@interface PassWordViewController ()<UITextFieldDelegate>

@end

@implementation PassWordViewController
{

    UITextField *validateField;
    UITextField *sureValidateField;
    NSString *changSucess;
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
    SingleModel *sing = [SingleModel sharedSingleModel];
    UILabel *photoLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 150, 20)];
    photoLB.font = [UIFont systemFontOfSize:14];
    photoLB.text = [NSString stringWithFormat:@"手机号：%@",sing.telphone];
    photoLB.textAlignment = NSTextAlignmentCenter;
    photoLB.textColor = [UIColor blackColor];
    [self.view addSubview:photoLB];
    
    _countDownCode = [CountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(SCREEN_WIDTH-120,photoLB.frame.origin.y-5, 100, 30);
    [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_countDownCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor whiteColor];
    _countDownCode.clipsToBounds = YES;
    _countDownCode.layer.cornerRadius = 3;
    _countDownCode.layer.borderColor = [[UIColor grayColor]CGColor];
    _countDownCode.layer.borderWidth = 1;
    _countDownCode.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_countDownCode];
    
    
    [_countDownCode addToucheHandler:^(CountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        [self valiData];
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(CountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            
            return title;
        }];
        [sender didFinished:^NSString *(CountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
            
        }];
        
    }];
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
    newValidateField.tag = 1002;
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
    sureValidateField.tag = 1003;
    sureValidateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:sureValidateField];
    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(sureValidateField.frame)+20, 300, 40)];
    sureButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
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
-(void)validatePress:(UIButton *)btn{
    [self valiData];
}
-(void)valiData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:SAFEVALIDATE,COMMON,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:path parameters:@{@"phoneNo":model.telphone} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (string.length == 0) {
        return YES;
    }
    if(textField.tag == 1002||textField.tag==1003){
        if (toBeString.length >20 && range.length!=1) {
            textField.text = [toBeString substringToIndex:20];
            UIAlertView *alterview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度不能超过20位" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alterview show];
            return NO;
        }
    }
    else if ([kAlphaNum rangeOfString:string].location == NSNotFound) {
        return NO;
    }

    return YES;
}
-(void) revisePassword{
    UIAlertView *alert;
    NSString *titlestring;
    UITextField *pwd_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField *surepwd_field = (UITextField *)[self.view viewWithTag:1003];
    if ([validateField.text isEqualToString:@""]) {
        titlestring = @"请输入验证码";
    }
    else if ([pwd_field.text isEqualToString:@""]){
        titlestring = @"请输入密码";
    }
    else if ([surepwd_field.text isEqualToString:@""]){
        titlestring = @"请确认密码";
    }
   else  if (![pwd_field.text isEqualToString:surepwd_field.text]) {
       titlestring = @"两次输入密码不一致,请重新输入";
    }
   else{
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:SAFERIVESE,COMMON,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"phone":model.telphone,@"rand":validateField.text,@"password":sureValidateField.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        UIAlertView *alterview;
        if ([dic[@"status"]integerValue]==1) {
            changSucess = dic[@"info"];
        }
        else{
            changSucess = dic[@"info"];
        }
        alterview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:changSucess delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterview show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
       return;
    }
    alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:titlestring delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
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



@end
