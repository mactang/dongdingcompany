//
//  WithdrawalsViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "WithdrawalsViewController.h"
#import "RDVTabBarController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "AddBankcardController.h"
#import "BanklistTableViewCell.h"
@interface WithdrawalsViewController()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableview;
    NSMutableArray *datarray;
    
}
@end

@implementation WithdrawalsViewController
-(instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"提现";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self banklistrequest];
    datarray = [NSMutableArray array];
    }
-(void)initerface{
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
     [self cellmessage];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64 )style:UITableViewStyleGrouped];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.sectionFooterHeight = 1;
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.scrollEnabled = NO;
//    //去掉分割线
//    _tableview.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableview];
//   _tableview.tableFooterView = [[UIView alloc]init];
    
}
-(void)banklistrequest{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:BANKCARDLIST,COMMON,model.userkey];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            [datarray addObjectsFromArray:dic[@"data"]];
            NSLog(@"%@",dic);
        }
        [self initerface];
        [hud hide:YES];
       
        [_tableview reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datarray.count+1;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
 
    return 10;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = [[UIView alloc]init];
    headerview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(0, 9.5, SCREEN_WIDTH, 1)];
    linview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [headerview addSubview:linview];
    return headerview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (datarray.count!=0) {
        static NSString *identity = @"cell";
        BanklistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (!cell) {
            cell =  [[BanklistTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        }
        cell.cellNo = indexPath.row;
        cell.datacount = datarray.count;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row!= datarray.count) {
            cell.dic = datarray[indexPath.row];
        }
        return cell;
    }
    if (datarray.count==0) {
        static NSString *identity = @"mycell";
        UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
        UILabel *addbanklabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40)];
        addbanklabel.text = [NSString stringWithFormat:@"➕添加银行卡"];
        addbanklabel.font = [UIFont systemFontOfSize:14];
        addbanklabel.textColor = [UIColor lightGrayColor];
        addbanklabel.userInteractionEnabled = NO;
        addbanklabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:addbanklabel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    else{
        return nil;
    }
     
}
-(void)cellmessage{
    NSArray *array = @[@"到账时间",@"金额",@"验证码",];
    NSArray *anotherarray = @[@"预计3-5个工作日内",@"转出金额",@"请输入验证码",];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 134, SCREEN_WIDTH, 115)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    for (NSInteger i=0; i<array.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, i*35+i*5, 60, 30)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.text = array[i];
        [view addSubview:label];
        UIView *lineview = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+5, SCREEN_WIDTH, 0.5)];
        lineview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
        [view addSubview:lineview];
        if (i==0) {
            UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/2, widgetFrameY(label), SCREEN_WIDTH/2-10, widgetboundsHeight(label))];
            timelabel.text = anotherarray[i];
            timelabel.textColor = [UIColor lightGrayColor];
            timelabel.font = [UIFont systemFontOfSize:13];
            timelabel.textAlignment = NSTextAlignmentRight;
            [view addSubview:timelabel];
        }
        else{
            UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame)+20, widgetFrameY(label), SCREEN_WIDTH/2-20, widgetboundsHeight(label))];
            textfield.font = [UIFont systemFontOfSize:13];
            textfield.placeholder = anotherarray[i];
            [view addSubview:textfield];
            if (i==2) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(SCREEN_WIDTH-80, widgetFrameY(textfield), 70, widgetboundsHeight(textfield));
                button.titleLabel.font = [UIFont systemFontOfSize:12];
                [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                button.layer.cornerRadius = 3;
                button.layer.borderColor = [[UIColor lightGrayColor]CGColor];
                button.layer.borderWidth = 1;
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [view addSubview:button];
                
                UIButton *confirmbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                confirmbutton.frame = CGRectMake(10, CGRectGetMaxY(view.frame)+20, SCREEN_WIDTH-20, SCREEN_WIDTH/9);
                confirmbutton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
                confirmbutton.layer.cornerRadius = 4;
                [confirmbutton setTitle:@"确认" forState:UIControlStateNormal];
                confirmbutton.titleLabel.font = [UIFont systemFontOfSize:15];
                [self.view addSubview:confirmbutton];
                
                UILabel *prolabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(confirmbutton.frame)+10, SCREEN_WIDTH-20, 20)];
                prolabel.textColor = [UIColor blackColor];
                prolabel.font = [UIFont systemFontOfSize:13];
                prolabel.text = [NSString stringWithFormat:@"可提现余额%@",@"128.90"];
                prolabel.textAlignment = NSTextAlignmentCenter;
                [self.view addSubview:prolabel];

            }
        }
    }

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        AddBankcardController *addbank = [[AddBankcardController alloc]init];
        [self.navigationController pushViewController:addbank animated:YES];
    }
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
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = YES;
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
