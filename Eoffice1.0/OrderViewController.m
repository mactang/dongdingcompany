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
#import "LoginViewController.h"
#import "SingleModel.h"
#import "UIKit+AFNetworking.h"
#import "AllorderviewCell.h"
#import "MJRefresh.h"
#import "UIAlertView+AlerViewBlocks.h"
#import "CommodityViewController.h"
#import "CMDetailsViewController.h"
#import "BDWalletSDKMainManager.h"
#import <CommonCrypto/CommonDigest.h>

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,DropDown1Delegate,logindelegate,deletgateOrder,BDWalletSDKMainManagerDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *classifyDatas;
@property(nonatomic,copy)NSString  *orderId;
@property(nonatomic,assign)NSString *returnId;
@property(nonatomic,assign)NSInteger serviceOrderId;
@property(nonatomic,copy)NSString *docstatusign;
@property(nonatomic,copy)NSString *moredata;
@property(nonatomic,strong)UILabel *labelsign;
@property(nonatomic,strong)UIButton *strollbutton;
@end

@implementation OrderViewController
{

    NSArray *dropDownMenuList;
    DropDown1 *dd1;
    NSString *docstatus;
    OrderModel *model1;
    LoginViewController *login;
    NSMutableArray *testarray;
    BOOL  refresh;
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
//    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
//        self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    testarray = [NSMutableArray array];
    refresh = YES;
    self.view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
//    self.navigationController.navigationBarHidden = YES;
    self.moredata = @"-1";
    _docstatusign = @"-1";
    UILabel *myOrder = [[UILabel alloc]initWithFrame:CGRectMake(120, 35, 80, 20)];
    myOrder.text = @"我的订单";
    myOrder.textColor = [UIColor blackColor];
    myOrder.textAlignment = NSTextAlignmentCenter;
    myOrder.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:myOrder];
    
    dropDownMenuList = [[NSArray alloc]initWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"已完成",nil];
    
    dd1= [[DropDown1 alloc]initWithFrame:CGRectMake(0, 70, 120, 0)];
    [dd1.textButton setTitle:@"所有" forState:UIControlStateNormal];
    [dd1.textButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    dd1.delegate = self;
    dd1.tableArray = dropDownMenuList;
    dd1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dd1];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dd1.frame), dd1.frame.origin.y, 220, dd1.frame.size.height)];
    lb.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lb];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(dd1.frame), SCREEN_WIDTH, SCREEN_HEIGHT-105-44) style:UITableViewStyleGrouped];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;

    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}
-(void)loadMoreData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSInteger pageNumber = [self.classifyDatas count] / 6 + 1;
    self.moredata = [NSString stringWithFormat:@"%ld",pageNumber];
    NSString *path= [NSString stringWithFormat:ORDERCLASSIFY,COMMON,model.jsessionid,model.userkey,self.moredata];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:@{@"docstatus":_docstatusign} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        if (dic[@"data"] !=[NSNull null]){
            NSArray *array = dic[@"data"];
            for(NSDictionary *subDict in array)
            {
                OrderModel *model = [OrderModel modelWithDic:subDict];
                if (![testarray containsObject:subDict]) {
                    [self.classifyDatas addObject:model];
                }
            }
        }
        [hud hide:YES];
        [_tableView reloadData];
        [self.tableView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}
- (void)dropDownControlView:(DropDown1 *)view didFinishWithSelection:(id)selection{
    if (selection) {
        [dd1.textButton setTitle:[NSString stringWithFormat:@"%@",selection] forState:UIControlStateNormal];
        //dropDownMenu.title = [NSString stringWithFormat:@"%@▼",selection];
        NSLog(@"%@",dd1.textButton.titleLabel.text);
        if ([dd1.textButton.titleLabel.text isEqualToString:@"全部"]) {
            _docstatusign = @"-1";
        }
        if ([dd1.textButton.titleLabel.text isEqualToString:@"待付款"]) {
            _docstatusign = @"1";
        }

        if ([dd1.textButton.titleLabel.text isEqualToString:@"待发货"]) {
            _docstatusign = @"2";
        }
        if ([dd1.textButton.titleLabel.text isEqualToString:@"待收货"]) {
            _docstatusign = @"3";
        }
        if ([dd1.textButton.titleLabel.text isEqualToString:@"已完成"]) {
            _docstatusign = @"4";
        }
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.classifyDatas removeAllObjects];
                [testarray removeAllObjects];
                [self classifyData];
//              [self.tableView reloadData];
                
            });
            
        });
    }
    
}
-(void)classifyData{
    self.moredata = @"-1";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:ORDERCLASSIFY,COMMON,model.jsessionid,model.userkey,self.moredata];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:@{@"docstatus":_docstatusign} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        if (dic[@"data"] !=[NSNull null]){
            self.tableView.footer.hidden = NO;
            [self.labelsign removeFromSuperview];
            [self.strollbutton removeFromSuperview];
            NSArray *array = dic[@"data"];
        
        for(NSDictionary *subDict in array)
        {
            if (![testarray containsObject:subDict]) {
                [testarray addObject:subDict];
                OrderModel *model = [OrderModel modelWithDic:subDict];
                [self.classifyDatas addObject:model];
            }
        }
    }
        else{
            self.tableView.footer.hidden = YES;
            if (!self.labelsign) {
                self.labelsign = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, 40)];
            }
            self.labelsign.text = @"抱歉,没有找到相关订单";
            self.labelsign.textAlignment = NSTextAlignmentCenter;
            self.labelsign.font = [UIFont systemFontOfSize:17];
            [self.view addSubview:self.labelsign];
            
            if (!self.strollbutton) {
                self.strollbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                
            }
            self.strollbutton.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/3.5)/2, CGRectGetMaxY(self.labelsign.frame)+10, SCREEN_WIDTH/3.5, SCREEN_WIDTH/10.5);
            self.strollbutton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
            self.strollbutton.layer.borderWidth = 1;
            self.strollbutton.layer.cornerRadius = 2;
            self.strollbutton.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.strollbutton setTitle:@"随便逛逛" forState:UIControlStateNormal];
            [self.strollbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self.strollbutton addTarget:self action:@selector(gotolookPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.strollbutton];
        }
        [hud hide:YES];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        NSLog(@"%@",error);
    }];
}

-(void)gotolookPressed{
    CommodityViewController *cmd = [[CommodityViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:cmd animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.classifyDatas.count;
   
}
-(void)reloadata{

    [self classifyData];
    
    SingleModel *model = [SingleModel sharedSingleModel];
    if (model.userkey != nil) {
//        self.navigationController.navigationBarHidden = NO;
//        [self.navigationItem setTitle:@"我的订单"];
    }
    else{
        
        
    }
}
-(void)reloadshopcart{
    
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
    
    return 160;
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
    AllorderviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[AllorderviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.classifyDatas[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

-(void)deatailGoodId:(NSString *)goodId{
    
    NSLog(@"%@",goodId);
    SingleModel *singM = [SingleModel sharedSingleModel];
    singM.goodsId = goodId;
    singM.paraId = @"505";
    singM.cPartnerId = @"1000";
    CMDetailsViewController *cmd = [[CMDetailsViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:cmd animated:YES];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message isEqualToString:@"确定要删除该订单"]) {
        if (buttonIndex == 1) {
            
        }else{
            [self deleteData];
            
        }
    }
    if ([alertView.message isEqualToString:@"删除失败"]) {
        if (buttonIndex==0) {
            [self deleteData];
        }
    }

}
#pragma mark  orderdelegatemathds
//OrderModel *model = [OrderModel modelWithDic:subDict];
//[self.datas addObject:model];
-(void)delegatemethds:(NSString *)orderid{
    _orderId = orderid;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除该订单" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];
    //设置提示框样式（可以输入账号密码）
    alert.alertViewStyle = UIAlertViewStyleDefault;
    alert.delegate = self;
    [alert show];
    
}
#pragma mark  baifubao
-(void)baifubao:(NSInteger)buttonTag{
    BDWalletSDKMainManager* payMainManager = [BDWalletSDKMainManager getInstance];
    NSString *orderInfo = [self buildOrderInfoTest];
    payMainManager.delegate = self;
    NSLog(@"%@",orderInfo);
     [payMainManager doPayWithOrderInfo:orderInfo params:nil delegate:self];
}
-(void)deleteData{
    
    NSString *path= [NSString stringWithFormat:DELETEORDER,COMMON,_orderId];
    NSLog(@"%@",path);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *messagestring;
        NSString *signstring;
        NSString *cancelsting;
        if ([dic[@"status"] integerValue]==1) {
            
            messagestring = @"删除成功";
            signstring = @"确定";
            cancelsting = nil;
            NSIndexPath *path;
            for (NSInteger i=0; i<self.classifyDatas.count; i++) {
                OrderModel *model = self.classifyDatas[i];
                if ([model.orderId isEqualToString:_orderId]) {
                    path = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.classifyDatas removeObjectAtIndex:i];
                    break;
                }
            }
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
           
        }
        else{
            messagestring = @"删除失败";
            signstring = @"点击重试";
            cancelsting = @"取消";
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:messagestring delegate:self cancelButtonTitle:signstring otherButtonTitles:cancelsting,nil];
        alert.delegate = self;
        [alert show];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
        if (error.code==-1004) {
            
            [UIAlertView showMsgWithTitle:@"温馨提示" promptmessage:@"连接服务器失败" confirm:@"点击重试" cancel:@"取消" blocks:^(NSInteger index) {
                [self deleteData];
            }];
            
        }
        if (error.code==-1001) {
            
            [UIAlertView showMsgWithTitle:@"温馨提示" promptmessage:@"连接超时" confirm:@"点击重试" cancel:@"取消" blocks:^(NSInteger index) {
                [self deleteData];
            }];
            
        }

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
   
    NSString *path= [NSString stringWithFormat:RETUNGOODSSTATE,COMMON,model.jsessionid,model.userkey,_returnId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
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
    SingleModel *model = [SingleModel sharedSingleModel];
  
    if (model.userkey == nil) {
        if (!login) {
            login = [[LoginViewController alloc]init];
            [self.view addSubview:login.view];
            login.delegate = self;
        }
    }
    if (model.userkey != nil) {
        [login.view removeFromSuperview];
        if (refresh) {
            [self classifyData];
//            refresh = NO;
        }
       
    }
}
-(NSString*)buildOrderInfoTest
{
    
    NSDate *senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYYMMDDHHMMSS"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSLog(@"locationString:%@",locationString);
    
  
    
    NSMutableString *str = [[NSMutableString alloc]init];
    
    static NSString *spNo = @"1000242714";
    static NSString *key = @"zfVWqNyuW3w4MS3UC3U3dZ8MgkwK4RWB";

    NSString *orderId = [NSString stringWithFormat:@"%.0f", fabs(arc4random())];
    [str appendString:@"currency=1&extra="];
    [str appendString:@"&goods_desc="];
    [str appendString:[self utf8toGbk:@"美丽的童话世界"]];
    [str appendString:@"&goods_name="];
    [str appendString:[self utf8toGbk:@"笔记本电脑"]]; // 中文处理1

    [str appendString:@"&goods_url=http://item.jd.com/736610.html&input_charset=1&order_create_time=20130508131702&order_no="];
    [str appendString:orderId];
    [str appendString:@"&pay_type=2"];

//    [str appendString:@"&version=2"];
    [str appendString:@"&return_url=http://item.jd.com/736610.html&service_code=1&sign_method=1&sp_no="];
    [str appendString:spNo];
    [str appendString:@"&sp_request_type="];
    [str appendString:@"1"];
    [str appendString:@"&sp_uno="];
    [str appendString:@"11"];
    [str appendString:@"&total_amount="];
    [str appendString:@"1"];
   

    
    NSString *md5CapPwd = [self mD5GBK:[NSString stringWithFormat:@"%@&key=%@" , str, key]]; // 中文处理2
    
    NSMutableString *str1 = [[NSMutableString alloc]init];
    
    [str1 appendString:@"currency=1&extra="];
    [str1 appendString:@"&goods_desc="];
    [str1 appendString:[self encodeURL:[self utf8toGbk:@"美丽的童话世界"]]];
    [str1 appendString:@"&goods_name="];
    [str1 appendString:[self encodeURL:[self utf8toGbk:@"笔记本电脑"]]];// 中文处理3

    [str1 appendString:@"&goods_url=http://item.jd.com/736610.html&input_charset=1&order_create_time=20130508131702&order_no="];
    [str1 appendString:orderId];
    [str1 appendString:@"&pay_type=2"];

    [str1 appendString:@"&return_url=http://item.jd.com/736610.html&service_code=1&sign_method=1&sp_no="];
    [str1 appendString:spNo];
    [str1 appendString:@"&sp_request_type="];
    [str1 appendString:@"1"];
    [str1 appendString:@"&sp_uno="];
    [str1 appendString:@"11"];
    [str1 appendString:@"&total_amount="];
    [str1 appendString:@"1"];

    
    return [NSString stringWithFormat:@"%@&sign=%@" , str1 , md5CapPwd];
}

- (NSString *)mD5GBK:(NSString *)src
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    const char *cStr = [src cStringUsingEncoding:enc];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*)encodeURL:(NSString *)string
{
    NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)string,
                                                                                                    NULL,
                                                                                                    CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),
                                                                                                    kCFStringEncodingGB_18030_2000));
    if (escaped_value) {
        return escaped_value;
    }
    return @"";
}
-(NSString*)utf8toGbk:(NSString*)str
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString* str1 = [str stringByReplacingPercentEscapesUsingEncoding:enc];
    return str1;
}
-(void)BDWalletPayResultWithCode:(int)statusCode payDesc:(NSString*)payDesc;
{
    NSLog(@"支付结束 接口 code:%d desc:%@",statusCode,payDesc);
}

- (void)logEventId:(NSString*)eventId eventDesc:(NSString*)eventDesc;
{}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
