//
//  CMdetailCell.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/13.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CMdetailCell.h"
#import "Control.h"
#import "BigPhotoModel.h"

@interface CMdetailCell()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableView1;
    UITableView *tableView2;
}
@end
@implementation CMdetailCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //cell的背景
        UIImageView *backgroundImageView = [UIImageView imageViewWithFrame:CGRectMake(0, 0, 320, 49) image:@"topic_Cell_Bg"];
        
       // [self.contentView addSubview:backgroundImageView];
        self.backgroundView = backgroundImageView;
        //左边的图片视图
        CGFloat gap = 10;
        CGFloat imageGap = 15;
        
        //创建左边的图片视图
        UIImageView *leftImageViewTemp = [[UIImageView alloc]initWithFrame:CGRectMake(imageGap, gap, 60, 60)];
        //设计圆角
       // [leftImageViewTemp setImage:[UIImage imageNamed:@"1.jpg"]];
        leftImageViewTemp.clipsToBounds = YES;
        //leftImageViewTemp.backgroundColor = [UIColor redColor];
        leftImageViewTemp.layer.cornerRadius = 12;
        
        [self.contentView addSubview:leftImageViewTemp];
        self.leftImageView = leftImageViewTemp;
        //self.leftImageView.backgroundColor = [UIColor redColor];
        
        //创建名字
        UILabel *nameLabelTemp = [UILabel boldLabelWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+gap, gap, 200, 20) title:nil font:15];
        [self.contentView addSubview:nameLabelTemp];
        
        self.nameLabel = nameLabelTemp;
        
//        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
//        [bt addTarget:self action:@selector(btnPrss:) forControlEvents:UIControlEventTouchUpInside];
//        bt.tag = 1000;
//        [self.contentView addSubview:bt];
//        self.myBt = bt;
//
//        UIButton *bt1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bt.frame)+20, 10, 30, 30)];
//        [bt1 addTarget:self action:@selector(btnPrss:) forControlEvents:UIControlEventTouchUpInside];
//        bt1.tag = 1001;
//        [self.contentView addSubview:bt1];
//        self.myBt1 = bt1;

        
        
        
    }
    return self;
}
-(void)btnPrss:(UIButton *)bt{
    NSLog(@"...");
    if (bt.tag == 1000) {
        
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320, 200)];
    tableView1.backgroundColor = [UIColor orangeColor];
        tableView1.delegate = self;
        tableView1.dataSource = self;
    [self addSubview:tableView1];
    }if (bt.tag == 1001) {
        tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, 320, 200)];
        tableView2.backgroundColor = [UIColor grayColor];
        tableView2.tag = 1;
        tableView2.delegate = self;
        tableView2.dataSource = self;
        [self addSubview:tableView2];
    }
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 5;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return 5;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([tableView isEqual:tableView1]) {
//    static NSString *ident = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
//        
//    }
//    cell.textLabel.text = @"jj";
//        
//    return cell;
//    }
//   else if([tableView isEqual:tableView2]){
//        static NSString *ident = @"cell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
//            
//        }
//        cell.textLabel.text = @"aa";
//        return cell;
//    
//   }
//    return nil;
//}
//创建一个cell对象
+(CMdetailCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ident = @"cell";
    CMdetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[CMdetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
//    }else{
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject]removeFromSuperview];
//        }
//    }
    
    return cell;
}

-(void)setMyModel:(BigPhotoModel *)myModel{

    myModel = myModel;
    self.backgroundView.frame = self.frame;
    
   // self.leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:myModel.imageName]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
