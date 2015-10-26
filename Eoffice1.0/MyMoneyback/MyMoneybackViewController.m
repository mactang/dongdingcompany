//
//  MyMoneybackViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "MyMoneybackViewController.h"
#import "RDVTabBarController.h"
#import "CurrentrecordCell.h"
#import "PresentdetailsCell.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "WithdrawalsViewController.h"
@interface MyMoneybackViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIButton *_currButton;
    UIView *headerView;
    UILabel *totalPrice;
    UILabel *balancePrice;
    UITableView *_tableview;
    NSMutableDictionary *datadic;
    NSMutableArray *dataarray;
    BOOL sucess;
}
@end
@implementation MyMoneybackViewController
-(instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"我的返现";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 30);
    //  [rightButton addTarget:self action:@selector(rightItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提现" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    rightButton.layer.cornerRadius = 2;
    [rightButton addTarget:self action:@selector(rightbuttonPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightItem];

    datadic = [NSMutableDictionary dictionary];
    sucess = YES;
    
    [self initerface];
    [self datarequest];
}
-(void)initerface{
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH/6.7)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame)+2.5, SCREEN_WIDTH, widgetboundsHeight(headerView)-10)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteview];
    
    totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, (SCREEN_WIDTH-20)/2, widgetboundsHeight(whiteview)-10)];
    totalPrice.font = [UIFont systemFontOfSize:14];
    totalPrice.text = [NSString stringWithFormat:@"总金额: %.2f",[datadic[@"totalAmount"] floatValue]];
    [whiteview addSubview:totalPrice];

    balancePrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalPrice.frame), 5, (SCREEN_WIDTH-20)/2, widgetboundsHeight(whiteview)-10)];
    balancePrice.font = [UIFont systemFontOfSize:14];
    balancePrice.text = [NSString stringWithFormat:@"余额:%.2f",[datadic[@"balance"] floatValue]];
    [whiteview addSubview:balancePrice];
    
    NSArray *array = @[@"返现记录",@"提现明细",];
    for (NSInteger i=0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH/10+i*((SCREEN_WIDTH-(SCREEN_WIDTH/10)*2)/3)+i*((SCREEN_WIDTH-(SCREEN_WIDTH/10)*2)/3), widgetboundsHeight(headerView)/2-15, (SCREEN_WIDTH-(SCREEN_WIDTH/10)*2)/3, 30);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.selected = NO;
        button.tag = 70+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(setmengbuttonpressed:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
        if (i==0) {
            UIView *anotherLineView = [[UIView alloc]initWithFrame:CGRectMake(10, widgetFrameY(headerView)+widgetboundsHeight(headerView), (SCREEN_WIDTH-30)/2, 2.5)];
            anotherLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            anotherLineView.tag = 40;
            [self.view addSubview:anotherLineView];
            button.selected = YES;
            _currButton = button;
        }
    }
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteview.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(whiteview.frame)-10) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableview setLayoutMargins:UIEdgeInsetsZero];
    }
    _tableview.tableFooterView = [[UIView alloc]init];
}
-(void)datarequest{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:ALLMONEYMESSAGE,COMMON,model.userkey];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if (dic[@"data"] !=[NSNull null]){
            [datadic addEntriesFromDictionary:dic[@"data"]];
            NSLog(@"%@",datadic);
        }
        [hud hide:YES];

        [_tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
- (void)setmengbuttonpressed:(UIButton *)sender{
    UIView *anotherView = (UIView *)[self.view viewWithTag:40];
    if (_currButton == sender) {
        return;
    }
    [_currButton setSelected:NO];
    [sender setSelected:YES];
    _currButton = sender;
    sucess = !sucess;
    [UIView animateWithDuration:0.2 animations:^{
        anotherView.frame = CGRectMake(10+(sender.tag-70)*((SCREEN_WIDTH-30)/2)+(sender.tag-70)*10, widgetFrameY(headerView)+widgetboundsHeight(headerView), (SCREEN_WIDTH-30)/2, 2.5);
    }];
    if (sucess) {
        totalPrice.text = [NSString stringWithFormat:@"总金额: %.2f",[datadic[@"totalAmount"] floatValue]];
        balancePrice.text = [NSString stringWithFormat:@"余额:%.2f",[datadic[@"balance"] floatValue]];
    }
    else{
        totalPrice.text = [NSString stringWithFormat:@"提现成功: %.2f",[datadic[@"successCash"] floatValue]];
        balancePrice.text = [NSString stringWithFormat:@"申请提现:%.2f",[datadic[@"frozenCash"] floatValue]];
    }
    [_tableview reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (sucess) {
         return [datadic[@"cashBackList"] count];
    }
    return [datadic[@"cashDetailList"] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (sucess) {
        return 35;
    }
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (sucess) {
        return 35;
    }
    return 0.5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = [[UIView alloc]init];
    if (!sucess) {
        headerview.hidden = YES;
    }
    headerview.backgroundColor = [UIColor whiteColor];
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 34.5, SCREEN_WIDTH, 0.5)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [headerview addSubview:lineview];
    NSArray *titlearray = @[@"用户名",@"金额",@"时间",];
    for (NSInteger i=0; i<titlearray.count; i++) {
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(5+i*5+i*((SCREEN_WIDTH-20)/3), 0, (SCREEN_WIDTH-20)/3, 34)];
        titlelabel.text = titlearray[i];
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textAlignment =NSTextAlignmentCenter;
        [headerview addSubview:titlelabel];
        if (i!=2) {
            UIView *acrossview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame)+2.2, 0, 0.5, 35)];
            acrossview.backgroundColor = [UIColor lightGrayColor];
            [headerview addSubview:acrossview];
        }
    }
    return headerview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (sucess) {
        static NSString *identity = @"cell";
        CurrentrecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell) {
            cell = [[CurrentrecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        }
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = datadic[@"cashBackList"][indexPath.row];
        return cell;
    }
    else{
        static NSString *identity = @"mycell";
        PresentdetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell) {
            cell = [[PresentdetailsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        }
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dicnationary = datadic[@"cashDetailList"][indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)rightbuttonPressed{
    
    WithdrawalsViewController *withcontroller = [[WithdrawalsViewController alloc]init];
    [self.navigationController pushViewController:withcontroller animated:YES];

}
- (void)leftItemClicked{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBar.translucent = NO;
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////更新contentTableview界面数据
//- (void)updateuserInterface:(NSString *)key
//{
//    NSInteger newDataCount = [dataSource[key] count];//旧数据的数量
//    NSInteger oldDataCount = oldTableDataNum;//新数据的数量
//    NSMutableArray *tempArray = [NSMutableArray array];//临时数组用于处理增删数据的indexPath
//    
//    //如果新数据比旧数据少，应该先移除旧数据，使旧数据数量与新数据数量一致，再更新界面
//    if (newDataCount <= oldDataCount) {
//        
//        //移除旧数据多出新数据的cell
//        for (NSInteger i = newDataCount; i<oldDataCount; i++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [tempArray addObject:indexPath];
//        }
//        [contentTableView beginUpdates];
//        [contentTableView deleteRowsAtIndexPaths:tempArray withRowAnimation:NO];
//        [contentTableView endUpdates];
//        
//        //更新界面
//        [tempArray removeAllObjects];
//        for (NSInteger i = 0; i < newDataCount; i++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [tempArray addObject:indexPath];
//        }
//        [contentTableView beginUpdates];
//        [contentTableView reloadRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
//        [contentTableView endUpdates];
//    }
//    //如果旧数据比新数据少，应该先更新与旧数据数量相同的新数据，余下数据再插入进去
//    else
//    {
//        //先更新与旧数据相同数量的cell
//        NSMutableArray *arrayTemp = [NSMutableArray array];
//        NSMutableArray *arrayAllData = [NSMutableArray arrayWithArray:dataSource[key]];
//        for (NSInteger i = 0; i<oldDataCount; i++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [tempArray addObject:indexPath];
//            [arrayTemp addObject:dataSource[key][i]];
//        }
//        
//        [dataSource setObject:arrayTemp forKey:key];
//        [contentTableView beginUpdates];
//        [contentTableView reloadRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
//        [contentTableView endUpdates];
//        [tempArray removeAllObjects];
//        
//        //再将剩下的数据插入
//        for (NSInteger i = oldDataCount; i < newDataCount; i++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [tempArray addObject:indexPath];
//        }
//        [dataSource setObject:arrayAllData forKey:key];
//        [contentTableView beginUpdates];
//        [contentTableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
//        [contentTableView endUpdates];
//    }
//    
//    //更新界面布局
//    contentTableView.frame = CGRectMake(widgetFrameX(contentTableView), widgetFrameY(contentTableView), widgetBoundsWidth(contentTableView),[dataSource[key] count]*SCREEN_WIDTH/4.5 + SCREEN_WIDTH/8 + SCREEN_WIDTH/10);
//    recommendationView.frame = CGRectMake(widgetFrameX(recommendationView), widgetFrameY(contentTableView) + widgetboundsHeight(contentTableView), widgetBoundsWidth(recommendationView), widgetboundsHeight(recommendationView));
//    tourismStrategyTableview.frame = CGRectMake(widgetFrameX(tourismStrategyTableview), widgetFrameY(recommendationView) + widgetboundsHeight(recommendationView), widgetBoundsWidth(tourismStrategyTableview), widgetboundsHeight(tourismStrategyTableview));
//    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, widgetFrameY(tourismStrategyTableview) + widgetboundsHeight(tourismStrategyTableview) + 50);
//}
//


@end
