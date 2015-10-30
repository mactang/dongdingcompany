//
//  NewsViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/20.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "NewsViewController.h"
#import "DetailNewsViewController.h"
#import "RDVTabBarController.h"
#import "TarBarButton.h"
@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    TarBarButton *leftButton = [[TarBarButton alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    [leftButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [leftButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    leftButton.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    [self.navigationItem setTitle:@"消息"];
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -1, 320, 550) style:UITableViewStyleGrouped];
    //_tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.scrollEnabled = NO;
    
    //设置uitableview的cell分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
   // _tableView.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)leftItemClicked{
    
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 300, 285)];
    button.backgroundColor = [UIColor whiteColor];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 5;
    button.layer.borderWidth = 1;
  //  button.layer.borderColor = [[UIColor grayColor]CGColor];
    cell.backgroundColor = [UIColor grayColor];
    
    
    [cell addSubview:button];
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 320, 20)];
    titleLB.font = [UIFont systemFontOfSize:18];
    titleLB.text = @"下一个主角就是你，E办公在等你";
    titleLB.textColor = [UIColor blackColor];
    [button addSubview:titleLB];
    
    UILabel *dateLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLB.frame)-5, 100, 40)];
    dateLB.font = [UIFont systemFontOfSize:12];
    dateLB.text = @" 7月11日";
    dateLB.textColor = [UIColor blackColor];
    //dateLB.backgroundColor = [UIColor redColor];
    [button addSubview:dateLB];
    
    UIImageView *imageView = [[ UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLB.frame)+35, 300, 100)];
    imageView.image = [UIImage imageNamed:@"xiaoxintu"];
    [button addSubview:imageView];
    
    UILabel *deatailLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, 280, 60)];
    deatailLB.font = [UIFont systemFontOfSize:12];
    NSString * cLabelString = @"成都东鼎泰和科技有限公司前身系成都东华贸易中心,成立于1996年,前期以主营二手电脑、办公耗材卖场为主,在数码市场管理日趋成熟,结合现有市场分析,公司从新定位,";
    deatailLB.lineBreakMode = NSLineBreakByTruncatingTail;
    deatailLB.numberOfLines = 3;
    deatailLB.textColor = [UIColor blackColor];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:cLabelString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [cLabelString length])];
    [deatailLB setAttributedText:attributedString1];
    [deatailLB sizeToFit];
    
    [button addSubview:deatailLB];
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(-15, CGRectGetMaxY(deatailLB.frame)+10, 100, 20)];
    moreButton.backgroundColor = [UIColor whiteColor];
    moreButton.clipsToBounds = YES;
    moreButton.font = [UIFont systemFontOfSize:12];
    [moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(detailPress) forControlEvents:UIControlEventTouchUpInside];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addSubview:moreButton];
    
    
    return cell;
}
-(void)detailPress{

    DetailNewsViewController *detail = [[DetailNewsViewController alloc]init];
    
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    [super viewWillDisappear:animated];
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
