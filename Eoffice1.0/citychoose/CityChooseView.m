//
//  CityChooseView.m
//  Eoffice1.0
//
//  Created by tangtao on 15/8/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CityChooseView.h"
#import "AFNetworking.h"
#import "Config.h"
@interface CityChooseView()<UIPickerViewDelegate,UIPickerViewDataSource>{

}
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,retain)NSMutableArray* pickerArray;
@property(nonatomic,retain)NSMutableArray* subPickerArray;
@property(nonatomic,retain)NSMutableArray* thirdPickerArray;
@property(nonatomic,retain)NSArray *dataArray;
@property(nonatomic,copy)NSString *prvoice;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *area;
@property(nonatomic,copy)NSString *cityid;
@end
@implementation CityChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self.pickerArray = [NSMutableArray array];
    self.subPickerArray = [NSMutableArray array];
    self.thirdPickerArray = [NSMutableArray array];
    self = [super initWithFrame:frame];
    if (self) {
      [self readdata];
      
    }
    return self;
}
-(void)readdata{
    // 1.获得沙盒根路径
    NSString *home1 = NSHomeDirectory();
    
    // 2.document路径
    NSString *docPath1 = [home1 stringByAppendingPathComponent:@"Documents"];
    
    // 3.文件路径
    NSString *filepath1 = [docPath1 stringByAppendingPathComponent:@"data.plist"];
    
    // 4.读取数据
    NSArray *data1 = [NSArray arrayWithContentsOfFile:filepath1];
    
    if (data1.count !=0) {
       self.dataArray = data1;
        for (NSInteger i=0; i<[self.dataArray count]; i++) {
            [self.pickerArray addObject:self.dataArray[i][@"name"]];
        }
        self.subPickerArray = [self.dataArray objectAtIndex:0][@"city"];
        if ([[self.subPickerArray objectAtIndex:0][@"county"] count]!=0) {
            self.thirdPickerArray = [self.subPickerArray objectAtIndex:0][@"county"];
        }
        else{
            self.area = @"";
        }

        [self initalizaApperance];
    }
    else{
        [self datarequest];
    }
}
-(void)datarequest{
    NSString *path= [NSString stringWithFormat:@"http://192.168.0.65:8080/eoffice/phone/order!selectAll.action"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        // 1.获得沙盒根路径
        NSString *home = NSHomeDirectory();
        
        // 2.document路径
        NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
        
        NSString *filepath = [docPath stringByAppendingPathComponent:@"data.plist"];
        [dic[@"data"] writeToFile:filepath atomically:YES];
        
        self.dataArray = dic[@"data"];
        for (NSInteger i=0; i<[dic[@"data"] count]; i++) {
            [self.pickerArray addObject:dic[@"data"][i][@"name"]];
        }
        self.subPickerArray = [self.dataArray objectAtIndex:0][@"city"];
        if ([[self.subPickerArray objectAtIndex:0][@"county"] count]!=0) {
            self.thirdPickerArray = [self.subPickerArray objectAtIndex:0][@"county"];
        }
        else{
            self.area = @"";
        }
        //        NSLog(@"%@",self.pickerArray);
        //        NSLog(@"%@+++",self.subPickerArray);
        //        NSLog(@"%@---",self.thirdPickerArray);
        [self initalizaApperance];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
-(void)initalizaApperance{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, widgetboundsHeight(self)-180,SCREEN_WIDTH, 200)];
    //    指定Delegate
    self.pickerView.delegate=self;
    //    显示选中框
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pickerView];
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citychoose" ofType:@"plist"];
//    self.dataArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
//  NSLog(@"%@", self.dataArray);//直接打印数据。
//    for (NSInteger i=0; i<self.dataArray.count; i++) {
//        [self.pickerArray addObject:self.dataArray[i][@"state"]];
//    }
//    self.subPickerArray = [self.dataArray objectAtIndex:0][@"cities"];
//    if ([[self.subPickerArray objectAtIndex:0][@"areas"] count]!=0) {
//        self.thirdPickerArray = [self.subPickerArray objectAtIndex:0][@"areas"];
//    }
//    else{
//        self.area = @"";
//    }
//    NSLog(@"%@",self.subPickerArray);
    UIView *linghtView = [[UIView alloc]initWithFrame:CGRectMake(0, widgetboundsHeight(self)-210, SCREEN_WIDTH, 30)];
    linghtView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:linghtView];
    NSArray *buttonarray = @[@"关闭",@"确定"];
    for (NSInteger i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0+i*(SCREEN_WIDTH-50), 0, 50, 30);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:buttonarray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.tag = 10+i;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [linghtView addSubview:button];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     [UIView animateWithDuration:0.4f animations:^{
         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
     } completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
}
#pragma mark -uipickerviewdelegate and uipickerviewdatasource

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
       return [self.pickerArray count];
    }
    if (component==1) {
        return [self.subPickerArray count];
    }
    else{
        return [self.thirdPickerArray count];
    }
}
#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    if (component==0) {
        self.prvoice = [self.pickerArray objectAtIndex:row];
       return [self.pickerArray objectAtIndex:row];
    }
    if (component==1) {
        self.city = [self.subPickerArray objectAtIndex:row][@"name"];
        return [self.subPickerArray objectAtIndex:row][@"name"];
    }
    else{
        if ([self.thirdPickerArray count]!=0) {
            self.area = [self.thirdPickerArray objectAtIndex:row][@"name"];
            self.cityid = [self.thirdPickerArray objectAtIndex:row][@"id"];
            return [self.thirdPickerArray objectAtIndex:row][@"name"];
        }
        else{
            self.area = @"";
            return nil;
        }
    }
    
}
//选中滚轮时触发
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSLog(@"%ld",row);
    if (component==0) {
        self.subPickerArray = [self.dataArray objectAtIndex:row][@"city"];
        self.thirdPickerArray = [self.subPickerArray objectAtIndex:0][@"county"];
        self.prvoice = [self.pickerArray objectAtIndex:row];
        self.city = [self.subPickerArray objectAtIndex:0][@"name"];
        self.cityid = [self.thirdPickerArray objectAtIndex:0][@"id"];
        if ([self.thirdPickerArray count] !=0) {
           self.area = [self.thirdPickerArray objectAtIndex:0][@"name"];
        }
        else{
            self.area = @"";
        }
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }
    else if (component==1) {
        self.thirdPickerArray = [self.subPickerArray objectAtIndex:row][@"county"];
        self.city = [self.subPickerArray objectAtIndex:row][@"name"];
        if ([self.thirdPickerArray count] !=0) {
            self.area = [self.thirdPickerArray objectAtIndex:0][@"name"];
            self.cityid = [self.thirdPickerArray objectAtIndex:row][@"id"];
        }
        else{
            self.area = @"";
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }
    else{
        if ([self.thirdPickerArray count] !=0) {
            self.area = [self.thirdPickerArray objectAtIndex:row][@"name"];
            self.cityid = [self.thirdPickerArray objectAtIndex:row][@"id"];
        }
        else{
            self.area = @"";
        }

       
    }
}
-(void)buttonPressed:(UIButton *)button{
        [UIView animateWithDuration:0.4f animations:^{
            self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    if (button.tag==11) {
        if (_delegate && [self.delegate respondsToSelector:@selector(addressed:cityid:)]) {
            [self.delegate addressed:[NSString stringWithFormat:@"%@%@%@",self.prvoice,self.city,self.area]cityid:self.cityid];
        }
    }
}
@end
