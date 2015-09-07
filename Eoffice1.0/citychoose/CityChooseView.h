//
//  CityChooseView.h
//  Eoffice1.0
//
//  Created by tangtao on 15/8/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol citychoosedelegate <NSObject>
-(void)addressed:(NSString *)address cityid:(NSString *)cityid;
@end
@interface CityChooseView : UIView<NSXMLParserDelegate>
@property(nonatomic,assign)id<citychoosedelegate>delegate;
@end
