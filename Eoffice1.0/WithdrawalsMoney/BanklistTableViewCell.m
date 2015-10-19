//
//  BanklistTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/19.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "BanklistTableViewCell.h"

@implementation BanklistTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.banklabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 20)];
        self.banklabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.banklabel];
    }
    return self;
}
-(void)setDic:(NSMutableDictionary *)dic{
    self.banklabel.text = @"水电费水电费";
}
@end
