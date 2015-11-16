//
//  RegisterViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "RegisterViewController.h"
#import "RDVTabBarController.h"
#import "MainViewController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#define kAlphaNum  @"0123456789"
#import "Mobliejudge.h"
@interface RegisterViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *userNameField;
@property(nonatomic,strong)UITextField *passWordField;
@end

@implementation RegisterViewController
{
    
    UITextField *text_field;
    NSString *registerSucess;
}
-(void)loadView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    
    //用户名
    UIImageView *logoimageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 40, 141, 50)];
    logoimageView.clipsToBounds = YES;
    logoimageView.layer.cornerRadius = 3;
    logoimageView.image = [UIImage imageNamed:@"logo"];
    logoimageView.userInteractionEnabled = YES;
    [self.view addSubview:logoimageView];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 280, 300)];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 3;
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.image = [UIImage imageNamed:@"注册横线"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    UIView *name_view = [[UIView alloc] init];
    [name_view setFrame:CGRectMake(0, 0, 280, 40)];
    [imageView addSubview:name_view];
    
    [self createTextField:1 withView:name_view];
    
    
    
    UIView *getPassWord_view = [[UIView alloc] init];
    [getPassWord_view setFrame:CGRectMake(0, CGRectGetMaxY(name_view.frame)+5, 280, 40)];
    [imageView addSubview:getPassWord_view];
    [self createTextField:2 withView:getPassWord_view];
    
    
    UIView *AgePassWord_view = [[UIView alloc] init];
    [AgePassWord_view setFrame:CGRectMake(0, CGRectGetMaxY(getPassWord_view.frame)+13, 280, 40)];
    [imageView addSubview:AgePassWord_view];
    [self createTextField:3 withView:AgePassWord_view];
    
    UIView *phoneNumber_view = [[UIView alloc] init];
    [phoneNumber_view setFrame:CGRectMake(0, CGRectGetMaxY(AgePassWord_view.frame)+5, 280, 40)];
    [imageView addSubview:phoneNumber_view];
    [self createTextField:4 withView:phoneNumber_view];
//    UIButton *validateBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 15, 70, 30)];
//    validateBtn.clipsToBounds = YES;
//    validateBtn.layer.cornerRadius = 3;
//    validateBtn.layer.borderWidth = 1;
//    validateBtn.layer.borderColor = [[UIColor grayColor]CGColor];
//    validateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//    [validateBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//    [validateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [validateBtn addTarget:self action:@selector(identifyingBtn) forControlEvents:UIControlEventTouchUpInside];
//    [phoneNumber_view addSubview:validateBtn];
    
    _countDownCode = [CountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(SCREEN_WIDTH-120,17, 70, 30);
    [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_countDownCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor whiteColor];
    _countDownCode.clipsToBounds = YES;
    _countDownCode.layer.cornerRadius = 3;
    _countDownCode.layer.borderColor = [[UIColor grayColor]CGColor];
    _countDownCode.layer.borderWidth = 1;
    _countDownCode.titleLabel.font = [UIFont systemFontOfSize:10];
    [phoneNumber_view addSubview:_countDownCode];
    
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

    
    UIView *number_view = [[UIView alloc] init];
    [number_view setFrame:CGRectMake(0, CGRectGetMaxY(phoneNumber_view.frame)+9, 280, 40)];
    [imageView addSubview:number_view];
    [self createTextField:5 withView:number_view];
    
    UIView *invitation_view = [[UIView alloc] init];
    [invitation_view setFrame:CGRectMake(0, CGRectGetMaxY(number_view.frame)+9, 280, 40)];
    [imageView addSubview:invitation_view];
    [self createTextField:6 withView:invitation_view];
    
    
    
    UIButton *registerButton = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(imageView.frame)+20, 300, 45)];
    registerButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    registerButton.clipsToBounds = YES;
    registerButton.layer.cornerRadius = 5;
    registerButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerButton addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注 册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(registerButton.frame)+15, 300, 45)];
    loginButton.backgroundColor = [UIColor whiteColor];
    loginButton.clipsToBounds = YES;
    loginButton.layer.cornerRadius = 5;
    loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(backLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    // Do any additional setup after loading the view.
}

-(void)identifyingBtn{
    
    [self valiData];
}

-(void)valiData{
    
    UITextField *name_field = (UITextField *)[self.view viewWithTag:VERIFICATION];
    NSString *path = [NSString stringWithFormat:REGISTERMASSAGE,COMMON,name_field.text];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic--%@",dic);
        NSLog(@"%@",dic[@"data"]);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)backLogin{
    
//    [self dismissViewControllerAnimated:NO completion:^{
//       
//    }];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)createTextField:(int)isPwd withView:(UIView *)text_view
{
    
    
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.frame = CGRectMake(10, 20, 34/2, 38/2);
    [text_view addSubview:iconImageView];
    
    //输入框
    text_field = [[UITextField alloc] init];
    text_field.borderStyle = UITextBorderStyleNone;
    text_field.frame = CGRectMake(45, 20, 235, 20);
    text_field.font = [UIFont systemFontOfSize:18];
    text_field.clearButtonMode = UITextFieldViewModeAlways;
    // [text_field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    text_field.textColor = [UIColor grayColor];
    text_field.delegate = self;
    
    text_field.returnKeyType = UIReturnKeyDone;
    [text_view addSubview:text_field];
    [text_field setAutocorrectionType:UITextAutocorrectionTypeNo];
    [text_field setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [text_field setSpellCheckingType:UITextSpellCheckingTypeNo];
    text_field.keyboardType = UIKeyboardTypeEmailAddress;
    
    //判断
    if (isPwd == 1)
    {
        text_field.text = @"";
        text_field.secureTextEntry = NO;
        text_field.tag = 1001;
        text_field.placeholder = @"用户名";
        iconImageView.image = [UIImage imageNamed:@"图层-9"];
        // iconImageView.highlightedImage = [UIImage imageNamed:@"userIcon_highlight.png"];
        //  iconImageView.tag = NAME_ICON;
    }
    if (isPwd == 2)
    {
        text_field.text = @"";
        text_field.secureTextEntry = YES;
        text_field.tag = 1002;
        text_field.placeholder = @"设置密码";
        iconImageView.image = [UIImage imageNamed:@"图层-10"];
    }
    if (isPwd == 3)
    {
        text_field.text = @"";
        text_field.secureTextEntry = YES;
        text_field.tag = 1003;
        text_field.placeholder = @"重复密码";
        iconImageView.image = [UIImage imageNamed:@"图层-10"];
    }
    if (isPwd == 4)
    {
        
        text_field.text = @"";
        text_field.tag = VERIFICATION;
        text_field.clearButtonMode = UITextFieldViewModeNever;
        text_field.placeholder = @"请输入手机号码";
        iconImageView.image = [UIImage imageNamed:@"图层-11"];
        
    }
    if (isPwd == 5)
    {
        text_field.text = @"";
        text_field.tag = 1004;
        text_field.placeholder = @"请输入验证码";
        iconImageView.image = [UIImage imageNamed:@"图层-12"];
        
    }
    
    if (isPwd == 6)
    {
        text_field.text = @"";
        text_field.tag = 1005;
        text_field.placeholder = @"请输入推荐码";
        iconImageView.image = [UIImage imageNamed:@"图层-12"];
        
    }
    text_field.font = [UIFont fontWithName:@"STHeitiK-Medium" size:18];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"%ld",(long)textField.tag);
    
    UITextField *pwd_field = (UITextField *)[self.view viewWithTag:1002];
    if (textField.tag == 1003) {
        if (![pwd_field.text isEqualToString:textField.text]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"两个输入密码不一致" message:@"请重新输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
- (void)surePress{
    
    UITextField *pwd_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField *replace_field = (UITextField *)[self.view viewWithTag:1003];
    
        if (![pwd_field.text isEqualToString:replace_field.text]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"两个输入密码不一致" message:@"请重新输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
        
            [self sureRgister];
        }
}
-(void)sureRgister{

    UITextField *name_field = (UITextField *)[self.view viewWithTag:1001];
    UITextField *pwd_field = (UITextField *)[self.view viewWithTag:1002];
    UITextField *identifying_field = (UITextField *)[self.view viewWithTag:1004];
    UITextField  *phoneNumber_field = (UITextField *)[self.view viewWithTag:VERIFICATION];
    UITextField *replace_field = (UITextField *)[self.view viewWithTag:1003];
    UITextField *recommend_field = (UITextField *)[self.view viewWithTag:1005];
    UIAlertView *alert;
    NSString *messageString;
    if ([name_field.text isEqualToString:@""]) {
        messageString = @"姓名不能为空";
    }
    else if ([pwd_field.text isEqualToString:@""]){
        messageString = @"密码不能为空";
    }
    else if ([replace_field.text isEqualToString:@""]){
        messageString = @"请确认密码";
    }
    else if (![pwd_field.text isEqualToString:replace_field.text]){
        messageString = @"两次密码不一致,请重新输入";
    }
    else if ([phoneNumber_field.text isEqualToString:@""]){
        messageString = @"电话号码不能为空";
    }
    else if ([Mobliejudge valiMobile:phoneNumber_field.text]){
        messageString = [Mobliejudge valiMobile:phoneNumber_field.text];
    }
    else{
        NSString *path = [NSString stringWithFormat:REGISTER,COMMON];
        NSLog(@"%@",path);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:path parameters:@{@"username":name_field.text,@"password":pwd_field.text,@"rand":identifying_field.text,@"phone":phoneNumber_field.text,@"recommendCode":recommend_field.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            UIAlertView *alterview;
            if ([dic[@"status"]integerValue]==1) {
                registerSucess = dic[@"info"];
            }
            else{
                registerSucess = dic[@"info"];
            }
            alterview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:registerSucess delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alterview show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        return;
    }
    alert = [[UIAlertView alloc]initWithTitle:@"提示" message:messageString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        if (buttonIndex == 0) {
           [self.navigationController popViewControllerAnimated:YES];
        }else{
            
           NSLog(@"oo");
        }
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (string.length == 0) {
        return YES;
    }
    if(textField.tag == 1004){
        if (toBeString.length >16 && range.length!=1) {
            textField.text = [toBeString substringToIndex:16];
            return NO;
        }
        else if ([kAlphaNum rangeOfString:string].location == NSNotFound) {
            return NO;
        }
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
@end
