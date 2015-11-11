//
//  RecommendViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "RecommendViewController.h"
#import "RDVTabBarController.h"
#import "RecommCodeGenerator.h"
#import "CalculateStringSpace.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "RcommendBackModel.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/TencentOAuth.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "ComRuleController.h"

@interface RecommendViewController ()<UMSocialUIDelegate>
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation RecommendViewController
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@"推荐返现"];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    //[imageView addSubview: image];
    [self downData];
}
- (void)downData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:RECOMMENBACKMONEY,COMMON,model.userkey];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            NSLog(@"%@",dic);
            NSDictionary *array = dic[@"data"];
            RcommendBackModel *model = [RcommendBackModel modelWithDic:array];
            [self.datas addObject: model];
        }
        [self recommendBackView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)recommendBackView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,64,SCREEN_WIDTH, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    NSLog(@"%@",self.datas[0]);
    RcommendBackModel *model = self.datas[0];
    NSLog(@"%@",model.registerCount);
    NSString *string = [NSString stringWithFormat:@"%@",model.registerCount];
    NSString *string1 = [NSString stringWithFormat:@"%@",model.totalAmount];
    NSString *buyString = [NSString stringWithFormat:@"%@",model.buyCount];
    NSLog(@"%lu",(unsigned long)[string length]);
    
    NSMutableAttributedString *personNumberString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"推荐注册:%@人",string]];
    [personNumberString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:204.0/255.0 green:0/255.0 blue:0/255.0 alpha:1] range:NSMakeRange(5, [string length])];
    UILabel *personNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 20)];
    personNumberLb.attributedText = personNumberString;
    personNumberLb.font = [UIFont systemFontOfSize:12];
    [view addSubview:personNumberLb];
    
    
    NSMutableAttributedString *recommendPayString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"推荐已消费:%@人",buyString]];
    [recommendPayString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:204.0/255.0 green:0/255.0 blue:0/255.0 alpha:1] range:NSMakeRange(6, [buyString length])];
    UILabel *recommendPayLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(personNumberLb.frame)+10, 10, 200, 20)];
    recommendPayLb.attributedText = recommendPayString;
    recommendPayLb.font = [UIFont systemFontOfSize:12];
    [view addSubview:recommendPayLb];
    
    
    NSMutableAttributedString *readyString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已获金额:%@元",string1]];
    [readyString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:204.0/255.0 green:0/255.0 blue:0/255.0 alpha:1] range:NSMakeRange(5, [string1 length])];
    UILabel *readyLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(personNumberLb.frame)+10, 200, 20)];
    readyLb.attributedText = readyString;
    readyLb.font = [UIFont systemFontOfSize:12];
    [view addSubview:readyLb];
    
    // sample
    UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(view.frame)+10,320, 450)];
    otherView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:otherView];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 30, 160, 160)];
    imageView.image = [RecommCodeGenerator qrImageForString:@"http://www.baidu.com" imageSize:imageView.bounds.size.width];
    [otherView addSubview: imageView];
    
    UILabel *shareLb = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(imageView.frame)-10, 160, 20)];
    shareLb.text = @"分享你的推荐码";
    shareLb.textColor = [UIColor grayColor];
    shareLb.textAlignment = NSTextAlignmentCenter;
    shareLb.font = [UIFont systemFontOfSize:10];
    [otherView addSubview:shareLb];
    
    UILabel *recommendCodeLb = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(shareLb.frame), 160, 20)];
    recommendCodeLb.text = [NSString stringWithFormat:@"%@",model.code];
    recommendCodeLb.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    recommendCodeLb.font = [UIFont systemFontOfSize:15];
    recommendCodeLb.textAlignment = NSTextAlignmentCenter;
    [otherView addSubview:recommendCodeLb];
    
    NSString *labelText = @"推荐好友使用您的推荐码注册，好友消费时您将获得返现!";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    UILabel *recommendExplaiLb = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(recommendCodeLb.frame)-10, 280, 60)];
    recommendExplaiLb.attributedText = attributedString;
    recommendExplaiLb.numberOfLines = 2;
    recommendExplaiLb.font = [UIFont systemFontOfSize:12];
    recommendExplaiLb.userInteractionEnabled = YES;
    [otherView addSubview:recommendExplaiLb];
    
    UIButton *ruleButton = [[UIButton alloc]initWithFrame:CGRectMake(215, 30, 60, 20)];
    [ruleButton setTitle:@"(返现规则)" forState:UIControlStateNormal];
    [ruleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    ruleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [ruleButton addTarget:self action:@selector(rulePressBtn) forControlEvents:UIControlEventTouchUpInside];
    [recommendExplaiLb addSubview:ruleButton];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [btn setFrame:CGRectMake(10, CGRectGetMaxY(recommendExplaiLb.frame), 300, 40)];
    [btn addTarget:self action:@selector(sharePreeBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.clipsToBounds= YES;
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [otherView addSubview:btn];
    
    
    
}
-(void)rulePressBtn{
    ComRuleController *recomm = [[ComRuleController alloc]init];
    [self.navigationController pushViewController:recomm animated:YES];
}
-(void)sharePreeBtn{
    
    
    [UMSocialQQHandler setQQWithAppId:@"1104934732" appKey:@"3QLZa0n70Sfom2um" url:@"http://www.umeng.com/social"];
    
    [UMSocialWechatHandler setWXAppId:@"wxd20a08d7a7efd6b4" appSecret:@"7ac03523b9ee4296d2adf49648702c62" url:nil];
    
    NSString *shareText = @"http://www.ebangon.com";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5631871667e58ebeff003677"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects: UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToTencent,UMShareToSms, nil]
                                       delegate:self];
}
- (void)leftItemClicked{
    
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
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
