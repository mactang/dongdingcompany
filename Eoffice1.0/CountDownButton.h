//
//  CountDownButton.h
//  Eoffice1.0
//
//  Created by gyz on 15/11/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountDownButton;
typedef NSString* (^DidchangeBlock)(CountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(CountDownButton *countDownButton,int second);
typedef void (^TouchedDownBlock)(CountDownButton *countDownButton,NSInteger tag);
@interface CountDownButton : UIButton
{

    int _second;
    int _totalSecond;
    
    NSTimer *_timer;
    NSDate *_startDate;
    
    DidchangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
-(void)addToucheHandler:(TouchedDownBlock)touchHandler;

-(void)didChange:(DidchangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;

@end
