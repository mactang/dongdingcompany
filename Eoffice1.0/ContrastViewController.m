//
//  ContrastViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/22.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ContrastViewController.h"
#import "RDVTabBarController.h"
@interface ContrastViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ContrastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"商家对比"];

    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)leftBtn{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
   // cell.textLabel.font = [UIFont systemFontOfSize:12];
   // cell.textLabel.text = @"东鼎泰和科技有限公司";
    
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 120, 20)];
    lb1.text = @"东鼎泰和科技有限公司";
    lb1.font = [UIFont systemFontOfSize:12];
    //lb1.textColor = [UIColor grayColor];
    [cell addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame)+20, 20, 60, 20)];
    lb2.text = @"￥780.00";
    lb2.font = [UIFont systemFontOfSize:12];
    lb2.textColor = [UIColor redColor];
    [cell addSubview:lb2];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame)+10, 20, 40, 20)];
    [btn setTitle:@"买" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    [cell addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+10, 20, 40, 20)];
    [btn1 setTitle:@"车" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:10];
    [cell addSubview:btn1];
    
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
