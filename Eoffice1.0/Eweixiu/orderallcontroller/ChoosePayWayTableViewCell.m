//
//  ChoosePayWayTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/12/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ChoosePayWayTableViewCell.h"

@implementation ChoosePayWayTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID =@"Cell";
    ChoosePayWayTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ChoosePayWayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.picimageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 26, 26)];
        [self.contentView addSubview:self.picimageview];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.picimageview.frame)+20, widgetFrameX(self.picimageview), 100, widgetboundsHeight(self.picimageview))];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        self.chooseButton= [UIButton buttonWithType:UIButtonTypeCustom];
        self.chooseButton.frame = CGRectMake(SCREEN_WIDTH-30, 15, 20, 20);
        [self.chooseButton setImage:[UIImage imageNamed:@"noSelected"] forState:UIControlStateNormal];
        [self.chooseButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [self.chooseButton addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.chooseButton];
    }
    return self;
}
-(void)setDictionary:(NSDictionary *)dictionary{
    UIImage *picimage = [UIImage imageNamed:dictionary[@"image"]];
    self.picimageview.image = picimage;
    self.titleLabel.text = dictionary[@"title"];
    self.chooseButton.tag = 100+_buttontag;
}
-(void)isPublicBtnPress:(UIButton *)button{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(buttondelegate:)]) {
        [self.delegate buttondelegate:button];
    }
}
@end
