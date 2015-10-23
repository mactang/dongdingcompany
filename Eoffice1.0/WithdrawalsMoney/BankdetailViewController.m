//
//  BankdetailViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "BankdetailViewController.h"
#import "RDVTabBarController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
@interface BankdetailViewController ()<UIAlertViewDelegate>

@end

@implementation BankdetailViewController
-(instancetype)init{
    if (self = [super init]) {
        self.navigationItem.title = @"银行卡详细";
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIBarButtonItem *releaseButon=[[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    releaseButon.tintColor = [UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem = releaseButon;
    
    UIView *detailview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    detailview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:detailview];
    
    UIImageView *headerimageview = IMAGEVIEW_MYSELF(@"bankcard.png");
    headerimageview.frame = CGRectMake(10, 7, 40, 36);
    [detailview addSubview:headerimageview];
    
    UILabel *bankname = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerimageview.frame)+10, 5, SCREEN_WIDTH/2, 20)];
    bankname.font = [UIFont systemFontOfSize:14];
    bankname.text = _dic[@"bankName"];
    [detailview addSubview:bankname];
    
    UILabel *laterNo = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(bankname), CGRectGetMaxY(bankname.frame), widgetBoundsWidth(bankname), widgetboundsHeight(bankname))];
    laterNo.font = [UIFont systemFontOfSize:13];
    laterNo.textColor = [UIColor grayColor];
    laterNo.text = [NSString stringWithFormat:@"尾号: %@",@"4567"];
    [detailview addSubview:laterNo];
    NSLog(@"%@",_dic);
    
    
}
-(void)rightItemClicked{
    UIWindow * window = [[UIApplication sharedApplication].delegate window ];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.7];
    view.tag=80;
    [window addSubview:view];
    [UIView animateWithDuration:0.3f animations:^{
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT);
    }];
    
    UIView *whiteview = [[UIView alloc]initWithFrame:CGRectMake(15, (SCREEN_HEIGHT-(SCREEN_HEIGHT/6))/2, SCREEN_WIDTH-30, SCREEN_HEIGHT/6)];
    whiteview.backgroundColor = [UIColor whiteColor];
    whiteview.layer.cornerRadius = 4;
    whiteview.clipsToBounds = YES;
    [view addSubview:whiteview];
    UILabel *bankname = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, widgetBoundsWidth(whiteview), widgetboundsHeight(whiteview)*0.37)];
    bankname.backgroundColor = [UIColor colorWithRed:191/255.0 green:35/255.0 blue:29/255.0 alpha:1];
    bankname.text = [NSString stringWithFormat:@"%@(%@)",_dic[@"bankName"],@"4567"];
    bankname.textAlignment = NSTextAlignmentCenter;
    bankname.textColor = [UIColor whiteColor];
    bankname.font = [UIFont systemFontOfSize:14];
    [whiteview addSubview:bankname];
    for (NSInteger i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15+i*((SCREEN_WIDTH-70)/2)+i*10, CGRectGetMaxY(bankname.frame)+10, (SCREEN_WIDTH-70)/2, (widgetboundsHeight(whiteview)-widgetboundsHeight(bankname)-20));
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 4;
        button.layer.borderColor = [[UIColor colorWithRed:191/255.0 green:35/255.0 blue:29/255.0 alpha:1]CGColor];
        button.layer.borderWidth = 1;
        [button setTitle:@"取消" forState:UIControlStateNormal];
        if (i==1) {
            button.backgroundColor =[UIColor colorWithRed:191/255.0 green:35/255.0 blue:29/255.0 alpha:1];
            [button setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            [button setTitleColor: [UIColor colorWithRed:191/255.0 green:35/255.0 blue:29/255.0 alpha:1]forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [whiteview addSubview:button];
    }
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewclick)];
    [view addGestureRecognizer:tapGes];
}
-(void)buttonPressed:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"取消"]) {
        [self viewclick];
    }else{
        [self datarequest];
    }
}
-(void)viewclick{
    UIWindow * window = [[UIApplication sharedApplication].delegate window ];
    UIView *view = (UIView *)[window viewWithTag:80];
    [UIView animateWithDuration:0.3f animations:^{
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}
-(void)datarequest{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path= [NSString stringWithFormat:DELEGATEBANKCARD,COMMON,model.userkey,_dic[@"id"]];
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic[@"info"]);
        UIAlertView *alterview;
        NSString *string;
        if ([dic[@"status"]integerValue]==1) {
            string = @"删除成功";
    }
        else{
            string = @"删除失败";
        }
        alterview  =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alterview.delegate = self;
        [alterview show];
        [hud hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES];
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message isEqualToString:@"删除成功"]) {
         [self viewclick];
        [self leftItemClicked];
        if (_delegate&&[_delegate respondsToSelector:@selector(refreshdatalist)]) {
            [self.delegate refreshdatalist];
        }
    }
}
- (void)leftItemClicked{

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

@end
