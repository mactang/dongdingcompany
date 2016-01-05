//
//  ChooseAddressViewController.m
//  Eoffice1.0
//
//  Created by tangtao on 15/11/26.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "TarBarButton.h"
#import "LoginMobileViewController.h"
@interface ChooseAddressViewController ()

@end

@implementation ChooseAddressViewController
-(void)setTitlestring:(NSString *)titlestring{
    _titlestring = titlestring;
}
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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 64, 30)];
    label.text = _titlestring;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:16];
    self.navigationItem.titleView = label;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH/7);
    button.backgroundColor = [UIColor whiteColor];
    button.selected = YES;
    [button addTarget: self action:@selector(choosePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *chooselabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH/2, widgetboundsHeight(button)-10)];
    chooselabel.text = @"请选择服务地点";
    chooselabel.font = [UIFont systemFontOfSize:14];
    [button addSubview:chooselabel];
   
    UIImage *image = [UIImage imageNamed:@"zuo"];
    // 创建UIImageView
    UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(SCREEN_WIDTH-30, (widgetboundsHeight(button)-25)/2, image.size.width, image.size.height) ];
    imageView.image = image;
    [button addSubview:imageView];
    // 旋转
    CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI);
    [imageView setTransform:rotate];
}
-(void)choosePressed:(UIButton *)sender{
    
    LoginViewMobileController *login = [[LoginViewMobileController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
  
}
-(void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}

@end
