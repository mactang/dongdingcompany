//
//  LoginViewController.m
//  EOffice
//
//  Created by gyz on 15/7/8.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "LoginViewController.h"
#import "Config.h"
#import "BottonTabBarController.h"
#import "RDVTabBarController.h"
#import "RegisterViewController.h"
#import "AFNetworking.h"
#import "PersonViewController.h"
#import "SingleModel.h"
#import "OrderController.h"
#import "TarBarButton.h"
#import "MainViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
{
     UITextField *temp_txt;
    BOOL isChecked;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.navigationController.navigationBarHidden = YES;
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang21"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    leftButton.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    self.navigationItem.title = @"";
    
    isChecked = NO;
    self.view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    float bl[4];
    if (IOS_7_VERSION)
    {
        bl[0] = 0.31338028;
        bl[1] = 0.41;
        bl[2] = 0.62;
        bl[3] = 0.54;
    }
    else
    {
        bl[0] = 0.35;
        bl[1] = 0.46;
        bl[2] = 0.8;
        bl[3] = 0.64;
    }
    
    UIImageView *inputImageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    inputImageView1.frame = CGRectMake(90, 60, 164, 54);
    [self.view addSubview:inputImageView1];

     int height = SCREEN_HEIGHT;
    //输入框背景
    UIImageView *inputImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textfield.png"]];
    inputImageView.frame = CGRectMake((SCREEN_WIDTH - 581/2) /2, 150, 581/2, 217/2);
    [self.view addSubview:inputImageView];
    
    //用户名
    UIView *name_view = [[UIView alloc] init];
    [name_view setFrame:CGRectMake(0, 150, 320, 100)];
    [self.view addSubview:name_view];
    [self createTextField:NO withView:name_view];
    
    //密码
    UIView *pwd_view = [[UIView alloc] init];
    [pwd_view setFrame:CGRectMake(0, 200, 320, 100)];
    [self.view addSubview:pwd_view];
    [self createTextField:YES withView:pwd_view];
    
    //记住用户
    UIView *remeber_view = [[UIView alloc] init];
    remeber_view.frame = CGRectMake(0, height*bl[2]+50, 200, 60);
    [self.view addSubview:remeber_view];
    [self createRemeberView:remeber_view];
    UITapGestureRecognizer *remeber_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkRemember)];
    [remeber_view addGestureRecognizer:remeber_tap];
    
    //登录按钮
    NSString *btn_path1 = [[NSBundle mainBundle] pathForResource:@"loginBtn1" ofType:@"png"];
    UIImage *btn_img1 = [[UIImage alloc] initWithContentsOfFile:btn_path1];
    
    NSString *btn_path2 = [[NSBundle mainBundle] pathForResource:@"loginBtn2" ofType:@"png"];
    UIImage *btn_img2 = [[UIImage alloc] initWithContentsOfFile:btn_path2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:btn_img1 forState:UIControlStateNormal];
//    [btn setBackgroundImage:btn_img2 forState:UIControlStateHighlighted];
    btn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [btn setFrame:CGRectMake((SCREEN_WIDTH - 581/2)/2, height*bl[2]-70, 581/2, 88/2)];
    [btn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    btn.clipsToBounds= YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"登 录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.tag = LOGIN_BTN;
   // btn.enabled = NO;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setBackgroundImage:btn_img1 forState:UIControlStateNormal];
    //    [btn setBackgroundImage:btn_img2 forState:UIControlStateHighlighted];
    [btn1 setFrame:CGRectMake((SCREEN_WIDTH - 581/2)/2, CGRectGetMaxY(btn.frame)+10, 581/2, 88/2)];
    [btn1 addTarget:self action:@selector(registerLogin) forControlEvents:UIControlEventTouchUpInside];
    btn1.clipsToBounds= YES;
    btn1.layer.cornerRadius = 5;
    btn1.layer.borderColor = [[UIColor grayColor]CGColor];
    btn1.layer.borderWidth = 0.5;
    [btn1 setTitle:@"注 册" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn1.tag = LOGIN_BTN;
    // btn.enabled = NO;
    [self.view addSubview:btn1];
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(130, 432, 50, 0.5)];
    lb2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lb2];
    
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(233, 432, 50, 0.5)];
    lb3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lb3];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(180, 420, 100, 20)];
    lb1.font = [UIFont systemFontOfSize:12];
    lb1.text = @"忘记密码?";
    lb1.textColor = [UIColor grayColor];
    [self.view addSubview:lb1];
    
//    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(lb1.frame)+20, 40, 40)];
//    [shareBtn setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
//
//    [self.view addSubview:shareBtn];
//    
//    UIButton *shareBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shareBtn.frame)+20, CGRectGetMaxY(lb1.frame)+20, 40, 40)];
//    [shareBtn1 setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
//    
//    [self.view addSubview:shareBtn1];
//    
//    UIButton *shareBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shareBtn1.frame)+20, CGRectGetMaxY(lb1.frame)+20, 40, 40)];
//    [shareBtn2 setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
//    
//    [self.view addSubview:shareBtn2];
    // Do any additional setup after loading the view.
}
-(void)leftItemClicked{
    
    MainViewController *main = [[MainViewController alloc]init];
    [self.navigationController pushViewController:main animated:YES];
//    self.navigationController.navigationBar.translucent = YES;
 //   [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)createTextField:(BOOL)isPwd withView:(UIView *)text_view
{
    
    
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.frame = CGRectMake(65-34, 20, 34/2, 38/2);
    [text_view addSubview:iconImageView];
    
    //输入框
    UITextField *text_field = [[UITextField alloc] init];
    text_field.borderStyle = UITextBorderStyleNone;
    text_field.frame = CGRectMake(65, 20, 235, 20);
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
    if (isPwd)
    {
        text_field.text = @"";
        text_field.secureTextEntry = YES;
        text_field.tag = PASSWORD_FIELD;
        text_field.placeholder = @"请输入密码";
        iconImageView.image = [UIImage imageNamed:@"图层-9"];
        iconImageView.highlightedImage = [UIImage imageNamed:@"lockIcon_highlight.png"];
        iconImageView.tag = PASSWORD_ICON;
    }
    else
    {
        text_field.text = @"";
        text_field.secureTextEntry = NO;
        text_field.tag = NAME_FIELD;
        text_field.placeholder = @"请输入用户名";
        iconImageView.image = [UIImage imageNamed:@"图层-10"];
        iconImageView.highlightedImage = [UIImage imageNamed:@"userIcon_highlight.png"];
        iconImageView.tag = NAME_ICON;
    }
    text_field.font = [UIFont fontWithName:@"STHeitiK-Medium" size:18];
}
/**
 *  创建记住框
 *
 *  @param remember_view 父类的view
 */
- (void)createRemeberView:(UIView *)remember_view
{
    
//    NSString *check_path = [[NSBundle mainBundle] pathForResource:@"checkNO" ofType:@"png"];
//    UIImage *check_img = [[UIImage alloc] initWithContentsOfFile:check_path];
//    UIImageView *check_imgView = [[UIImageView alloc] initWithImage:check_img];
//    [check_imgView setFrame:CGRectMake(20, 0, 20, 20)];
//    check_imgView.tag = CHECK_IMG_VIEW;
//    [remember_view addSubview:check_imgView];
//    
//    //描述文字
//    UILabel *remember_lab = [[UILabel alloc] init];
//    remember_lab.text = @"记住密码";
//    remember_lab.font = [UIFont fontWithName:@"STHeitiK-Medium" size:15];
//    remember_lab.textColor = [UIColor grayColor];
//    remember_lab.frame = CGRectMake(50, 0, 200, 20);
//    [remember_view addSubview:remember_lab];
    
}

/**
 *  点击键盘的返回按钮
 *
 *  @param textField 对象本身
 *
 *  @return 无
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //    NSString *text_path = [self getFieldColor];
    //    UIImage *text_img = [[UIImage alloc] initWithContentsOfFile:text_path];
    //    UIImageView *text_imgView = (UIImageView *)[textField superview];
    //    [text_imgView setImage:text_img];
    //    [text_img release];
    [textField resignFirstResponder];
    [self resumeView];
    
    //验证登录按钮是否可以点击
    UITextField *name_field = (UITextField *)[self.view viewWithTag:NAME_FIELD];
    UITextField *pwd_field = (UITextField *)[self.view viewWithTag:PASSWORD_FIELD];
    UIButton *login_btn = (UIButton *)[self.view viewWithTag:LOGIN_BTN];
    if ((name_field.text != nil && ![name_field.text isEqualToString:@""]) &&(pwd_field.text != nil && ![pwd_field.text isEqualToString:@""]))
    {
        login_btn.enabled = YES;
    }
    else
    {
        login_btn.enabled = NO;
    }
    
    return YES;
}

//恢复原始视图位置
- (void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //下移30个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,0,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
}

/**
 *  收回键盘
 */
- (void)clickReturn
{
    NSString *text_path = [self getFieldColor];
    UIImage *text_img = [[UIImage alloc] initWithContentsOfFile:text_path];
    UIImageView *text_imgView = (UIImageView *)[temp_txt superview];
    [text_imgView setImage:text_img];
    [temp_txt resignFirstResponder];
}
/**
 *  设置字段的颜色
 *
 *  @return 图片的路径
 */
- (NSString *)getFieldColor
{
    NSString *text_path = @"";
    if(temp_txt.text  == nil || [temp_txt.text isEqualToString:@""])
    {
        //        text_path = [[NSBundle mainBundle] pathForResource:@"textfield_red" ofType:@"png"];
    }
    else
    {
        //        text_path = [[NSBundle mainBundle] pathForResource:@"textfield" ofType:@"png"];
    }
    return text_path;
}
/**
 *  点击记住用户事件
 *
 *  @param tap tap
 */
- (void)checkRemember
{
    UIImageView *imgView = (UIImageView *)[self.view viewWithTag:CHECK_IMG_VIEW];
    NSString *check_path;
    if (isChecked)
    {
        check_path = [[NSBundle mainBundle] pathForResource:@"checkNO" ofType:@"png"];
    }
    else
    {
        check_path = [[NSBundle mainBundle] pathForResource:@"checkYES" ofType:@"png"];
    }
    UIImage *check_img = [[UIImage alloc] initWithContentsOfFile:check_path];
    [imgView setImage:check_img];
    isChecked = !isChecked;
    
}

- (void)clickLogin{


    NSLog(@"..");
    
    UITextField *name_field = (UITextField *)[self.view viewWithTag:NAME_FIELD];
    UITextField *pwd_field = (UITextField *)[self.view viewWithTag:PASSWORD_FIELD];
    
    NSString *path= [NSString stringWithFormat:LOGIN,name_field.text,pwd_field.text ];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
         NSLog(@"array--%@",string);
        if ([string isEqualToString:@"0"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"请输入正确的账号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            //设置提示框样式（可以输入账号密码）
            alert.alertViewStyle = UIAlertViewStyleDefault;
            
            [alert show];

        }
        else{
            SingleModel *model = [SingleModel sharedSingleModel];
            NSDictionary *subDic = dic[@"data"];
            NSString *userkey = subDic[@"userkey"];
            NSString *jsessionid = subDic[@"jsessionId"];
            NSLog(@"jsessionid--%@",jsessionid);
           
            model.userkey = userkey;
            model.jsessionid = jsessionid;
            model.isBoolLogin = @"Y";
            NSLog(@"%@",model.userkey);
        
            if ([model.push isEqualToString:@"shopOrder"]) {
                UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"确认订单" style:UIBarButtonItemStylePlain target:nil action:nil];
                self.navigationItem.backBarButtonItem = backItem;
                self.navigationController.navigationBarHidden = NO;
                OrderController *order = [[OrderController alloc]init];
                [self.navigationController pushViewController:order animated:YES];
                
            }
            
            else {
                PersonViewController *person = [[PersonViewController alloc]init];
                [self.navigationController pushViewController:person animated:YES];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];

}
- (void)registerLogin{

    
    RegisterViewController *reg = [[RegisterViewController alloc]init];
    
    [self.navigationController pushViewController:reg animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    
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
