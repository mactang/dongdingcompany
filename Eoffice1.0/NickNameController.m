//
//  NickNameController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "NickNameController.h"
#import "RDVTabBarController.h"

@interface NickNameController ()<UITextFieldDelegate>

@end

@implementation NickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UITextField *nickName = [[UITextField alloc]initWithFrame:CGRectMake(0, 70, 320, 40)];
    nickName.backgroundColor = [UIColor whiteColor];
    nickName.clearButtonMode = UITextFieldViewModeAlways;
    nickName.delegate = self;
    [self.view addSubview:nickName];
    
    // Do any additional setup after loading the view.
}
//点击return键执行的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
