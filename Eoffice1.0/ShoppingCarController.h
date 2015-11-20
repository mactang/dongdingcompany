//
//  ShoppingCarController.h
//  Eoffice1.0
//
//  Created by gyz on 15/7/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShoppingCarControllerDeledate<NSObject>
-(void)allSelected:(UITableView *)tableView;
-(void)releadCartNumber;
@end
@interface ShoppingCarController : UIViewController
@property(nonatomic,strong)NSString *shopNumber;
@property(nonatomic,assign)id<ShoppingCarControllerDeledate>delegate;
@end
