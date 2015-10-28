//
//  MaintainController.m
//  EOffice
//
//  Created by gyz on 15/7/8.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "MaintainController.h"
#import "TarBarButton.h"
@interface MaintainController ()

@end

@implementation MaintainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftButton setTitle:@"保养维修" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    // Do any additional setup after loading the view.
}
-(void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
