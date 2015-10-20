//
//  BanklistTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/19.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "BanklistTableViewCell.h"
@interface BanklistTableViewCell(){
   
}
@end
@implementation BanklistTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.banklabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH/2, 20)];
        self.banklabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.banklabel];
    }
    return self;
}
-(void)setDic:(NSMutableDictionary *)dic{
    self.banklabel.text = @"中国工商银行";
  
}
-(void)setCellNo:(NSInteger)cellNo{
    _cellNo = cellNo;
}
-(void)setDatacount:(NSInteger)datacount{
    if (_cellNo==datacount) {
        UILabel *addbanklabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 40)];
        addbanklabel.text = [NSString stringWithFormat:@"➕添加银行卡"];
        addbanklabel.font = [UIFont systemFontOfSize:14];
        addbanklabel.textColor = [UIColor lightGrayColor];
        addbanklabel.userInteractionEnabled = NO;
        addbanklabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:addbanklabel];

    }
}
@end
