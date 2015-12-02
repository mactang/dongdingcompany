//
//  LoginViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/27.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "LoginMobileViewController.h"
#import "TarBarButton.h"
#import "CountDownButton.h"
#import "ServiceTimeViewController.h"
@interface LoginViewMobileController ()<UITableViewDataSource,UITableViewDelegate>{
    CountDownButton *_countDownCode;
    UITableView *_tableView;
    NSArray *imageviewArray;
    NSArray *titleArray;
}

@end

@implementation LoginViewMobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageviewArray = @[@"图层-11",@"图层-12",@"图层-10",];
    titleArray = @[@"请输入手机号",@"请输入验证码",@"请输入密码",@"确定",@"点击”确定“,标示你同意《e办公用户协议》"];
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
    label.text = @"绑定手机登录";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }


    
    _countDownCode = [CountDownButton buttonWithType:UIButtonTypeCustom];
    _countDownCode.frame = CGRectMake(SCREEN_WIDTH-120,17, 70, 30);
    [_countDownCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_countDownCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor whiteColor];
    _countDownCode.clipsToBounds = YES;
    _countDownCode.layer.cornerRadius = 3;
    _countDownCode.layer.borderColor = [[UIColor grayColor]CGColor];
    _countDownCode.layer.borderWidth = 1;
    _countDownCode.titleLabel.font = [UIFont systemFontOfSize:10];
//    [phoneNumber_view addSubview:_countDownCode];
    
    [_countDownCode addToucheHandler:^(CountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
//        [self valiData];
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(CountDownButton *countDownButton,int second) {
            
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
            
        }];
        [sender didFinished:^NSString *(CountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
            
        }];
        
    }];

   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        return 45;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identity = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row<3) {
        cell.textLabel.text = [NSString stringWithFormat:@"        %@",titleArray[indexPath.row]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
        imageView.image = [UIImage imageNamed:imageviewArray[indexPath.row]];
        [cell addSubview:imageView];
    }
    else{
        if (indexPath.row==3) {
            UIButton *confirmbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            confirmbutton.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 35);
            [confirmbutton setTitle:titleArray[indexPath.row] forState:UIControlStateNormal];
            confirmbutton.titleLabel.font = [UIFont systemFontOfSize:15];
            confirmbutton.layer.cornerRadius = 5;
            confirmbutton.backgroundColor = [UIColor colorWithRed:191/255.0f green:35/255.0f blue:29/255.0f alpha:1];
            [confirmbutton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:confirmbutton];
        }
        else{
            
            NSMutableAttributedString *readyString = [[NSMutableAttributedString alloc]initWithString:titleArray[indexPath.row]];
            [readyString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(12,9 )];
            [readyString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,12 )];
            UILabel *ServiceItems = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 30)];
            ServiceItems.attributedText = readyString;
            ServiceItems.font = [UIFont systemFontOfSize:14];
            [cell addSubview:ServiceItems];
            
        }
        cell.contentView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(void)buttonPressed:(UIButton *)sender{
    ServiceTimeViewController *serviceTime = [[ServiceTimeViewController alloc]init];
    [self.navigationController pushViewController:serviceTime animated:YES];
}
-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

@end
