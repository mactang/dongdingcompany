//
//  MybankcardViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "MybankcardViewController.h"
#import "RDVTabBarController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "BanklistTableViewCell.h"
#import "AddBankcardController.h"
#import "BankdetailViewController.h"
@interface MybankcardViewController()<UITableViewDataSource,UITableViewDelegate,addbankdelegate,refreshdatadelegate>{
    UITableView *_tableview;
    NSMutableArray *datarray;
}

@end

@implementation MybankcardViewController
-(instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"我的银行卡";
    }
    return self;
}
-(void)setSucess:(BOOL)sucess{
    _sucess = sucess;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    datarray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    if (_sucess) {
        UIBarButtonItem *releaseButon=[[UIBarButtonItem alloc] initWithTitle:@"➕" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
        releaseButon.tintColor = [UIColor lightGrayColor];
        self.navigationItem.rightBarButtonItem = releaseButon;
    }
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.sectionFooterHeight = 1;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.userInteractionEnabled = YES;
    _tableview.scrollEnabled = YES;
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:_tableview];
    _tableview.tableFooterView = [[UIView alloc]init];
    [self banklistrequest];
}

-(void)banklistrequest{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:BANKCARDLIST,COMMON,model.userkey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [datarray removeAllObjects];
        if (dic[@"data"] !=[NSNull null]){
            [datarray addObjectsFromArray:dic[@"data"]];
            NSLog(@"%@",dic);
        }
        [hud hide:YES];
        if (datarray.count==0) {
            [self addbankcard];
        }
        [_tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
-(void)addbankcard{
    UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, 50)];
    whiteview.backgroundColor = [UIColor whiteColor];
    whiteview.tag = 70;
    [self.view addSubview:whiteview];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 2, SCREEN_WIDTH, 46);
    [button setTitle:@"➕添加银行卡" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(addbankcardPressed) forControlEvents:UIControlEventTouchUpInside];
    [whiteview addSubview:button];
}
-(void)addbankcardPressed{
    [self rightItemClicked];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return datarray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity = @"cell";
    BanklistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell =  [[BanklistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    cell.dic = datarray[indexPath.row];
    return cell;

}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_sucess) {
        BankdetailViewController *bankdetail = [[BankdetailViewController alloc]init];
        bankdetail.dic = datarray[indexPath.row];
        bankdetail.delegate = self;
        [self.navigationController pushViewController:bankdetail animated:YES];
    }
    else{
        if (_delegate &&[_delegate respondsToSelector:@selector(choosebankcard:)]) {
            [self.delegate choosebankcard:datarray[indexPath.row]];
            [self leftItemClicked];
        }
    }
   
}
#pragma mark addbankdelegate
-(void)reloadlist{
    UIView *whiteview = (UIView *)[self.view viewWithTag:70];
    [whiteview removeFromSuperview];
    [self banklistrequest];
}
#pragma mark refreshdatadelegate
-(void)refreshdatalist{
    [self banklistrequest];
}
-(void)rightItemClicked{
    AddBankcardController *addbank = [[AddBankcardController alloc]init];
    addbank.delegate = self;
    addbank.sucess = NO;
    [self.navigationController pushViewController:addbank animated:YES];
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
    [super viewWillDisappear:animated];
}
@end
