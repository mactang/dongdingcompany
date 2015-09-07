//
//  ChangeAddrssController.m
//  Eoffice1.0
//
//  Created by gyz on 15/8/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ChangeAddrssController.h"
#import "RDVTabBarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "AddressDetailModel.h"
#import "ChangeAddressCell.h"
#import "CityChooseView.h"
#import "ChangeModel.h"
#import "Mobliejudge.h"
@interface ChangeAddrssController ()<UITableViewDataSource,UITableViewDelegate,citychoosedelegate,districtdelegate>
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *datarray;
@property(nonatomic,strong)NSArray *detailarray;
@property(nonatomic,strong)UILabel *distirtlabel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary *dictionary;
@property(nonatomic,copy)NSString *cityid;
@property(nonatomic,copy)NSString *defaultsign;
@end

@implementation ChangeAddrssController
-(instancetype)initwithtitle:(NSDictionary *)dicdata{
    self.dictionary = dicdata;
    self.defaultsign = dicdata[@"defaultAD"];
    return self;
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.datarray = @[@"四川省成都市金牛区",@"回龙观",self.dictionary[@"fullAddress"],self.dictionary[@"receiver"],self.dictionary[@"telphone"],self.dictionary[@"post"],@"设为默认地址",];
    for (NSInteger i=0; i<self.datarray.count; i++) {
        [self.dataArray addObject:self.datarray[i]];
    }
//    [self.datarray initWithObjects:@"四川省成都市金牛区",@"回龙观",@"北京市昌平区回龙观田园风光雅苑",@"龙大爷",@"15448454465",@"464484",@"设为默认地址", nil];
    NSLog(@"%@",self.datarray);
    self.detailarray = @[@"所在地区",@"街道",@"详细地址",@"收货人姓名",@"手机号码",@"邮编",self.dictionary[@"defaultAD"],];
    self.navigationItem.title = @"修改收货地址";
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-64-45) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
//    _tableView.scrollEnabled = NO;
    //开始默认表是不编辑状态
    _tableView.editing = NO;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableView];
    
    for (NSInteger i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*(SCREEN_WIDTH-70), SCREEN_HEIGHT-45-58, 50, 30);
        button.backgroundColor = [UIColor redColor];
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        if (i==1) {
            [button setTitle:@"保存" forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}
-(void)buttonPressed:(UIButton *)button{
    for (NSInteger i=0; i<self.dataArray.count; i++) {
        if ([self.dataArray[i] isKindOfClass:[NSNull class]]) {
            self.dataArray[i] = @"";
        }
    }
    NSLog(@"%@",self.dataArray);
    UIAlertView *alertview;
    NSString *signstring;
    if ([self.dataArray[0]isEqualToString:@""]) {
        signstring = @"请选择区域";
    }
    else if ([self.dataArray[1]isEqualToString:@""]) {
        signstring = @"请输入街道";
    }
    else if ([self.dataArray[2]isEqualToString:@""]) {
        signstring = @"请输入详细地址";
    }
    else if ([self.dataArray[3]isEqualToString:@""]) {
        signstring = @"请输入姓名";
    }
    else if ([self.dataArray[4]isEqualToString:@""]) {
        signstring = @"请输入手机号";
    }
    else if ([Mobliejudge valiMobile:self.dataArray[4]]){
        signstring = [Mobliejudge valiMobile:self.dataArray[4]];
    }
    else if ([self.dataArray[5]isEqualToString:@""]) {
        signstring = @"请输入邮箱";
    }
       else if (![Mobliejudge isValidateEmail:self.dataArray[5]]){
        signstring = @"请输入正确的邮箱";
    }

    else{
       [self downData];
        return;
    }
    alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:signstring delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertview show];
}
- (void)downData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:@"http://192.168.0.65:8080/eoffice/phone/order!updateAddress.action;jsessionid=%@?userkey=%@",model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    NSDictionary *dicdata = [NSDictionary dictionaryWithObjectsAndKeys:self.dataArray[2],@"address",self.dataArray[4],@"telPhone",self.dataArray[3],@"receiver",self.dataArray[5],@"post",self.dictionary[@"addressId"],@"id",self.cityid,@"city",self.defaultsign,@"isDefault",nil];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
    [manager POST:path parameters:dicdata success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"-----------%@",dic);
        
        UIAlertView *alertview;
        NSString *stirng;
        if ([dic[@"status"] integerValue]==1) {
            stirng = @"修改地址成功";
        }
        else{
            stirng  = @"修改地址失败";
        }
        alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:stirng delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        if ([stirng isEqualToString:@"修改地址成功"]) {
            self.navigationController.navigationBar.translucent = YES;
            [self.navigationController popViewControllerAnimated:YES];
            if (_delegate &&[_delegate respondsToSelector:@selector(reloadAddress)]) {
                [_delegate reloadAddress];
          }
        }
        [alertview show];

        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==6) {
        return 40;
    }
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangeAddressCell *cell = [ChangeAddressCell cellWithTableView:tableView indexpthnumber:indexPath.row];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexnumber = indexPath.row;
    cell.message = self.dataArray[indexPath.row];
    cell.detailstring = self.detailarray[indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma districtdelegate mark
-(void)citydelegatemesthd:(UILabel *)district{
    self.distirtlabel = district;
    CityChooseView *cithchoose = [[CityChooseView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    cithchoose.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    cithchoose.delegate = self;
    [self.view addSubview:cithchoose];
}
-(void)textfieldtext:(NSString *)text texttag:(NSInteger)tagnumber{
    [self.dataArray replaceObjectAtIndex:tagnumber-10 withObject:text];
}
#pragma mark citychoosedelegate methds
-(void)addressed:(NSString *)address cityid:(NSString *)cityid{
    self.cityid = cityid;
    self.distirtlabel.text = address;
    [self.dataArray replaceObjectAtIndex:0 withObject:self.distirtlabel.text];

}
#pragma mark buttonclickdelegate
-(void)buttonclick:(NSString *)defaultstring{
    self.defaultsign = defaultstring;
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
    self.navigationController.navigationBarHidden = NO;
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
