//
//  InvoiceAlterView.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/18.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "InvoiceAlterView.h"
// 设置警告框的长和宽

#define Alertwidth 300.0f
#define Alertheigth 260.0f
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


@interface InvoiceAlterView ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation InvoiceAlterView
{
    UIButton *payBtn;
    BOOL invoiceSelector;
    NSIndexPath *selectIndexPath;
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
+(InvoiceAlterView*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle
{
    InvoiceAlterView *alert = [[InvoiceAlterView alloc] initWithTitle:message leftButtonTitle:nil rightButtonTitle:cancle];
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
       
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -15, 300, 300) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2 || indexPath.row == 4 ||indexPath.row == 6) {
    
    
    if (invoiceSelector && selectIndexPath.row + 1 == indexPath.row) {
        return 130;
        
    }
        return 0;
     //   tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
        
    }
    else{
        return 60;
    }
    
    
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
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        bl.backgroundColor = [UIColor redColor];
        bl.font = [UIFont systemFontOfSize:20];
        [bl setText:@"  发票信息"];
        [bl setTextColor:[UIColor whiteColor]];
        [cell addSubview:bl];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"个人发票";
        payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(0, 0, 20, 20);
        [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = payBtn;
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"公司增票";
        payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(0, 0, 20, 20);
        [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = payBtn;
    }
    if (indexPath.row == 5) {
        cell.textLabel.text = @"公司普票";
        payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(0, 0, 20, 20);
        [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = payBtn;
    }
    
    if (indexPath.row == 7) {
        NSString *leftTitle = @"取消";
        NSString *rigthTitle = @"确定";
        CGRect leftbtnFrame;
        CGRect rightbtnFrame;
        if (!leftTitle) {
            rightbtnFrame = CGRectMake(10, 15, GYZSinglebuttonWidth, GYZbuttonHeigth);
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn.frame = rightbtnFrame;
            
        }else {
            leftbtnFrame = CGRectMake(10, 15, GYZdoublebuttonWidth, GYZbuttonHeigth);
            
            rightbtnFrame = CGRectMake(10+GYZbuttonHeigth+110, 15, GYZdoublebuttonWidth, GYZbuttonHeigth);
            self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //self.leftbtn.backgroundColor = [UIColor redColor];
            self.leftbtn.frame = leftbtnFrame;
            self.rightbtn.frame = rightbtnFrame;
        }
        
        
        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightbtn.backgroundColor = [UIColor redColor];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [self.leftbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 3.0;
        self.leftbtn.layer.borderColor = self.rightbtn.layer.borderColor = [[UIColor redColor] CGColor];
        self.leftbtn.layer.borderWidth = self.rightbtn.layer.borderWidth = 1;
        
        [cell addSubview:self.leftbtn];
        [cell addSubview:self.rightbtn];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 1 || indexPath.row == 3 ||indexPath .row == 5) {
        
        if (!selectIndexPath) {//第一次
            selectIndexPath = indexPath;
       
            _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height+130);

        }
        
    invoiceSelector = !invoiceSelector;
    BOOL isOtherIndex = NO;
    
        if (selectIndexPath.row != indexPath.row) {
            isOtherIndex = YES;
            
            _tableView.frame = CGRectMake(0, -15, 300, 300);
        }
        selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        _tableView.frame = CGRectMake(0, -15, 300, 300);
        if (isOtherIndex && !invoiceSelector) {
            invoiceSelector = YES;
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
             _tableView.frame = CGRectMake(0, -15, 300, 300);
        }
        
    }
    

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
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5+30, Alertwidth, Alertheigth+160);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //视图位置
        self.frame = afterFrame;
        self.alpha=0.9;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
