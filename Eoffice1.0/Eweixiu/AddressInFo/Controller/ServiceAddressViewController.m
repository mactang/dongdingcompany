//
//  ServiceAddressViewController.m
//  Eoffice1.0
//
//  Created by Janice on 15/12/2.
//  Copyright © 2015年 gl. All rights reserved.
//

#import "ServiceAddressViewController.h"
#import "TarBarButton.h"
#import "ServiceAddressTableViewCell.h"
#import "CommonAddressFootView.h"
#import "CreateCommonAddressViewController.h"


@interface ServiceAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CommonAddressFootView *footView;

@end

@implementation ServiceAddressViewController

- (CommonAddressFootView *)footView{
    
    if (!_footView) {
        _footView = LOAD_NIB(@"CommonAddressFootView");
    }
    return _footView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView =self.footView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    //标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = @"选择服务地址";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = label;
    
    //返回按钮
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"zuo"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    __block typeof(self) wself=self;
    [self.footView setAddAddressBlock:^(){
        CreateCommonAddressViewController *createCommonAddress = [[CreateCommonAddressViewController alloc]initWithNibName:@"CreateCommonAddressViewController" bundle:nil];
        [wself.navigationController pushViewController:createCommonAddress animated:YES];
    }];

}

-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ServiceAddressTableViewCell";
    ServiceAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = LOAD_NIB(@"ServiceAddressTableViewCell");
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}


@end
