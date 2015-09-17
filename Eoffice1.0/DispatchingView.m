//
//  DispatchingView.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/22.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "DispatchingView.h"
#import "CalculateStringSpace.h"
// 设置警告框的长和宽

#define Alertwidth 300.0f
#define Alertheigth 260.0f
#define GYZtitlegap 15.0f
#define GYZtitleofheigth 25.0f
#define GYZSinglebuttonWidth 160.0f
#define UILABEL @"您再15:00之前提交的订单,如果您勾选夜间配送,您的订单将在当晚19:00-22:00点之间送达,么么哒么么哒么么哒么么哒么么哒"
//        单个按钮时的宽度
#define GYZdoublebuttonWidth 130.0f
//        双个按钮的宽度
#define GYZbuttonHeigth 33.0f
//        按钮的高度
#define GYZbuttonbttomgap 10.0f
//        设置按钮距离底部的边距


@interface DispatchingView ()<UITableViewDelegate,UITableViewDataSource>
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


@implementation DispatchingView
{
    UIButton *payBtn;
    UIButton *onerbutton;
    BOOL invoiceSelector;
    NSIndexPath *selectIndexPath;
    UIButton *currentbutton;
    BOOL  sucess;
    BOOL  cellbool;
    UIButton *choosebutton;
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
        invoiceSelector = NO;
        sucess = NO;
        cellbool = NO;
        // Initialization code
    }
    return self;
}
+(DispatchingView*)showmessage:(NSString *)message subtitle:(NSString *)subtitle cancelbutton:(NSString *)cancle
{
    DispatchingView *alert = [[DispatchingView alloc] initWithTitle:message leftButtonTitle:nil rightButtonTitle:cancle];
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
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, 300, 240) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        
        [self addSubview:_tableView];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    
    if (indexPath.row == 2) {
    
        if (invoiceSelector && selectIndexPath.row  == indexPath.row) {
            
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
    NSLog(@"%ld",indexPath.section);
    static NSString *identity = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    cell.clipsToBounds = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        bl.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        bl.font = [UIFont systemFontOfSize:20];
        [bl setText:@"  配送方式"];
        [bl setTextColor:[UIColor whiteColor]];
        [cell addSubview:bl];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"送货上门";
        if (!payBtn) {
             payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        payBtn.frame = CGRectMake(0, 0, 20, 20);
        [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        payBtn.tag = indexPath.row;
        cell.accessoryView = payBtn;
    }
    if (indexPath.row==2) {
        UILabel *deliverylabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 60, 20)];
        deliverylabel.text = @"送货时间 :";
        deliverylabel.textColor = [UIColor blackColor];
        deliverylabel.backgroundColor = [UIColor whiteColor];
        deliverylabel.font = [UIFont systemFontOfSize:13];
        [cell addSubview:deliverylabel];
        
        for (NSInteger i=0; i<2; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(90, 12.5, (SCREEN_WIDTH-135)/2, 25);
            [button setTitle:@"普通" forState:UIControlStateNormal];
            button.layer.borderColor = [[UIColor grayColor]CGColor];
            if (i==1) {
                button.frame = CGRectMake(90+(SCREEN_WIDTH-135)/2+10, 12.5, (SCREEN_WIDTH-135)/2, 25);
                [button setTitle:@"加急配送" forState:UIControlStateNormal];
                button.layer.borderColor = [[UIColor redColor]CGColor];
            }
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.borderWidth = 0.5;
            button.layer.cornerRadius = 3;
            button.tag = 90+i;
            [button addTarget:self action:@selector(deliverchoosePressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
            
            if ([button.titleLabel.text isEqualToString:@"加急配送"]) {
                choosebutton = button;
            }
            
        }
        CGSize size  = [CalculateStringSpace sizeWithString:UILABEL font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH-135, MAXFLOAT)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90, 45, size.width, size.height)];
        label.font = [UIFont systemFontOfSize:13];
        label.text = UILABEL;
        label.numberOfLines = 0;
        [cell addSubview:label];
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"上门自取";
        if (!onerbutton) {
             onerbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        onerbutton.frame = CGRectMake(0, 0, 20, 20);
        [onerbutton setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [onerbutton setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [onerbutton addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        onerbutton.tag = indexPath.row;
        cell.accessoryView = onerbutton;
    }
    
    if (indexPath.row == 4) {
        NSString *leftTitle = @"取消";
        NSString *rigthTitle = @"确定";
        CGRect leftbtnFrame;
        CGRect rightbtnFrame;
        if (!leftTitle) {
            rightbtnFrame = CGRectMake(10, 15, GYZSinglebuttonWidth, GYZbuttonHeigth);
            if (!self.rightbtn) {
                self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            }
            self.rightbtn.frame = rightbtnFrame;
            
        }else {
            leftbtnFrame = CGRectMake(10, 15, GYZdoublebuttonWidth, GYZbuttonHeigth);
            
            rightbtnFrame = CGRectMake(10+GYZbuttonHeigth+110, 15, GYZdoublebuttonWidth, GYZbuttonHeigth);
            if (!self.leftbtn) {
                self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            }
            if (!self.rightbtn) {
                self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            }
            //self.leftbtn.backgroundColor = [UIColor redColor];
            self.leftbtn.frame = leftbtnFrame;
            self.rightbtn.frame = rightbtnFrame;
        }
        
        
        [self.rightbtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.rightbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightbtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.leftbtn setTitle:leftTitle forState:UIControlStateNormal];
        
        [self.leftbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.leftbtn.titleLabel.font = self.rightbtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [self.leftbtn addTarget:self action:@selector(leftbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightbtn addTarget:self action:@selector(rightbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftbtn.layer.masksToBounds = self.rightbtn.layer.masksToBounds = YES;
        self.leftbtn.layer.cornerRadius = self.rightbtn.layer.cornerRadius = 3.0;
        self.leftbtn.layer.borderColor = self.rightbtn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];
        self.leftbtn.layer.borderWidth = self.rightbtn.layer.borderWidth = 1;
        
        [cell addSubview:self.leftbtn];
        [cell addSubview:self.rightbtn];
    }
    
    return cell;
}
-(void)deliverchoosePressed:(UIButton *)button{
    if (choosebutton == button) {
        return;
    }
    choosebutton.selected = NO;
    button.selected = YES;
    if (choosebutton.selected ==NO) {
        choosebutton.layer.borderColor = [[UIColor grayColor]CGColor];
    }
    if (button.selected) {
        button.layer.borderColor = [[UIColor redColor]CGColor];
    }
    choosebutton = button;
}
- (void)isPublicBtnPress:(UIButton*)btn{
    
    if (currentbutton==btn) {
        invoiceSelector = !invoiceSelector;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag+1 inSection:0];
        if (btn.tag!=3) {
            if (!invoiceSelector) {
                [self tableviewmove:self.tableView number:NO];
            }
            if (invoiceSelector) {
                [self tableviewmove:self.tableView number:YES];
            }

        }
        if (btn.tag!=3) {
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        return;
    }
    currentbutton.selected = NO;
    btn.selected = YES;
    currentbutton = btn;
    
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag+1 inSection:0];
    if (!selectIndexPath) {//第一次
        if (btn.tag!=3) {
            [self tableviewmove:self.tableView number:YES];
        }
            cellbool = YES;
    }
    if (selectIndexPath.row!=indexPath.row) {
        sucess = YES;
    }
    
        selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    
    invoiceSelector = !invoiceSelector;
    if (cellbool) {
        if (btn.tag!=3) {
            if (!invoiceSelector) {
                [self tableviewmove:self.tableView number:NO];
            }
            if (invoiceSelector) {
                [self tableviewmove:self.tableView number:YES];
            }
        }
    }
    
    if (sucess &&!invoiceSelector) {
        invoiceSelector = YES;
        if (btn.tag==3) {
            [self tableviewmove:self.tableView number:NO];
        }else{
            [self tableviewmove:self.tableView number:YES];

            
        }
    }
    [_tableView reloadRowsAtIndexPaths:@[selectIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
}
-(void)tableviewmove:(UITableView *)tabelview number:(BOOL)signumber{
    if (signumber) {
        [UIView animateWithDuration:0.3f animations:^{
            tabelview.frame = CGRectMake(tabelview.frame.origin.x, tabelview.frame.origin.y, tabelview.frame.size.width, 370);
        }];
    }
    else{
        [UIView animateWithDuration:0.3f animations:^{
            tabelview.frame = CGRectMake(tabelview.frame.origin.x, tabelview.frame.origin.y, tabelview.frame.size.width, 240);
        }];
        
    }
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
    self.frame = topVC.view.bounds;
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
    CGRect  viewframe = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = viewframe;
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
        self.backimageView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        self.backimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    //    加载背景背景图,防止重复点击
    [topVC.view addSubview:self.backimageView];
    CGRect  viewframe = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //视图位置
        self.frame = viewframe;
        self.alpha=0.9;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}
@end
