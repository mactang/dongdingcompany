//
//  OrderConfrimTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/12/2.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OrderConfrimTableViewCell.h"

@implementation OrderConfrimTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 70, 30)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleLabel];
        
        self.itemLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), widgetFrameY(self.titleLabel), SCREEN_WIDTH-90, widgetboundsHeight(self.titleLabel))];
        self.itemLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.itemLabel];
        
    }
    return self;
}
-(void)setDictionary:(NSDictionary *)dictionary{
    self.titleLabel.text = dictionary[@"title"];
    self.itemLabel.text  =dictionary[@"titleItem"];
}
-(void)setSucess:(BOOL)sucess{
    if (!sucess) {
        self.titleLabel.frame = CGRectMake(10, 10, 70, 30);
        self.itemLabel.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), widgetFrameY(self.titleLabel), SCREEN_WIDTH-90, widgetboundsHeight(self.titleLabel));
        self.itemLabel.textAlignment = NSTextAlignmentRight;
    }
    else{
        self.titleLabel.textColor = [UIColor grayColor];
    }
}
@end
