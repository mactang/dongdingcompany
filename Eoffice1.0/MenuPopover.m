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
#import "SingleModel.h"
#import "AFNetworking.h"
#import "LoginViewController.h"
#import "CMDetailsViewController.h"
#import "UIImageView+WebCache.h"
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

@interface MenuPopover ()<UITextFieldDelegate>{
    BOOL loginsucess;
}
@property(nonatomic,retain) UIButton  *deleteBtn;
//@property(nonatomic,strong)UILabel *numberLb1;
@property(nonatomic, strong)UIButton *numberBtn1;
@property(nonatomic,strong)UITextField *textfield;
@end
@implementation MenuPopover
{
    NSInteger _currentNumber;
    UIButton *versionSelectButton;
    UITableView *menuItemsTableView;
    NSMutableDictionary *dicdata;

}
- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)aMenuItems
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        NSLog(@"%@",self.dic)
        ;
        [self data];
        dicdata = [NSMutableDictionary dictionary];
        self.backgroundColor =  [[UIColor grayColor]colorWithAlphaComponent:0.5];
        _currentNumber = 1;
        
    }
    
    return self;
}
-(void)initalizeapprance{
    menuItemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, widgetboundsHeight(self)-200) style:UITableViewStylePlain];
    menuItemsTableView.dataSource = self;
    menuItemsTableView.delegate = self;
    menuItemsTableView.scrollEnabled = NO;
   // menuItemsTableView.backgroundColor = [UIColor greenColor];
    menuItemsTableView.tag = MENU_TABLE_VIEW_TAG;
    if ([menuItemsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [menuItemsTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([menuItemsTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [menuItemsTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self addSubview:menuItemsTableView];

}
//-(void)requestdata{
//    SingleModel *model = [SingleModel sharedSingleModel];
//    NSString *path = [NSString stringWithFormat:PRODUCTMESSAGE,COMMON,model.goodsId];
// 
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dic);
//        [editionArray addObjectsFromArray:dic[@"data"]];
//        [self data];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//
//}
-(void)data{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *path = [NSString stringWithFormat:MAINTAINDETAIL,COMMON,model.paraId,model.goodsId,model.cPartnerId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [dicdata setDictionary:dic[@"data"]];
        [self initalizeapprance];
        [menuItemsTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}
#pragma mark UITableViewDatasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }
    if (indexPath.row==1) {
        if ([self.dic[@"version"]count]==0) {
            menuItemsTableView.frame = CGRectMake(0, SCREEN_HEIGHT-90-130-64-35, SCREEN_WIDTH, 90+130+64+35);
            return 35;
        }
        if ([self.dic[@"version"] count]==1) {
            menuItemsTableView.frame = CGRectMake(0, SCREEN_HEIGHT-90-130-64-35-35, SCREEN_WIDTH, 90+130+64+35+35);
            return 70;
        }
        if ([self.dic[@"version"]count]%2==0) {
            menuItemsTableView.frame = CGRectMake(0, SCREEN_HEIGHT-35*(([self.dic[@"version"]count])/2)-90-130-64-35, SCREEN_WIDTH, 35*(([self.dic[@"version"]count])/2)+90+130+64+35);
            return 35+35*(([self.dic[@"version"]count])/2);
            
        }
        else{
            menuItemsTableView.frame = CGRectMake(0, SCREEN_HEIGHT-35*(([self.dic[@"version"]count])/2+1)-90-130-64-35, SCREEN_WIDTH, 35*(([self.dic[@"version"]count])/2+1)+90+130+64+35);
            return 35+35*(([self.dic[@"version"]count])/2+1);
        }
    }
    if (indexPath.row==3) {
        return 60;
    }
    return 70;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
     return 4;
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
        
        self.deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-40, 5, 30, 30)];
        [self.deleteBtn setImage:[UIImage imageNamed:@"cha1"] forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.deleteBtn addTarget:self action:@selector(dismissMenuPopover) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:self.deleteBtn];
        
        UILabel *pricelable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, 15, SCREEN_WIDTH-110, 25)];
        pricelable.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        pricelable.font = [UIFont systemFontOfSize:16];
        pricelable.text = [NSString stringWithFormat:@"￥%.2f",[dicdata[@"price"]floatValue]];
        [cell addSubview:pricelable];
        
        UILabel *stocklabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(pricelable), CGRectGetMaxY(pricelable.frame)+5, widgetBoundsWidth(pricelable), widgetboundsHeight(pricelable))];
        stocklabel.textColor = [UIColor grayColor];
        stocklabel.font = [UIFont systemFontOfSize:16];
        stocklabel.text = [NSString stringWithFormat:@"库存%@件",dicdata[@"wgoodsId"]];
        [cell addSubview:stocklabel];
    }
    else if (indexPath.row == 1){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *versionLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 50, 20)];
        [versionLb setText:@"版本"];
        [versionLb setTextColor:[UIColor grayColor]];
        [cell addSubview:versionLb];
        
        for (NSInteger i=0; i<[self.dic[@"version"]count]; i++) {
            UIButton *editionbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            editionbutton.frame = CGRectMake(15+(i%2)*((SCREEN_WIDTH-40)/2)+(i%2)*10, CGRectGetMaxY(versionLb.frame)+5+(i/2)*35, (SCREEN_WIDTH-40)/2, 30);
            editionbutton.backgroundColor = [UIColor whiteColor];
            [editionbutton setTitle:self.dic[@"version"][i][@"maValue"] forState:UIControlStateNormal];
            editionbutton.titleLabel.font = [UIFont systemFontOfSize:13];
            editionbutton.layer.cornerRadius = 3;
            editionbutton.layer.borderWidth = 0.5;
            editionbutton.layer.borderColor = [[UIColor grayColor]CGColor];
            [editionbutton addTarget:self action:@selector(versionPress:) forControlEvents:UIControlEventTouchUpInside];
            [editionbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (i==0) {
                versionSelectButton = editionbutton;
                editionbutton.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];

            }
            [cell addSubview:editionbutton];
        }
        
    }
    else if (indexPath.row == 2){
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
        
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+5, widgetFrameY(_numberBtn1), 50, 30)];
        self.textfield.text = [NSString stringWithFormat:@"%ld",_currentNumber];
        self.textfield.delegate = self;
        self.textfield.textColor = [UIColor blackColor];
        self.textfield.textAlignment = NSTextAlignmentCenter;
        self.textfield.layer.cornerRadius = 3;
        self.textfield.layer.borderWidth = 0.8;
        self.textfield.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:self.textfield];

    }
    else if (indexPath.row == 3){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.intcart == YES) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 40);
            button.layer.cornerRadius = 4;
            button.layer.borderColor = [[UIColor redColor]CGColor];
            button.layer.borderWidth = 0.5;
            [button setTitle:@"确认" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
            button.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            [button addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:button];
        }
        else{
            UIButton *shopCarBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
            // [shopCarBtn setTitle:@"购物车" forState:UIControlStateNormal];
            shopCarBtn.backgroundColor = [UIColor colorWithRed:200/255.0 green:3/255.0 blue:3/255.0 alpha:1];
            shopCarBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            shopCarBtn.clipsToBounds = YES;
            shopCarBtn.layer.cornerRadius = 6;
            shopCarBtn.tag = 2000;
            shopCarBtn.selected = YES;
            // [shopCarBtn setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
            [shopCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [shopCarBtn addTarget:self action:@selector(shopcartPressed:) forControlEvents:UIControlEventTouchUpInside];
            shopCarBtn.tag = 80;
            [cell addSubview:shopCarBtn];
            UIButton *shopCarBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, 20, 20)];
            [shopCarBtn1 setImage:[UIImage imageNamed:@"gouwuche"] forState:UIControlStateNormal];
            shopCarBtn1.userInteractionEnabled = NO;
            [shopCarBtn addSubview:shopCarBtn1];
            
            UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 22, 30, 20)];
            lb1.font = [UIFont systemFontOfSize:10];
            lb1.text = @"购物车";
            lb1.userInteractionEnabled = NO;
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
            shopBtn.selected = NO;
            shopBtn.layer.cornerRadius = 6;
            shopBtn.tag = 2002;
            [shopBtn setImage:[UIImage imageNamed:@"lijigoumai"] forState:UIControlStateNormal];
            [shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [shopBtn addTarget:self action:@selector(shopPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:shopBtn];
        }
    }
    
    return cell;
}

//设置分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
#pragma mark - UItextfieldelegate methds
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    _currentNumber = [text intValue];
    if (string.length == 0) {
        return YES;
    }
    return YES;
}
-(void)shopcartPressed:(UIButton *)button{
    if (_delegate &&[_delegate respondsToSelector:@selector(clickshopcratbutton)]) {
        [self.delegate clickshopcratbutton];
    }
}
-(void)shopPress:(UIButton *)btn{
    
    if (self.Distinguish||btn.selected ==YES) {
        if (_delegate &&[_delegate respondsToSelector:@selector(pushlogincontroller:shopnumber:)]) {
            [_delegate pushlogincontroller:YES shopnumber:_currentNumber];
    }

}
    else{
        if (_delegate &&[_delegate respondsToSelector:@selector(pushlogincontroller:shopnumber:)]) {
            [_delegate pushlogincontroller:NO shopnumber:_currentNumber];
    }
  }
}
-(NSInteger)numBtnPress:(UIButton *)btn{
    
    
    if (btn.tag ==1) {
        if (_currentNumber>1) {
            _currentNumber--;
            NSLog(@"%ld",_currentNumber);
            
            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%ld",_currentNumber]];
            [self.textfield setText:string];
        }
    }
    if (btn.tag == 2) {
        _currentNumber++;
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%ld",_currentNumber]];
        [self.textfield setText:string];
    }
    return _currentNumber;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    [UIView animateWithDuration:0.4f animations:^{
         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 1);
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
        
    }];
}
-(void)dismissMenuPopover{
    [UIView animateWithDuration:0.4f animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
////取得当前view的控制器
//- (UIViewController*)viewController {
//    for (UIView* next = [self superview]; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController*)nextResponder;
//        }
//    }
//    return nil;
//}

@end

