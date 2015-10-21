//
//  PersonViewController.m
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PersonViewController.h"
#import "PersonalInformationController.h"
#import "AddressViewController.h"
#import "HopleViewController.h"
#import "LoginViewController.h"
#import "SafeViewController.h"
#import "ShoppingCarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "RDVTabBarController.h"
#import "PersonInformationModel.h"
#import "SingleModel.h"
#import "LoginViewController.h"
#import "MyMoneybackViewController.h"
#import "RecommendViewController.h"
@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate,logindelegate,persondelegate>{
    LoginViewController *login;
    BOOL refresh;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *datas;
@end

@implementation PersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
    }
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
    refresh = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@""];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *string = @"my";
    model.isBoolmy = [NSString stringWithFormat:@"%@",string];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

}
- (void)downData{
    
    [self.datas removeAllObjects];
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:PERSONCONME,COMMON,model.jsessionid,model.userkey];
    
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            
            NSDictionary *array = dic[@"data"];
            PersonInformationModel *model = [PersonInformationModel modelWithDic:array];
        
           [self.datas addObject: model];
        }
        NSLog(@"%@",self.datas);
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    SingleModel *model = [SingleModel sharedSingleModel];
       if (model.userkey == nil) {
        if (!login) {
            login = [[LoginViewController alloc]init];
            login.delegate = self;
            [self.view addSubview:login.view];
           
        }
        
    }else{
//        if (login) {
            [login.view removeFromSuperview];
            if (refresh) {
                [self downData];
                refresh = NO;
            }
//        }

    }
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)reloadata{
    
    [self downData];
    
}
-(void)reloadshopcart{
    
}
-(void)repeatlogin{
    login = [[LoginViewController alloc]init];
    login.delegate = self;
    [self.view addSubview:login.view];

}
-(void)buttonPress{
    
    LoginViewController *logincontroller = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:logincontroller animated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8*self.datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 175;
    }
            return 50;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 0) {
        PersonInformationModel *model = self.datas[indexPath.row];
        UIImageView *detailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 175)];
        detailImageView.userInteractionEnabled = YES;
        detailImageView.image = [UIImage imageNamed:@"求真像"];
        [cell addSubview:detailImageView];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(105, 30, 110, 105)];
        // button.backgroundColor = [UIColor redColor];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 30;
        [button addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
        [detailImageView addSubview:button];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(115, CGRectGetMaxY(button.frame)+10, 100, 20)];
        lb1.font = [UIFont systemFontOfSize:15];
        lb1.text = [NSString stringWithFormat:@"%@",model.name];
        lb1.textColor = [UIColor whiteColor];
        lb1.textAlignment = NSTextAlignmentCenter;
        [detailImageView addSubview:lb1];
    }
    
    if (indexPath.row == 1) {
        
        cell.textLabel.text = @"       个人信息";
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"个人信息"];
        [cell addSubview:imageView];
        
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"       我的购物车";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"我的购物车"];
        [cell addSubview:imageView];
        
        
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"       收货地址";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"收货地址"];
        [cell addSubview:imageView];
        
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"       我的返现";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"安全设置"];
        [cell addSubview:imageView];
    }
    if (indexPath.row == 5) {
        
        cell.textLabel.text = @"       推荐返现";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"帮助与反馈"];
        [cell addSubview:imageView];
        
    }
    if (indexPath.row == 6) {
        cell.textLabel.text = @"       安全设置";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"安全设置"];
        [cell addSubview:imageView];
    }
    if (indexPath.row == 7) {
        
        cell.textLabel.text = @"       帮助与反馈";
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:@"帮助与反馈"];
        [cell addSubview:imageView];
        
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row == 1) {
        PersonalInformationController *perIn = [[PersonalInformationController alloc]init];
        perIn.delegate = self;
        [self.navigationController pushViewController:perIn animated:YES];
    }
    if (indexPath.row == 2) {
        
        ShoppingCarController *shop = [[ShoppingCarController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
        
    }
    if (indexPath.row == 3) {
        AddressViewController *add = [[AddressViewController alloc]init];
        [self.navigationController pushViewController:add animated:YES];

    }
    if (indexPath.row == 4) {
        MyMoneybackViewController *mymoney = [[MyMoneybackViewController alloc]init];
        [self.navigationController pushViewController:mymoney animated:YES];
    }
    if (indexPath.row == 5) {
        RecommendViewController *recomm = [[RecommendViewController alloc]init];
        [self.navigationController pushViewController:recomm animated:YES];
    }
    if (indexPath.row == 6) {
        SafeViewController *safe = [[SafeViewController alloc]init];
        
        [self.navigationController pushViewController:safe animated:YES];
    }
    if (indexPath.row == 7) {
        HopleViewController *hope = [[HopleViewController alloc]init];
        [self.navigationController pushViewController:hope animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
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
