//
//  ShopCarCell.h
//  Eoffice1.0
//
//  Created by gyz on 15/9/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCarModel;
@protocol celldelegate <NSObject>

-(void)signMutablearray:(UIButton *)btn;
-(void)subCount:(NSString *)subCountLB;
-(void)addCount:(NSString *)addCountLB;
-(void)chooseCount:(NSString *)chooseCountLB;
-(void)noChooseCount:(NSString *)noChooseCountLB;
-(void)totalPrice:(NSString *)totalPrices;
-(void)totalPricrArray:(NSString *)totalPricrArray;

@end
@interface ShopCarCell : UITableViewCell
{

    BOOL			m_checked;
}
@property(nonatomic, strong)ShopCarModel *myModel;
@property(nonatomic, strong)UIButton *chooseBtn;
@property(nonatomic, strong)UIImageView *ImageView;
@property(nonatomic, strong)UILabel *nameLB;
@property(nonatomic, strong)UILabel *priceLB;
@property(nonatomic, strong)UILabel *countBL;

@property(nonatomic, strong)UILabel *versionLB;
@property(nonatomic, strong)UILabel *versionButton;
@property(nonatomic, strong)UILabel *shopNumber;

@property(nonatomic, strong)UIButton *subNumber;
@property(nonatomic, strong)UIButton *addNumber;
@property(nonatomic, strong)UILabel *number;


@property(nonatomic,assign)NSInteger numbercell;

@property(nonatomic,assign)id<celldelegate>delegate;
+ (ShopCarCell *)cellWithTableView:(UITableView *)tableView;

- (void)setChecked:(BOOL)checked;
@end
