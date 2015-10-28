//
//  AllorderviewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/9/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@protocol deletgateOrder <NSObject>
-(void)delegatemethds:(NSString *)orderid;
-(void)deatailGoodId:(NSString *)goodId;
-(void)baifubao:(NSInteger )buttonTag;

@end
@interface AllorderviewCell : UITableViewCell
@property(nonatomic,strong)OrderModel *model;
@property(nonatomic,strong)UIImageView *picimageview;
@property(nonatomic,strong)UILabel *productname;
@property(nonatomic,strong)UILabel *unitPrice;
@property(nonatomic,strong)UILabel *totalPrice;
@property(nonatomic,strong)UILabel *productnumber;
@property(nonatomic,strong)UILabel *Freightmoney;
@property(nonatomic,strong)UILabel *totalnumber;
@property(nonatomic,strong)UILabel *sizecolor;
@property(nonatomic,strong)UIView *lineview;
@property(nonatomic,strong)UIView *anotherview;
@property(nonatomic,strong)UIButton *orderbutton;
@property(nonatomic,strong)UIButton *logisticsbutton;
@property(nonatomic,strong)UIButton *delegatebutton;
@property(nonatomic,strong)UIButton *resultbutton;
@property(nonatomic,strong)UIButton *returnbutton;
@property(nonatomic,strong)UIButton *repairbutton;
@property(nonatomic,strong)UIButton *detailButton;
@property(nonatomic,assign)id<deletgateOrder>delegate;
@end
