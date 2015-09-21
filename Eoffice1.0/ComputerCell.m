//
//  ComputerCell.m
//  EOffice
//
//  Created by gyz on 15/7/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ComputerCell.h"
#import "detailsModel.h"
#import "UIKit+AFNetworking.h"
@implementation ComputerCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.backgroundColor = [UIColor purpleColor];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.imgView];
        
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame), CGRectGetWidth(self.frame)-10, 20)];
        self.price.backgroundColor = [UIColor whiteColor];
        self.price.textAlignment = NSTextAlignmentLeft;
        self.price.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.price];
        
        self.detailmessage = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.price.frame), CGRectGetWidth(self.frame)-10, 40)];
        self.detailmessage.numberOfLines = 2;
        self.detailmessage.backgroundColor = [UIColor whiteColor];
        self.detailmessage.lineBreakMode = NSLineBreakByTruncatingTail;
        self.detailmessage.font  =[UIFont systemFontOfSize:12];
        self.detailmessage.text = @"Apple MacBook Pro MF839CH/A 13.3英寸宽屏笔记本电脑 128GB 闪存";
        [self addSubview:self.detailmessage];
                

    }
    return self;
}
-(void)setModel:(detailsModel *)model{
    self.price.text = [NSString stringWithFormat: @"￥%@",model.price ];
    [self.imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.imgUrl]]];
}
@end
