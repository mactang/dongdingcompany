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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"修改手机号码";
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 290)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UILabel *photoLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 70, 20)];
    photoLB.font = [UIFont systemFontOfSize:12];
    photoLB.text = @"原手机号码:";
    photoLB.textColor = [UIColor blackColor];
    [self.view addSubview:photoLB];
    
    _phoneField = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoLB.frame), 75, 155, 30)];
    _phoneField.backgroundColor = [UIColor whiteColor];
    _phoneField.clipsToBounds = YES;
    [_phoneField setText:@"13618090081"];
    _phoneField.layer.cornerRadius = 3;
    _phoneField.layer.borderWidth = 1;
    _phoneField.layer.borderColor = [[UIColor grayColor]CGColor];
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
    
    UITextField *validateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(validateLB.frame), CGRectGetMaxY(photoLB.frame)+23, 155, 30)];
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
    
    UITextField *newPhoneField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newValidateLB.frame), CGRectGetMaxY(validateField.frame)+25, 155, 30)];
    newPhoneField.backgroundColor = [UIColor whiteColor];
    newPhoneField.clipsToBounds = YES;
    newPhoneField.delegate = self;
    newPhoneField.layer.cornerRadius = 3;
    newPhoneField.layer.borderWidth = 1;
    newPhoneField.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:newPhoneField];
    
    UIButton *newNalidateButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newPhoneField.frame)+5,newPhoneField.frame.origin.y, 70, 30)];
    newNalidateButton.backgroundColor = [UIColor whiteColor];
    newNalidateButton.clipsToBounds =YES;
    newNalidateButton.layer.cornerRadius = 3;
    newNalidateButton.layer.borderColor = [[UIColor grayColor]CGColor];
    newNalidateButton.layer.borderWidth = 1;
    newNalidateButton.font = [UIFont systemFontOfSize:12];
    [newNalidateButton addTarget:self action:@selector(validatePress) forControlEvents:UIControlEventTouchUpInside];
    [newNalidateButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [newNalidateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:newNalidateButton];
    
    UILabel *newNalidateLB = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(newValidateLB.frame)+30, 50, 20)];
    newNalidateLB.font = [UIFont systemFontOfSize:12];
    newNalidateLB.text = @"验证码：";
    newNalidateLB.textColor = [UIColor blackColor];
    [self.view addSubview:newNalidateLB];
    
    UITextField *newNalidateField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newValidateLB.frame), CGRectGetMaxY(newValidateLB.frame)+23, 155, 30)];
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

-(void)valiData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SAFEVALIDATE,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
