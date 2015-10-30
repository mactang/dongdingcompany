//
//  OneSectionTableViewCell.h
//  Eoffice1.0
//
//  Created by tangtao on 15/10/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sharedelegate <NSObject>

-(void)sharedelegate;

@end
@class detailsModel;
@interface OneSectionTableViewCell : UITableViewCell
@property(strong,nonatomic)NSDictionary *dic;
@property(strong,nonatomic)detailsModel *model;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic,assign)id<sharedelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableview cellnumber:(NSInteger )cellnumber;
@end
