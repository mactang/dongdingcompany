//
//  ViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ViewController.h"
#import "CountDownButton.h"
#import "Mobliejudge.h"
#import "Config.h"
@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController
{
    
    UITextField *text_field;
    CountDownButton *_countDownCode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    UILabel *title_lab = [[UILabel alloc] init];
    title_lab.text = @"登录DEMO";
    title_lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    title_lab.textColor = [UIColor colorWithRed:0 green:128./255 blue:1 alpha:1];
    title_lab.textAlignment = NSTextAlignmentCenter;
    title_lab.frame = CGRectMake(0, 175/2+10, 320, 25);
    title_lab.userInteractionEnabled = NO;
    [self.view addSubview:title_lab];
    
    
    
    //输入框背景
    UIImageView *inputImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textfield.png"]];
    inputImageView.frame = CGRectMake((SCREEN_WIDTH - 581/2) /2, 150, 581/2, 217/2);
    inputImageView.userInteractionEnabled = YES;
    [self.view addSubview:inputImageView];
    
    //    UITapGestureRecognizer *closeKeyboard_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    //    [imageView addGestureRecognizer:closeKeyboard_tap];
    
    UIView *phoneNumber_view = [[UIView alloc] init];
    [phoneNumber_view setFrame:CGRectMake(0, 0, 280, 40)];
    [inputImageView addSubview:phoneNumber_view];
    [self createTextField:1 withView:phoneNumber_view];
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
    
    UITextField  *phoneNumber_field = (UITextField *)[self.view viewWithTag:1001];
    [_countDownCode addToucheHandler:^(CountDownButton*sender, NSInteger tag) {
        UIAlertView *alert;
        NSString *messageString;
        NSLog(@"%@",phoneNumber_field.text);
        if ([Mobliejudge valiMobile:phoneNumber_field.text]){
            messageString = [Mobliejudge valiMobile:phoneNumber_field.text];
            alert = [[UIAlertView alloc]initWithTitle:@"提示" message:messageString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            
            // [self newNaliData];
            
            sender.enabled = NO;
            
            [sender startWithSecond:60];
            
            [sender didChange:^NSString *(CountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                
                return title;
            }];
            [sender didFinished:^NSString *(CountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"点击重新获取";
                
            }];
        }
    }];
    
    UIView *invitation_view = [[UIView alloc] init];
    [invitation_view setFrame:CGRectMake(0, CGRectGetMaxY(phoneNumber_view.frame)+9, 280, 40)];
    [inputImageView addSubview:invitation_view];
    [self createTextField:2 withView:invitation_view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setBackgroundImage:btn_img1 forState:UIControlStateNormal];
    //    [btn setBackgroundImage:btn_img2 forState:UIControlStateHighlighted];
    //btn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [btn setFrame:CGRectMake((SCREEN_WIDTH - 581/2)/2, CGRectGetMaxY(inputImageView.frame)+20, 581/2, 88/2)];
    [btn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"loginBtn1"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"loginBtn2"] forState:UIControlStateHighlighted];
    btn.clipsToBounds= YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"登 录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // btn.enabled = NO;
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)clickLogin{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"没有数据请求" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert show];
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
    
    if (isPwd == 1)
    {
        
        text_field.text = @"";
        text_field.tag = 1001;
        text_field.clearButtonMode = UITextFieldViewModeNever;
        text_field.placeholder = @"请输入手机号码";
        text_field.keyboardType = UIKeyboardTypeNumberPad;
        iconImageView.image = [UIImage imageNamed:@"图层-11"];
        
    }
    if (isPwd == 2)
    {
        text_field.text = @"";
        text_field.tag = 1002;
        text_field.keyboardType = UIKeyboardTypeNumberPad;
        text_field.placeholder = @"请输入验证码";
        iconImageView.image = [UIImage imageNamed:@"图层-12"];
        
    }
    
    text_field.font = [UIFont fontWithName:@"STHeitiK-Medium" size:18];
}
-(void)sureRgister{
    
    
    
    UITextField  *phoneNumber_field = (UITextField *)[self.view viewWithTag:1001];
    
    UIAlertView *alert;
    NSString *messageString;
    if ([phoneNumber_field.text isEqualToString:@""]) {
        messageString = @"电话号码不能为空";
    }
    alert = [[UIAlertView alloc]initWithTitle:@"提示" message:messageString delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)closeKeyBoard
{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
