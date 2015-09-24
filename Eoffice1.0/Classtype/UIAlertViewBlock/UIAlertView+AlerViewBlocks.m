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

+ (void)showMsgWithTitle:(NSString *)title
                     promptmessage:(NSString *)promptmessage
                 confirm:(NSString *)confirm
                  cancel:(NSString *)cancel blocks:(void (^)(NSInteger))blocks {
    
    _alertViewBlocks = [blocks copy];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:promptmessage delegate:self cancelButtonTitle:confirm otherButtonTitles:cancel, nil];

//    for (int i=0; i<confirm.count; i++) {
//        [alertView addButtonWithTitle:confirm[i]];
//    }
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
