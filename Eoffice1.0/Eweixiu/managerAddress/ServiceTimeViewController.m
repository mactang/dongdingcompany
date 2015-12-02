//
//  ServiceTimeViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ServiceTimeViewController.h"
#import "TarBarButton.h"
#import "ButtonHeaderController.h"
#import "MapChooseViewController.h"
#import "DataPickerView.h"
#import "OrederConfirmViewController.h"
@interface ServiceTimeViewController ()<UITableViewDataSource,UITableViewDelegate,AppointmentDelegate,UITextViewDelegate>{
    UITableView *_tableview;
    UILabel *textlabel;
}
@end
@implementation ServiceTimeViewController
-(void)setNaviTitle:(NSString *)naviTitle{
    _naviTitle = naviTitle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"zuo"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = _naviTitle;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.scrollEnabled = NO;
//  _tableview.showsVerticalScrollIndicator =
//    NO;
//  _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [_tableview registerClass:[ButtonHeaderController class] forHeaderFooterViewReuseIdentifier:@"Myheader"];
    [self.view addSubview:_tableview];
    [self setExtraCellLineHidden:_tableview];
   
}
#pragma mark - TQTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = @[[NSArray arrayWithObjects:@"丰德国际广场B1座12楼",@"15923459876",nil],@"请选择服务时间",@"备注",];
    UILabel *titlelabel;
    static NSString *ID =@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row!=2) {
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (!titlelabel) {
        titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
        titlelabel.font  =[UIFont systemFontOfSize:14];
        if (indexPath.row==0) {
            titlelabel.textColor = [UIColor blackColor];
            titlelabel.text = array[indexPath.row][0];
            UILabel *phonelabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(titlelabel), CGRectGetMaxY(titlelabel.frame), widgetBoundsWidth(titlelabel), widgetboundsHeight(titlelabel))];
            phonelabel.text = array[indexPath.row][1];
            phonelabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:phonelabel];
        }
        else{
            titlelabel.textColor = [UIColor grayColor];
            titlelabel.text = array[indexPath.row];
            if (indexPath.row==2) {
                textlabel = titlelabel;
                UITextView *textview = [[UITextView alloc]init];
                textview.frame = CGRectMake(widgetFrameX(titlelabel)-4, widgetFrameY(titlelabel), widgetBoundsWidth(titlelabel),130);
                textview.scrollEnabled = YES;
                textview.editable = YES;
                textview.textColor = [UIColor blackColor];
                textview.delegate = self;
                textview.tag = 166;
                textview.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:textview];
            }
        }
        [cell.contentView addSubview:titlelabel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark_UITextViewdelegate_meathds
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        textlabel.text = @"备注";
    }else{
        textlabel.text = @"";
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 80;
    }
    if (indexPath.row==2) {
        return 150;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        ButtonHeaderController *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Myheader"];
        headerview.sectionstring = @"提交订单";
        headerview.delegate = self;
        return headerview;
    }
    else{
        return nil;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        MapChooseViewController *mapchoose = [[MapChooseViewController alloc]init];
        [self.navigationController pushViewController:mapchoose animated:YES];
    }
    if (indexPath.row==1) {
        DataPickerView *datapicker = [[DataPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
        datapicker.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self.view addSubview:datapicker];
        [UIView animateWithDuration:0.3f animations:^{
            datapicker.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
      
    }
}
-(void)chooseAddressed{
    OrederConfirmViewController *orederconfirm = [[OrederConfirmViewController alloc]init];
    [self.navigationController pushViewController:orederconfirm animated:YES];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

@end
