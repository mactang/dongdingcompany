//
//  PresentdetailsCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "PresentdetailsCell.h"

@implementation PresentdetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bankcardWithdrawals = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 120, 20)];
        self.bankcardWithdrawals.font = [UIFont systemFontOfSize:13];
        self.bankcardWithdrawals.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.bankcardWithdrawals];
        
        self.withdrawalstime = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.bankcardWithdrawals.frame), widgetBoundsWidth(self.bankcardWithdrawals), 15)];
        self.withdrawalstime.font = [UIFont systemFontOfSize:12];
        self.withdrawalstime.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.withdrawalstime];
        
        self.banktype = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.withdrawalstime.frame)+SCREEN_WIDTH/32, widgetFrameY(self.bankcardWithdrawals), 80, widgetboundsHeight(self.bankcardWithdrawals))];
        self.banktype.font = [UIFont systemFontOfSize:13];
        self.banktype.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.banktype];
        
        self.backTailnumber = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(self.banktype), CGRectGetMaxY(self.banktype.frame), widgetBoundsWidth(self.banktype), 15)];
        self.backTailnumber.font = [UIFont systemFontOfSize:12];
        self.backTailnumber.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.backTailnumber];
        
        self.moneynumber = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.banktype.frame)+SCREEN_WIDTH/32, widgetFrameY(self.backTailnumber), SCREEN_WIDTH-5-SCREEN_WIDTH/32-CGRectGetMaxX(self.banktype.frame), 20)];
        self.moneynumber.font = [UIFont systemFontOfSize:13];
        self.moneynumber.textColor = [UIColor lightGrayColor];
        self.moneynumber.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.moneynumber];
        
        self.orsucess = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(self.moneynumber), widgetFrameY(self.banktype), widgetBoundsWidth(self.moneynumber), 20)];
        self.orsucess.font = [UIFont systemFontOfSize:13];
        self.orsucess.textColor = [UIColor lightGrayColor];
        self.orsucess.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.orsucess];
        
        
    }
    return self;
}
-(void)setDicnationary:(NSMutableDictionary *)dicnationary{
    self.bankcardWithdrawals.text = dicnationary[@"cashway"];
    self.withdrawalstime.text = dicnationary[@"date"];
    self.banktype.text = dicnationary[@"bank"];
    self.backTailnumber.text = [NSString stringWithFormat:@"尾号%@",dicnationary[@"bankNo"]];
    self.moneynumber.text = @"6000.00";
    self.orsucess.text = @"提现成功";

}
@end
