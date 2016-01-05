//
//  ButtonHeaderController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ButtonHeaderController.h"

@implementation ButtonHeaderController

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUserInterface];
    }
    return self;
}
- (void)initUserInterface{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 35);
    self.button.clipsToBounds = YES;
    self.button.layer.cornerRadius=4;
    self.button.backgroundColor = [UIColor colorWithRed:191/255.0f green:35/255.0f blue:29/255.0f alpha:1];
    [self.button addTarget: self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside]
    ;
    [self.contentView addSubview:self.button];

}
-(void)setSectionstring:(NSString *)sectionstring{
    [self.button setTitle:sectionstring forState:UIControlStateNormal];
    
}
-(void)buttonPressed:(UIButton *)button{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(chooseAddressed)]) {
        [self.delegate chooseAddressed];
    }
}
@end
