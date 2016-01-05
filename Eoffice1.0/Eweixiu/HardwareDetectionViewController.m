//
//  HardwareDetectionViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "HardwareDetectionViewController.h"
#import "TheSameHeaderView.h"
#import "TheSameTableViewCell.h"
#import "HardwareTariffViewController.h"
@interface HardwareDetectionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableview;
}
@end

@implementation HardwareDetectionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"硬件检测维修";
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
        HardwareTariffViewController *hardwaretariff = [[HardwareTariffViewController alloc]init];
        [self.navigationController pushViewController:hardwaretariff animated:YES];
    }];
    return headerView;
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
}
@end
