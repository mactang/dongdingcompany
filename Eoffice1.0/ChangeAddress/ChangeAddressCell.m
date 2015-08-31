//
//  ChangeAddressCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ChangeAddressCell.h"
@interface ChangeAddressCell(){
    NSInteger indexpath;
}
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UILabel *detaillabel;
@end
@implementation ChangeAddressCell
+ (instancetype)cellWithTableView:(UITableView *)tableview indexpthnumber:(NSInteger)number
{
    if (number ==0||number==6) {
        static NSString *ID =@"AnotherCell";
        ChangeAddressCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ChangeAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        return cell;
    }
    else{
        static NSString *ID =@"Cell";
        ChangeAddressCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ChangeAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        return cell;
    }
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    if ([reuseIdentifier isEqualToString:@"AnotherCell"]) {
        
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH, 30)];
            self.label.font = [UIFont systemFontOfSize:17];
            self.label.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.label];
            self.detaillabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(self.label), CGRectGetMaxY(self.label.frame)+5, 100, 13)];
            self.detaillabel.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:self.detaillabel];
        }

    }
    else{
        
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 30)];
            self.textfield.font = [UIFont systemFontOfSize:17];
            [self.contentView addSubview:self.textfield];
            self.detaillabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(self.textfield), CGRectGetMaxY(self.textfield.frame)+5, 100, 13)];
            self.detaillabel.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:self.detaillabel];
    }
        
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self setLayoutMargins:UIEdgeInsetsZero];
        
    }

        return self;
}
-(void)setMessage:(NSString *)message{
    _message = message;
    self.label.text = message;
    self.textfield.placeholder = message;
}
-(void)setDetailstring:(NSString *)detailstring{
    self.detaillabel.text = detailstring;
}
@end
