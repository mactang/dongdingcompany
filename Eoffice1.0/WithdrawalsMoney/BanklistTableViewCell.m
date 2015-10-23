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
        self.banklabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, SCREEN_WIDTH/2-40, 20)];
        self.banklabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.banklabel];
        
        self.picimageview = IMAGEVIEW_MYSELF(@"bankcard.png");
        self.picimageview.frame = CGRectMake(10, 7, 40, 36);
        [self.contentView addSubview:self.picimageview];
        
        self.laterNo = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(self.banklabel), CGRectGetMaxY(self.banklabel.frame), widgetBoundsWidth(self.banklabel), widgetboundsHeight(self.banklabel))];
        self.laterNo.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.laterNo];
        
    }
    return self;
}
-(void)setDic:(NSMutableDictionary *)dic{
    
    self.banklabel.text = dic[@"bankName"];
    self.laterNo.text = [NSString stringWithFormat:@"尾号: %@",@"1234"];
    
}
@end
