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
#import "CalculateStringSpace.h"
#import "UIAlertView+AlerViewBlocks.h"
@interface OrderController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,messagedelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableArray *orderlist;
@property(nonatomic,strong)NSString *totalprice;
@property(nonatomic,strong)NSMutableDictionary *ordermessagedictionary;
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
    NSInteger signsection;
    BOOL sucess;
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
-(void)setShopCartId:(NSString *)shopCartId{
    if (!_shopCartId) {
        _shopCartId = [NSString string];
        _shopCartId = shopCartId;
    }
    else{
        _shopCartId = shopCartId;
    }
}
-(void)setGoodsId:(NSString *)goodsId{
    if (!_goodsId) {
        _goodsId = [NSString string];
        _goodsId = goodsId;
    }
    else{
        _goodsId = goodsId;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    sucess = YES;
    self.ordermessagedictionary = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    TarBarButton *ligthButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
 
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    self.navigationItem.title = @"确认订单";
    [self footviewinterface];
    [self orderlistrequest];
}
-(void)initerfacedata{
    self.view.backgroundColor = [UIColor whiteColor];
//  self.edgesForExtendedLayout = UIRectEdgeNone;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *value = [ud objectForKey:@"payWay"];
    NSString *value1 = [ud objectForKey:@"invoice"];
    NSString *value2 = [ud objectForKey:@"dispatch"];
    if (value != nil) {
        payWay = value;
        [self.ordermessagedictionary setValue:payWay forKey:@"payway"];
    }else{
    
        payWay = @"";
    }
    if (value1 != nil) {
        invoice = value1;
    }else{
        
        invoice = @"";
    }
    if (value2 != nil) {
        dispatch = value2;
    }else{
        
        dispatch = @"";
    }
    _currentNumber = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-70-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedRegular:) name:@"selectedAddress" object:nil];
    
}
-(void)footviewinterface{
    UIView   *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-70, SCREEN_WIDTH, 70)];
    headerview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerview];
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineview.backgroundColor = [UIColor lightGrayColor];
    [headerview addSubview:lineview];
    

    totalPice = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-120, 25)];
    totalPice.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    totalPice.font = [UIFont systemFontOfSize:14];
    totalPice.textAlignment = NSTextAlignmentRight;
    [headerview addSubview:totalPice];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 70, 50)];
    [btn3 setTitle:@"确定" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];

    btn3.clipsToBounds = YES;
    btn3.layer.cornerRadius = 5;
    btn3.tag = 1000;
    [btn3 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:20];
    [headerview addSubview:btn3];
    
//  [self.tableView beginUpdates];
//  [self.tableView setTableHeaderView:headerview];
//  [self.tableView endUpdates];

}
- (void)leftItemClicked{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [self.ordermessagedictionary setObject:payWay forKey:@"payway"];
    [ud setObject:payWay forKey:@"payWay"];
    [ud setObject:invoice forKey:@"invoice"];
    [ud setObject:dispatch forKey:@"dispatch"];
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return self.orderlist.count +1;;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
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
        if (self.datas.count==0) {
            return 50;
        }else{
            AddressModel *model = self.datas[signsection];
            CGSize size = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"地址:%@",model.address] font:[UIFont systemFontOfSize:14] constraintSize:CGSizeMake(SCREEN_WIDTH-35, 40)];
        return size.height+50;
        }

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
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
            [control addSubview:view];
            if (self.datas.count != 0) {
                AddressModel *model = self.datas[signsection];
              
                SingleModel *sing = [SingleModel sharedSingleModel];
                sing.addressId = model.addressId;
                
                UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2-30, 20)];
                lb1.font = [UIFont systemFontOfSize:14];
                lb1.text = [NSString stringWithFormat:@"收货人:%@",model.receiver];
                [self.ordermessagedictionary setObject:lb1.text forKey:@"receiver"];
                [view addSubview:lb1];
                
                UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame), 10, SCREEN_WIDTH/2-25, 20)];
                lb2.font = [UIFont systemFontOfSize:14];
                if ([model.telphone isKindOfClass:[NSNull class]]) {
                    lb2.text=@"暂无";
                }else{
                    lb2.text = [NSString stringWithFormat:@"手机号:%@",model.telphone];
                    [self.ordermessagedictionary setObject:lb2.text forKey:@"phone"];
                }
                [view addSubview:lb2];
                
                CGSize size = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"地址:%@",model.address]font:[UIFont systemFontOfSize:14] constraintSize:CGSizeMake(SCREEN_WIDTH-35, 40)];
                
                addressLb = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(lb1), CGRectGetMaxY(lb1.frame)+10, size.width, size.height)];
                addressLb.font = [UIFont systemFontOfSize:14];
                addressLb.numberOfLines = 2;
                addressLb.text = [NSString stringWithFormat:@"地址:%@",model.address];
                [self.ordermessagedictionary setObject:addressLb.text forKey:@"address"];
                view.frame = CGRectMake(0, 0, SCREEN_WIDTH, size.height+50);
                [view addSubview:addressLb];
                
            }else{
            
                view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        
                UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(12, 15, 100, 20)];
                lb1.text = @"请添加收获地址";
                lb1.font = [UIFont systemFontOfSize:13];
                [view addSubview:lb1];
            }
            UIButton *headerbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            headerbutton.frame  = view.bounds;
            headerbutton.backgroundColor = [UIColor clearColor];
            [headerbutton addTarget:self action:@selector(headerbuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [control addSubview:headerbutton];
        
            UIImageView *_weiboContentTextView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, (widgetboundsHeight(view)-15)/2, 15, 15)];
            [_weiboContentTextView setImage:[UIImage imageNamed:@"youzhixiang"]];
            _weiboContentTextView.transform=CGAffineTransformMakeRotation(M_PI);
            [view addSubview:_weiboContentTextView];

        }
       
    }
    return control;

}
-(void)headerbuttonPressed:(UIButton *)button{
    OrderAddressViewController *addre = [[OrderAddressViewController alloc]init];
    addre.delegate=self;
    [self.navigationController pushViewController:addre animated:YES];
}
-(void)newaddressrelaod{
    [self defaultAddress];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
            static NSString *identity = @"cell";
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
            cell.clipsToBounds = YES;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        
            NSLog(@"%lu",(unsigned long)self.datas.count);
        
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             NSArray *message = @[@"配送方式",@"支付方式",@"发票方式",];
             NSArray *thewhyarray = @[dispatch,payWay,invoice];
        if (indexPath.row==0||indexPath.row==1||indexPath.row==2) {
            
            
            cell.textLabel.text = message[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = thewhyarray[indexPath.row];
        }
        if (indexPath.row==4){
            _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, 320, 40)];
            _textField.placeholder = @"给卖家留言";
            _textField.tag = 1;
            _textField.delegate = self;
            _textField.backgroundColor = [UIColor whiteColor];
            [cell addSubview:_textField];
        }
        if (indexPath.row==3){
           cell.textLabel.text = @"邀请码";
            _textField = [[UITextField alloc]initWithFrame:CGRectMake(230, 0, 100, 40)];
            _textField.placeholder = @"请输入邀请码";
            _textField.tag = 1;
            _textField.delegate = self;
            _textField.font = [UIFont systemFontOfSize:13];
            _textField.backgroundColor = [UIColor whiteColor];
            [cell addSubview:_textField];
        }
        return cell;
        
    }
    else{
        
        OrderTableViewCell *cell = [OrderTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = self.orderlist[indexPath.section-1];
        return cell;
        
    }
}
#pragma mark 订单列表网络请求
-(void)orderlistrequest{
    
    NSLog(@"%@",self.shopCartId);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:SUBMITORDER,COMMON,model.userkey,[NSString stringWithFormat:@"%@",self.shopCartId]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.orderlist removeAllObjects];
        if (dic[@"data"] !=[NSNull null]) {
            self.totalprice = [NSString stringWithFormat:@"%@",dic[@"data"][@"total"]];
            totalPice.text = [NSString stringWithFormat:@"合计:￥%@",self.totalprice];
            [self.ordermessagedictionary setObject:totalPice.text forKey:@"totalprice"];
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
    NSString *path= [NSString stringWithFormat:ADDRESS,COMMON,model.userkey];

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
            for (NSInteger i=0; i<self.datas.count; i++) {
                AddressModel *model = self.datas[i];
                if (![model.defaultsign isKindOfClass:[NSNull class]]) {
                    if ([model.defaultsign isEqualToString:@"Y"]) {
                        signsection = i;
                    }
                }
                
            }

        }
        [hud hide:YES];
        if (sucess) {
            [self initerfacedata];
        }
        sucess = NO;
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}
- (void)selectedRegular:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    signsection = [reglarText integerValue];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)selectedPayWay:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    NSLog(@"%@",reglarText);
    payWay = reglarText;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)selectedDispatch:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    NSLog(@"%@",reglarText);
    dispatch = reglarText;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)selectedinvoice:(NSNotification *)notify{
    
    NSString *reglarText = notify.object;
    NSLog(@"%@",reglarText);
    invoice = reglarText;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
            alter.frame = self.view.bounds;
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
    
//    phone/order!wbasketCommit.action?userkey=?&cartIds=?&payway=?&id=?&invoice=?&total=?
//    
//    payway是支付方式，0，1
//    invoice是是否开发票，Y,N
//    id是地址ID
    UIAlertView *alterview;
    NSString *string;
    if (btn.tag==1000) {
        if (self.datas.count==0) {
            string = @"请添加收货地址";
        }
        else if ([dispatch isEqualToString:@""]) {
            
            string = @"请选择配送方式";
        }
       else if ([payWay isEqualToString:@""]) {
            string = @"请选择支付方式";
        }
              else if ([invoice isEqualToString:@""]) {
            string =@"请选择是否开发票";
        }
       else{
          [self sureOrder];
           return;
       }
        alterview = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alterview show];
    }

}
- (void)sureOrder{
    
    SingleModel *sing = [SingleModel sharedSingleModel];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    
    if ([payWay isEqualToString:@"货到付款"]) {
        paywayCount = @"0";
        
    }else{
    
        paywayCount = @"1";
    }
    NSString *count = [NSString stringWithFormat:@"%d",_currentNumber];
    NSString *path= [NSString stringWithFormat:SUREORDER,COMMON,model.userkey,model.goodsId,count,paywayCount,sing.addressId];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        [hud hide:YES];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
        if ([dic[@"status"] integerValue]==1) {
            if ([payWay isEqualToString:@"在线支付"]) {
                PayViewController *pay = [[PayViewController alloc]init];
                [self.navigationController pushViewController:pay animated:YES];
                pay.totalPrice = self.totalprice;
            }
            else{
                OrderSuccessController *orderSucc = [[OrderSuccessController alloc]init];
                orderSucc.dicmessage = self.ordermessagedictionary;
                [self.navigationController pushViewController:orderSucc animated:YES];
            }

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
        [UIAlertView errorcode:error.code blocks:^(NSInteger index) {
            [self sureOrder];
        }];
     }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedPayWay:) name:@"payway" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDispatch:) name:@"dispatch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedinvoice:) name:@"invoice" object:nil];
    
     self.navigationController.navigationBarHidden = NO;
    // self.parentViewController.tabBarController.tabBar.hidden = YES;
    // [(BottonTabBarController*)self.tabBarController hideTabBar:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedRegular:) name:@"selectedAddress" object:nil];
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
 
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
@end
