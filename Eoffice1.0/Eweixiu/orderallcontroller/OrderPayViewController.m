//
//  OrderPayViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/12/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderPayViewController.h"
#import "TarBarButton.h"
#import "ButtonHeaderController.h"
#import "ChoosePayWayTableViewCell.h"
@interface OrderPayViewController()<UITableViewDataSource,UITableViewDelegate,AppointmentDelegate,choosePaydelegate>
{
    UITableView *_tableview;
    NSMutableArray *allmessageArray;
    NSInteger signumber;
    UIButton *signbutton;
}
@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    signumber = 0;
    allmessageArray = [NSMutableArray array];
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
    label.text = @"支付订单";
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
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return 4;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        NSArray *array = @[@"百度钱包",@"微信支付",@"支付宝",@"银行卡",];
        NSArray *titleArray = @[@"baiduqianbao",@"weixinpay",@"alipay",@"bank",];
        for (NSInteger i=0; i<titleArray.count; i++) {
            [allmessageArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:array[i],@"title",titleArray[i],@"image", nil]];
        }
        ChoosePayWayTableViewCell *cell = [ChoosePayWayTableViewCell cellWithTableView:tableView];
        cell.buttontag = indexPath.row;
        cell.dictionary = allmessageArray[indexPath.row];
        cell.delegate = self;
        if (indexPath.row == signumber) {
            cell.chooseButton.selected = YES;
            signbutton = cell.chooseButton;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        
        static NSString *ID =@"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        //    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
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
    if (section==0) {
        return 40;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==2) {
        return 50;
    }
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==2) {
        ButtonHeaderController *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Myfooterview"];
        headerview.sectionstring = @"确认支付";
        headerview.delegate = self;
        return headerview;
    }
    else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)chooseAddressed{
}
-(void)buttondelegate:(UIButton *)button{
    signbutton.selected  = NO;
    signumber = button.tag-100;
    button.selected = YES;
    signbutton = button;
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
