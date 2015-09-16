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
@interface OrderController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic, strong)UIButton *numberBtn1;
@property(nonatomic,strong)UILabel *numberLb1;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSMutableArray *datas;
@end

@implementation OrderController
{
    int _currentNumber;
    UILabel *priceLb;
    UILabel *totalPice;
    UILabel *addressLb ;
    LoginViewController *login;
    NSString *payWay;
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    payWay = @"";
    
    TarBarButton *ligthButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
//    [ligthButton setTitle:@"确认订单" forState:UIControlStateNormal];
//    [ligthButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    ligthButton.font = [UIFont systemFontOfSize:14];
   // ligthButton.backgroundColor = [UIColor redColor];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    self.navigationItem.title = @"确认订单";
    
    _currentNumber = 1;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -1, 320, 540) style:UITableViewStyleGrouped];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    [self defaultAddress];
    //键盘空白收回
//    self.view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fingerTapped:)];
//    [self.view addGestureRecognizer:singleTap];
    

}
//-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
//
//{
//    
//    [self.view endEditing:YES];
//    
//    
//}
- (void)leftItemClicked{
    
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
    return self.datas.count*3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 7;
    }else{
    return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        return 100;
    }
    else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {
            return 80;
        }
        return 40;
    }
    else if (indexPath.section == 2)
    {
    
        return 72;
    }
    else{
        return 60;
    }
   
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedRegular:) name:@"selectedAddress" object:nil];
    NSLog(@"%lu",(unsigned long)self.datas.count);
    if (indexPath.section == 0) {
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        AddressModel *model = self.datas[indexPath.section];
        SingleModel *sing = [SingleModel sharedSingleModel];
        sing.addressId = model.addressId;
        
        cell.tag = 1000;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 40, 20)];
        [btn setTitle:@"收货人 :" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [cell addSubview:btn];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 20, 100, 20)];
        lb1.text = model.receiver;
        [cell addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame), 20, 130, 20)];
        lb2.text = model.telphone;
        [cell addSubview:lb2];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(btn.frame)+5, 40, 20)];
        [btn1 setTitle:@"地址 :" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:10];
        [cell addSubview:btn1];
        
        
        
        addressLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), CGRectGetMaxY(btn.frame)+2, 250, 40)];
        addressLb.font = [UIFont systemFontOfSize:12];
        //lb3.backgroundColor = [UIColor redColor];
        addressLb.lineBreakMode = NSLineBreakByWordWrapping;
        addressLb.numberOfLines = 0;
        addressLb.text = model.address;
        [cell addSubview:addressLb];
        
    }
    if (indexPath.section == 1) {
    
    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        imageView.image = [UIImage imageNamed:@"tu1"];
        [cell addSubview:imageView];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, imageView.frame.origin.y, 160, 40)];
        lb1.font = [UIFont systemFontOfSize:10];
        //lb3.backgroundColor = [UIColor redColor];
        lb1.lineBreakMode = NSLineBreakByTruncatingTail;
        lb1.numberOfLines = 2;
        lb1.text = @"Apple MacBook Pro MF839CH/A 13.3英寸宽屏笔记本电脑 128GB 闪存";
        [cell addSubview:lb1];
        UILabel *priceFLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame)+5, lb1.frame.origin.y+5, 10, 20)];
        priceFLb.font = [UIFont systemFontOfSize:13];
        priceFLb.textColor = [UIColor blackColor];
        priceFLb.text = @"￥";
        [cell addSubview:priceFLb];
        SingleModel *single = [SingleModel sharedSingleModel];
        priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceFLb.frame), lb1.frame.origin.y+4, 80, 20)];
        priceLb.font = [UIFont systemFontOfSize:13];
        priceLb.textColor = [UIColor blackColor];
        NSLog(@"%@",single.price);
        priceLb.text = [NSString stringWithFormat:@"%@",single.price];
        _price = single.price;
        [cell addSubview:priceLb];
        
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb2.font = [UIFont systemFontOfSize:10];
        lb2.text = @"颜色 :";
        [cell addSubview:lb2];
        
        UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), CGRectGetMaxY(lb1.frame), 30, 20)];
        lb3.font = [UIFont systemFontOfSize:10];
        lb3.text = @"宾利蓝";
        [cell addSubview:lb3];
        
        UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame)+20, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb4.font = [UIFont systemFontOfSize:10];
        lb4.text = @"尺寸 :";
        [cell addSubview:lb4];
        
        UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb4.frame)+5, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb5.font = [UIFont systemFontOfSize:10];
        lb5.text = @"128G";
        [cell addSubview:lb5];
        
            }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"购买数量";
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        
        _numberBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(185, 5, 30, 30)];
        _numberBtn1.backgroundColor = [UIColor whiteColor];
        [_numberBtn1 setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        
        _numberBtn1.clipsToBounds = YES;
        _numberBtn1.layer.cornerRadius = 3;
        _numberBtn1.layer.borderWidth = 0.8;
        _numberBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [_numberBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_numberBtn1 addTarget:self action:@selector(numBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        _numberBtn1.tag = 1;
        [cell addSubview:_numberBtn1];
        
        UIButton *numberBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+60, _numberBtn1.frame.origin.y, 30, 30)];
        numberBtn2.backgroundColor = [UIColor whiteColor];
        [numberBtn2 setImage:[UIImage imageNamed:@"圆角矩形-3-2"] forState:UIControlStateNormal];
        numberBtn2.clipsToBounds = YES;
        numberBtn2.layer.cornerRadius = 3;
        numberBtn2.layer.borderWidth = 0.8;
        numberBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [numberBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numberBtn2 addTarget:self action:@selector(numBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        numberBtn2.tag = 2;
        [cell addSubview:numberBtn2];
        
        _numberLb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+5, _numberBtn1.frame.origin.y, 50, 30)];
        _numberLb1.backgroundColor = [UIColor whiteColor];
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
        [_numberLb1 setText:string];
        [_numberLb1 setTextColor:[UIColor blackColor]];
        _numberLb1.clipsToBounds = YES;
        _numberLb1.layer.cornerRadius = 3;
        _numberLb1.layer.borderWidth = 0.8;
        _numberLb1.layer.borderColor = [[UIColor grayColor] CGColor];
        [cell addSubview:_numberLb1];
        
    }
    else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"配送方式";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else if (indexPath.row == 3) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedPayWay:) name:@"payway" object:nil];
        cell.textLabel.text = @"支付方式";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.detailTextLabel.text = payWay;

        
        
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"发票信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 5) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    else if (indexPath.row == 6) {
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(140, 15, 60, 20)];
        lb2.font = [UIFont systemFontOfSize:12];
        lb2.text = @"工1件商品";
        [cell addSubview:lb2];
        
        UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), 15, 40, 20)];
        lb3.font = [UIFont systemFontOfSize:13];
        lb3.text = @"合计 :";
        [cell addSubview:lb3];
        
        UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame), 15, 60, 20)];
        lb4.font = [UIFont systemFontOfSize:13];
        lb4.text = @"34000.00";
        [cell addSubview:lb4];
    }
    }
    if (indexPath.section == 2) {
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(140, 10, 45, 20)];
        [btn1 setTitle:@"合计 :￥" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:btn1];
        
        totalPice = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), 10, 60, 20)];
        totalPice.text = priceLb.text;
        totalPice.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        totalPice.font = [UIFont systemFontOfSize:12];
        [cell addSubview:totalPice];
        
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totalPice.frame), 10, 70, 50)];
        [btn3 setTitle:@"确定" forState:UIControlStateNormal];
        btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        btn3.clipsToBounds = YES;
        btn3.layer.cornerRadius = 5;
        btn3.tag = 1000;
        [btn3 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.titleLabel.font = [UIFont systemFontOfSize:20];
        [cell addSubview:btn3];
        
    }
    return cell;
    
}

- (void)defaultAddress{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:ADDRESS,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        [hud hide:YES];
        [self.datas removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        if (dic[@"data"] !=[NSNull null]) {
            for (NSInteger i=0; i<[dic[@"data"]count]; i++) {
                if (![dic[@"data"][i][@"defaultAD"]isEqualToString:@"Y"]) {
                    NSArray *array = dic[@"data"];
                    for(NSDictionary *subDict in array)
                    {
                    AddressModel *model = [AddressModel modelWithDic:subDict];
                    [self.datas addObject:model];
                        NSLog(@"%@",self.datas);
                    }
                }
            }
        }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OrderAddressViewController *addre = [[OrderAddressViewController alloc]init];
        addre.regularText = addressLb.text;
        [self.navigationController pushViewController:addre animated:YES];
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row==2) {
            
            
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
        if (indexPath.row==3) {
    
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
        if (indexPath.row == 4) {
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
        PayViewController *pay = [[PayViewController alloc]init];
        [self.navigationController pushViewController:pay animated:YES];
        
    }
    
    
}

- (void)sureOrder{
    
    SingleModel *sing = [SingleModel sharedSingleModel];
    NSLog(@"%@",sing.addressId);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *count = [NSString stringWithFormat:@"%d",_currentNumber];
    NSString *path= [NSString stringWithFormat:SUREORDER,model.userkey,model.goodsId,count,payWay,sing.addressId];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        [hud hide:YES];
        [self.datas removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
    
}


-(void)numBtnPress:(UIButton *)btn{
    
    
    if (btn.tag ==1) {
        if (_currentNumber>1) {
            
            
            _currentNumber--;
            NSLog(@"%@",_price);
            NSLog(@"priceLb-%d",[(priceLb.text)intValue]);
            
            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
            [_numberLb1 setText:string];
            
            int price = ([(totalPice.text)intValue])-([(_price)intValue]);
            
            totalPice.text = [NSString stringWithFormat:@"%d",price];
            
        }
    }
    if (btn.tag == 2) {
        _currentNumber++;
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
        [_numberLb1 setText:string];
        
        int price = [(priceLb.text)intValue]*_currentNumber;
        
        totalPice.text = [NSString stringWithFormat:@"%d",price];
    }
    
    
    
}


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
