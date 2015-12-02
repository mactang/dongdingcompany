//
//  OtherServicesViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/24.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "OtherServicesViewController.h"
#import "TarBarButton.h"
#import "photoAlterView.h"
@interface OtherServicesViewController ()<UITextViewDelegate>{
    
    UILabel *textlabel;
    
}
@end

@implementation OtherServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"zuo"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIButton *rightbutton = [UIButton buttonWithType: UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, 0, 30, 30);
    [rightbutton setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    UIBarButtonItem *lightItem = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    [rightbutton addTarget:self action:@selector(rightbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:lightItem];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = @"其他服务";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
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

-(void)rightbuttonClick{
    photoAlterView *alter=[[photoAlterView alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"呼叫"];
    alter.phoneNumber = @"4000-456-423";
    alter.rightBlock=^()
    {
        NSLog(@"右边按钮被点击");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4000456423"]];
    };
    alter.leftBlock=^()
    {
        NSLog(@"左边按钮被点击");
    };
    alter.dismissBlock=^()
    {
        NSLog(@"窗口即将消失");
    };
    [alter show];
    
}
-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}


@end
