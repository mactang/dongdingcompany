//
//  MLKMenuPopover.m
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import "MenuPopover.h"
#import <QuartzCore/QuartzCore.h>
#import "OrderController.h"
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

#define MENU_ITEM_HEIGHT        44
#define FONT_SIZE               15
#define CELL_IDENTIGIER         @"MenuPopoverCell"
#define MENU_TABLE_VIEW_FRAME   CGRectMake(0, 0, frame.size.width, frame.size.height)
#define SEPERATOR_LINE_RECT     CGRectMake(10, MENU_ITEM_HEIGHT - 1, self.frame.size.width - 20, 1)
#define MENU_POINTER_RECT       CGRectMake(frame.origin.x, frame.origin.y, 23, 11)

#define CONTAINER_BG_COLOR      RGBA(0, 0, 0, 0.1f)

#define ZERO                    0.0f
#define ONE                     1.0f
#define ANIMATION_DURATION      0.5f

#define MENU_POINTER_TAG        1011
#define MENU_TABLE_VIEW_TAG     1012

#define LANDSCAPE_WIDTH_PADDING 50

@interface MenuPopover ()

@property(nonatomic,retain) NSArray *menuItems;
@property(nonatomic,retain) UIButton *containerButton;
@property(nonatomic,retain) UIButton  *deleteBtn;
@property(nonatomic,strong)UILabel *numberLb1;
@property(nonatomic, strong)UIButton *numberBtn1;
- (void)hide;
- (void)addSeparatorImageToCell:(UITableViewCell *)cell;

@end

@implementation MenuPopover
{
    int _currentNumber;
    UIButton *selectButton;
    UIButton *versionSelectButton;
}
@synthesize menuPopoverDelegate;
@synthesize menuItems;
@synthesize containerButton;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.menuItems = aMenuItems;
        _currentNumber = 1;
        // Adding Container Button which will take care of hiding menu when user taps outside of menu area
        self.containerButton = [[UIButton alloc] init];
       [self.containerButton setBackgroundColor:CONTAINER_BG_COLOR];
        [self.containerButton addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.containerButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        self.deleteBtn = [[UIButton alloc]init];
       // self.deleteBtn.backgroundColor = [UIColor redColor];
        [self.deleteBtn setTitle:@"X" forState:UIControlStateNormal];
        self.deleteBtn.clipsToBounds = YES;
        self.deleteBtn.layer.cornerRadius = 10;
        self.deleteBtn.layer.borderWidth = 0.8;
        self.deleteBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteBtn setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
        
        
        UITableView *menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 440) style:UITableViewStylePlain];
        
        menuItemsTableView.dataSource = self;
        menuItemsTableView.delegate = self;
       // menuItemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        menuItemsTableView.scrollEnabled = NO;
        menuItemsTableView.backgroundColor = [UIColor greenColor];
        menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Menu_PopOver_BG"]];
        menuItemsTableView.backgroundView = bgView;
        
        [self addSubview:menuItemsTableView];
        
        self.backgroundColor = [UIColor redColor];
        self.frame = CGRectMake(0, 110, 320, 440);
        
        [self.containerButton addSubview:self];
    
       // [self.deleteBtn addSubview:self];
    }
    
    return self;
}

#pragma mark -
#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    else
    return 80;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
     return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = CELL_IDENTIGIER;
    
   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    

    if (indexPath.row == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userIcon"]];
        imageView.frame = CGRectMake(10, 5, 40, 40);
        [cell addSubview:imageView];
        [cell addSubview:imageView];
        
    }
    else if (indexPath.row == 1){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *colorLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 50, 20)];
        [colorLb setText:@"颜色"];
        [colorLb setTextColor:[UIColor grayColor]];
        [cell addSubview:colorLb];
        
        
        UIButton *colorBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(colorLb.frame)+10, 80, 30)];
        colorBtn.backgroundColor = [UIColor whiteColor];
        [colorBtn setTitle:@"雪山白" forState:UIControlStateNormal];
        colorBtn.clipsToBounds = YES;
        colorBtn.layer.cornerRadius = 3;
        colorBtn.layer.borderWidth = 0.8;
        colorBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        [colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [colorBtn addTarget:self action:@selector(colorPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:colorBtn];
        
        UIButton *colorBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(colorBtn.frame)+10, CGRectGetMaxY(colorLb.frame)+10, 80, 30)];
        colorBtn1.backgroundColor = [UIColor whiteColor];
        [colorBtn1 setTitle:@"宾利色" forState:UIControlStateNormal];
        colorBtn1.clipsToBounds = YES;
        colorBtn1.layer.cornerRadius = 3;
        colorBtn1.layer.borderWidth = 0.8;
        colorBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [colorBtn1 addTarget:self action:@selector(colorPress:) forControlEvents:UIControlEventTouchUpInside];
        [colorBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:colorBtn1];
        
        UIButton *colorBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(colorBtn1.frame)+10, CGRectGetMaxY(colorLb.frame)+10, 80, 30)];
        colorBtn2.backgroundColor = [UIColor whiteColor];
        [colorBtn2 setTitle:@"丝绸色" forState:UIControlStateNormal];
        colorBtn2.clipsToBounds = YES;
        colorBtn2.layer.cornerRadius = 3;
        colorBtn2.layer.borderWidth = 0.8;
        colorBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [colorBtn2 addTarget:self action:@selector(colorPress:) forControlEvents:UIControlEventTouchUpInside];
        [colorBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:colorBtn2];

    
    }
    else if (indexPath.row == 2){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *versionLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 50, 20)];
        [versionLb setText:@"版本"];
        [versionLb setTextColor:[UIColor grayColor]];
        [cell addSubview:versionLb];
        
        UIButton *versionBtn = [[UIButton alloc]initWithFrame:CGRectMake(versionLb.frame.origin.x, CGRectGetMaxY(versionLb.frame)+10, 80, 30)];
        versionBtn.backgroundColor = [UIColor whiteColor];
        [versionBtn setTitle:@"128G" forState:UIControlStateNormal];
        versionBtn.clipsToBounds = YES;
        versionBtn.layer.cornerRadius = 3;
        versionBtn.layer.borderWidth = 0.8;
        versionBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        [versionBtn addTarget:self action:@selector(versionPress:) forControlEvents:UIControlEventTouchUpInside];
        [versionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:versionBtn];
        
        UIButton *versionBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(versionBtn.frame)+10, versionBtn.frame.origin.y, 80, 30)];
        versionBtn1.backgroundColor = [UIColor whiteColor];
        [versionBtn1 setTitle:@"32G" forState:UIControlStateNormal];
        versionBtn1.clipsToBounds = YES;
        versionBtn1.layer.cornerRadius = 3;
        versionBtn1.layer.borderWidth = 0.8;
        versionBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [versionBtn1 addTarget:self action:@selector(versionPress:) forControlEvents:UIControlEventTouchUpInside];
        [versionBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:versionBtn1];
        
        UIButton *versionBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(versionBtn1.frame)+10, versionBtn.frame.origin.y, 100, 30)];
        versionBtn2.backgroundColor = [UIColor whiteColor];
        [versionBtn2 setTitle:@"128G(套餐)" forState:UIControlStateNormal];
        versionBtn2.clipsToBounds = YES;
        versionBtn2.layer.cornerRadius = 3;
        versionBtn2.layer.borderWidth = 0.8;
        versionBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [versionBtn2 addTarget:self action:@selector(versionPress:) forControlEvents:UIControlEventTouchUpInside];
        [versionBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell addSubview:versionBtn2];

    }
    else if (indexPath.row == 3){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *numberLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 30)];
        [numberLb setText:@"购买数量"];
        [numberLb setTextColor:[UIColor grayColor]];
        [cell addSubview:numberLb];
        
        _numberBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(numberLb.frame)+80, numberLb.frame.origin.y +10, 30, 30)];
        _numberBtn1.backgroundColor = [UIColor whiteColor];
        
        _numberBtn1.clipsToBounds = YES;
        _numberBtn1.layer.cornerRadius = 3;
        _numberBtn1.layer.borderWidth = 0.8;
        _numberBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [_numberBtn1 setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        [_numberBtn1 addTarget:self action:@selector(numBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        _numberBtn1.tag = 1;
        [cell addSubview:_numberBtn1];
        
        UIButton *numberBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+60, _numberBtn1.frame.origin.y, 30, 30)];
        numberBtn2.backgroundColor = [UIColor whiteColor];
        [numberBtn2 setImage:[UIImage imageNamed:@"圆角矩形-3-2"] forState:UIControlStateNormal];        numberBtn2.clipsToBounds = YES;
        numberBtn2.layer.cornerRadius = 3;
        numberBtn2.layer.borderWidth = 0.8;
        numberBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [numberBtn2 addTarget:self action:@selector(numBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        numberBtn2.tag = 2;
        [cell addSubview:numberBtn2];
        
        _numberLb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+5, _numberBtn1.frame.origin.y, 50, 30)];
        _numberLb1.backgroundColor = [UIColor whiteColor];
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
        [_numberLb1 setText:string];
        [_numberLb1 setTextColor:[UIColor blackColor]];
        _numberLb1.clipsToBounds = YES;
        _numberLb1.layer.cornerRadius = 3;
        _numberLb1.layer.borderWidth = 0.8;
        _numberLb1.layer.borderColor = [[UIColor grayColor] CGColor];;
        
        [cell addSubview:_numberLb1];
    }
    else if (indexPath.row == 4){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *shopCarBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        // [shopCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
        shopCarBtn.backgroundColor = [UIColor colorWithRed:200/255.0 green:3/255.0 blue:3/255.0 alpha:1];
        shopCarBtn.font = [UIFont systemFontOfSize:12];
        shopCarBtn.clipsToBounds = YES;
        shopCarBtn.layer.cornerRadius = 6;
        shopCarBtn.tag = 2000;
        shopCarBtn.selected = YES;
        // [shopCarBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
        [shopCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shopCarBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:shopCarBtn];
        
        UIButton *shopCarBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, 20, 20)];
        [shopCarBtn1 setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
        [shopCarBtn addSubview:shopCarBtn1];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 22, 30, 20)];
        lb1.font = [UIFont systemFontOfSize:10];
        lb1.text = @"购物车";
        lb1.textColor = [UIColor whiteColor];
        [shopCarBtn addSubview:lb1];
        
        UIButton *InShopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shopCarBtn.frame)+8, 5, 120, 40)];
        [InShopBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        InShopBtn.backgroundColor = [UIColor colorWithRed:203/255.0 green:103/255.0 blue:103/255.0 alpha:1];
        InShopBtn.clipsToBounds = YES;
        InShopBtn.layer.cornerRadius = 6;
        InShopBtn.tag = 2001;
        InShopBtn.selected = YES;
        [InShopBtn setImage:[UIImage imageNamed:@"jiaru"] forState:UIControlStateNormal];
        [InShopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [InShopBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:InShopBtn];
        
        UIButton *shopBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(InShopBtn.frame)+8, 5, 120, 40)];
        [shopBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
        shopBtn.backgroundColor = [UIColor colorWithRed:207/255.0 green:134/255.0 blue:65/255.0 alpha:1];
        shopBtn.clipsToBounds = YES;
        shopBtn.layer.cornerRadius = 6;
        shopBtn.tag = 2002;
        [shopBtn setImage:[UIImage imageNamed:@"lijigoumai"] forState:UIControlStateNormal];
        [shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [shopBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:shopBtn];

    }
    
   
    
    return cell;
}
-(void)colorPress:(UIButton *)btn{
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
-(void)versionPress:(UIButton *)btn{
    if (versionSelectButton == btn) {
        return;
    }
    versionSelectButton.selected = NO;
    btn.selected = YES;
    if(versionSelectButton.selected == NO){
        versionSelectButton.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    if (btn.selected) {
        
        btn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];
        
    }
    versionSelectButton = btn;
}

-(void)shopPress:(UIButton *)btn{
    if (btn.tag == 2000) {
        NSLog(@";;;");

    }
    else if (btn.tag == 2001){
        NSLog(@";;;");

    }
    else if (btn.tag == 2002){
        
            [self hide];
            [self.menuPopoverDelegate menuPopover:self];
        NSLog(@";;;");
    }
    
}
-(int)numBtnPress:(UIButton *)btn{
    
    
    if (btn.tag ==1) {
        if (_currentNumber>1) {
            
            
            _currentNumber--;
            NSLog(@"%d",_currentNumber);
            
            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
            [_numberLb1 setText:string];
        }
    }
    if (btn.tag == 2) {
        _currentNumber++;
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
        [_numberLb1 setText:string];
    }
    
    
    return _currentNumber;
}

#pragma mark -
#pragma mark UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self hide];
//    [self.menuPopoverDelegate menuPopover:self didSelectMenuItemAtIndex:indexPath.row];
//}

#pragma mark -
#pragma mark Actions

- (void)dismissMenuPopover
{
    [self hide];
}

- (void)showInView:(UIView *)view
{
    self.containerButton.alpha = ZERO;
    self.deleteBtn.alpha = ZERO;
    self.containerButton.frame = view.bounds;
    self.deleteBtn.frame = CGRectMake(280, 120, 30, 30);
    //self.containerButton.backgroundColor = [UIColor redColor];
    [view addSubview:self.containerButton];
    [view addSubview:self.deleteBtn];
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ONE;
                         self.deleteBtn.alpha = ONE;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)hide
{
    [UIView animateWithDuration:ANIMATION_DURATION
                     animations:^{
                         self.containerButton.alpha = ZERO;
                         self.deleteBtn.alpha = ZERO;
                     }
                     completion:^(BOOL finished) {
                         [self.containerButton removeFromSuperview];
                         [self.deleteBtn removeFromSuperview];
                     }];
}

#pragma mark -
#pragma mark Separator Methods

- (void)addSeparatorImageToCell:(UITableViewCell *)cell
{
    UIImageView *separatorImageView = [[UIImageView alloc] initWithFrame:SEPERATOR_LINE_RECT];
    [separatorImageView setImage:[UIImage imageNamed:@"DefaultLine"]];
    separatorImageView.opaque = YES;
    [cell.contentView addSubview:separatorImageView];
}

#pragma mark -
#pragma mark Orientation Methods

//- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    BOOL landscape = (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//    
//    UIImageView *menuPointerView = (UIImageView *)[self.containerButton viewWithTag:MENU_POINTER_TAG];
//    UITableView *menuItemsTableView = (UITableView *)[self.containerButton viewWithTag:MENU_TABLE_VIEW_TAG];
//    
//    if( landscape )
//    {
//        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
//        
//        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x + LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
//    }
//    else
//    {
//        menuPointerView.frame = CGRectMake(menuPointerView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuPointerView.frame.origin.y, menuPointerView.frame.size.width, menuPointerView.frame.size.height);
//        
//        menuItemsTableView.frame = CGRectMake(menuItemsTableView.frame.origin.x - LANDSCAPE_WIDTH_PADDING, menuItemsTableView.frame.origin.y, menuItemsTableView.frame.size.width, menuItemsTableView.frame.size.height);
//    }
//}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
