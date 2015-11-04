//
//  CMDetailsTableviewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CMDetailsTableviewCell.h"
#import "CalculateStringSpace.h"
#import "detailsModel.h"
@interface CMDetailsTableviewCell(){
    UILabel *MerchantPare;
    UILabel *MerchantMessage;
    NSArray *keysArray;
    NSArray *AllvalueArray;
}
@end
@implementation CMDetailsTableviewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview cellnumber:(NSInteger)cellnumber
{
    if (cellnumber==1) {
        static NSString *ID = @"cell";
        CMDetailsTableviewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CMDetailsTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        return cell;
 
    }
    if (cellnumber==2) {
        static NSString *ID = @"secell";
        CMDetailsTableviewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CMDetailsTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        return cell;
    }
    else{
        static NSString *ID = @"Mycell";
        CMDetailsTableviewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CMDetailsTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        return cell;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([reuseIdentifier isEqualToString:@"cell"]) {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            
            MerchantPare = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 40)];
            MerchantPare.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:MerchantPare];
            
        }
    }
    if ([reuseIdentifier isEqualToString:@"secell"]) {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            MerchantMessage = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 40)];
            MerchantMessage.font = [UIFont systemFontOfSize:16];
            [self.contentView addSubview:MerchantMessage];
            
        }
    }

    else{
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            
            keysArray = [NSArray array];
            AllvalueArray = [NSArray array];
    }
}
    return self;
}
-(void)setModel:(detailsModel *)model{
    MerchantPare.text = @"商家对比";
    MerchantMessage.text = @"购买信息";
    keysArray = [model.data allKeys];
    AllvalueArray = [model.data allValues];
}
-(void)setIndexpathsection:(NSInteger)indexpathsection{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSInteger i=0; i<keysArray.count; i++) {
        CGSize size = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"%@:%@",keysArray[i],AllvalueArray[i]] font:[UIFont systemFontOfSize:12] constraintSize:CGSizeMake((SCREEN_WIDTH-15)/2, 40)];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5+(i%2)*((SCREEN_WIDTH-15)/2)+(i%2)*5, 15+(i/2)*45, size.width, size.height)];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 2;
        label.text = [NSString stringWithFormat:@"%@:%@",keysArray[i],AllvalueArray[i]];
        [self.contentView addSubview:label];
        
        if (i!=1+(i/2)*2) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(3, 50+(i/2)*45, SCREEN_WIDTH-6, 0.5)];
            view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
            [self.contentView  addSubview:view];
        }
        
    }

}
@end


