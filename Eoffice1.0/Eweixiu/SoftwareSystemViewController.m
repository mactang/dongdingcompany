//
//  SoftwareSystemViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "SoftwareSystemViewController.h"
#import "TarBarButton.h"
#import "photoAlterView.h"
#import "TheSameHeaderView.h"
#import "TheSameTableViewCell.h"
#import "SoftTariffViewController.h"
@interface SoftwareSystemViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableview;
}
@end
@implementation SoftwareSystemViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"zuo"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIButton *rightbutton = [UIButton buttonWithType: UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, 0, 30, 30);
    [rightbutton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    UIBarButtonItem *lightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    [rightbutton addTarget:self action:@selector(rightbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:lightItem];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = @"软件系统维护";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.showsVerticalScrollIndicator =
    NO;
    //    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_tableview registerClass:[TheSameHeaderView class] forHeaderFooterViewReuseIdentifier:@"Myheader"];
    [self.view addSubview:_tableview];
    [self setExtraCellLineHidden:_tableview];
}
#pragma mark - TQTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    if (section==1) {
        return 4;
    }
    else{
        return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cellarray = @[[NSArray arrayWithObjects:@"商品类目",@"商品类型",@"商品详情",nil],[NSArray arrayWithObjects:@"服务范围",@"服务时间",@"维修流程",@"注意事项",nil]];
    TheSameTableViewCell *cell = [TheSameTableViewCell cellWithTableView:tableView];
    if (indexPath.section!=2) {
        cell.titlestring = cellarray[indexPath.section][indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 50;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *headerarray = @[@"商品简介",@"服务须知",@"快速下单"];
    TheSameHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Myheader"];
    headerView.contentView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [headerView titlelabel:headerarray[section] headerblock:^(UIButton *button) {
        SoftTariffViewController *softTariff = [[SoftTariffViewController alloc]init];
        [self.navigationController pushViewController:softTariff animated:YES];
    }];
    return headerView;
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}

-(void)rightbuttonClick{
    photoAlterView *alter=[[photoAlterView alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"呼叫"];
    alter.phoneNumber = @"4000-456-423";
    alter.rightBlock=^()
    {
        NSLog(@"右边按钮被点击");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000456423"]];
    };
    alter.leftBlock=^()
    {
        NSLog(@"左边按钮被点击");
    };
    alter.dismissBlock=^()
    {
        NSLog(@"窗口即将消失");
    };
    [alter show];
    
}
-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}
@end
