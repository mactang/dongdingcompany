//
//  PayViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/17.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PayViewController.h"
#import "RDVTabBarController.h"
#import "TarBarButton.h"
#import "PayWayButton.h"

#import "BDWalletSDKMainManager.h"
#import <CommonCrypto/CommonDigest.h>

//APP端签名相关头文件
#import "payRequsestHandler.h"

//服务端签名只需要用到下面一个头文件
//#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>

#import "WXApiObject.h"
#import "WXApi.h"


@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate,BDWalletSDKMainManagerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation PayViewController
{
     UIButton *payBtn;
    UIButton *selectButton;
    NSInteger payWayMark;
    NSString *payprice;
   
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
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    TarBarButton *ligthButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    //向微信注册
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    
    payWayMark = 0;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -1, 320, 310) style:UITableViewStyleGrouped];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 320, 300, 40)];
    sureBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surePay) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius = 10;
    
    [self.view addSubview:sureBtn];
    
    // Do any additional setup after loading the view.
}
- (void)leftItemClicked{

    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 4;
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
         NSLog(@"price**%@",self.totalPrice);
        NSString *string =[NSString stringWithFormat:@"%@",self.totalPrice];
        NSLog(@"length**%lu",(unsigned long)[string length]);
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-[string length]-65, 20, [string length]+65, 20)];
        price.text = [NSString stringWithFormat:@"%.2f元",[self.totalPrice floatValue] ];
        price.font = [UIFont systemFontOfSize:13];
        [cell addSubview:price];
        
        payprice = [NSString stringWithFormat:@"%@",self.totalPrice];
        
    }if (indexPath.section == 1) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;;
        if (indexPath.row == 0) {
    
            
            PayWayButton *leftButton = [[PayWayButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
            [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
            UIImage *ligthImage = [UIImage imageNamed:@"weixinpay"];
            [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
            [leftButton setTitle:@"微信支付" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
            
            [cell addSubview:leftButton];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 17, 17);
            payBtn.selected = YES;
            payBtn.tag = 100+indexPath.row;
            [payBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = payBtn;

        }
        if (indexPath.row == 1) {
           
            
            PayWayButton *leftButton = [[PayWayButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
            [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
            UIImage *ligthImage = [UIImage imageNamed:@"alipay"];
            [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
            [leftButton setTitle:@"支付宝" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell addSubview:leftButton];

            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 17, 17);
            [payBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            payBtn.tag = 100+indexPath.row;
            cell.accessoryView = payBtn;
        }
        if (indexPath.row == 2) {
            
            
            PayWayButton *leftButton = [[PayWayButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
            [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
            UIImage *ligthImage = [UIImage imageNamed:@"baiduqianbao"];
            [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
            [leftButton setTitle:@"百度钱包" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell addSubview:leftButton];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 17, 17);
            [payBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            payBtn.tag = 100+indexPath.row;
            cell.accessoryView = payBtn;
        }
        
        if (indexPath.row == 3) {
            
            PayWayButton *leftButton = [[PayWayButton alloc]initWithFrame:CGRectMake(15, 20, 20, 20)];
            [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
            UIImage *ligthImage = [UIImage imageNamed:@"bank"];
            [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
            [leftButton setTitle:@"银行卡" forState:UIControlStateNormal];
            [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell addSubview:leftButton];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            payBtn.frame = CGRectMake(0, 0, 17, 17);
            [payBtn setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
            [payBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
            [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            payBtn.tag = 100+indexPath.row;
            cell.accessoryView = payBtn;
        }
    }
    return cell;
}
- (void)isPublicBtnPress:(UIButton*)btn{
    payWayMark = btn.tag;
    UIButton *button = (UIButton *)[self.view viewWithTag:100];
    button.selected = NO;
    selectButton.selected = NO;
    btn.selected = !btn.selected;
    selectButton = btn;
    
}
-(void)surePay{
    if (payWayMark == 0) {
        [self sendPay_demo];
    }
    //微信支付
    if (payWayMark == 100) {
       [self sendPay_demo];
    }
    if (payWayMark == 101) {
        
    }
    //百度钱包支付
    if (payWayMark == 102) {
        [self baifubao];
    }
    if (payWayMark == 103) {
        
    }
    
}

- (void)sendPay_demo
{
    //{{{
    //本实例只是演示签名过程， 请将该过程在商户服务器上实现
    
    //创建支付签名对象
    payRequsestHandler *req = [[payRequsestHandler alloc]init];
    //初始化支付签名对象
    [req init:APP_ID mch_id:MCH_ID];
    //设置密钥
    [req setKey:PARTNER_ID];
    req.payPrice = payprice;
    //}}}
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    NSMutableDictionary *dict = [req sendPay_demo];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        [self alert:@"提示信息" msg:debug];
        
        NSLog(@"%@\n\n",debug);
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dict objectForKey:@"appid"];
        req.partnerId           = [dict objectForKey:@"partnerid"];
        req.prepayId            = [dict objectForKey:@"prepayid"];
        req.nonceStr            = [dict objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dict objectForKey:@"package"];
        req.sign                = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req];
    }
}


//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    
}
- (void)sendPay
{
    //从服务器获取支付参数，服务端自定义处理逻辑和格式
    //订单标题
    NSString *ORDER_NAME    = @"Ios服务器端签名支付 测试";
    //订单金额，单位（元）
    NSString *ORDER_PRICE   = [NSString stringWithFormat:@"%@",self.totalPrice];
    
    //根据服务器端编码确定是否转码
    NSStringEncoding enc;
    //if UTF8编码
    //enc = NSUTF8StringEncoding;
    //if GBK编码
    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
                           SP_URL,
                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
                           ORDER_PRICE];
    
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.openID              = [dict objectForKey:@"appid"];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
            }else{
                [self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
            }
        }else{
            [self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
        }
    }else{
        [self alert:@"提示信息" msg:@"服务器返回错误"];
    }
}


#pragma mark  baifubao
-(void)baifubao{
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    BDWalletSDKMainManager* payMainManager = [BDWalletSDKMainManager getInstance];
    [[BDWalletSDKMainManager getInstance] setBdWalletNavTitleColor:[UIColor blackColor]];
    NSString *orderInfo = [self buildOrderInfoTest];
    payMainManager.delegate = self;
    NSLog(@"%@",orderInfo);
    [payMainManager doPayWithOrderInfo:orderInfo params:nil delegate:self];
    
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
    
    [str appendString:[NSString stringWithFormat:@"%.0f",[self.totalPrice floatValue]*100]];

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
    [str1 appendString:[NSString stringWithFormat:@"%.0f",[self.totalPrice floatValue]*100]];
    
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}


- (void)logEventId:(NSString*)eventId eventDesc:(NSString*)eventDesc;
{
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
@end
