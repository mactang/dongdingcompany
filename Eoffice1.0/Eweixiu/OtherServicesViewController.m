//
//  OtherServicesViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OtherServicesViewController.h"
@interface OtherServicesViewController ()<UITextViewDelegate>{
    
    UILabel *textlabel;
    
}
@end

@implementation OtherServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"其他服务";
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 69, SCREEN_WIDTH-20, 30)];
    titlelabel.text = @"亲,请填写想要我们为您提供的维修服务^_^";
    titlelabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titlelabel];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 104, SCREEN_WIDTH-20, SCREEN_WIDTH*0.5)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    UITextView *textview = [[UITextView alloc]init];
    textview.frame = CGRectMake(5, 5, widgetBoundsWidth(whiteView)-15, widgetboundsHeight(whiteView)-10);
    textview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    textview.scrollEnabled = YES;
    textview.editable = YES;
    textview.textColor = [UIColor blackColor];
    textview.delegate = self;
    textview.tag = 166;
    textview.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:textview];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    textlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-40,20)];
    textlabel.text = @"手机维修、相机维修、数码维修等需要相关维修服务";
    textlabel.font = [UIFont systemFontOfSize:14];
    textlabel.enabled = NO;
    textlabel.backgroundColor = [UIColor clearColor];
    [whiteView addSubview:textlabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, CGRectGetMaxY(whiteView.frame)+10, SCREEN_WIDTH-20, 40);
    button.clipsToBounds = YES;
    button.layer.cornerRadius=4;
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:191/255.0f green:35/255.0f blue:29/255.0f alpha:1];
    [button addTarget: self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside]
    ;
    [self.view addSubview:button];
}
-(void)buttonPressed:(UIButton *)button{
    
}
#pragma mark_UITextViewdelegate_meathds
-(void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length == 0) {
        textlabel.text = @"手机维修、相机维修、数码维修等需要相关维修服务";
    }else{
        textlabel.text = @"";
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    return YES;
    
}
@end
