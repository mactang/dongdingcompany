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


@interface InvoiceAlterView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
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
    UIButton *currentbutton;
    BOOL  sucess;
    BOOL  cellbool;
    UIButton *selectButton;
    NSString *chooseType;
    UIButton *typeButton;
    BOOL keepInfor;
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
        keepInfor = NO;
        chooseType = @"明细";
        self.layer.cornerRadius = 5.0;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -15, 300, 240) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
    
    
    if (invoiceSelector && selectIndexPath.row   == indexPath.row) {
        return 190;
        
    }
        
        return 0;
        
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        bl.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        bl.font = [UIFont systemFontOfSize:20];
        [bl setText:@"  发票信息"];
        [bl setTextColor:[UIColor whiteColor]];
        [cell addSubview:bl];
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"开发票";
        payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(0, 0, 20, 20);
        [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        payBtn.tag = indexPath.row;
        [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = payBtn;
    }
    if (indexPath.row == 2) {
        
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 60, 20)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.text = @"发票抬头:";
        lb.textColor = [UIColor blackColor];
        [cell addSubview:lb];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb.frame), 12, 202, 25)];
        textField.clipsToBounds = YES;
        textField.layer.cornerRadius = 2;
        textField.layer.borderWidth = 1;
        textField.delegate = self;
        textField.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1]CGColor];
        [cell addSubview:textField];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(textField.frame)+18, 60, 20)];
        lb1.font = [UIFont systemFontOfSize:12];
        lb1.text = @"发票内容:";
        lb1.textColor = [UIColor blackColor];
        [cell addSubview:lb1];
        for (int i = 0; i<4; i++) {
            
         NSArray *array = @[@"明细",@"办公用品",@"电脑配件",@"耗材"];
            
        typeButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame)+(i%2)*((SCREEN_WIDTH-138)/2)+(i%2)*15, CGRectGetMaxY(textField.frame)+18+(i/2)*35, 98, 25)];
        typeButton.clipsToBounds = YES;
        typeButton.layer.cornerRadius = 2;
        typeButton.layer.borderWidth = 1;
        [typeButton setTitle:array[i] forState:UIControlStateNormal];
        [typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        typeButton.font = [UIFont systemFontOfSize:10];
            if ([array[i] isEqualToString:chooseType]) {
                typeButton.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1]CGColor];
                selectButton = typeButton;
            }else{
                typeButton.layer.borderColor = [[UIColor grayColor]CGColor];
            }
        typeButton.tag = i+10;
        [typeButton addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:typeButton];
            
        }
        
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(76, CGRectGetMaxY(textField.frame)+100, 98, 25)];
        button1.clipsToBounds = YES;
        button1.layer.cornerRadius = 2;
        button1.layer.borderWidth = 1;
        [button1 setTitle:@"保存发票信息" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button1.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        button1.font = [UIFont systemFontOfSize:12];
        button1.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1]CGColor];
        [button1 addTarget:self action:@selector(keepBtn) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button1];
        
        UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button1.frame)+5, CGRectGetMaxY(textField.frame)+100, 40, 25)];
        button2.clipsToBounds = YES;
        button2.layer.cornerRadius = 2;
        button2.layer.borderWidth = 1;
        [button2 setTitle:@"取消" forState:UIControlStateNormal];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button2.backgroundColor = [UIColor whiteColor];
        button2.font = [UIFont systemFontOfSize:12];
        button2.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:button2];
        
    }
    if (indexPath.row == 3) {
        
       
        cell.textLabel.text = @"不开发票";
        payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(0, 0, 20, 20);
        [payBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [payBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [payBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = payBtn;
        payBtn.tag = indexPath.row;
    }
    
    if (indexPath.row == 4) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        [cell addSubview:self.leftbtn];
        [cell addSubview:self.rightbtn];
    }
    
    return cell;
}
-(void)keepBtn{
    
 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    
    
    
    
    invoiceSelector = !invoiceSelector;
    BOOL isOtherIndex = NO;
    
    if (selectIndexPath.row != indexPath.row) {
        isOtherIndex = YES;
        
        [self tableviewmove:self.tableView number:NO];
    }
    selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self tableviewmove:self.tableView number:NO];
    if (isOtherIndex && !invoiceSelector) {
        invoiceSelector = YES;
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self tableviewmove:self.tableView number:NO];
        
    }
    
}
-(void)pressBtn:(UIButton *)btn{
    
    NSLog(@"%@",btn.titleLabel.text);
    chooseType = btn.titleLabel.text;
    if (selectButton == btn) {
        return;
    }
    selectButton.selected = NO;
    btn.selected = YES;
    if(selectButton.selected == NO){
        selectButton.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    if (btn.selected) {
        
        btn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];
        
    }
    selectButton = btn;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
 _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    if (indexPath.row == 1) {
//        
//        if (!selectIndexPath) {//第一次
//            selectIndexPath = indexPath;
//       
//            _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height+130);
//
//        }
//        
//    invoiceSelector = !invoiceSelector;
//    BOOL isOtherIndex = NO;
//    
//        if (selectIndexPath.row != indexPath.row) {
//            isOtherIndex = YES;
//            
//            _tableView.frame = CGRectMake(0, -15, 300, 300);
//        }
//        selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        _tableView.frame = CGRectMake(0, -15, 300, 300);
//        if (isOtherIndex && !invoiceSelector) {
//            invoiceSelector = YES;
//            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//            
//             _tableView.frame = CGRectMake(0, -15, 300, 300);
//        }
//        
//    }
//    

}
- (void)isPublicBtnPress:(UIButton*)btn{
    
    NSArray *array = @[@"开发票",@"不开发票"];
    
    int i;
    if (btn.tag == 1) {
        i = 0;
    }else{
    
        i = 1;
    }
    NSString *string = [NSString stringWithFormat:@"%@",array[i]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"invoice" object:string];
    
    
    
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
            tabelview.frame = CGRectMake(tabelview.frame.origin.x, tabelview.frame.origin.y, tabelview.frame.size.width, 430);
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
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-20, Alertwidth, Alertheigth+160);
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
