//
//  ScreenMainTainController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/29.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ScreenMainTainController.h"
#import "RDVTabBarController.h"
#import "HMSegmentedControl.h"
@interface ScreenMainTainController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ScreenMainTainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"品牌";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(rightItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //rightButton.font = [UIFont systemFontOfSize:20];
    rightButton.frame = CGRectMake(0, 20, 60, 20);
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    [self.navigationItem setRightBarButtonItem:rightItem2];
    
    
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    
    CGFloat yDelta = 60;
    
//    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"推荐品牌", @"字母顺序"]];
//    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
//    self.segmentedControl.frame = CGRectMake(0, yDelta, self.view.frame.size.width, 40);
//    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 100, 0, 14);
//    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionIndicatorLocationDown;
//    self.segmentedControl.selectionIndicatorHeight = 1.5f;
//    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
//    self.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
//    self.segmentedControl.font = [UIFont systemFontOfSize:12.5];
//    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
//    self.segmentedControl.userDraggable = NO;
//    self.segmentedControl.textColor = [UIColor blackColor];
//    self.segmentedControl.selectedTextColor = [UIColor blackColor];
//    [self.view addSubview:self.segmentedControl];
    HMSegmentedControl *segmentedControl2 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"推荐品牌", @"字母顺序"]];
    segmentedControl2.frame = CGRectMake(0, 60, self.view.frame.size.width, 40);
    segmentedControl2.selectionIndicatorHeight = 4.0f;
    segmentedControl2.backgroundColor = [UIColor whiteColor];
    segmentedControl2.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl2.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    [segmentedControl2 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl2];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(segmentedControl2.frame), 320, 480) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentedControl{
    NSLog(@"asdsds");
    
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)rightItemClicked{
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    NSArray *array = @[@"全部",@"ThinkPad",@"联系(Lenovo)",@"华硕(ASUS)",@"苹果(Apple)",@"戴尔(DELL)",@"鸿基(acer)",@"惠普(HP）",@"神州行(HASEE)",];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
