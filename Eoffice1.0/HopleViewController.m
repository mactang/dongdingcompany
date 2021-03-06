//
//  HopleViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "HopleViewController.h"
#import "RDVTabBarController.h"
#import "photoAlterView.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "LetfWordButton.h"
@interface HopleViewController ()<UITextViewDelegate>

@end

@implementation HopleViewController
{
    UITextView *TextView;
    UILabel *LB;
    NSString *phoneSure;
    LetfWordButton *photoBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIView *telePhone = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 60)];
    telePhone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:telePhone];
    
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
    titleLB.font = [UIFont systemFontOfSize:18];
    titleLB.text = @"客服电话";
    titleLB.textColor = [UIColor blackColor];
    [telePhone addSubview:titleLB];
    
    
    photoBtn = [[LetfWordButton alloc]initWithFrame:CGRectMake(180, 15, 120, 40)];
    [photoBtn setTitle:@"400888888" forState:UIControlStateNormal];
    [photoBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    photoBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [photoBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(photoPress) forControlEvents:UIControlEventTouchUpInside];
    [telePhone addSubview:photoBtn];
    
    
    UIView *idealPhone = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(telePhone.frame)+15, 320, 310)];
    idealPhone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:idealPhone];
    
    UILabel *idealLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
    idealLB.font = [UIFont systemFontOfSize:18];
    idealLB.text = @"意见反馈";
    idealLB.textColor = [UIColor blackColor];
    [idealPhone addSubview:idealLB];

    TextView = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(idealLB.frame)+10, 300, 200)];
    TextView.clipsToBounds = YES;
    TextView.layer.cornerRadius = 5;
    TextView.layer.borderWidth = 1;
    TextView.layer.borderColor = [[UIColor grayColor]CGColor];
    TextView.delegate = self;
   // TextView.text = @"最多输入100个汉字";
    [idealPhone addSubview:TextView];
    
     LB = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(idealLB.frame)+15, 100, 20)];
     LB.font = [UIFont systemFontOfSize:12];
     LB.text = @"最多输入100个汉字";
    LB.textColor = [UIColor blackColor];
    LB.enabled = NO;
    [idealPhone addSubview:LB];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(TextView.frame)+10, 300, 40)];
    sureBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 5;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
    [idealPhone addSubview:sureBtn];
    // Do any additional setup after loading the view.
}

- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)photoPress{
    photoAlterView *alter=[[photoAlterView alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
    alter.phoneNumber = photoBtn.titleLabel.text ;
    alter.rightBlock=^()
    {
        NSLog(@"右边按钮被点击");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://123456789"]];
    };
    alter.leftBlock=^()
    {
        NSLog(@"左边按钮被点击");
    };
    alter.dismissBlock=^()
    {
        NSLog(@"窗口即将消失");
    };
    [alter show];
}
-(void)surePress{

    [self feedData];
}

-(void)feedData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *string = [NSString stringWithFormat:@"%@",TextView.text];
    
//  NSString *transString = [NSString stringWithString:[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//  NSString *utfString = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//  const char* utfString = [string UTF8String];
    NSString *path= [NSString stringWithFormat:FEEDBACK,COMMON,model.userkey,string];
    NSLog(@"%@",path);
//  [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *escapedPath = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:escapedPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        UIAlertView *alterview;
        
        if ([dic[@"status"]integerValue]==1) {
            
            phoneSure = dic[@"info"];
            
        }
        else{
            
            phoneSure = dic[@"info"];
            
        }
        alterview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:phoneSure delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alterview show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{

    if (textView.text.length == 0) {
        LB.text = @"请填写审批意见...";
    }else{
        LB.text = @"";
    } 
}
-(void)phone{

    
}
- (void)leftBtn{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
