//
//  ChangeAddressCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/8/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ChangeAddressCell.h"
#import "ChangeModel.h"
@interface ChangeAddressCell()<UITextFieldDelegate>{
    NSInteger indexpath;
}
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)UILabel *detaillabel;
@property(nonatomic,strong)UIButton *cellbutton;
@property(nonatomic,strong)UILabel *districtlabel;
//@property(nonatomic,copy)NSString *street;
//@property(nonatomic,copy)NSString *deatilAddress;
//@property(nonatomic,copy)NSString *recevierName;
//@property(nonatomic,copy)NSString *phoneNumber;
//@property(nonatomic,copy)NSString *postNumber;
@end
@implementation ChangeAddressCell
+ (instancetype)cellWithTableView:(UITableView *)tableview indexpthnumber:(NSInteger)number
{
    
    if (number ==0) {
        static NSString *ID =@"AnotherCell";
        ChangeAddressCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ChangeAddressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        return cell;
    }
    else if(number == 4){
        static NSString *ID =@"DefaultCell";
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

    if ([reuseIdentifier isEqualToString:@"AnotherCell"]||[reuseIdentifier isEqualToString:@"DefaultCell"]) {
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            self.label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH, 30)];
            self.label.font = [UIFont systemFontOfSize:17];
            self.label.backgroundColor = [UIColor whiteColor];
            self.label.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.label];
            self.detaillabel = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(self.label), CGRectGetMaxY(self.label.frame)+5, 100, 13)];
            self.detaillabel.font = [UIFont systemFontOfSize:13];
            [self.contentView addSubview:self.detaillabel];
            if ([reuseIdentifier isEqualToString:@"AnotherCell"]) {
                self.cellbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                self.cellbutton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
                self.cellbutton.backgroundColor = [UIColor clearColor];
                [self.cellbutton addTarget:self action:@selector(choosecity) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:self.cellbutton];
            }
            
        }

    }
    if([reuseIdentifier isEqualToString:@"DefaultCell"]){
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cellbutton.frame = CGRectMake(SCREEN_WIDTH-40, 5, 30, 30);
        self.cellbutton.backgroundColor = [UIColor clearColor];
        [self.cellbutton setImage:IMAGE_MYSELF(@"确认40灰色.png") forState:UIControlStateNormal];
        [self.cellbutton setImage:IMAGE_MYSELF(@"蓝色确认40.png") forState:UIControlStateSelected];
        [self.cellbutton addTarget:self action:@selector(clickPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.cellbutton.layer.cornerRadius = 15;
        [self.contentView addSubview:self.cellbutton];
    }
    }
    if([reuseIdentifier isEqualToString:@"Cell"]){
     
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, 30)];
            self.textfield.font = [UIFont systemFontOfSize:17];
            self.textfield.delegate = self;
            self.textfield.textColor = [UIColor lightGrayColor];
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
-(void)clickPressed:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(buttonclick:)]) {
        if (button.selected) {
            [_delegate buttonclick:@"Y"];
        }
        else{
            [_delegate buttonclick:@"N"];
        }
    }
}
-(void)choosecity{
    
    if (_delegate && [_delegate respondsToSelector:@selector(citydelegatemesthd:)]) {
     
        [_delegate citydelegatemesthd:self.districtlabel];
    }
}
-(void)setMessage:(NSString *)message{
   if (_indexnumber==0) {
        self.districtlabel = self.label;
    }
    self.label.text = message;
    self.label.tag = 10+_indexnumber;
    if (![message isKindOfClass:[NSNull class]]) {
         self.textfield.text = message;
    }else{
        self.textfield.text = @"暂无";
    }
    self.textfield.tag = 10+_indexnumber;
}
-(void)setDetailstring:(NSString *)detailstring{
    self.detaillabel.text = [NSString stringWithFormat:@"%@",detailstring];
    if (![detailstring isKindOfClass:[NSNull class]]) {
        if ([detailstring isEqualToString:@"Y"]||[detailstring isEqualToString:@"N"]) {
            self.detaillabel.hidden = YES;
            if ([detailstring isEqualToString:@"Y"]) {
                self.cellbutton.selected = YES;
            }
        }

    }
    else{
        self.detaillabel.hidden = YES;
    }
}
-(void)setIndexnumber:(NSInteger)indexnumber{
    _indexnumber = indexnumber;
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_delegate &&[_delegate respondsToSelector:@selector(textfieldtext:texttag:)]) {
        [_delegate textfieldtext:text texttag:textField.tag];
    }
    if (string.length == 0) {
        return YES;
    }
    if (textField.tag==14) {
        if ([@"1234567890" rangeOfString:string].location == NSNotFound && string.length !=0)
        {
            return NO;
        }
        if (textField.text.length>10 && textField.tag==14) {
            return NO;
        }
    }
    
//    NSLog(@"%ld",textField.tag);
//    NSLog(@"%@",text);
//    NSLog(@"%@",string);
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"sdfdsfdsfdsf");
}
@end
