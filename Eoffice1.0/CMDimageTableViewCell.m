//
//  CMDimageTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CMDimageTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "detailsModel.h"
@interface CMDimageTableViewCell(){
    NSArray *imageviewarray;
}
@end
@implementation CMDimageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"cdmimage";
    CMDimageTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CMDimageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
   
    }
    return self;
}
-(void)setModel:(detailsModel *)model{
    _model = model;
    imageviewarray = [model.detaiImgUrl componentsSeparatedByString:@","];
    for (NSInteger i=0; i<imageviewarray.count; i++) {
        UIImageView *detailmageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0+i*(SCREEN_WIDTH/2)+i*10, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        [detailmageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageviewarray[i]]]];
        [self.contentView addSubview:detailmageview];
        
    }

}
@end
