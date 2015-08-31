//
//  AddressViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/23.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AddressViewController.h"
#import "RDVTabBarController.h"
#import "AddAddressController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "AddressModel.h"
#import "SingleModel.h"
#import "ChangeAddrssController.h"
#import "ManageAddressCell.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,buttondelegate>{
     UIButton *anotherButton;
}
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

@implementation AddressViewController

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
    self.navigationItem.title = @"管理收货地址";
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    
    UIBarButtonItem *releaseButon=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(releaseInfo:)];
    self.navigationItem.rightBarButtonItem = releaseButon;
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    [self downData];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //开始默认表是不编辑状态
    _tableView.editing = NO;
    [self.view addSubview:_tableView];
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 510, 300, 40)];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setTitle:@"新增收获地址" forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    addBtn.clipsToBounds = YES;
    addBtn.layer.cornerRadius = 5;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
    _nameDatas = [NSMutableArray arrayWithObjects:@"东鼎泰和",@"泰和",@"科技", nil];
    
    _phoneDatas = [NSMutableArray arrayWithObjects:@"12345678901",@"23456789876",@"45678906543", nil];
    
    _addressDatas = [NSMutableArray arrayWithObjects:@"四川省成都市武侯区桐梓林地铁站旁丰德国际广场B1座12楼",@"四川省成都市武侯区桐梓林地铁站旁丰德国际广场B1座12楼",@"四川省成都市武侯区桐梓林地铁站旁丰德国际广场B1座12楼", nil];
    
    _selectedCellIndexes = [NSMutableArray array];
    // Do any additional setup after loading the view.
}
-(void)releaseInfo:(UIBarButtonItem *)button{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:DEFAULTADDREDD,self.dataarray[self.signbutton][@"addressId"],model.userkey];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic[@"info"]);
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


}
- (void)downData{

    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:ADDRESS,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        if (dic[@"data"] !=[NSNull null]) {
            for (NSInteger i=0; i<[dic[@"data"]count]; i++) {
                if (![dic[@"data"][i][@"defaultAD"]isKindOfClass:[NSNull class]]) {
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
        NSLog(@"%@",error);
    }];
    
}

-(void)addPress{
    AddAddressController *add = [[AddAddressController alloc]init];
    
    [self.navigationController pushViewController:add animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ManageAddressCell *cell = [ManageAddressCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.buttontag = indexPath.row;
    cell.model = self.datas[indexPath.row];
    cell.delegate = self;
    if (indexPath.row == self.signbutton) {
        cell.clickbutton.selected = YES;
        anotherButton = cell.clickbutton;
    }
    return cell;
}
-(void)checkPressed:(UIButton *)button{
   
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
<<<<<<< HEAD:Eoffice1.0/AddressViewController.m

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//
//    if (buttonIndex == 0) {
//        NSLog(@"....");
//    }else{
//        [_tableView setEditing:!self.tableView.editing animated:YES];
//        
//        //将保存选中行的数组清空
//        [self.selectedCellIndexes removeAllObjects];
//        //刷新表
//        [self.tableView reloadData];
//
//    }
//}
- (void)isPublicBtnPress:(UIButton*)btn{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除这条地址吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //设置提示框样式（可以输入账号，密码）
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    alertView.delegate = self;
    [alertView show];
    btn.selected = !btn.selected;
    _btnNumber = btn.tag;
    
    NSLog(@"aaa");
    
    
=======
#pragma mark buttondelegate methds
-(void)buttondelegate:(UIButton *)button{
    anotherButton.selected  = NO;
    self.signbutton = button.tag-100;
    button.selected = YES;
    anotherButton = button;
>>>>>>> 9d485e7261549113bc728c352968808692aa86c6:Eoffice1.0/manageAddress/AddressViewController.m
}
-(void)delegatedata:(NSInteger)buttontag{
    _btnNumber = buttontag;
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要删除该地址吗" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertview.alertViewStyle = UIAlertViewStyleDefault;
    alertview.delegate = self;
    [alertview show];
}
//- (void)isPublicBtnPress:(UIButton*)btn{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定删除这条地址吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    //设置提示框样式（可以输入账号，密码）
//    alertView.alertViewStyle = UIAlertViewStyleDefault;
//    alertView.delegate = self;
//    [alertView show];
//    btn.selected = !btn.selected;
//    _btnNumber = btn.tag;
//        NSLog(@"aaa");
//    
//    
//}
//
//-(void)delegateBtn:(UIButton *)btn{
//    
//   
//    _btnNumber = btn.tag;
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除订单" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];
//    //设置提示框样式（可以输入账号密码）
//    alert.alertViewStyle = UIAlertViewStyleDefault;
//    
//    [alert show];
//    
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        NSLog(@"....");
    }else{
        
         NSIndexPath *path = [NSIndexPath indexPathForRow:_btnNumber inSection:0];
        [self.datas removeObjectAtIndex:_btnNumber];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationFade];
        [_tableView endUpdates];
        [self deleteData];
        
    }
}
-(void)deleteData{
    
    NSLog(@"row--%@",_addressId);
//    http://192.168.0.170:8080/eoffice/phone/order!delAddress.action?id=?
    
    NSString *path= [NSString stringWithFormat:ADDRESSDELTE,self.dataarray[_btnNumber][@"addressId"]];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
//        NSLog(@"array--%@",string);
        if ([string isEqualToString:@"1"]) {
            
            
        }
        else{
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel *model = self.datas[indexPath.row];
    
    SingleModel *single = [SingleModel sharedSingleModel];
    single.addressId = model.addressId;

    ChangeAddrssController *change = [[ChangeAddrssController alloc]init];
    [self.navigationController pushViewController:change animated:YES];
    
}

////继承该方法时,左右滑动会出现删除按钮(自定义按钮),点击按钮时的操作
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//   [_nameDatas removeObjectAtIndex:indexPath.row];
//    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
//    NSLog(@"indexPath--%@",indexPath);
//   [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//    
//}
//
////选中某行
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //将选中行的位置放入数组
//    [self.selectedCellIndexes addObject:indexPath];
//}
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
