//
//  UIAlertView+AlerViewBlocks.m
//  AlertViewBlocks
//
//  Created by RIMI on 14-7-25.
//  Copyright (c) 2014年 RIMI. All rights reserved.
//

#import "UIAlertView+AlerViewBlocks.h"

typedef void(^alerBlocks)(NSInteger index);

static alerBlocks _alertViewBlocks;

@implementation UIAlertView (AlerViewBlocks)

+(void)errorcode:(NSInteger)code blocks:(void (^)(NSInteger index))blocks{
    NSString *messagestring;
    if (code==-1004) {
        messagestring = @"连接服务器失败";
    }
    if (code==-1001) {
        messagestring = @"连接超时";
    }
    if (code==-1005) {
        messagestring = @"网络连接失败";
    }
    _alertViewBlocks = [blocks copy];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:messagestring delegate:self cancelButtonTitle:@"点击重试" otherButtonTitles:@"取消", nil];
    [alertView show];

}
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    /**
     *  调用blocks
     */
    if (buttonIndex==0) {
        _alertViewBlocks(buttonIndex);
    }
}






















@end
