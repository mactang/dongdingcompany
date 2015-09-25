//
//  OrederManagerCell.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrederManagerCell.h"
#import "AddressModel.h"
@implementation OrederManagerCell
{
    UILabel *titlelabel;
    UILabel *phonelabel;
    UILabel *detailaddresslabel;
    UILabel *whetherdefault;
    UIButton *delegatebutton;
}

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID =@"Cell";
    OrederManagerCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[OrederManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 100, 20)];
        titlelabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:titlelabel];
        
        phonelabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-160, widgetFrameY(titlelabel), 130, 20)];
        phonelabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:phonelabel];
        
        self.clickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.clickbutton.frame = CGRectMake(SCREEN_WIDTH-40, 40, 20, 20);
        [self.clickbutton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.clickbutton setImage:[UIImage imageNamed:@"大勾"] forState:UIControlStateSelected];
        [self.clickbutton addTarget:self action:@selector(checkPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.clickbutton];

        
        detailaddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(titlelabel), widgetFrameY(titlelabel)+5+widgetboundsHeight(titlelabel), SCREEN_WIDTH-35, 40)];
        detailaddresslabel.font = [UIFont systemFontOfSize:13];
        detailaddresslabel.numberOfLines = 2;
        [self.contentView addSubview:detailaddresslabel];
        

        whetherdefault = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.clickbutton.frame)+3, 80, 100, 40)];
        whetherdefault.font = [UIFont systemFontOfSize:13];
        whetherdefault.textColor = [UIColor blackColor];
        [self.contentView addSubview:whetherdefault];
        
    }
    return self;
}
-(void)setModel:(AddressModel *)model{
    
    //   if (![model.defaultsign isKindOfClass:[NSNull class]]) {
    //            self.clickbutton.selected = YES;
    //    }
    if ([model.defaultsign isEqualToString:@"Y"]) {
        self.clickbutton.selected = YES;
    }else{
        self.clickbutton.selected = NO;
    }
    titlelabel.text = model.receiver;
    if ([model.telphone isKindOfClass:[NSNull class]]) {
        phonelabel.text = @"暂无";
    }else{
        phonelabel.text = model.telphone;
    }
    detailaddresslabel.text = model.address;
    NSLog(@"%@",model.fullAddress);
    self.clickbutton.tag = 100+_buttontag;
}
-(void)checkPressed:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(buttondelegate:)]) {
        [_delegate buttondelegate:button];
    }
}
-(void)delegatePressed{
    if (_delegate &&[_delegate respondsToSelector:@selector(delegatedata:)]) {
        [_delegate delegatedata:self.buttontag];
    }
}


@end
