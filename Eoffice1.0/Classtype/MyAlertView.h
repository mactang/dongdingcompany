//
//  MyAlertView.h
//  315酒店
//
//  Created by Francis on 15-1-26.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
typedef void (^ClickButtonIndex)(NSInteger index);
typedef void (^DissMiss)(void);
@interface MyAlertView : NSObject
+(void)startCheckNetwork:(NSString *)title message:(NSArray *)messages cancelButtonTitle:(NSString *)cancelButtonTitle buttonArray:(NSArray *)buttonArray clickButtonIndex:(ClickButtonIndex)buttonIndex dissMiss:(DissMiss)dissMiss;

+(void)createAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle clickButtonIndex:(ClickButtonIndex)buttonIndex dissMiss:(DissMiss)dissMiss;

+(void)createAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle buttonArray:(NSArray *)buttonArray  clickButtonIndex:(ClickButtonIndex)buttonIndex dissMiss:(DissMiss)dissMiss;
@end
