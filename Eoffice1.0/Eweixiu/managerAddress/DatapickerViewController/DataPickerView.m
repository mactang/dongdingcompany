//
//  DataPickerView.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/30.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "DataPickerView.h"
@interface DataPickerView()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIDatePicker *datePicker;//日期选择控件
    NSDateFormatter *dateFormatter;//日期格式
    UIDatePickerMode datePickerMode;//日期控件显示风格
    NSDate *date;
    UITextField *textField;
    UIView *subview;
}
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,retain)NSMutableArray *pickerArray;
@property(nonatomic,retain)NSMutableArray *subPickerArray;
@end

@implementation DataPickerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initalizeapprance];
    }
    return self;
}
-(void)initalizeapprance{
    self.pickerArray = [NSMutableArray array];
    self.subPickerArray = [NSMutableArray array];
    for (NSInteger i=0; i<24; i++) {
       
        [self.pickerArray addObject:[NSString stringWithFormat:@"%ld",i]];
      
    }
    for (NSInteger i=0; i<60; i++) {
         [self.subPickerArray addObject:[NSString stringWithFormat:@"%ld",i]];
     
    }
    dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];//location设置为中国
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //picker的默认时间为当前时间
    date=[NSDate date];
    
    //picker的默认style为只显示日期
    datePickerMode=UIDatePickerModeDate;
    
    //构造一个子视图,用于显示日期选择器
    subview=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-380, SCREEN_WIDTH, 380)];
    
    subview.backgroundColor=[UIColor whiteColor];
    
    subview.tag=0;
    [self addSubview:subview];
    
    UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 30)];
    timelabel.text = @"服务时间";
    timelabel.font = [UIFont systemFontOfSize:17];
    timelabel.textAlignment = NSTextAlignmentCenter;
    [subview addSubview:timelabel];
    
    //为子视图构造datePicker
    datePicker=[[UIDatePicker alloc]init];
    
    [datePicker setDate:date];
    
    datePicker.frame=CGRectMake(0, 30, SCREEN_WIDTH, 100);

    datePicker.datePickerMode=datePickerMode;
    
    //指定datepicker的valueChanged事件
    
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [subview addSubview:datePicker]; //把datePicker加入子视图
    
    UILabel *anotherlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(datePicker.frame), SCREEN_WIDTH, 30)];
    anotherlabel.text = @"时间点";
    anotherlabel.font = [UIFont systemFontOfSize:17];
    anotherlabel.textAlignment = NSTextAlignmentCenter;
    [subview addSubview:anotherlabel];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(anotherlabel.frame),SCREEN_WIDTH, 100)];
    //    指定Delegate
    self.pickerView.delegate=self;
    //    显示选中框
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    NSArray *array = [locationString componentsSeparatedByString:@":"];
    
    for (NSInteger i=0; i<[self.pickerArray count]; i++) {
        if ([array[0] integerValue] == [self.pickerArray[i] integerValue]) {
            [self.pickerView selectRow: i inComponent:0 animated:NO];
        }
    }
    for (NSInteger i=0; i<[self.subPickerArray count]; i++) {
        if ([array[1] integerValue] == [self.subPickerArray[i] integerValue]) {
            [self.pickerView selectRow: i inComponent:1 animated:NO];
        }
    }
    [subview addSubview:self.pickerView];

    //上面是子视图，下面是父视图
    
   }
-(void)dateChanged:(id)sender{
    
    date = [sender date];//获取datepicker的日期
    
    //改变textField的值
    
    textField.text=[NSString stringWithString:
                    
                    [dateFormatter stringFromDate:date]];
    
}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return [self.pickerArray count];
    }
   
    return [self.subPickerArray count];
    
}
#pragma mark Picker Delegate Methods
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component==0) {
//        self.prvoice = [self.pickerArray objectAtIndex:row];
        return [self.pickerArray objectAtIndex:row];
    }

//        self.city = [self.subPickerArray objectAtIndex:row][@"name"];
        return [self.subPickerArray objectAtIndex:row];
    
}
//选中滚轮时触发
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component==0) {
    }
    else{

}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
     [UIView animateWithDuration:0.3f animations:^{
         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
     }];
}
@end
