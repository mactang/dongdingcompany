//
//  TariffHeaderController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/25.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "TariffHeaderController.h"

@implementation TariffHeaderController
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUserInterface];
    }
    return self;
}
- (void)initUserInterface{
    UILabel *servicePrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    servicePrice.text = @"服务报价";
    servicePrice.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:servicePrice];
    
    UILabel *pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(servicePrice.frame), SCREEN_WIDTH-20, 30)];
    pricelabel.text = @"上门费(30元)+安装费(30元/台)=60元";
    pricelabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:pricelabel];
    
    NSMutableAttributedString *readyString = [[NSMutableAttributedString alloc]initWithString:@"服务项目(可多选)"];
    [readyString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(4,5 )];
    
    UILabel *ServiceItems = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(pricelabel.frame), SCREEN_WIDTH-20, 30)];
    ServiceItems.attributedText = readyString;
    ServiceItems.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:ServiceItems];
    NSArray  *messageArray =  @[@"台式灰尘清洁",@"一体机灰尘清洁",@"笔记本灰尘清洁",@"全套清洁处理"];
    
    for (NSInteger i=0; i<messageArray.count; i++) {
        UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        clickButton.frame = CGRectMake(10+(i%3)*((SCREEN_WIDTH-40)/3)+(i%3)*10, CGRectGetMaxY(ServiceItems.frame)+10+((i/3)*((SCREEN_WIDTH-10)/3)), ((SCREEN_WIDTH-40)/3), ((SCREEN_WIDTH-40)/3));
        clickButton.clipsToBounds = YES;
        clickButton.layer.borderColor = [[UIColor grayColor]CGColor];
        clickButton.layer.borderWidth = 1;
        clickButton.selected  = YES;
        [clickButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:clickButton];
        
        UILabel *Itemslabel = [[UILabel alloc]initWithFrame:CGRectMake(1, (widgetboundsHeight(clickButton)-40)/2, widgetboundsHeight(clickButton)-2, 20)];
        Itemslabel.text = messageArray[i];
        Itemslabel.textColor = [UIColor grayColor];
        Itemslabel.textAlignment = NSTextAlignmentCenter;
        Itemslabel.font = [UIFont systemFontOfSize:13];
        [clickButton addSubview:Itemslabel];
        
        UILabel *pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(1, CGRectGetMaxY(Itemslabel.frame), widgetBoundsWidth(Itemslabel), widgetboundsHeight(Itemslabel))];
        pricelabel.text = @"￥30";
        pricelabel.textColor = [UIColor grayColor];
        pricelabel.font = [UIFont systemFontOfSize:14];
        pricelabel.textAlignment = NSTextAlignmentCenter;
        [clickButton addSubview:pricelabel];
    }
}
-(void)buttonPressed:(UIButton *)button{
    if (button.selected) {
        button.layer.borderColor = [[UIColor orangeColor]CGColor];
    }
    else{
        button.layer.borderColor = [[UIColor grayColor]CGColor];
    }
    button.selected = !button.selected;
    
}
@end
