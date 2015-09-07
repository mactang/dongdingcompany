//
//  MyAlertView.m
//
//  Created by Francis on 15-1-26.
//  Copyright (c) 2015年 Francis. All rights reserved.
//

#import "MyAlertView.h"

@implementation MyAlertView

static ClickButtonIndex  _buttonIndex;
static DissMiss  _dissMiss;
NSInteger check = 1;
+ (BOOL) connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+(void)startCheckNetwork:(NSString *)title message:(NSArray *)messages cancelButtonTitle:(NSString *)cancelButtonTitle buttonArray:(NSArray *)buttonArray clickButtonIndex:(ClickButtonIndex)buttonIndex dissMiss:(DissMiss)dissMiss
{
    
    NSString *str;
    if (check == 1) {
        _buttonIndex = [buttonIndex copy];
        _dissMiss = [dissMiss copy];
        if (![self connectedToNetwork]) {
            
            str = messages[0];
        }
        else
        {
            str = messages[1];
        }
        [self createAlertView:title message:str cancelButtonTitle:cancelButtonTitle buttonArray:buttonArray];
    }
}
+(void)createAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle clickButtonIndex:(ClickButtonIndex)buttonIndex dissMiss:(DissMiss)dissMiss
{
    if (check == 1) {
        _buttonIndex = [buttonIndex copy];
        _dissMiss = [dissMiss copy];
        
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:title
                                  message:message
                                  delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        [alertView show];
        check = 0;
    }
    
   
}

+(void)createAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle buttonArray:(NSArray *)buttonArray  clickButtonIndex:(ClickButtonIndex)buttonIndex dissMiss:(DissMiss)dissMiss
{
    _buttonIndex = [buttonIndex copy];
    _dissMiss = [dissMiss copy];
    [self createAlertView:title message:message cancelButtonTitle:cancelButtonTitle buttonArray:buttonArray];
}

+(void)createAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle buttonArray:(NSArray *)buttonArray
{
    check = 0;
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    for (int i = 0; i < buttonArray.count; i++) {
        [alertView addButtonWithTitle:buttonArray[i]];
    }
    [alertView show];
}

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    check = 1;
    _buttonIndex(buttonIndex);
}

+(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    check = 1;
    _dissMiss();
    
}
@end

