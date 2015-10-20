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
        self.cellbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cellbutton.frame = CGRectMake(SCREEN_WIDTH-30, 15, 20, 20);
        [self.cellbutton setImage:IMAGE_MYSELF(@"下箭头.png") forState:UIControlStateNormal];
        [self.cellbutton setImage:IMAGE_MYSELF(@"上箭头.png") forState:UIControlStateSelected];
        self.cellbutton.selected = NO;
        [self.cellbutton addTarget:self action:@selector(cellbuttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.cellbutton];
    }
    return self;
}
-(void)setCellNo:(NSInteger)cellNo{
    if (cellNo==0) {
        self.cellbutton.hidden = NO;
    }else{
        self.cellbutton.hidden = YES;
    }
    _cellNo = cellNo;
    self.cellbutton.tag = cellNo;
    
    
}
-(void)setDic:(NSMutableDictionary *)dic{
    
    self.banklabel.text = dic[@"bankName"];
    
  
}
-(void)cellbuttonPressed:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(cellbutton:)]) {
        [self.delegate cellbutton:button];
    }

    NSLog(@"%ld",button.tag);
}
@end
