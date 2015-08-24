//
//  LogisticsDetailsController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/23.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "LogisticsDetailsController.h"
#import "RDVTabBarController.h"
@interface LogisticsDetailsController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation LogisticsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *logoutItem = [[UIBarButtonItem alloc] initWithTitle:@"＜" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBtn)];
//    [self.navigationItem setLeftBarButtonItem:logoutItem];
    self.navigationItem.title = @"物流详情";
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 520) style:UITableViewStyleGrouped];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.view addSubview:_tableView];

    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else
        
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0 && indexPath.row == 0) {
        
            return 40;
    }
    if (indexPath.section==0 && indexPath.row == 1) {
        
        return 60;
    }
    if (indexPath.section==1 && indexPath.row == 0) {
        
        return 40;
    }
    if (indexPath.section==1 && indexPath.row == 4) {
        
        return 180;
    }
    else{
    
        return 60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
            lb2.font = [UIFont systemFontOfSize:18];
            lb2.text = @"商品详情";
            lb2.textColor = [UIColor blackColor];
            [cell addSubview:lb2];
        }
        if (indexPath.row == 1) {
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dingdanxiaotu"]];
            imageView.frame = CGRectMake(10, 5, 40, 40);
            [cell addSubview:imageView];
            UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, imageView.frame.origin.y, 150, 30)];
            lb1.font = [UIFont systemFontOfSize:10];
            lb1.lineBreakMode = NSLineBreakByTruncatingTail;
            lb1.numberOfLines = 2;
            lb1.text = @"联想（Lenovo）G50-70M 15.6英寸笔记本电脑（i5-4258U 4G 500G GT820M 2G独显 DVD刻录 Win8）金属黑";
            [cell addSubview:lb1];
            
            UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(lb1.frame.origin.x, CGRectGetMaxY(lb1.frame), 30, 20)];
            lb2.font = [UIFont systemFontOfSize:10];
            lb2.text = @"颜色 :";
            lb2.textColor = [UIColor grayColor];
            [cell addSubview:lb2];
            
            UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), lb2.frame.origin.y, 30, 20)];
            lb3.font = [UIFont systemFontOfSize:10];
            lb3.text = @"土豪金";
            lb3.textColor = [UIColor grayColor];
            [cell addSubview:lb3];
            
            UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame)+5, lb3.frame.origin.y, 30, 20)];
            lb4.font = [UIFont systemFontOfSize:10];
            lb4.text = @"尺寸 :";
            lb4.textColor = [UIColor grayColor];
            [cell addSubview:lb4];
            
            UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb4.frame), lb4.frame.origin.y, 30, 20)];
            lb5.font = [UIFont systemFontOfSize:10];
            lb5.text = @"128G";
            lb5.textColor = [UIColor grayColor];
            [cell addSubview:lb5];
            
            UILabel *lb6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame)+40, lb1.frame.origin.y, 60, 20)];
            lb6.font = [UIFont systemFontOfSize:10];
            lb6.text = @"￥68000.00";
            [cell addSubview:lb6];
            
            UILabel *lb7 = [[UILabel alloc]initWithFrame:CGRectMake(lb6.frame.origin.x+40, CGRectGetMaxY(lb6.frame)+10, 60, 20)];
            lb7.font = [UIFont systemFontOfSize:10];
            lb7.text = @"×1";
            [cell addSubview:lb7];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
            lb2.font = [UIFont systemFontOfSize:18];
            lb2.text = @"物流详情";
            lb2.textColor = [UIColor blackColor];
            [cell addSubview:lb2];
        }
    }
    return cell;
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
