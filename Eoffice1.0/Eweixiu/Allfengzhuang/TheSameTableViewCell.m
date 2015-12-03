//
//  TheSameTableViewCell.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "TheSameTableViewCell.h"
#import "CalculateStringSpace.h"
@implementation TheSameTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID =@"Cell";
    TheSameTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TheSameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
        self.titlelabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titlelabel];
//        NSString  *msg;
//        msg = [NSString stringWithFormat:@"%@",[[[DATA.specificSearchList objectAtIndex:indexPath.row]objectForKey:@"content"] stringByReplacingOccurrencesOfString:@"\\n" withString:@" \r\n" ]];
//        
//        label.numberOfLines = 0;        //不要忘记设置这个
//        label.text = msg;
        
    }
    return self;
}
-(void)setTitlestring:(NSString *)titlestring{
    _titlestring = titlestring;
    self.titlelabel.text = titlestring;
}
@end
