//
//  RecommendViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/10/14.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "RecommendViewController.h"
#import "RDVTabBarController.h"
#import "RecommCodeGenerator.h"
@interface RecommendViewController ()

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@"推荐返现"];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    // sample
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 120, 120)];
    imageView.image = [RecommCodeGenerator qrImageForString:@"Hello, world!" imageSize:imageView.bounds.size.width];
    [self.view addSubview: imageView];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 20, 20)];
    image.image = [UIImage imageNamed:@""];
    image.backgroundColor = [UIColor redColor];
    //[imageView addSubview: image];
    
    
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = NO;
    
    [super viewWillDisappear:animated];
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
