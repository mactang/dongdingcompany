//
//  PayViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/17.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PayViewController.h"
#import "RDVTabBarController.h"

@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PayViewController
{
     UIButton *payBtn;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.title = @"订单支付";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"＜" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtn)];
    [self.navigationItem setLeftBarButtonItem:logoutItem];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -1, 320, 250) style:UITableViewStyleGrouped];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 260, 300, 40)];
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 10;
    
    [self.view addSubview:sureBtn];
    
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
            return 60;
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"订单金额";
    }if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"微信支付";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 20, 20);
            [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = payBtn;

        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"支付宝";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 20, 20);
            [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = payBtn;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"银行卡";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 20, 20);
            [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = payBtn;
        }
    }
    return cell;
}
- (void)isPublicBtnPress:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    
}
- (void)leftBtn{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
