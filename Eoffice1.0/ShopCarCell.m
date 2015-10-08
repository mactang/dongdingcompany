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
   
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
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
        
        self.ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.chooseBtn.frame)+10, 10, 60, 60)];
        [self.contentView addSubview:self.ImageView];
        self.nameLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ImageView.frame)+5, self.ImageView.frame.origin.y, 120, 40)];
        self.nameLB.font = [UIFont systemFontOfSize:10];
        self.nameLB.lineBreakMode = NSLineBreakByTruncatingTail;
        self.nameLB.numberOfLines = 2;
        [self.contentView addSubview:self.nameLB];
        
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(235, 10, 13, 20)];
        LB.font = [UIFont systemFontOfSize:15];
        LB.text = @"￥";
        LB.textColor = [UIColor blackColor];
        [self.contentView addSubview:LB];
        
        self.priceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(LB.frame), 10, 40, 20)];
        self.priceLB.font = [UIFont systemFontOfSize:15];
        self.priceLB.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.priceLB];
        
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(275, 30, 11, 20)];
        bl.font = [UIFont systemFontOfSize:15];
        bl.text = @"x";
        [bl setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:bl];
        
        self.countBL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bl.frame), 30, 50, 20)];
        self.countBL.font = [UIFont systemFontOfSize:15];
        [self.countBL setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:self.countBL];
        
    }
    return self;
}
- (void)isPublicBtnPress:(UIButton*)btn{
    
    NSLog(@"%ld",btn.tag);
    //selectedButton.selected = NO;
    btn.selected =! btn.selected;
   // selectedButton = btn;
    if (self.signcell==YES) {
        if (!btn.selected) {
            if (_delegate &&[_delegate respondsToSelector:@selector(signMutablearray:)]) {
                [self.delegate signMutablearray:btn.tag];
            }
            
        }

    }
    else{
        if (btn.selected) {
            
            if (_delegate &&[_delegate respondsToSelector:@selector(signMutablearray:)]) {
                [self.delegate signMutablearray:btn.tag];
            }

        }
        
    }
    
    
}
-(void)allSelectButton:(UITableView *)tableView{

    self.chooseBtn.selected = YES;
}
-(void)setMyModel:(ShopCarModel *)myModel{
    self.chooseBtn.tag = self.numbercell;

    _myModel = myModel;
    
    [self.ImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",myModel.cartImg]]];
    
    self.nameLB.text = [NSString stringWithFormat:@"%@",myModel.name];
    self.priceLB.text = [NSString stringWithFormat:@"%@",myModel.price];
    
    self.countBL.text = [NSString stringWithFormat:@"%@",myModel.count];
}

+ (ShopCarCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ident = @"cell";
    
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (!cell) {
        cell = [[ShopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
}

@end
