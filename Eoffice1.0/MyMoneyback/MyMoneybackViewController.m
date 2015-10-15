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
@interface MyMoneybackViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIButton *_currButton;
    UIView *headerView;
    UILabel *totalPrice;
    UILabel *balancePrice;
    UITableView *_tableview;
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
//    [rightButton addTarget:self action:@selector(rightItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"提现" forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    rightButton.layer.cornerRadius = 2;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH/6.7)];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    
    UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame)+2.5, SCREEN_WIDTH, widgetboundsHeight(headerView)-10)];
    whiteview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteview];
    
    totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, (SCREEN_WIDTH-20)/2, widgetboundsHeight(whiteview)-10)];
    totalPrice.font = [UIFont systemFontOfSize:14];
    totalPrice.text = [NSString stringWithFormat:@"总金额: %@",@"122.89"];
    [whiteview addSubview:totalPrice];
    
    balancePrice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalPrice.frame), 5, (SCREEN_WIDTH-20)/2, widgetboundsHeight(whiteview)-10)];
    balancePrice.font = [UIFont systemFontOfSize:14];
    balancePrice.text = [NSString stringWithFormat:@"余额:%@",@"32.59"];
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
}
- (void)setmengbuttonpressed:(UIButton *)sender{
    UIView *anotherView = (UIView *)[self.view viewWithTag:40];
    if (_currButton == sender) {
        return;
    }
    [_currButton setSelected:NO];
    [sender setSelected:YES];
    _currButton = sender;
    [UIView animateWithDuration:0.2 animations:^{
        anotherView.frame = CGRectMake(10+(sender.tag-70)*((SCREEN_WIDTH-30)/2)+(sender.tag-70)*10, widgetFrameY(headerView)+widgetboundsHeight(headerView), (SCREEN_WIDTH-30)/2, 2.5);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    cell.textLabel.text  = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
