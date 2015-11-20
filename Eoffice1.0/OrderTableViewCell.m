//
//  OrderTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/9/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "SingleModel.h"
#import "UIKit+AFNetworking.h"
#import "CalculateStringSpace.h"
@interface OrderTableViewCell(){
   NSInteger _currentNumber;
}
@property(nonatomic,strong)UIImageView *imagiew;
@property(nonatomic,strong)UILabel *productmessage;
@property(nonatomic,strong)UILabel *price;
@property(nonatomic,strong)UILabel *versioninformation;
@property(nonatomic,strong)UILabel *numberlabel;
@end
@implementation OrderTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID =@"anotherCell";
    OrderTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _currentNumber = 1;
        self.imagiew = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:self.imagiew];
        
        
        self.price = [[UILabel alloc]init];
        self.price.backgroundColor = [UIColor whiteColor];
        self.price.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [self.contentView addSubview:self.price];
        
        
        self.productmessage = [[UILabel alloc]init];
        [self.contentView addSubview:self.productmessage];
        
        self.versioninformation = [[UILabel alloc]init];
        [self.contentView addSubview:self.versioninformation];
        
        self.numberlabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.numberlabel];
        
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    
    
   [self.imagiew setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"cartImg"]]]];
    
    CGSize size = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"￥%.2f",[dic[@"price"] floatValue]] font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH/2-10, 20)];
    self.price.frame = CGRectMake(SCREEN_WIDTH-size.width-10, widgetFrameY(self.imagiew), size.width, size.height);
    self.price.font = [UIFont systemFontOfSize:13];
    self.price.textAlignment = NSTextAlignmentRight;
    self.price.numberOfLines = 1;
    self.price.text = [NSString stringWithFormat:@"￥%.2f",[dic[@"price"] floatValue]];
    
    CGSize productsize = [CalculateStringSpace sizeWithString:dic[@"name"] font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH-widgetBoundsWidth(self.imagiew)-widgetBoundsWidth(self.price)-30, 40)];
    
    self.productmessage.frame = CGRectMake(CGRectGetMaxX(self.imagiew.frame)+5, self.imagiew.frame.origin.y, productsize.width, productsize.height);
    self.productmessage.font = [UIFont systemFontOfSize:13];
    self.productmessage.numberOfLines = 2;
    self.productmessage.text = dic[@"name"];
    
    
    CGSize versionsize = [CalculateStringSpace sizeWithString:[NSString stringWithFormat:@"版本信息:%@",dic[@"version"]] font:[UIFont systemFontOfSize:13] constraintSize:CGSizeMake(SCREEN_WIDTH-widgetBoundsWidth(self.imagiew)-widgetBoundsWidth(self.price)-30, 40)];
    self.versioninformation.frame = CGRectMake(widgetFrameX(self.productmessage), CGRectGetMaxY(self.productmessage.frame)+5, versionsize.width, versionsize.height);
    self.versioninformation.font = [UIFont systemFontOfSize:13];
    self.versioninformation.numberOfLines = 2;
    self.versioninformation.text = [NSString stringWithFormat:@"版本信息:%@",dic[@"version"]];
    
    self.numberlabel.frame = CGRectMake(SCREEN_WIDTH-60, CGRectGetMaxY(self.price.frame)+10, 50, 20);
    self.numberlabel.font = [UIFont systemFontOfSize:15];
    self.numberlabel.textAlignment = NSTextAlignmentRight;
    self.numberlabel.text = [NSString stringWithFormat:@"x%@",dic[@"count"]];
    
    
    
    
}
//-(void)numBtnPress:(UIButton *)button{
//    
//    if (button.tag ==200) {
//        if (_currentNumber>1) {
//            _currentNumber--;
//            NSLog(@"%@",_price);
//            NSLog(@"priceLb-%d",[(_priceLb.text)intValue]);
//            
//            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %ld",_currentNumber]];
//            [_numberLb1 setText:string];
//            
//        }
//    }
//    if (button.tag == 300) {
//        _currentNumber++;
//        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %ld",_currentNumber]];
//        [_numberLb1 setText:string];
//        
//       
//    }
//
//}
@end
