//
//  CurrentrecordCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CurrentrecordCell.h"

@implementation CurrentrecordCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.namelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH-8)/3, 34)];
        self.namelabel.font = [UIFont systemFontOfSize:13];
        self.namelabel.textColor = [UIColor lightGrayColor];
        self.namelabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView  addSubview:self.namelabel];
        
        self.moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.namelabel.frame)+2, widgetFrameY(self.namelabel), widgetBoundsWidth(self.namelabel), widgetboundsHeight(self.namelabel))];
        self.moneylabel.font = self.namelabel.font;
        self.moneylabel.textColor = [UIColor lightGrayColor];
        self.moneylabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.moneylabel];
        
        self.timelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.moneylabel.frame)+2, widgetFrameY(self.moneylabel), widgetBoundsWidth(self.moneylabel), widgetboundsHeight(self.moneylabel))];
        self.timelabel.font = self.moneylabel.font;
        self.timelabel.textColor = [UIColor lightGrayColor];
        self.timelabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.timelabel];
        
        self.lineview = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-20)/3+7.2, 0, 0.5, 35)];
        self.lineview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineview];
        
        self.seconedview = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.lineview.frame)+(SCREEN_WIDTH-20)/3+5, widgetFrameY(self.lineview), widgetBoundsWidth(self.lineview), widgetboundsHeight(self.lineview))];
        self.seconedview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.seconedview];
    }
    return self;
}
-(void)setDic:(NSMutableDictionary *)dic{
    self.namelabel.text = dic[@"name"];
    self.moneylabel.text = [NSString stringWithFormat:@"%@",dic[@"money"]];
    if (dic[@"date"]!=[NSNull null]) {
        self.timelabel.text = dic[@"date"]; 
    }
    else{
        self.timelabel.text = @"暂无";
    }
   
}
@end
