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
@interface ChangeAddrssController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *datarray;
@property(nonatomic,strong)NSArray *detailarray;

@end

@implementation ChangeAddrssController
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.datarray = @[@"四川省成都市金牛区",@"回龙观",@"北京市昌平区回龙观田园风光雅苑",@"龙大爷",@"15448454465",@"464484",@"设为默认地址",];
    self.detailarray = @[@"所在地区",@"街道",@"详细地址",@"收货人姓名",@"手机号码",@"邮编",@"",];
    self.navigationItem.title = @"修改收货地址";
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    [self downData];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 480) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
        button.frame = CGRectMake(10+i*(SCREEN_WIDTH-70), SCREEN_HEIGHT-45, 50, 30);
        button.backgroundColor = [UIColor redColor];
        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        if (i==1) {
            [button setTitle:@"保存" forState:UIControlStateNormal];
        }
        [self.view addSubview:button];
    }
}
- (void)downData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:ADDRESSDETAIL,model.addressId];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *array = dic[@"data"];
        NSLog(@"array--%@",array);
        
          AddressDetailModel   *model = [AddressDetailModel modelWithDic:array];
            [self.datas addObject:model];
        
            [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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
    cell.message = self.datarray[indexPath.row];
    cell.detailstring = self.detailarray[indexPath.row];
    return cell;
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
