//
//  OrderViewController.m
//  EOffice
//
//  Created by gyz on 15/7/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderViewController.h"
#import "DropDown1.h"
#import "LogisticsDetailsController.h"
#import "ExchangeViewController.h"
#import "ServiceViewController.h"
#import "RDVTabBarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "OrderModel.h"
#import "AFNetworking.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,DropDown1Delegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableArray *classifyDatas;

@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)NSInteger btnNumber;
@property(nonatomic,assign)NSInteger orderId;
@property(nonatomic,assign)NSString *returnId;
@property(nonatomic,assign)NSInteger serviceOrderId;
@property(nonatomic,assign)NSString *docstatus;
@end

@implementation OrderViewController
{

    NSArray *dropDownMenuList;
     DropDown1 *dd1;
    BOOL isClssify;
    NSString *docstatus;
    OrderModel *model1;
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

-(NSMutableArray *)classifyDatas{
    if (_classifyDatas == nil) {
        _classifyDatas = [NSMutableArray array];
    }
    return _classifyDatas;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // self.title = @"订单";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationItem setTitle:@"我的订单"];
    
    isClssify = NO;
    [self downData];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, 320, 430) style:UITableViewStyleGrouped];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    dropDownMenuList = [[NSArray alloc]initWithObjects:@"全部",@"待发货",@"退换货/维修",@"待评价", nil];
    
    
    
    dd1= [[DropDown1 alloc]initWithFrame:CGRectMake(0, 0, 100, 0)];
    [dd1.textButton setTitle:@"所有" forState:UIControlStateNormal];
    [dd1.textButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    dd1.delegate = self;
    dd1.tableArray = dropDownMenuList;
    dd1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dd1];

    
}

- (void)dropDownControlView:(DropDown1 *)view didFinishWithSelection:(id)selection{
    
    if (selection) {
        
        [dd1.textButton setTitle:[NSString stringWithFormat:@"%@",selection] forState:UIControlStateNormal];
        //dropDownMenu.title = [NSString stringWithFormat:@"%@▼",selection];
        NSLog(@"%@",dd1.textButton.titleLabel.text);
        isClssify = YES;
        if ([dd1.textButton.titleLabel.text isEqualToString:@"全部"]) {
            _docstatus = @"-1";
        }
        if ([dd1.textButton.titleLabel.text isEqualToString:@"待发货"]) {
            _docstatus = @"1";
        }
        if ([dd1.textButton.titleLabel.text isEqualToString:@"退换货/维修"]) {
            _docstatus = @"2";
        }
        if ([dd1.textButton.titleLabel.text isEqualToString:@"待评价"]) {
            _docstatus = @"3";
        }
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
           
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self classifyData];
//                [self.tableView reloadData];
                [self.classifyDatas removeAllObjects];
            });
            
        });
    }
    
}

-(void)classifyData{
    
    
    NSLog(@"%@",_docstatus);

    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:ORDERCLASSIFY,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"docstatus":_docstatus} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
        
        for(NSDictionary *subDict in array)
        {
            NSLog(@"%@",subDict);
            OrderModel *model = [OrderModel modelWithDic:subDict];
            [self.classifyDatas addObject:model];
            
        }
        
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)downData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];

    
    NSString *path= [NSString stringWithFormat:ORDER,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
       
        for(NSDictionary *subDict in array)
        {
            NSLog(@"%@",subDict);
            OrderModel *model = [OrderModel modelWithDic:subDict];
            [self.datas addObject:model];
            
        }
        }
       
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (isClssify == NO) {
        return self.datas.count;
    }
    else{
    
        return self.classifyDatas.count;
    }
   
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.row == 0) {
//        return 60;
//    }
//    else if (indexPath.row == 2){
//        return 50;
//    }
//    
//    else{
//        return 40;
    
    return 150;
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.clipsToBounds = YES;
    NSLog(@"%@",self.datas);
    if (isClssify == NO) {
    model1 = self.datas[indexPath.row];
    NSLog(@"%@",model1.orderDescription);
    
        
    
    }
    if (isClssify == YES) {
        model1 = self.classifyDatas[indexPath.row];
        
    }
        docstatus = [NSString stringWithFormat:@"%@",model1.docstatus];
    
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
        lb6.text = lb6.text = [NSString stringWithFormat:@"%@",model1.price];;
        [cell addSubview:lb6];
        
        UILabel *lb7 = [[UILabel alloc]initWithFrame:CGRectMake(lb6.frame.origin.x+40, CGRectGetMaxY(lb6.frame)+10, 60, 20)];
        lb7.font = [UIFont systemFontOfSize:10];
        lb7.text = @"×1";
        [cell addSubview:lb7];

 
        UILabel *lbT = [[UILabel alloc]initWithFrame:CGRectMake(55, CGRectGetMaxY(imageView.frame)+25, 60, 20)];
        lbT.font = [UIFont systemFontOfSize:10];
        lbT.text = @"共1件商品";
        lbT.textColor = [UIColor grayColor];
        [cell addSubview:lbT];
        
        UILabel *lbT1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbT.frame)+5, lbT.frame.origin.y, 80, 20)];
        lbT1.font = [UIFont systemFontOfSize:10];
        lbT1.text = @"运费 :￥30.00";
        lbT1.textColor = [UIColor grayColor];
        [cell addSubview:lbT1];
        
        UILabel *lbT2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbT1.frame)+5, lbT.frame.origin.y, 30, 20)];
        lbT2.font = [UIFont systemFontOfSize:10];
        lbT2.text = @"合计 :";
        lbT2.textColor = [UIColor grayColor];
        [cell addSubview:lbT2];
        
        UILabel *lbT3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lbT2.frame), lbT.frame.origin.y, 60, 20)];
        lbT3.font = [UIFont systemFontOfSize:10];
        lbT3.text = @"￥36030.00";
        [cell addSubview:lbT3];

        
        if ([docstatus isEqualToString:@"1"]) {
            self.row = indexPath.row;
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(170,CGRectGetMaxY(lbT.frame)+20, 60, 20)];
       [btn1 setTitle:@"删除订单" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        btn1.clipsToBounds = YES;
        _row = [[NSString stringWithFormat:@"%@",model1.orderId]intValue];
            SingleModel *single = [SingleModel sharedSingleModel];
            single.orderId = model1.orderId;
            NSLog(@"%ld",(long)btn1.tag);
        btn1.tag = indexPath.row;
        btn1.font = [UIFont systemFontOfSize:12];
        btn1.layer.cornerRadius = 3;
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:btn1];
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn3 setTitle:@"马上付款" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.clipsToBounds = YES;
        btn3.font = [UIFont systemFontOfSize:12];
        btn3.layer.cornerRadius = 3;
        [btn3 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 1000;
        btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addSubview:btn3];
        }
        
        if ([docstatus isEqualToString:@"3"]) {
            
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(lbT.frame)+20, 60, 20)];
        [btn1 setTitle:@"删除订单" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn1.clipsToBounds = YES;
       _row = [[NSString stringWithFormat:@"%@",model1.orderId]intValue];
            NSLog(@"%ld",(long)_row);
        btn1.tag = indexPath.row;
        btn1.font = [UIFont systemFontOfSize:12];
        btn1.layer.cornerRadius = 3;
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:btn1];

        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn2 setTitle:@"查看物流" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn2.clipsToBounds = YES;
        btn2.font = [UIFont systemFontOfSize:12];
        btn2.layer.cornerRadius = 3;
        btn2.layer.borderWidth = 1;
        btn2.layer.borderColor = [[UIColor grayColor]CGColor];
        [btn2 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 1001;
        [cell addSubview:btn2];

        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn3 setTitle:@"确认收货" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.clipsToBounds = YES;
        btn3.font = [UIFont systemFontOfSize:12];
        btn3.layer.cornerRadius = 3;
        [btn3 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            btn2.tag = 1002;
        btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addSubview:btn3];
            
        }
        if ([docstatus isEqualToString:@"2"]) {
            
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(170, CGRectGetMaxY(lbT.frame)+20, 60, 20)];
        [btn1 setTitle:@"删除订单" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn1.clipsToBounds = YES;
       _row = [[NSString stringWithFormat:@"%@",model1.orderId]intValue];
         NSLog(@"model.orderId--%ld",(long)_row);
        btn1.tag = indexPath.row;
            
        btn1.font = [UIFont systemFontOfSize:12];
        btn1.layer.cornerRadius = 3;
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:btn1];


        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn3 setTitle:@"提醒发货" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.clipsToBounds = YES;
        btn3.font = [UIFont systemFontOfSize:12];
        btn3.layer.cornerRadius = 3;
        [btn3 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 1003;
        btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addSubview:btn3];
            
        }
        if ([docstatus isEqualToString:@"4"]) {
            
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(lbT.frame)+20, 60, 20)];
        [btn1 setTitle:@"删除订单" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn1.clipsToBounds = YES;
       _row = [[NSString stringWithFormat:@"%@",model1.orderId]intValue];
            NSLog(@"%ld",(long)btn1.tag);
             btn1.tag = indexPath.row;
        btn1.font = [UIFont systemFontOfSize:12];
        btn1.layer.cornerRadius = 3;
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:btn1];

        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn2 setTitle:@"退换货" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn2.clipsToBounds = YES;
        btn2.font = [UIFont systemFontOfSize:12];
        btn2.layer.cornerRadius = 3;
        btn2.layer.borderWidth = 1;
        btn2.layer.borderColor = [[UIColor grayColor]CGColor];
        [btn2 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 1004;
        [cell addSubview:btn2];

        UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn4 setTitle:@"维修" forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn4.clipsToBounds = YES;
        btn4.font = [UIFont systemFontOfSize:12];
        btn4.layer.cornerRadius = 3;
        btn4.layer.borderWidth = 1;
        btn4.layer.borderColor = [[UIColor grayColor]CGColor];
        [btn4 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn4.tag = 1005;
        _serviceOrderId = indexPath.row;
        [cell addSubview:btn4];

        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn4.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn3 setTitle:@"马上评价" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.clipsToBounds = YES;
        btn3.font = [UIFont systemFontOfSize:12];
        btn3.layer.cornerRadius = 3;
            [btn3 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            btn3.tag = 1005;
        btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addSubview:btn3];
        
        }
        if ([docstatus isEqualToString:@"5"]) {
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(lbT.frame)+20, 60, 20)];
        [btn1 setTitle:@"删除订单" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn1.clipsToBounds = YES;
       _row = [[NSString stringWithFormat:@"%@",model1.orderId]intValue];
            NSLog(@"model.orderId--%ld",(long)_row);
         btn1.tag = indexPath.row;
        btn1.font = [UIFont systemFontOfSize:12];
        btn1.layer.cornerRadius = 3;
        btn1.layer.borderWidth = 1;
        btn1.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:btn1];

        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn2 setTitle:@"查看结果" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn2.clipsToBounds = YES;
        btn2.font = [UIFont systemFontOfSize:12];
        btn2.layer.cornerRadius = 3;
        btn2.layer.borderWidth = 1;
            OrderModel *model = self.datas[indexPath.row];
            _returnId = model.orderId;
        btn2.layer.borderColor = [[UIColor grayColor]CGColor];
        [btn2 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 1006;
        [cell addSubview:btn2];

        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame)+5, btn1.frame.origin.y, 60, 20)];
        [btn3 setTitle:@"马上评价" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn3.clipsToBounds = YES;
        btn3.font = [UIFont systemFontOfSize:12];
        btn3.layer.cornerRadius = 3;
        [btn3 addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        btn3.tag = 1007;
        btn3.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell addSubview:btn3];
        
         
    }
    
    


    
    return cell;
}
-(void)delegateBtn:(UIButton *)btn{
    
    NSLog(@"%ld",(long)_row);
    
    _btnNumber = btn.tag;
   
    _orderId = _row;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除订单" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];
    //设置提示框样式（可以输入账号密码）
    alert.alertViewStyle = UIAlertViewStyleDefault;
    _row = btn.tag;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        NSLog(@"....");
    }else{
        
        
         [self.datas removeObjectAtIndex:_btnNumber];

         [_tableView reloadData];
        [self deleteData];
        
    }
}
-(void)deleteData{

    NSLog(@"row--%ld",(long)_orderId);
    NSString *string = [NSString stringWithFormat:@"%ld",(long)_orderId];
    
    NSString *path= [NSString stringWithFormat:DELETEORDER,string];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
        NSLog(@"array--%@",string);
        if ([string isEqualToString:@"1"]) {
            

        }
        else{
        }

       


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];


}

-(void)buttonPress:(UIButton *)btn{
    //查看物流
    if (btn.tag == 1001) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;

        LogisticsDetailsController *lg = [[LogisticsDetailsController alloc]init];
        
        [self.navigationController pushViewController:lg animated:YES];
        NSLog(@",,");
    }
    
    //退换货
    if (btn.tag == 1004) {
        
        SingleModel *model = [SingleModel sharedSingleModel];
        model.serviceOrderId = [NSString stringWithFormat:@"%ld",(long)_serviceOrderId];
        ExchangeViewController *exc = [[ExchangeViewController alloc]init];
        
        [self.navigationController pushViewController:exc animated:YES];
    }
    //维修
    if (btn.tag == 1005) {
        SingleModel *model = [SingleModel sharedSingleModel];
        model.serviceOrderId = [NSString stringWithFormat:@"%ld",(long)_serviceOrderId];
        ServiceViewController *ser = [[ServiceViewController alloc]init];
        [self.navigationController pushViewController:ser animated:YES];
    }
    if (btn.tag == 1006) {
        [self exchageStateDatas];
    }
}
-(void)exchageStateDatas{
    
    
    
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    int i = [(model.reasonId)intValue];
    
    NSString *path= [NSString stringWithFormat:RETUNGOODSSTATE,model.jsessionid,model.userkey,_returnId];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
        NSLog(@"array--%@",string);
        if ([string isEqualToString:@"1"]) {
            
            
        }
        else{
        }
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
