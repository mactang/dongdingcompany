//
//  OneSectionTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/10/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OneSectionTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "detailsModel.h"
#import "ButtonImageWithTitle.h"
@interface OneSectionTableViewCell(){
    UIScrollView *scrollView;
    UILabel *description;
    UILabel *priceLb;
}
@end
@implementation OneSectionTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview cellnumber:(NSInteger)cellnumber
{
    if (cellnumber==0) {
        static NSString *ID = @"OneSectionTableViewCell";
        OneSectionTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[OneSectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        return cell;
    }
    else{
        static NSString *ID = @"Mycell";
        OneSectionTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[OneSectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        return cell;
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
        if ([reuseIdentifier isEqualToString:@"OneSectionTableViewCell"]) {
            if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
                
                scrollView = [[UIScrollView alloc] init];
                scrollView.frame = CGRectMake(0, 0, 320, 150);
                scrollView.backgroundColor = [UIColor grayColor];
                // 一页的大小应该是frame的大小
                scrollView.pagingEnabled = YES;
                
                scrollView.showsHorizontalScrollIndicator = NO;
                scrollView.showsVerticalScrollIndicator = NO;
                [self.contentView addSubview:scrollView];
                scrollView.tag = 3001;
                //[scrollView setContentOffset:CGPointMake(320, 0)];
                //分页控制控件
                self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110, 130, 120, 0)];
                self.pageControl.backgroundColor = [UIColor redColor];
                
                //当前显示的分页
                self.pageControl.currentPage = 0;
                //将分页控制控件加在本视图上面
                [self.contentView addSubview:self.pageControl];
                
            }
            
        }
        
    else{
        
        if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
            description = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-90, 40)];
            description.font = [UIFont systemFontOfSize:13];
            description.lineBreakMode = NSLineBreakByWordWrapping;
            [self.contentView addSubview:description];
            
            
            priceLb = [[UILabel alloc]initWithFrame:CGRectMake(widgetFrameX(description), CGRectGetMaxY(description.frame), 60, 20)];
            priceLb.font = [UIFont systemFontOfSize:15];
            priceLb.textColor = [UIColor colorWithRed:200/255.0 green:3/255.0 blue:3/255.0 alpha:1];
            [self.contentView addSubview:priceLb];
            
            ButtonImageWithTitle  *fenxBtb = [[ButtonImageWithTitle alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 10, 50, 50)];
            [fenxBtb setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
            [fenxBtb addTarget:self action:@selector(fenxClicked) forControlEvents:UIControlEventTouchUpInside];
            [fenxBtb setTitle:@"分享" forState:UIControlStateNormal];
            [fenxBtb setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            fenxBtb.titleLabel.font = [UIFont systemFontOfSize:12];
            fenxBtb.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:fenxBtb];
            
           }

    }
    return self;
}
-(void)setModel:(detailsModel *)model{
    _model = model;
    NSString *nstring = [NSString stringWithFormat:@"%@",model.goodsImgUrl];
    NSArray *array = [nstring componentsSeparatedByString:@","];
    scrollView.contentSize = CGSizeMake(320*array.count, 150);
    //分页的页数
    self.pageControl.numberOfPages = array.count;
    
    for (int i = 0; i < [array count]; i++) {
        NSLog(@"string:%@", [array objectAtIndex:i]);
        UIImageView *forImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, 150)];
        [forImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]]]];
        [scrollView addSubview:forImageView];
    }
    
    description.text = [NSString stringWithFormat:@"%@",model.version[0][@"maValue"]];
    priceLb.text = [NSString stringWithFormat:@"￥%@",model.price];
    
}
-(void)fenxClicked{
    if (_delegate &&[_delegate respondsToSelector:@selector(sharedelegate)]) {
        [self.delegate sharedelegate];
    }
}
@end

