//
//  OrderAddressViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderAddressViewController.h"
#import "RDVTabBarController.h"
#import "AddAddressController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "AddressModel.h"
#import "SingleModel.h"
#import "ChangeAddrssController.h"
#import "OrederManagerCell.h"
#import "AddressViewController.h"

@interface OrderAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,reloaddelegate,reloadAddressdelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *nameDatas;
@property(nonatomic, strong)NSMutableArray *phoneDatas;
@property(nonatomic, strong)NSMutableArray *addressDatas;
@property(nonatomic, strong)NSMutableArray *selectedCellIndexes;
@property(nonatomic,assign)NSInteger btnNumber;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic, strong)NSString *addressId;
@property(nonatomic,assign)NSInteger signbutton;
@property(nonatomic,strong)NSMutableArray *dataarray;

@end

@implementation OrderAddressViewController


{
    UIButton *anotherButton;
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.signbutton = 0;
    self.dataarray = [NSMutableArray array];
    self.navigationItem.title = @"收货地址";
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //开始默认表是不编辑状态
    _tableView.editing = NO;
    [self.view addSubview:_tableView];
    [self downData];
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 510, 300, 40)];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setTitle:@"管理收货地址" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    addBtn.clipsToBounds = YES;
    addBtn.layer.cornerRadius = 5;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
   
}

- (void)downData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:ADDRESS,COMMON,model.userkey];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        [hud hide:YES];
        [self.datas removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        [self.dataarray removeAllObjects];
        [self.datas removeAllObjects];
        if (dic[@"data"] !=[NSNull null]) {
            for (NSInteger i=0; i<[dic[@"data"]count]; i++) {
                if (![dic[@"data"][i][@"defaultAD"]isEqualToString:@"N"]) {
                    self.signbutton = i;
                }
            }
            [self.dataarray addObjectsFromArray:dic[@"data"]];
            NSArray *array = dic[@"data"];
            for(NSDictionary *subDict in array)
            {
                AddressModel *model = [AddressModel modelWithDic:subDict];
                [self.datas addObject:model];
            }
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}

-(void)addPress{
    AddressViewController *add = [[AddressViewController alloc]init];
    
    [self.navigationController pushViewController:add animated:YES];
}
#pragma mark reloadata
-(void)reloaddata{
    [self downData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrederManagerCell *cell = [OrederManagerCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = 1000;
    cell.buttontag = indexPath.row;
    cell.model = self.datas[indexPath.row];
    if (indexPath.row == self.signbutton) {
       cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}
-(void)checkPressed:(UIButton *)button{
    NSLog(@"++++++++");
}
- (void)leftItemClicked{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        NSLog(@"....");
    }else{
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:_btnNumber inSection:0];
        [self.datas removeObjectAtIndex:_btnNumber];
        [self.dataarray removeObjectAtIndex:_btnNumber];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    AddressModel *model = self.datas[indexPath.row];
    SingleModel *sing = [SingleModel sharedSingleModel];
    sing.addressId = model.addressId;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectedAddress" object:[NSString stringWithFormat:@"%ld",indexPath.row]];
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark reloadAddressdelegate methds
-(void)reloadAddress{
    
    [self downData];
    
}

- (void)leftBtn{
    
    // [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    //  [(BottonTabBarController*)self.tabBarController hideTabBar:NO];
    
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
