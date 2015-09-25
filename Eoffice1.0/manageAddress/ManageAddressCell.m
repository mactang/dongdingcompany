//
//  ManageAddressCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/8/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ManageAddressCell.h"
#import "AddressModel.h"
@interface ManageAddressCell(){
    UILabel *titlelabel;
    UILabel *phonelabel;
    UILabel *detailaddresslabel;
    UILabel *whetherdefault;
    UIButton *delegatebutton;
}
@end
@implementation ManageAddressCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
        static NSString *ID =@"Cell";
        ManageAddressCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ManageAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
       
        detailaddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(titlelabel), widgetFrameY(titlelabel)+5+widgetboundsHeight(titlelabel), SCREEN_WIDTH-35, 40)];
        detailaddresslabel.font = [UIFont systemFontOfSize:13];
        detailaddresslabel.numberOfLines = 2;
        [self.contentView addSubview:detailaddresslabel];
     
        self.clickbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.clickbutton.frame = CGRectMake(20, 90, 20, 20);
        [self.clickbutton setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
        [self.clickbutton setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
        [self.clickbutton addTarget:self action:@selector(checkPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.clickbutton];
        
        whetherdefault = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.clickbutton.frame)+3, 80, 100, 40)];
        whetherdefault.font = [UIFont systemFontOfSize:13];
        whetherdefault.textColor = [UIColor blackColor];
        [self.contentView addSubview:whetherdefault];
        
        delegatebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        delegatebutton.frame = CGRectMake(SCREEN_WIDTH-80, 90, 60, 20);
        [delegatebutton setTitle:@"删除" forState:UIControlStateNormal];
        [delegatebutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [delegatebutton addTarget:self action:@selector(delegatePressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:delegatebutton];
      
    }
    return self;
}
-(void)setModel:(AddressModel *)model{
    
//   if (![model.defaultsign isKindOfClass:[NSNull class]]) {
//            self.clickbutton.selected = YES;
//    }
    if (![model.defaultsign isKindOfClass:[NSNull class]]) {
        if ([model.defaultsign isEqualToString:@"Y"]) {
            self.clickbutton.selected = YES;
        }else{
            self.clickbutton.selected = NO;
        }
    }
        titlelabel.text = model.receiver;
    if ([model.telphone isKindOfClass:[NSNull class]]) {
        phonelabel.text = @"暂无";
    }else{
        phonelabel.text = model.telphone;
    }
    detailaddresslabel.text = model.fullAddress;
    whetherdefault.text = @"默认地址";
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

