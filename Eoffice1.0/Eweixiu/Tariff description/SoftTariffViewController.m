//
//  SoftTariffViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "SoftTariffViewController.h"
#import "TarBarButton.h"
#import "TariffHeaderController.h"
#import "ButtonHeaderController.h"
#import "ChooseAddressViewController.h"
@interface SoftTariffViewController ()<UITableViewDelegate,UITableViewDataSource,AppointmentDelegate>{
    UITableView *_tableview;
}
@end
@implementation SoftTariffViewController
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
    label.text = @"资费说明";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.showsVerticalScrollIndicator =
    NO;
    // _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_tableview registerClass:[TariffHeaderController class] forHeaderFooterViewReuseIdentifier:@"Myheader"];
    [_tableview registerClass:[ButtonHeaderController class] forHeaderFooterViewReuseIdentifier:@"Mycell"];
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
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    if (section==0) {
        return 130+(SCREEN_WIDTH-40)/3+(SCREEN_WIDTH-40)/3;
    }
    else{
        return 40;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        TariffHeaderController *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Myheader"];
        return headerview;
    }
    else{
        ButtonHeaderController *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Mycell"];
        headerview.sectionstring = @"立即预约";
        headerview.delegate = self;
        return headerview;
    }
    
}
-(void)chooseAddressed{
    ChooseAddressViewController *chooseAddress = [[ChooseAddressViewController alloc]init];
    chooseAddress.titlestring = @"软件系统维护";
    [self.navigationController pushViewController:chooseAddress animated:YES];
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
