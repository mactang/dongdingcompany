//
//  OrederConfirmViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/12/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrederConfirmViewController.h"
#import "TarBarButton.h"
#import "ButtonHeaderController.h"
#import "OrderConfrimTableViewCell.h"
#import "OrderPayViewController.h"
@interface OrederConfirmViewController ()<UITableViewDataSource,UITableViewDelegate,AppointmentDelegate>{
    UITableView *_tableview;
}
@end

@implementation OrederConfirmViewController

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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = @"订单确认";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_tableview registerClass:[ButtonHeaderController class] forHeaderFooterViewReuseIdentifier:@"Myfooterview"];
    [self.view addSubview:_tableview];
    [self setExtraCellLineHidden:_tableview];

}
#pragma mark - TQTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 5;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *messageArray = @[[NSDictionary dictionaryWithObjectsAndKeys:@"服务类型",@"title",@"软件系统维护",@"titleItem",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"联系电话",@"title",@"18782931381",@"titleItem",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"预约时间",@"title",@"2015-10-31 (周六) 08:00",@"titleItem",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"服务地点",@"title",@"成都市丰德国际广场B1座12楼",@"titleItem",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"订单备注",@"title",@"要发票!要发票!要发票!",@"titleItem",nil],];
    NSArray *costArray = @[[NSDictionary dictionaryWithObjectsAndKeys:@"上门费",@"title",@"￥30",@"titleItem",nil],[NSDictionary dictionaryWithObjectsAndKeys:@"重装系统",@"title",@"￥30",@"titleItem",nil],];
    static NSString *ID =@"Cell";
    OrderConfrimTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[OrderConfrimTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section==0) {
        cell.sucess = YES;
        cell.dictionary  = messageArray[indexPath.row];
    }
    if (indexPath.section==1) {
        cell.sucess = NO;
        cell.dictionary = costArray[indexPath.row];
    }
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
#pragma mark - Tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 40;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1) {
        ButtonHeaderController *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Myfooterview"];
        headerview.sectionstring = @"前去支付";
        headerview.delegate = self;
        return headerview;
    }
    else{
        NSString *headerIndetifier = @"Myfooter";
        UITableViewHeaderFooterView * control = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIndetifier];
        if (!control) {
            control = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIndetifier];
            UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 39)];
            whiteview.backgroundColor = [UIColor whiteColor];
            [control addSubview:whiteview];
            NSArray *lineArray = @[@"支付方式",@"在线支付"];
            for (NSInteger i=0; i<2; i++) {
                UILabel *onlineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+i*(SCREEN_WIDTH-80), 5, 70, 30)];
                onlineLabel.font = [UIFont systemFontOfSize:14];
                onlineLabel.text = lineArray[i];
                [whiteview addSubview:onlineLabel];
                
            }
        }
        return control;

    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)chooseAddressed{
    
    OrderPayViewController *orderPayView = [[OrderPayViewController alloc]init];
    [self.navigationController pushViewController:orderPayView animated:YES];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

@end
