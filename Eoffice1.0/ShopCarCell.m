//
//  ShopCarCell.m
//  Eoffice1.0
//
//  Created by gyz on 15/9/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ShopCarCell.h"
#import "UIKit+AFNetworking.h"
#import "ShopCarModel.h"
#import "ShoppingCarController.h"
@interface ShopCarCell ()<ShoppingCarControllerDeledate>

@end
@implementation ShopCarCell
{

    UIButton *selectedButton;
    NSMutableArray *allcellnumber;
    NSString *NowCount;
    
    int mun;
    NSString *addTotal;
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        allcellnumber = [NSMutableArray array];
        
        
        
        ShoppingCarController *shop = [[ShoppingCarController alloc]init];
        shop.delegate = self;
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chooseBtn.frame = CGRectMake(10, 30, 20, 20);
        [self.chooseBtn setImage:[UIImage imageNamed:@"check-NO"] forState:UIControlStateNormal];
        [self.chooseBtn setImage:[UIImage imageNamed:@"check-YES"] forState:UIControlStateSelected];
        [self.chooseBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.chooseBtn];
        if (self.chooseBtn.selected == YES) {
            NSLog(@"kk");
        }
        self.ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.chooseBtn.frame)+10, 10, 60, 60)];
        self.ImageView.userInteractionEnabled =YES;
        [self.contentView addSubview:self.ImageView];
        self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ImageView.frame)+5, self.ImageView.frame.origin.y, 120, 30)];
        self.nameLB.font = [UIFont systemFontOfSize:12];
        self.nameLB.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nameLB.numberOfLines = 2;
        [self.contentView addSubview:self.nameLB];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        
        [button addTarget:self action:@selector(pessbtn) forControlEvents:UIControlEventTouchUpInside];
        [self.ImageView addSubview:button];
        
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(235, 10, 13, 20)];
        LB.font = [UIFont systemFontOfSize:15];
        LB.text = @"￥";
        LB.textColor = [UIColor blackColor];
        [self.contentView addSubview:LB];
        
        self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(LB.frame), 10, 40, 20)];
        self.priceLB.font = [UIFont systemFontOfSize:15];
        self.priceLB.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.priceLB];
        
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(270, 30, 11, 20)];
        bl.font = [UIFont systemFontOfSize:15];
        bl.text = @"x";
        [bl setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:bl];
        
        self.countBL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bl.frame), 30, 50, 20)];
        self.countBL.font = [UIFont systemFontOfSize:15];
        [self.countBL setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.countBL];
        
        
        self.versionLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ImageView.frame)+5, CGRectGetMaxY(self.nameLB.frame)+5, 60, 20)];
        self.versionLB.font = [UIFont systemFontOfSize:12];
        self.versionLB.text = @"版本信息:";
        [self.versionLB setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.versionLB];
        
            
            self.versionButton = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.versionLB.frame), CGRectGetMaxY(self.nameLB.frame), 145, 30)];
           [self.versionButton setText:@"华硕版本1"];
            [self.versionButton setTextColor:[UIColor grayColor]];
            self.versionButton.font = [UIFont systemFontOfSize:11];
            
            self.versionButton.layer.borderColor = [[UIColor grayColor]CGColor];
        
        
            [self.contentView addSubview:self.versionButton];
            
        }
        
        
        self.shopNumber = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.ImageView.frame)+20, 100, 20)];
        self.shopNumber.font = [UIFont systemFontOfSize:15];
        self.shopNumber.text = @"购买数量";
        [self.shopNumber setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.shopNumber];
        
        self.subNumber = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.shopNumber.frame)+65, CGRectGetMaxY(self.ImageView.frame)+15, 25, 25)];
        self.subNumber.backgroundColor = [UIColor whiteColor];
        [self.subNumber setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        
        self.subNumber.clipsToBounds = YES;
        self.subNumber.layer.cornerRadius = 3;
        self.subNumber.layer.borderWidth = 0.8;
        self.subNumber.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.subNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.subNumber addTarget:self action:@selector(NumBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.subNumber];
        
        self.addNumber = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.subNumber.frame)+60, self.subNumber.frame.origin.y, 25, 25)];
        self.addNumber.backgroundColor = [UIColor whiteColor];
        [self.addNumber setImage:[UIImage imageNamed:@"圆角矩形-3-2"] forState:UIControlStateNormal];
        self.addNumber.clipsToBounds = YES;
        self.addNumber.layer.cornerRadius = 3;
        self.addNumber.layer.borderWidth = 0.8;
        self.addNumber.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.addNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.addNumber addTarget:self action:@selector(addNumBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
        
        [self.contentView addSubview:self.addNumber];
        
        self.number = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.subNumber.frame)+5, self.subNumber.frame.origin.y, 45, 25)];
        self.number.backgroundColor = [UIColor whiteColor];
        
    
        
    self.number.tag = 100;
        [self.number setTextColor:[UIColor blackColor]];
        self.number.clipsToBounds = YES;
        self.number.layer.cornerRadius = 3;
        self.number.layer.borderWidth = 0.8;
        self.number.textAlignment = NSTextAlignmentCenter;
        self.number.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.contentView addSubview:self.number];

        
    
    return self;
}
-(void)pessbtn{

    NSLog(@"numbercell--%ld",(long)self.numbercell);
    
    if (_delegate &&[_delegate respondsToSelector:@selector(goodDetailButton:)]) {
        [self.delegate goodDetailButton:self.numbercell];
    }
    
}
-(void)NumBtnPress:(UIButton *)btn{
    
    int addCount = [[NSString stringWithFormat:@"%@",self.number.text]intValue];
    
    float price = [[NSString stringWithFormat:@"%@",self.priceLB.text]floatValue];
    addTotal = [NSString stringWithFormat:@"%f",price];
    
    if (addCount>1) {
        addCount--;
        NSString *string = [NSString stringWithFormat:@"%d",addCount];
        [self.number setText:string];
        self.countBL.text = string;
        self.myModel.count  = string;
        if (self.chooseBtn.selected == YES) {
            
        if (_delegate &&[_delegate respondsToSelector:@selector(subCount:)]) {
            
            [self.delegate subCount:addTotal];
        }
        }else{
            if (_delegate &&[_delegate respondsToSelector:@selector(noChooseSubCount:)]) {
                
                [self.delegate noChooseSubCount:addTotal];
            
        }
        
    }
    }
    
}
-(void)addNumBtnPress:(UIButton *)btn{
    
    
    int addCount = [[NSString stringWithFormat:@"%@",self.number.text]intValue];
    
    float price = [[NSString stringWithFormat:@"%@",self.priceLB.text]floatValue];
    
    addCount++;
    
    NSString *string = [NSString stringWithFormat:@"%d",addCount];
    self.myModel.count  = string;
    [self.number setText:string];
    
    self.countBL.text = string;
    
    addTotal = [NSString stringWithFormat:@"%f",price];
    if (self.chooseBtn.selected == YES) {
        
            if (_delegate &&[_delegate respondsToSelector:@selector(addCount:)]) {
                [self.delegate addCount:addTotal];
            }
        
    }else{
        if (_delegate &&[_delegate respondsToSelector:@selector(noChooseAddCount:)]) {
            [self.delegate noChooseAddCount:addTotal];
        }
        
    }
    
    
    
    
}

- (void)isPublicBtnPress:(UIButton*)btn{
   
    NSLog(@"%ld",(long)btn.tag);
    if (_delegate &&[_delegate respondsToSelector:@selector(signMutablearray:)]) {
        [self.delegate signMutablearray:btn];
    }
    
    
    float addCount = [[NSString stringWithFormat:@"%@",self.countBL.text]floatValue];
    
    float price = [[NSString stringWithFormat:@"%@",self.priceLB.text]floatValue];
    
    NSLog(@"%f",price);
    float choosePrice = addCount*price;
    NSLog(@"choosePrice--%f",choosePrice);
    
    
    
    addTotal = [NSString stringWithFormat:@"%.2f",choosePrice];
    NSLog(@"%@",addTotal);
    if (btn.selected == YES) {
        
                if (_delegate &&[_delegate respondsToSelector:@selector(chooseCount:)]) {
                    
                    [self.delegate chooseCount:addTotal];

        }
 
    }else{
        
        if (_delegate &&[_delegate respondsToSelector:@selector(noChooseCount:)]) {
            
            [self.delegate noChooseCount:addTotal];
        
    }
    
}
}

-(void)setMyModel:(ShopCarModel *)myModel{
    
   
    self.chooseBtn.tag = self.numbercell;

    _myModel = myModel;
    
    [self.ImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myModel.cartImg]]];
    
    self.nameLB.text = [NSString stringWithFormat:@"%@",myModel.name];
    self.priceLB.text = [NSString stringWithFormat:@"%@",myModel.price];
    self.countBL.text = [NSString stringWithFormat:@"%@",myModel.count];
    NowCount = [NSString stringWithFormat:@"%@",myModel.count];
    self.number.text = [NSString stringWithFormat:@"%@",myModel.count];
    
    
    
}

+ (ShopCarCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ident = @"cell";
    
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[ShopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
}

- (void)setChecked:(BOOL)checked{
    if (checked)
    {
        self.chooseBtn.selected = YES;
    }
    else
    {
        self.chooseBtn.selected = NO;
    }
    m_checked = checked;
    
    
}

@end
