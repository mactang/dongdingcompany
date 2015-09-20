//
//  OrderTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/9/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "SingleModel.h"
@interface OrderTableViewCell(){
   NSInteger _currentNumber;
}
@property(nonatomic, strong)UIButton *numberBtn1;
@property(nonatomic,strong)UILabel *numberLb1;
@property(nonatomic,strong)UILabel *priceLb;
@property(nonatomic,strong)UILabel *price;
@end
@implementation OrderTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID =@"Cell";
    OrderTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _currentNumber = 1;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        imageView.image = [UIImage imageNamed:@"tu1"];
        [self.contentView addSubview:imageView];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, imageView.frame.origin.y, 160, 40)];
        lb1.font = [UIFont systemFontOfSize:10];
        //lb3.backgroundColor = [UIColor redColor];
        lb1.lineBreakMode = NSLineBreakByTruncatingTail;
        lb1.numberOfLines = 2;
        lb1.text = @"Apple MacBook Pro MF839CH/A 13.3英寸宽屏笔记本电脑 128GB 闪存";
        [self.contentView addSubview:lb1];
        UILabel *priceFLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame)+5, lb1.frame.origin.y+5, 10, 20)];
        priceFLb.font = [UIFont systemFontOfSize:13];
        priceFLb.textColor = [UIColor blackColor];
        priceFLb.text = @"￥";
        [self.contentView addSubview:priceFLb];
        
        SingleModel *single = [SingleModel sharedSingleModel];
        
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceFLb.frame), lb1.frame.origin.y+4, 80, 20)];
        _priceLb.font = [UIFont systemFontOfSize:13];
        _priceLb.textColor = [UIColor blackColor];
        NSLog(@"%@",single.price);
        _priceLb.text = [NSString stringWithFormat:@"%@",single.price];
        _price = single.price;
        [self.contentView addSubview:_priceLb];
        
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb2.font = [UIFont systemFontOfSize:10];
        lb2.text = @"颜色 :";
        [self.contentView addSubview:lb2];
        
        UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), CGRectGetMaxY(lb1.frame), 30, 20)];
        lb3.font = [UIFont systemFontOfSize:10];
        lb3.text = @"宾利蓝";
        [self.contentView addSubview:lb3];
        
        UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame)+20, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb4.font = [UIFont systemFontOfSize:10];
        lb4.text = @"尺寸 :";
        [self.contentView addSubview:lb4];
        
        UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb4.frame)+5, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb5.font = [UIFont systemFontOfSize:10];
        lb5.text = @"128G";
        [self.contentView addSubview:lb5];
        
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, SCREEN_WIDTH-20, 0.5)];
        lineview.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineview];
        
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(lineview), widgetFrameY(lineview)+20, 60, 25)];
        titlelabel.text = @"购买数量";
        titlelabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:titlelabel];
        
        _numberBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(185, widgetFrameY(titlelabel)-5, 30, 30)];
        _numberBtn1.backgroundColor = [UIColor whiteColor];
        [_numberBtn1 setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        
        _numberBtn1.clipsToBounds = YES;
        _numberBtn1.layer.cornerRadius = 3;
        _numberBtn1.layer.borderWidth = 0.8;
        _numberBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [_numberBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_numberBtn1 addTarget:self action:@selector(numBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        _numberBtn1.tag = 200;
        [self.contentView addSubview:_numberBtn1];
        
        UIButton *numberBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+60, _numberBtn1.frame.origin.y, 30, 30)];
        numberBtn2.backgroundColor = [UIColor whiteColor];
        [numberBtn2 setImage:[UIImage imageNamed:@"圆角矩形-3-2"] forState:UIControlStateNormal];
        numberBtn2.clipsToBounds = YES;
        numberBtn2.layer.cornerRadius = 3;
        numberBtn2.layer.borderWidth = 0.8;
        numberBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [numberBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numberBtn2 addTarget:self action:@selector(numBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        numberBtn2.tag = 300;
        [self.contentView addSubview:numberBtn2];
        
        _numberLb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+5, _numberBtn1.frame.origin.y, 50, 30)];
        _numberLb1.backgroundColor = [UIColor whiteColor];
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %ld",_currentNumber]];
        [_numberLb1 setText:string];
        [_numberLb1 setTextColor:[UIColor blackColor]];
        _numberLb1.clipsToBounds = YES;
        _numberLb1.layer.cornerRadius = 3;
        _numberLb1.layer.borderWidth = 0.8;
        _numberLb1.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.contentView addSubview:_numberLb1];

    }
    return self;
}
-(void)numBtnPress:(UIButton *)button{
    
    if (button.tag ==200) {
        if (_currentNumber>1) {
            _currentNumber--;
            NSLog(@"%@",_price);
            NSLog(@"priceLb-%d",[(_priceLb.text)intValue]);
            
            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %ld",_currentNumber]];
            [_numberLb1 setText:string];
            
        }
    }
    if (button.tag == 300) {
        _currentNumber++;
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %ld",_currentNumber]];
        [_numberLb1 setText:string];
        
       
    }

}
@end
