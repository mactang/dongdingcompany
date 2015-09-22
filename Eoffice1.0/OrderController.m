//
//  OrderController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/16.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderController.h"
#import "UIViewController+LewPopupViewController.h"
#import "LewPopupViewAnimationFade.h"
#import "LewPopupViewAnimationSlide.h"
#import "LewPopupViewAnimationSpring.h"
#import "LewPopupViewAnimationDrop.h"

#import "RDVTabBarController.h"
#import "PayViewController.h"
#import "GYZAlterview.h"
#import "InvoiceAlterView.h"
#import "DispatchingView.h"
#import "SingleModel.h"
#import "OrderAddressViewController.h"
#import "AFNetworking.h"
#import "AddressModel.h"
#import "TarBarButton.h"
#import "LoginViewController.h"
#import "OrderSuccessController.h"
#import "OrderTableViewCell.h"
@interface OrderController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableArray *orderlist;
@property(nonatomic,strong)NSString *totalprice;
@end

@implementation OrderController
{
    int _currentNumber;
    UILabel *priceLb;
    UILabel *totalPice;
    UILabel *addressLb ;
    LoginViewController *login;
    NSString *payWay;
    NSString *invoice;
    NSString *dispatch;
    NSString *paywayCount ;
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)orderlist{
    if (_orderlist==nil) {
        _orderlist = [NSMutableArray array];
    }
    return _orderlist;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self orderlistrequest];
}
-(void)initerfacedata{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //payWay = @"";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *value = [ud objectForKey:@"payWay"];
    NSString *value1 = [ud objectForKey:@"invoice"];
    NSString *value2 = [ud objectForKey:@"dispatch"];
    
    payWay = value;
    
    invoice = value1;
    
    dispatch = value2;
    
    TarBarButton *ligthButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    //    [ligthButton setTitle:@"确认订单" forState:UIControlStateNormal];
    //    [ligthButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    ligthButton.titleLabel.font = [UIFont systemFontOfSize:14];
    // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    self.navigationItem.title = @"确认订单";
    
    _currentNumber = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-70-64) style:UITableViewStyleGrouped];
//   self.automaticallyAdjustsScrollViewInsets = NO;
//   self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
-(void)footviewinterface{
    UIView   *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70)];
    headerview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerview];
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [headerview addSubview:lineview];
    

    totalPice = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-120, 25)];
    totalPice.text = [NSString stringWithFormat:@"合计:￥%@",self.totalprice];
    totalPice.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    totalPice.font = [UIFont systemFontOfSize:14];
    totalPice.textAlignment = NSTextAlignmentRight;
    [headerview addSubview:totalPice];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 70, 50)];
    [btn3 setTitle:@"确定" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    btn3.backgroundColor = [UIColor redColor];

    btn3.clipsToBounds = YES;
    btn3.layer.cornerRadius = 5;
    btn3.tag = 1000;
    [btn3 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:20];
    [headerview addSubview:btn3];
//
//    [self.tableView beginUpdates];
//    [self.tableView setTableHeaderView:headerview];
//    [self.tableView endUpdates];

}
- (void)leftItemClicked{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:payWay forKey:@"payWay"];
    [ud setObject:invoice forKey:@"invoice"];
    [ud setObject:dispatch forKey:@"dispatch"];
//    NSArray *array = self.navigationController.viewControllers;
//    //取出里面的对应元素（对象）,并返回
//    //popToViewController:是返回到这个对象
//    [self.navigationController popToViewController:array[4] animated:YES];
   // self.navigationController.navigationBarHidden = YES;
    NSArray *array = self.navigationController.viewControllers;
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popToViewController:array[4] animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.orderlist.count +1;;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    if (section==1) {
        return 1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        return 40;
    }
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return 100;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.5;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    if (section!=0) {
        return nil;
    }
    NSString *headerIndetifier = @"MyHeader";
    UITableViewHeaderFooterView * control = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIndetifier];
    if (!control) {
        control = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIndetifier];
        if (section==0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
            view.backgroundColor = [UIColor whiteColor];
            [control addSubview:view];
            NSLog(@"%@",self.datas[section]);
            AddressModel *model = self.datas[section];
            SingleModel *sing = [SingleModel sharedSingleModel];
            sing.addressId = model.addressId;
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
            [btn setTitle:@"收货人 :" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:10];
            [view addSubview:btn];
            
            UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 20, 100, 20)];
            lb1.text = model.receiver;
            [view addSubview:lb1];
            
            UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame), 20, 130, 20)];
            lb2.text = model.telphone;
            [view addSubview:lb2];
            
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(btn.frame)+5, 40, 20)];
            [btn1 setTitle:@"地址 :" forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.titleLabel.font = [UIFont systemFontOfSize:10];
            [view addSubview:btn1];
            
            addressLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), CGRectGetMaxY(btn.frame)+2, 250, 40)];
            addressLb.font = [UIFont systemFontOfSize:12];
            //lb3.backgroundColor = [UIColor redColor];
            addressLb.lineBreakMode = NSLineBreakByWordWrapping;
            addressLb.numberOfLines = 0;
            addressLb.text = model.address;
            [view addSubview:addressLb];
            
            UIButton *headerbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            headerbutton.frame  = view.bounds;
            headerbutton.backgroundColor = [UIColor clearColor];
            [headerbutton addTarget:self action:@selector(headerbuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [control addSubview:headerbutton];
            
        }
       
    }
    return control;

}
-(void)headerbuttonPressed:(UIButton *)button{
    OrderAddressViewController *addre = [[OrderAddressViewController alloc]init];
    addre.regularText = addressLb.text;
    [self.navigationController pushViewController:addre animated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
            static NSString *identity = @"cell";
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
            cell.clipsToBounds = YES;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedRegular:) name:@"selectedAddress" object:nil];
            NSLog(@"%lu",(unsigned long)self.datas.count);
        
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           NSArray *message = @[@"配送方式",@"支付方式",@"发票方式",];
           NSArray *thewhyarray = @[dispatch,payWay,invoice];
        if (indexPath.row!=3) {
             [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDispatch:) name:@"dispatch" object:nil];
            cell.textLabel.text = message[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = thewhyarray[indexPath.row];
            
        }
        else{
            _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 320, 40)];
            _textField.placeholder = @"给卖家留言";
            _textField.tag = 1;
            _textField.delegate = self;
            _textField.backgroundColor = [UIColor whiteColor];
            [cell addSubview:_textField];
            //7数字键盘回收
            //创建一个view作为inputAcceStoryView
            UIView *view = [[UIView alloc]init];
            view.frame = CGRectMake(0, 0, 0, 40);
            view.backgroundColor = [UIColor grayColor];
            _textField.inputAccessoryView = view;
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
            backButton.frame = CGRectMake(10, 0, 100, 40);
            [backButton setTitle:@"收回键盘" forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(keyboardReturn:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:backButton];
        }
        return cell;
        
    }
    else{
        
        OrderTableViewCell *cell = [OrderTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = self.orderlist[indexPath.row];
        return cell;
        
    }
}
#pragma mark 订单列表网络请求
-(void)orderlistrequest{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:SUBMITORDER,COMMON,model.userkey,[NSString stringWithFormat:@"%@",self.shopCartId]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]) {
            self.totalprice = [NSString stringWithFormat:@"%@",dic[@"data"][@"total"]];
         
            [self.orderlist addObjectsFromArray:dic[@"data"][@"list"]];
        }
        [hud hide:YES];
        [self defaultAddress];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];

}
#pragma mark 地址网络请求
- (void)defaultAddress{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:ADDRESS,COMMON,model.jsessionid,model.userkey];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        
        [self.datas removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]) {
            NSArray *array = dic[@"data"];
            for(NSDictionary *subDict in array)
            {
                AddressModel *model = [AddressModel modelWithDic:subDict];
                [self.datas addObject:model];

            }

        }
        [hud hide:YES];
        [self initerfacedata];
        [self footviewinterface];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}
- (void)selectedRegular:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
//    UITableViewCell *cell = (UITableViewCell*)[self.view viewWithTag:1000];
//    cell.detailTextLabel.text = reglarText;
    addressLb.text = reglarText;
    
    
}
- (void)selectedPayWay:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    NSLog(@"%@",reglarText);
    payWay = reglarText;
    
    
    [_tableView reloadData];
    

    
}
- (void)selectedDispatch:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    NSLog(@"%@",reglarText);
    dispatch = reglarText;
    
    
    [_tableView reloadData];
    
    
    
}

- (void)selectedinvoice:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    NSLog(@"%@",reglarText);
    invoice = reglarText;
    
    
    [_tableView reloadData];
    
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            
            DispatchingView *alter=[[DispatchingView alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            alter.rightBlock=^()
            {
                NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                NSLog(@"左边按钮被点击");
            };
            alter.dismissBlock=^()
            {
                NSLog(@"窗口即将消失");
            };
            [alter show];
        }
        if (indexPath.row==1) {
    
        GYZAlterview *alter=[[GYZAlterview alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        alter.rightBlock=^()
        {
            NSLog(@"右边按钮被点击");
        };
        alter.leftBlock=^()
        {
            NSLog(@"左边按钮被点击");
        };
        alter.dismissBlock=^()
        {
            NSLog(@"窗口即将消失");
        };
        [alter show];
        }
        if (indexPath.row == 2) {
            InvoiceAlterView *alter=[[InvoiceAlterView  alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
            alter.rightBlock=^()
            {
                NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                NSLog(@"左边按钮被点击");
            };
            alter.dismissBlock=^()
            {
                NSLog(@"窗口即将消失");
            };
            [alter show];
        }
    }

}
-(void)btnPress:(UIButton *)btn{
    if (btn.tag == 1000) {
        [self sureOrder];
//        PayViewController *pay = [[PayViewController alloc]init];
//        [self.navigationController pushViewController:pay animated:YES];
        
        OrderSuccessController *orderSucc = [[OrderSuccessController alloc]init];
        [self.navigationController pushViewController:orderSucc animated:YES];
        
    }
}
- (void)sureOrder{
    
    SingleModel *sing = [SingleModel sharedSingleModel];
    NSLog(@"%@",sing.addressId);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    
    if ([payWay isEqualToString:@"货到付款"]) {
        paywayCount = @"0";
    }
    
    NSString *count = [NSString stringWithFormat:@"%d",_currentNumber];
    NSString *path= [NSString stringWithFormat:SUREORDER,COMMON,model.userkey,model.goodsId,count,paywayCount,sing.addressId];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        [hud hide:YES];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic[@"info"]);
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}
//-(void)numBtnPress:(UIButton *)btn{
//    
//    
//    if (btn.tag ==1) {
//        if (_currentNumber>1) {
//            _currentNumber--;
//            NSLog(@"%@",_price);
//            NSLog(@"priceLb-%d",[(priceLb.text)intValue]);
//            
//            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
//            [_numberLb1 setText:string];
//            
//            int price = ([(totalPice.text)intValue])-([(_price)intValue]);
//            
//            totalPice.text = [NSString stringWithFormat:@"%d",price];
//            
//        }
//    }
//    if (btn.tag == 2) {
//        _currentNumber++;
//        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
//        [_numberLb1 setText:string];
//        
//        int price = [(priceLb.text)intValue]*_currentNumber;
//        
//        totalPice.text = [NSString stringWithFormat:@"%d",price];
//    }
//    
//}
-(void)keyboardReturn:(UIButton *)button{
   
    [_textField resignFirstResponder];
    [self.view resignFirstResponder];
}

//键盘上移
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //输入框编辑完成以后，当键盘即将消失时，将视图恢复到原始状态
    self.view.frame = CGRectMake(0, 60, self.view.frame.size.width , self.view.frame.size.height);
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
          NSTimeInterval animationDuration=0.30f;
          [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
          [UIView setAnimationDuration:animationDuration];
          float width = self.view.frame.size.width;
          float height = self.view.frame.size.height;
          //上移n个单位，按实际情况设置
          CGRect rect=CGRectMake(0.0f,-130,width,height);
          self.view.frame=rect;
      [UIView commitAnimations];
          return YES;
      }
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = NO;
    //  self.parentViewController.tabBarController.tabBar.hidden = YES;
    //   [(BottonTabBarController*)self.tabBarController hideTabBar:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedRegular:) name:@"selectedAddress" object:nil];
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSLog(@"%@",model.userkey);
    NSLog(@"%@",[model.userkey class]);
    if (model.userkey == nil) {
        if (!login) {
            login = [[LoginViewController alloc]init];
            [self.view addSubview:login.view];
        }
        
    }else{
        if (login) {
            [login.view removeFromSuperview];
            
        }
        
    }
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
    
}

#pragma mark UITextFieldDelegate方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
