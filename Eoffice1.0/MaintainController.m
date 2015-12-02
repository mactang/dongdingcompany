//
//  MaintainController.m
//  EOffice
//
//  Created by gyz on 15/7/8.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "MaintainController.h"
#import "TarBarButton.h"
#import "RDVTabBarController.h"
#import "Titlebutton.h"
#import "photoAlterView.h"
#import "OfficeEequipmentViewController.h"
#import "ComputerCleaningViewController.h"
#import "HardwareDetectionViewController.h"
#import "SoftwareSystemViewController.h"
#import "LANmaintenanceViewController.h"
#import "MechanicalViewController.h"
#import "OtherServicesViewController.h"
#import "CommonAddressViewController.h"

@interface MaintainController ()

@end

@implementation MaintainController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
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
    label.text = @"维修服务";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = label;
    
    NSArray *imageName = @[@"weixiu",@"qingjie",@"yingjian",@"bangong",@"juyuwang",@"jidian",@"qita"];
    NSArray *imagetitle = @[@"软件系统维护",@"电脑清洁保养",@"硬件检测维修",@"办公设备维修",@"局域网维修",@"机电维修",@"其他服务",];
    for (NSInteger i=0; i<imageName.count; i++) {
        Titlebutton  *button = [[Titlebutton alloc]initWithFrame:CGRectMake(15+(i%3)*((SCREEN_WIDTH-60)/3)+(i%3)*15, 74+(i/3)*100, (SCREEN_WIDTH-60)/3, (SCREEN_WIDTH)/4)];
        [button setImage:[UIImage imageNamed:imageName[i]] forState:UIControlStateNormal];
        [button setTitle:imagetitle[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:button];
        }
}
-(void)buttonPressed:(UIButton *)button{
    NSInteger index = button.tag-1000;
    switch (index) {
        case 0:{
            SoftwareSystemViewController *software = [[SoftwareSystemViewController alloc]init];
            [self.navigationController pushViewController:software animated:YES];
        }
            break;
        case 1:{
            ComputerCleaningViewController *computerclean = [[ComputerCleaningViewController alloc]init];
            [self.navigationController pushViewController:computerclean animated:YES];
        }
            break;
        case 2:{
            HardwareDetectionViewController *hardware = [[HardwareDetectionViewController alloc]init];
            [self.navigationController pushViewController:hardware animated:YES];
        }
            break;
        case 3:{
            OfficeEequipmentViewController *offficeEquipment = [[OfficeEequipmentViewController alloc]init];
            [self.navigationController pushViewController:offficeEquipment animated:YES];
        }
            break;
        case 4:{
            LANmaintenanceViewController *labmaintenance = [[LANmaintenanceViewController alloc]init];
            [self.navigationController pushViewController:labmaintenance animated:YES];
        }
            break;
        case 5:{
            MechanicalViewController *mechanical = [[MechanicalViewController alloc]init];
            [self.navigationController pushViewController:mechanical animated:YES];
        }
            break;
        case 6:{
//            OtherServicesViewController *otherServices = [[OtherServicesViewController alloc]init];
//            [self.navigationController pushViewController:otherServices animated:YES];
            CommonAddressViewController *commonAddress =[[CommonAddressViewController alloc]init];
            [self.navigationController pushViewController:commonAddress animated:YES];
            
        }
            break;
        default:
            break;
    }
   
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
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}
@end
