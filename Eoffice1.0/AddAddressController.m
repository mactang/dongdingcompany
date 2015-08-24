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
@interface AddAddressController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,citychoosedelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *addressLB;
@property(nonatomic,strong)UITextField *nameLB;
@property(nonatomic,strong)UITextField *phoneLB;
@property(nonatomic,strong)UITextField *emailLB;
@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"新增收货地址";
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
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
    
    if (indexPath.row == 0) {
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, 20)];
        LB.font = [UIFont systemFontOfSize:17];
        LB.text = @"四川省成都市金牛区";
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
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 280, 20)];
        LB.font = [UIFont systemFontOfSize:17];
        LB.text = @"请选择街道";
        LB.textColor = [UIColor grayColor];
        [cell addSubview:LB];
        UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(LB.frame)+5, 280, 20)];
        LB1.font = [UIFont systemFontOfSize:12];
        LB1.text = @"街道";
        LB1.textColor = [UIColor grayColor];
        [cell addSubview:LB1];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (indexPath.row==0) {
        CityChooseView *cithchoose = [[CityChooseView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        cithchoose.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        cithchoose.delegate = self;
        [self.view addSubview:cithchoose];
        
    }
}
#pragma mark - citydelegate
-(void)addressed:(NSString *)address{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
