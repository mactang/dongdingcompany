//
//  TheSameHeaderView.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "TheSameHeaderView.h"

@implementation TheSameHeaderView
-(void)titlelabel:(NSString *)titlestring headerblock:(HeaderViewClickBlock) block{
    self.tieleName  = titlestring;
    self.block = [block copy];
    [self initUserInterface];
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}
- (void)initUserInterface{
    if (!self.titlelabel) {
        self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 70, 30)];
    }
    self.titlelabel.text = self.tieleName;
    self.titlelabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titlelabel];
    if ([self.tieleName isEqualToString:@"商品简介"]) {
        if (!self.button) {
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        self.button.frame = CGRectMake(CGRectGetMaxX(self.titlelabel.frame)+20,widgetFrameY(self.titlelabel), SCREEN_WIDTH-CGRectGetMaxX(self.titlelabel.frame)-40, widgetboundsHeight(self.titlelabel));
        [self.button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self.button setTitle:@"查看【资费说明&服务项目】"forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        self.button.tag=10;
        [self.button addTarget: self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];
    }
    if ([self.tieleName isEqualToString:@"快速下单"]) {
        self.orderbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderbutton.frame = CGRectMake(0, 10, SCREEN_WIDTH-20, 35);
        [self.orderbutton setTitle:self.tieleName forState:UIControlStateNormal];
        self.orderbutton.clipsToBounds = YES;
        self.orderbutton.layer.cornerRadius=4;
        self.orderbutton.backgroundColor = [UIColor colorWithRed:191/255.0f green:35/255.0f blue:29/255.0f alpha:1];
        [self.orderbutton addTarget: self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside]
        ;
        self.orderbutton.tag = 11;
        [self.contentView addSubview:self.orderbutton];
    }
}
-(void)buttonPressed:(UIButton *)button{
    self.block(button);
}
@end
