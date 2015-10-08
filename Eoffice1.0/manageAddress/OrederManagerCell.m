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
        
     

        detailaddresslabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(titlelabel), widgetFrameY(titlelabel)+5+widgetboundsHeight(titlelabel), SCREEN_WIDTH-35, 40)];
        detailaddresslabel.font = [UIFont systemFontOfSize:13];
        detailaddresslabel.numberOfLines = 2;
        [self.contentView addSubview:detailaddresslabel];
        
        
    }
    return self;
}
-(void)setModel:(AddressModel *)model{
  
    titlelabel.text = model.receiver;
    if ([model.telphone isKindOfClass:[NSNull class]]) {
        phonelabel.text = @"暂无";
    }else{
        phonelabel.text = model.telphone;
    }
    detailaddresslabel.text = model.address;
    NSLog(@"%@",model.fullAddress);
  
}
@end
