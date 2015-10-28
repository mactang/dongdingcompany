//
//  AllorderviewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/9/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "AllorderviewCell.h"
#import "UIKit+AFNetworking.h"
#import "OrderModel.h"
#import "CalculateStringSpace.h"
#import "SingleModel.h"
@interface AllorderviewCell(){
    NSString *stringmodel;
    NSString *goodId;
}
@end
@implementation AllorderviewCell

{
    
    NSString *wgoodsId;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.detailButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, SCREEN_WIDTH*0.13+16)];
        [self.detailButton addTarget:self action:@selector(detailButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        self.detailButton.userInteractionEnabled = YES;
        [self.contentView addSubview:self.detailButton];
        
        self.picimageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH*0.14, SCREEN_WIDTH*0.13)];
        [self.detailButton addSubview:self.picimageview];
        
        self.unitPrice = [[UILabel alloc]init];
        [self.detailButton addSubview:self.unitPrice];
        
        self.productname = [[UILabel alloc]init];
        [self.detailButton addSubview:self.productname];
        
        self.totalPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.totalPrice];
        
        self.sizecolor = [[UILabel alloc]init];
        [self.detailButton addSubview:self.sizecolor];
        
        self.productnumber = [[UILabel alloc]init];
        [self.detailButton addSubview:self.productnumber];
        
        self.lineview = [[UIView alloc]init];
        [self.contentView addSubview:self.lineview];
        
        self.totalPrice = [[UILabel alloc]init];
        [self.contentView addSubview:self.totalPrice];
        
        self.totalnumber = [[UILabel alloc]init];
        [self.contentView addSubview:self.totalnumber];
        
        self.anotherview = [[UIView alloc]init];
        [self.contentView addSubview:self.anotherview];
        
        self.orderbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.orderbutton];
        
        self.logisticsbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.logisticsbutton];
        
        self.delegatebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.delegatebutton];
        
        self.resultbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.resultbutton];
        
        self.returnbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.returnbutton];
        
        self.repairbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.repairbutton];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 10)];
        view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
        [self.contentView addSubview:view];
        
        
        
    }
    return self;
}

-(void)detailButtonPress:(UIButton *)btn{

    NSLog(@"mmmm");
    if (_delegate&&[_delegate respondsToSelector:@selector(deatailGoodId:)]) {
        [self.delegate deatailGoodId:goodId];
    }


}
-(void)setModel:(OrderModel *)model{
    
    NSLog(@"%@",model);
    NSLog(@"%@",model.list[0][@"wgoodsId"]);
    goodId = model.list[0][@"goodsId"];
    wgoodsId = model.list[0][@"wgoodsId"];
    [self.picimageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.list[0][@"imgurl"]]]];
    
    CGSize unitsize = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"￥%.2f",[model.list[0][@"price"]floatValue]] font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH-widgetBoundsWidth(self.picimageview)-25-100, 25)];
    self.unitPrice.frame = CGRectMake(SCREEN_WIDTH-unitsize.width-5, 10, unitsize.width, unitsize.height);
    self.unitPrice.numberOfLines = 1;
    self.unitPrice.font = [UIFont systemFontOfSize:13];
    self.unitPrice.text = [NSString stringWithFormat:@"￥%.2f",[model.list[0][@"price"]floatValue]];
    
    CGSize productsize = [CalculateStringSpace sizeWithString:model.list[0][@"name"]font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH-widgetBoundsWidth(self.picimageview)-widgetBoundsWidth(self.unitPrice)-35, 35)];
    self.productname.frame = CGRectMake(CGRectGetMaxX(self.picimageview.frame)+10, widgetFrameY(self.picimageview), productsize.width, productsize.height);
    self.productname.font = [UIFont systemFontOfSize:13];
    self.productname.numberOfLines = 2;
    self.productname.text = model.list[0][@"name"];
    
    self.sizecolor.frame = CGRectMake(widgetFrameX(self.productname), CGRectGetMaxY(self.productname.frame)+2, SCREEN_WIDTH/2+20, 20);
    self.sizecolor.font = [UIFont systemFontOfSize:13];
    //self.sizecolor.text = @"颜色: 粉红色  尺寸:128G";
    self.sizecolor.text = [NSString stringWithFormat:@"颜色: %@  尺寸:128G",model.list[0][@"color"]];
    self.productnumber.frame = CGRectMake(SCREEN_WIDTH-70, CGRectGetMaxY(self.productname.frame)+10, 65, 20);
    self.productnumber.font = [UIFont systemFontOfSize:14];
    self.productnumber.textAlignment =NSTextAlignmentRight;
    self.productnumber.text = @"x1";
    
    self.lineview.frame = CGRectMake(5, CGRectGetMaxY(self.productnumber.frame)+2, SCREEN_WIDTH-10, 0.5);
    self.lineview.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    
    NSMutableAttributedString *totalstring = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"合计:￥%.2f",[model.totalFee floatValue]]];
    [totalstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:204.0/255.0 green:0/255.0 blue:0/255.0 alpha:1] range:NSMakeRange(0, 3)];
    CGSize totalprice = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"合计:￥%.2f",[model.totalFee floatValue]] font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH/2, 20)];
    self.totalPrice.frame = CGRectMake(SCREEN_WIDTH-totalprice.width-5, CGRectGetMaxY(self.lineview.frame)+10, totalprice.width, totalprice.height);
    self.totalPrice.font = [UIFont systemFontOfSize:13];
    self.totalPrice.numberOfLines = 1;
    self.totalPrice.text =[NSString stringWithFormat:@"合计:￥%.2f",[model.totalFee floatValue]];
    self.totalPrice.attributedText = totalstring;
    
    self.totalnumber.frame = CGRectMake(10, widgetFrameY(self.totalPrice), SCREEN_WIDTH-widgetBoundsWidth(self.totalPrice)-25, widgetboundsHeight(self.totalPrice));
    self.totalnumber.font = [UIFont systemFontOfSize:13];
    self.totalnumber.text = [NSString stringWithFormat:@"共%@件商品 运费:￥30.00",model.totalCount];
    self.totalnumber.textAlignment = NSTextAlignmentRight;
    
    self.anotherview.frame = CGRectMake(5, CGRectGetMaxY(self.totalnumber.frame)+10, SCREEN_WIDTH-10, 0.5);
    self.anotherview.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    
    self.orderbutton.frame = CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-70)/4-10, widgetFrameY(self.anotherview)+10, (SCREEN_WIDTH-70)/4, SCREEN_WIDTH/12);
    self.orderbutton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    self.orderbutton.layer.cornerRadius = 3;
    self.orderbutton.layer.borderWidth = 0.5;
    self.orderbutton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.orderbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.orderbutton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    if ([model.orderDescription isEqualToString:@"待付款"]) {
        [self.orderbutton setTitle:@"马上付款" forState:UIControlStateNormal];
    }
    if ([model.orderDescription isEqualToString:@"待收货"]) {
        [self.orderbutton setTitle:@"确认收货" forState:UIControlStateNormal];
    }
    if ([model.orderDescription isEqualToString:@"待发货"]) {
        [self.orderbutton setTitle:@"提醒发货" forState:UIControlStateNormal];
    }
    if ([model.orderDescription isEqualToString:@"已完成"]) {
        [self.orderbutton setTitle:@"马上评价" forState:UIControlStateNormal];
    }
    if ([model.orderDescription isEqualToString:@"申请退货中"]) {
        [self.orderbutton setTitle:@"马上评价" forState:UIControlStateNormal];
        self.orderbutton.backgroundColor = [UIColor whiteColor];
    }
    NSLog(@"%@",model.orderDescription);
    
    self.logisticsbutton.frame = CGRectMake(widgetFrameX(self.orderbutton)-widgetBoundsWidth(self.orderbutton)-5, widgetFrameY(self.orderbutton), widgetBoundsWidth(self.orderbutton), widgetboundsHeight(self.orderbutton));
    [self.logisticsbutton setTitle:@"查看物流" forState:UIControlStateNormal];
    [self.logisticsbutton setTitleColor:[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1] forState:UIControlStateNormal];
    self.logisticsbutton.layer.cornerRadius = 3;
    self.logisticsbutton.layer.borderWidth = 0.5;
    self.logisticsbutton.clipsToBounds = YES;
    self.logisticsbutton.layer.borderColor = [[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1]CGColor];
    self.logisticsbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.logisticsbutton addTarget:self action:@selector(LogisticsPrss) forControlEvents:UIControlEventTouchUpInside];
    
    self.delegatebutton.frame  = CGRectMake(widgetFrameX(self.logisticsbutton)-widgetBoundsWidth(self.logisticsbutton)-5, widgetFrameY(self.logisticsbutton), widgetBoundsWidth(self.logisticsbutton), widgetboundsHeight(self.logisticsbutton));
    if ([model.orderDescription isEqualToString:@"待付款"]||[model.orderDescription isEqualToString:@"待发货"]) {
        self.delegatebutton.frame = CGRectMake(widgetFrameX(self.orderbutton)-widgetBoundsWidth(self.orderbutton)-5, widgetFrameY(self.orderbutton), widgetBoundsWidth(self.orderbutton), widgetboundsHeight(self.orderbutton));
        self.logisticsbutton.hidden = YES;
        self.returnbutton.hidden = YES;
        self.repairbutton.hidden = YES;
        self.resultbutton.hidden = YES;
    }
    if ([model.orderDescription isEqualToString:@"已完成"]) {
        self.repairbutton.frame = CGRectMake(widgetFrameX(self.orderbutton)-widgetBoundsWidth(self.orderbutton)-5, widgetFrameY(self.orderbutton), widgetBoundsWidth(self.orderbutton), widgetboundsHeight(self.orderbutton));
        [self.repairbutton setTitle:@"维修" forState:UIControlStateNormal];
        [self.repairbutton setTitleColor:[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1] forState:UIControlStateNormal];
        self.repairbutton.layer.cornerRadius = 3;
        self.repairbutton.layer.borderWidth = 0.5;
        self.repairbutton.clipsToBounds = YES;
        self.repairbutton.layer.borderColor = [[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1]CGColor];
        self.repairbutton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.repairbutton addTarget:self action:@selector(repairbuttonPress) forControlEvents:UIControlEventTouchUpInside];
        
        self.returnbutton.frame = CGRectMake(widgetFrameX(self.logisticsbutton)-widgetBoundsWidth(self.logisticsbutton)-5, widgetFrameY(self.logisticsbutton), widgetBoundsWidth(self.logisticsbutton), widgetboundsHeight(self.logisticsbutton));
        [self.returnbutton setTitle:@"退换货" forState:UIControlStateNormal];
        [self.returnbutton setTitleColor:[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1] forState:UIControlStateNormal];
        [self.returnbutton addTarget:self action:@selector(exchagePress) forControlEvents:UIControlEventTouchUpInside];
        self.returnbutton.layer.cornerRadius = 3;
        self.returnbutton.layer.borderWidth = 0.5;
        self.returnbutton.clipsToBounds = YES;
        self.returnbutton.layer.borderColor = [[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1]CGColor];
        self.returnbutton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.delegatebutton.frame = CGRectMake(widgetFrameX(self.returnbutton)-widgetBoundsWidth(self.returnbutton)-5, widgetFrameY(self.returnbutton), widgetBoundsWidth(self.returnbutton), widgetboundsHeight(self.returnbutton));
        self.logisticsbutton.hidden = YES;
        self.repairbutton.hidden = NO;
        self.returnbutton.hidden = NO;
        self.resultbutton.hidden = YES;
    }
    if ([model.orderDescription isEqualToString:@"待收货"]) {
        self.logisticsbutton.hidden = NO;
        self.returnbutton.hidden = YES;
        self.repairbutton.hidden = YES;
        self.resultbutton.hidden = YES;
    }
    if ([model.orderDescription isEqualToString:@"申请退货中"]) {
        self.logisticsbutton.hidden = YES;
        self.repairbutton.hidden = YES;
        self.returnbutton.hidden = YES;
        self.resultbutton.hidden = NO;
        self.resultbutton.frame = CGRectMake(widgetFrameX(self.orderbutton)-widgetBoundsWidth(self.orderbutton)-5, widgetFrameY(self.orderbutton), widgetBoundsWidth(self.orderbutton), widgetboundsHeight(self.orderbutton));
        self.resultbutton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        self.resultbutton.layer.cornerRadius = 3;
        self.resultbutton.layer.borderWidth = 0.5;
        self.resultbutton.layer.borderColor = [[UIColor grayColor]CGColor];
        self.resultbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    [self.delegatebutton setTitle:@"删除订单" forState:UIControlStateNormal];
    [self.delegatebutton setTitleColor:[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1] forState:UIControlStateNormal];
    self.delegatebutton.layer.cornerRadius = 3;
    self.delegatebutton.layer.borderWidth = 0.5;
    self.delegatebutton.layer.borderColor = [[UIColor colorWithRed:96/255.0 green:97/255.0 blue:98/255.0 alpha:1]CGColor];
    [self.delegatebutton addTarget:self action:@selector(delegateOrder) forControlEvents:UIControlEventTouchUpInside];
    self.delegatebutton.titleLabel.font = [UIFont systemFontOfSize:14];
    NSLog(@"%@",model.orderId);
    stringmodel = model.orderId;
}
-(void)buttonPressed:(UIButton *)button{
    
    if (_delegate&&[_delegate respondsToSelector:@selector(baifubao:)]) {
        [self.delegate baifubao:10];
    }
}
-(void)LogisticsPrss{
    SingleModel *model = [SingleModel sharedSingleModel];
    model.goodsId = goodId;
    
    if (_delegate&&[_delegate respondsToSelector:@selector(logistics)]) {
        [self.delegate logistics];
    }
    
}
-(void)exchagePress{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    model.goodsId = goodId;
     
    if (_delegate&&[_delegate respondsToSelector:@selector(exchangeDelete)]) {
        [self.delegate exchangeDelete];
    }
    
}
-(void)repairbuttonPress{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    model.goodsId = goodId;
    NSLog(@"wGoodsId--%@",wgoodsId);

    NSLog(@"%@",model.wGoodsId);


    if (_delegate&&[_delegate respondsToSelector:@selector(serviceRepair)]) {
        [self.delegate serviceRepair];
    }
}
-(void)delegateOrder{
    
    if (_delegate&&[_delegate respondsToSelector:@selector(delegatemethds:)]) {
        [self.delegate delegatemethds:stringmodel];
    }

}
@end
