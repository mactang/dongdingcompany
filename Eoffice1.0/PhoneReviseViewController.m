//
//  PhoneReviseViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PhoneReviseViewController.h"
#import "RDVTabBarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
@interface PhoneReviseViewController ()
@property(nonatomic,strong)UILabel *phoneField;
@end

@implementation PhoneReviseViewController
{

    UITextField *validateField;
    UITextField *newPhoneField ;
    UITextField *newNalidateField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"修改手机号码";
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
    
    UILabel *photoLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 70, 20)];
    photoLB.font = [UIFont systemFontOfSize:12];
    photoLB.text = @"原手机号码:";
    photoLB.textColor = [UIColor blackColor];
    [self.view addSubview:photoLB];
    
    SingleModel *sing = [SingleModel sharedSingleModel];
    _phoneField = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoLB.frame), 75, 155, 30)];
    _phoneField.backgroundColor = [UIColor whiteColor];
    _phoneField.clipsToBounds = YES;
    [_phoneField setText:[NSString stringWithFormat:@"%@",sing.telphone]];
    _phoneField.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:_phoneField];
    
    
    UIButton *validateButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_phoneField.frame)+5,photoLB.frame.origin.y-5, 70, 30)];
    validateButton.backgroundColor = [UIColor whiteColor];
    validateButton.clipsToBounds =YES;
    validateButton.layer.cornerRadius = 3;
    validateButton.layer.borderColor = [[UIColor grayColor]CGColor];
    validateButton.layer.borderWidth = 1;
    validateButton.font = [UIFont systemFontOfSize:12];
    [validateButton addTarget:self action:@selector(validatePress) forControlEvents:UIControlEventTouchUpInside];
    [validateButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [validateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:validateButton];
    
    
    UILabel *validateLB = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(photoLB.frame)+30, 50, 20)];
    validateLB.font = [UIFont systemFontOfSize:12];
    validateLB.text = @"验证码：";
    validateLB.textColor = [UIColor blackColor];
    [self.view addSubview:validateLB];
    
    
    validateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(validateLB.frame), CGRectGetMaxY(photoLB.frame)+23, 155, 30)];
    validateField.backgroundColor = [UIColor whiteColor];
    validateField.clipsToBounds = YES;
    validateField.delegate = self;
    validateField.layer.cornerRadius = 3;
    validateField.layer.borderWidth = 1;
    validateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:validateField];
    
    UILabel *newValidateLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(validateField.frame)+30, 70, 20)];
    newValidateLB.font = [UIFont systemFontOfSize:12];
    newValidateLB.text = @"新手机号码:";
    newValidateLB.textColor = [UIColor blackColor];
    [self.view addSubview:newValidateLB];
    
    newPhoneField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newValidateLB.frame), CGRectGetMaxY(validateField.frame)+25, 155, 30)];
    newPhoneField.backgroundColor = [UIColor whiteColor];
    newPhoneField.clipsToBounds = YES;
    newPhoneField.delegate = self;
    newPhoneField.layer.cornerRadius = 3;
    newPhoneField.layer.borderWidth = 1;
    newPhoneField.layer.borderColor = [[UIColor grayColor]CGColor];
    newPhoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:newPhoneField];
    
    UIButton *newNalidateButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newPhoneField.frame)+5,newPhoneField.frame.origin.y, 70, 30)];
    newNalidateButton.backgroundColor = [UIColor whiteColor];
    newNalidateButton.clipsToBounds =YES;
    newNalidateButton.layer.cornerRadius = 3;
    newNalidateButton.layer.borderColor = [[UIColor grayColor]CGColor];
    newNalidateButton.layer.borderWidth = 1;
    newNalidateButton.font = [UIFont systemFontOfSize:12];
    [newNalidateButton addTarget:self action:@selector(newValidatePress) forControlEvents:UIControlEventTouchUpInside];
    [newNalidateButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [newNalidateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:newNalidateButton];
    
    UILabel *newNalidateLB = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(newValidateLB.frame)+30, 50, 20)];
    newNalidateLB.font = [UIFont systemFontOfSize:12];
    newNalidateLB.text = @"验证码：";
    newNalidateLB.textColor = [UIColor blackColor];
    [self.view addSubview:newNalidateLB];
    
    newNalidateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newValidateLB.frame), CGRectGetMaxY(newValidateLB.frame)+23, 155, 30)];
    newNalidateField.backgroundColor = [UIColor whiteColor];
    newNalidateField.clipsToBounds = YES;
    newNalidateField.delegate = self;
    newNalidateField.layer.cornerRadius = 3;
    newNalidateField.layer.borderWidth = 1;
    newNalidateField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:newNalidateField];

    
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(newNalidateField.frame)+20, 300, 40)];
    sureButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    
    sureButton.font = [UIFont systemFontOfSize:15];
    
    [sureButton addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
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

-(void)newValidatePress{
    NSLog(@"text%@",newPhoneField.text);
    NSString  *string = [NSString stringWithFormat:@"%@",newPhoneField.text];
    NSLog(@"length--%lu",(unsigned long)[string length]);
    NSUInteger number = [string length];
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    BOOL isPhtoneNumber =[phoneTest evaluateWithObject:string];
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    NSLog(@"bool--%lu",(unsigned long)[string length]);
    
    
    
    if (number == 11 && [string length] == 0 && isPhtoneNumber == YES) {
        [self newNaliData];
    }else{
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请输入正确的电话号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        //设置提示框样式（可以输入账号密码）
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
    }
    
}

-(void)newNaliData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:SAFEVALIDATE,COMMON,model.jsessionid,model.userkey];
    NSLog(@"%@",_phoneField.text);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"phoneNo":newPhoneField.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


-(void)valiData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:SAFEVALIDATE,COMMON,model.jsessionid,model.userkey];
    NSLog(@"%@",_phoneField.text);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"phoneNo":_phoneField.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)surePress{
    
    [self phoneData];
}
-(void)phoneData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SAFENEWPHONE,COMMON,model.jsessionid,model.userkey];
    NSLog(@"%@",validateField.text);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"phone":_phoneField.text,@"phone1":newPhoneField.text,@"rand":newNalidateField.text,@"rand1":validateField.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
