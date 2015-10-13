//
//  AddAddressController.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/1.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AddAddressController.h"
#import "RDVTabBarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "CityChooseView.h"
#import "Config.h"
#import "Mobliejudge.h"
@interface AddAddressController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,citychoosedelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *addressLB;
@property(nonatomic,strong)UITextField *nameLB;
@property(nonatomic,strong)UITextField *phoneLB;
@property(nonatomic,strong)UITextField *emailLB;
@property(nonatomic,strong)UITextField *street;
@property(nonatomic,copy)NSString *cityid;
@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"新增收货地址";
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-128) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIButton *confirmbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmbutton.frame = CGRectMake(10, SCREEN_HEIGHT-64, SCREEN_WIDTH-20, 40);
    confirmbutton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [confirmbutton setTitle:@"确定" forState:UIControlStateNormal];
    confirmbutton.titleLabel.font = [UIFont systemFontOfSize:17];
    confirmbutton.clipsToBounds = YES;
    confirmbutton.layer.cornerRadius = 4;
    [confirmbutton addTarget:self action:@selector(confirmbuttonPresed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmbutton];
    // Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, 20)];
        LB.font = [UIFont systemFontOfSize:17];
        LB.text = @"请选择区域";
        LB.tag = 10;
        LB.textColor = [UIColor blackColor];
        [cell addSubview:LB];
        UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LB.frame)+5, 280, 20)];
        LB1.font = [UIFont systemFontOfSize:12];
        LB1.text = @"所在地区";
        LB1.textColor = [UIColor grayColor];
        [cell addSubview:LB1];
    }
    if (indexPath.row == 1) {
        self.street = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
        self.street.backgroundColor = [UIColor whiteColor];
        self.street.placeholder = @"请输入街道名称";
        self.street.font = [UIFont systemFontOfSize:17];
        self.street.delegate = self;
      self.street.clearButtonMode = UITextFieldViewModeAlways;
        [cell addSubview:self.street];
    }
    if (indexPath.row == 2) {
        _addressLB = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        _addressLB.backgroundColor = [UIColor whiteColor];
        _addressLB.placeholder = @"请输入详细地址";
        _addressLB.font = [UIFont systemFontOfSize:17];
        _addressLB.clearButtonMode = UITextFieldViewModeAlways;
        _addressLB.delegate = self;
        [cell addSubview:_addressLB];
    }
    if (indexPath.row == 3) {
        _nameLB = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        _nameLB.backgroundColor = [UIColor whiteColor];
        _nameLB.placeholder = @"请输入收货人姓名";
        _nameLB.font = [UIFont systemFontOfSize:17];
        _nameLB.clearButtonMode = UITextFieldViewModeAlways;
        _nameLB.delegate = self;
        [cell addSubview:_nameLB];
    }
    if (indexPath.row == 4) {
        _phoneLB = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        _phoneLB.backgroundColor = [UIColor whiteColor];
        _phoneLB.placeholder = @"请输入收货人联系电话";
        _phoneLB.font = [UIFont systemFontOfSize:17];
        _phoneLB.clearButtonMode = UITextFieldViewModeAlways;
        _phoneLB.delegate = self;
        [cell addSubview:_phoneLB];
    }
    if (indexPath.row == 5) {
        _emailLB = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        _emailLB.backgroundColor = [UIColor whiteColor];
        _emailLB.placeholder = @"请输入邮编";
        _emailLB.font = [UIFont systemFontOfSize:17];
        _emailLB.clearButtonMode = UITextFieldViewModeAlways;
        _emailLB.delegate = self;
        [cell addSubview:_emailLB];
    }
    return cell;
    
}
-(void)confirmbuttonPresed{
    UILabel *quitlabel = (UILabel *)[self.view viewWithTag:10];
    UIAlertView *alertview;
    NSString *string;
    if ([quitlabel.text isEqualToString:@"请选择区域"]) {
        string = @"请选择区域位置";
    }
    else if ([self.street.text isEqualToString:@""]) {
        string = @"请输入街道名称";
        
    }
    else if ([_addressLB.text isEqualToString:@""]){
        string = @"请输入详细地址";
    }
    else if ([_nameLB.text isEqualToString:@""]){
        string = @"请输入收货人姓名";
    }
    else if ([Mobliejudge valiMobile:_phoneLB.text]){
        string = [Mobliejudge valiMobile:_phoneLB.text];
    }
    else if (![Mobliejudge isValidateEmail:_emailLB.text]){
        string = @"请输入正确的邮编";
    }
    else{
        [self datarequest];
        return;
    }
    alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertview show];
}
-(void)datarequest{
    //增加地址
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    
    UILabel *addresslabel = (UILabel *)[self.view viewWithTag:10];
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:ADDRESSEDADD,COMMON,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameter=@{@"address":addresslabel.text,@"telPhone":_phoneLB.text,@"receiver":_nameLB.text,@"isDefault":@"Y",@"post":_emailLB.text,@"city":self.cityid};
    [manager POST:path parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic[@"info"]);
        UIAlertView *alertview;
        NSString *stirng;
        if ([dic[@"status"] integerValue]==1) {
            stirng = @"新增地址成功";
        }
        else{
            stirng  = @"新增失败";
        }
        alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:stirng delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        if ([stirng isEqualToString:@"新增地址成功"]) {
            alertview.tag = 20;
            self.navigationController.navigationBar.translucent = YES;
            [self.navigationController popViewControllerAnimated:YES];
            if (_delegate &&[_delegate respondsToSelector:@selector(reloaddata)]) {
                [_delegate reloaddata];
            }
        }
        else{
            alertview.tag = 21;
        }
        [alertview show];
        //  NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        //  NSLog(@"%@",string);
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CityChooseView *cithchoose = [[CityChooseView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        cithchoose.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        cithchoose.delegate = self;
        [self.view addSubview:cithchoose];
    }
}
#pragma mark - citydelegate
-(void)addressed:(NSString *)address cityid:(NSString *)cityid{
    self.cityid = cityid;
    UILabel *addressLabel = (UILabel *)[self.view viewWithTag:10];
    addressLabel.text = address;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
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
