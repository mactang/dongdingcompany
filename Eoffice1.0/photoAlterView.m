//
//  photoAlterView.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//
#define ZHToobarHeight 40
#import "photoAlterView.h"
// 设置警告框的长和宽

#define Alertwidth 300.0f
#define Alertheigth 100.0f
#define GYZtitlegap 15.0f
#define GYZtitleofheigth 25.0f
#define GYZSinglebuttonWidth 160.0f
//        单个按钮时的宽度
#define GYZdoublebuttonWidth 130.0f
//        双个按钮的宽度
#define GYZbuttonHeigth 33.0f
//        按钮的高度
#define GYZbuttonbttomgap 10.0f
//        设置按钮距离底部的边距

@interface photoAlterView ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UIView *backimageView;
@property(nonatomic,strong)UITableView *tableView;

@end
@implementation photoAlterView
{
    UIButton *payBtn;
}


+ (CGFloat)alertWidth
{
    return Alertwidth;
}

+ (CGFloat)alertHeight
{
    return Alertheigth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(photoAlterView*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle
{
    photoAlterView *alert = [[photoAlterView alloc] initWithTitle:message leftButtonTitle:nil rightButtonTitle:cancle];
    [alert show];
    alert.rightBlock = ^() {
        NSLog(@"right button clicked");
    };
    alert.dismissBlock = ^() {
        NSLog(@"cancel button clicked");
    };
    return alert;
}
- (id)initWithTitle:(NSString *)title
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5.0;
        self.backgroundColor = [UIColor whiteColor];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -5, 300, 47) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        CGRect leftbtnFrame;
        CGRect rightbtnFrame;
        
        if (!leftTitle) {
            rightbtnFrame = CGRectMake((Alertwidth - GYZSinglebuttonWidth) * 0.5, Alertheigth - GYZbuttonbttomgap - GYZbuttonHeigth, GYZSinglebuttonWidth, GYZbuttonHeigth);
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn.frame = rightbtnFrame;
            
        }else {
            leftbtnFrame = CGRectMake((Alertwidth - 2 * GYZdoublebuttonWidth - GYZbuttonbttomgap) * 0.5, Alertheigth - GYZbuttonbttomgap - GYZbuttonHeigth, GYZdoublebuttonWidth, GYZbuttonHeigth);
            
            rightbtnFrame = CGRectMake(CGRectGetMaxX(leftbtnFrame) + GYZbuttonbttomgap, Alertheigth - GYZbuttonbttomgap - GYZbuttonHeigth, GYZdoublebuttonWidth, GYZbuttonHeigth);
            self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftbtn.frame = leftbtnFrame;
            self.rightbtn.frame = rightbtnFrame;
        }
        
        
        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightbtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [self.leftbtn setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 3.0;
        self.leftbtn.layer.borderColor = self.rightbtn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];
        self.leftbtn.layer.borderWidth = self.rightbtn.layer.borderWidth = 1;
        
        [self addSubview:self.leftbtn];
        [self addSubview:self.rightbtn];
        self.alertTitleLabel.text = title;
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 47;
    
    
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
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        UILabel *phoneBl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        phoneBl.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        phoneBl.font = [UIFont systemFontOfSize:20];
        phoneBl.textAlignment = NSTextAlignmentCenter;
        [phoneBl setText:[NSString stringWithFormat:@"%@",_phoneNumber]];
        [phoneBl setTextColor:[UIColor whiteColor]];
        [cell addSubview:phoneBl];
    }
    
    return cell;
}
- (void)isPublicBtnPress:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    
}
- (void)leftbtnclicked:(id)sender
{
    
    if (self.leftBlock) {
        self.leftBlock();
    }
    [self dismissAlert];
}

- (void)rightbtnclicked:(id)sender
{
    
    if (self.rightBlock) {
        self.rightBlock();
    }
    [self dismissAlert];
}
- (void)show
{   //获取第一响应视图视图
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5, Alertwidth, Alertheigth);
    self.alpha=0;
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    [self.backimageView removeFromSuperview];
    self.backimageView = nil;
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5+30, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-30, Alertwidth, Alertheigth);
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        self.alpha=0;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    //     获取根控制器
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backimageView) {
        self.backimageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backimageView.backgroundColor = [UIColor grayColor];
        self.backimageView.alpha = 0.6f;
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5+30, Alertwidth, Alertheigth);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //视图位置
        self.frame = afterFrame;
        self.alpha=0.9;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}


@end
