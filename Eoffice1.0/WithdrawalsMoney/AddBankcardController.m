//
//  AddBankcardController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AddBankcardController.h"
#import "RDVTabBarController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "Mobliejudge.h"
@interface AddBankcardController ()<UITextFieldDelegate>{
    
    NSString *name;
    NSString *banknumber;
    NSString *bankcard;
    NSString *bankaddress;
}
@end

@implementation AddBankcardController
-(instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"添加银行卡";
    }
    return self;
}
-(void)setSucess:(BOOL)sucess{
    _sucess = sucess;
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
    NSArray *textname = @[@"姓名",@"卡号",@"银行卡",@"开户行",];
    NSArray *placeholderarrat = @[@"请输入姓名",@"请输入卡号",@"请输入银行卡名称",@"请输入开户行,如: 成都东大街支行",];
    for (NSInteger i=0; i<textname.count; i++) {
        UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 64+i*(SCREEN_WIDTH/7)+i*1, SCREEN_WIDTH, SCREEN_WIDTH/7)];
        whiteview.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:whiteview];
        UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 50, widgetboundsHeight(whiteview)-10)];
        textlabel.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
        textlabel.font = [UIFont systemFontOfSize:14];
        textlabel.text = textname[i];
        [whiteview addSubview:textlabel];
        
        UITextField *textpalce = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textlabel.frame)+20, widgetFrameY(textlabel), SCREEN_WIDTH-10-20-CGRectGetMaxX(textlabel.frame), widgetboundsHeight(textlabel))];
        textpalce.placeholder = placeholderarrat[i];
        textpalce.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
        textpalce.font = [UIFont systemFontOfSize:13];
        textpalce.delegate = self;
        textpalce.tag = 40+i;
        [whiteview addSubview:textpalce];
        if (i==textname.count-1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, (textname.count)*(SCREEN_WIDTH/7)+20+64, SCREEN_WIDTH-20, SCREEN_WIDTH/9);
            button.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            button.layer.cornerRadius = 4;
            [button setTitle:@"确认" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(addbankcardPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"%@",string);
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag==40) {
        name = text;
    }
    if (textField.tag==41) {
        banknumber = text;
    }
    if (textField.tag==42) {
        bankcard = text;
    }
    if (textField.tag==43) {
        bankaddress = text;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    UIAlertView *alterview;
    NSString *messagestring;
    if (textField.tag!=41) {
        if (! [Mobliejudge checkChinese:textField.text]) {
            NSLog(@"%@",@"姓名格式错误");
        }
        
    }
//    return YES;
}
-(void)addbankcardPressed{
    UIAlertView *alertview;
    NSString *messagestring;
    if (name==nil) {
        messagestring = @"姓名不能为空";
    }
   else if (banknumber==nil) {
        messagestring = @"卡号不能为空";
    }
   else if (messagestring==nil) {
        messagestring = @"请填写银行卡类型";
    }
   else if (bankaddress==nil) {
        bankaddress = @"请输入开户行";
    }
    else{
         [self datarequest];
        return;
    }
    alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:messagestring delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertview show];
    
}
-(void)datarequest{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
//  NSString *path= [NSString stringWithFormat:ADDBANKCARD,COMMON,model.userkey,name,bankcard,banknumber,bankaddress];
//  NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//  @"%@user!addBand.action?userkey=%@&name=%@&bankName=%@&bankNo=%@&bankAddress=%@"
    NSDictionary *dicdata = [NSDictionary dictionaryWithObjectsAndKeys:model.userkey,@"userkey",name,@"name",bankcard,@"bankName",banknumber,@"bankNo",bankaddress,@"bankAddress", nil];
    [manager POST:@"http://192.168.0.65:8080/phone/user!addBand.action?" parameters:dicdata success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        UIAlertView *alterview;
        NSString *string;
        if ([dic[@"status"]integerValue]==1) {
            string = @"添加成功";
            [self leftItemClicked];
            if (_delegate && [_delegate respondsToSelector:@selector(reloadlist)]) {
                [self.delegate reloadlist];
            }
        }
        else{
            string = @"添加失败";
        }
        alterview  =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alterview show];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
    }];
}
- (void)leftItemClicked{
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
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
