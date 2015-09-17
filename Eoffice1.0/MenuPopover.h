//
//  MLKMenuPopover.h
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuPopover;

@protocol MenuPopoverDelegate<NSObject>

- (void)pushlogincontroller:(BOOL )sucess shopnumber:(NSInteger )shopnumber;

@end

@interface MenuPopover : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign) id<MenuPopoverDelegate>delegate;

- (id)initWithFrame:(CGRect)frame menuItems:(NSArray *)menuItems;
- (void)showInView:(UIView *)view;
- (void)dismissMenuPopover;
@property(nonatomic,assign)BOOL  intcart;
@property(nonatomic,assign)BOOL  Distinguish;
//- (void)layoutUIForInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end


