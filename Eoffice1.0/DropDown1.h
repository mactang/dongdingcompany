//
//  DropDown1.h
//  demo
//
//  Created by gyz on 15/5/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DropDown1;
@protocol  DropDown1Delegate <NSObject>

// Selection contains the user selected option or nil if nothing was selected
- (void)dropDownControlView:(DropDown1 *)view didFinishWithSelection:(id)selection;

@optional

@end
@interface DropDown1 : UIView
<UITableViewDelegate,UITableViewDataSource> {
    UITableView *tv;//下拉列表
    NSArray *tableArray;//下拉列表数据
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}
@property (nonatomic, weak) id<DropDown1Delegate> delegate;

@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;

@property (nonatomic,retain) UIButton *textButton;
- (void)setSelectionOptions:(NSArray *)selectionOptions withTitles:(NSArray *)selectionOptionTitles;
@end
