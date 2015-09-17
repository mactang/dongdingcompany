//
//  MLKViewController.m
//  MLKMenuPopover
//
//  Created by NagaMalleswar on 20/11/14.
//  Copyright (c) 2014 NagaMalleswar. All rights reserved.
//

#import "GYZViewController.h"
#import "MenuPopover.h"

#define MENU_POPOVER_FRAME  CGRectMake(8, 0, 140, 88)


@interface GYZViewController () <MenuPopoverDelegate>

@property(nonatomic,strong) MenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;

@end

@implementation GYZViewController

#pragma mark -
#pragma mark UIViewController Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Menu Popover";
    
    self.menuItems = [NSArray arrayWithObjects:@"Menu Item 1", @"Menu Item 2", nil];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 120, 30, 30)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(showMenuPopOver:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark -
#pragma mark Actions

- (void)showMenuPopOver:(id)sender
{
    // Hide already showing popover
    [self.menuPopover dismissMenuPopover];
    self.menuPopover = [[MenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
    self.menuPopover.delegate = self;
    [self.menuPopover showInView:self.view];
}

#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(MenuPopover *)menuPopover
{
    [self.menuPopover dismissMenuPopover];
    
//    NSString *title = [NSString stringWithFormat:@"%@ selected.",[self.menuItems objectAtIndex:selectedIndex]];
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    [alertView show];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
