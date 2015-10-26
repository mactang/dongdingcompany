//
//  LeftSortsViewController.m
//  EOffice
//
//  Created by gyz on 15/7/9.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "LeftSlideViewController.h"
#import "CommodityViewController.h"
#import "AFNetworking.h"
#import "CategoryBig.h"
#import "RDVTabBarController.h"
#import "ComputerViewController.h"
#import "SingleModel.h"

@interface LeftSortsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)NSMutableArray *datas;
@property(nonatomic, strong)NSMutableArray *detailDatas;
@end

@implementation LeftSortsViewController
//懒加载
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)detailDatas{

    if (_detailDatas == nil) {
        _detailDatas = [NSMutableArray array];
    }
    return _detailDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageview];
    
    [self data];
    
    NSLog(@"self.datas%@",self.datas);
    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = CGRectMake(0, 60, 200, SCREEN_HEIGHT-60);
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)setMyModel:(CategoryBig *)myModel{
    _myModel = myModel;
    NSLog(@"%@",myModel.name);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor grayColor];
    UIImage *imge = [UIImage imageNamed:@"sousou1"];
    UIImageView *imgV = [[UIImageView alloc]initWithImage:imge];
    cell.selectedBackgroundView = imgV;
    NSArray *imageName = @[@"pos",@"zhizhang",@"diannao",@"dayingji",@"chuanzhenji"];
    CategoryBig *model = self.datas[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"       %@",model.name];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 22, 22)];
    imageView.image = [UIImage imageNamed:imageName[indexPath.row]];
    [cell addSubview:imageView];
  
//    NSLog(@"MProductMedcategoryId--%@",model.MProductMedcategoryId);
//    
//    NSString *path1= [NSString stringWithFormat:MAINTAINSORTSSMART,COMMON,model.MProductMedcategoryId];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:path1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        if (dic[@"data"] !=[NSNull null]){
//        NSArray *array = dic[@"data"];
//        
//        for(NSDictionary *subDict in array)
//        {
//            CategoryBig *model = [CategoryBig modelWithDic:subDict];
//            [self.detailDatas addObject:model];
//        }
//    }
//        [self category];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//
//    //初始化选中行
//    NSIndexPath *ind = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableview scrollToRowAtIndexPath:ind atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//    [self.tableview selectRowAtIndexPath:ind animated:YES scrollPosition:UITableViewScrollPositionMiddle];
       return cell;
}
-(void)data{
    
    NSString *path= [NSString stringWithFormat:MAINTAINSORTS,COMMON];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"data"];
        NSLog(@"array--%@",array);
        for(NSDictionary *subDict in array)
        {
            CategoryBig *model = [CategoryBig modelWithDic:subDict];
            [self.datas addObject:model];
            NSLog(@"model.name--%@",self.datas);
        }
        //刷新表
        [_tableview reloadData];
        //初始化选中行
        NSIndexPath *ind = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableview scrollToRowAtIndexPath:ind atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self.tableview selectRowAtIndexPath:ind animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
        [self category];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //打开这个方法选择颜色就会消失
  //  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CategoryBig *model = self.datas[indexPath.row];
    NSLog(@"MProductMedcategoryId--%@",model.MProductCategoryId);
    
    NSString *path1= [NSString stringWithFormat:MAINTAIN,COMMON,model.MProductCategoryId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"data"];
      
        for(NSDictionary *subDict in array)
        {
            CategoryBig *model = [CategoryBig modelWithDic:subDict];
            [self.detailDatas addObject:model];
        }
            [self category];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)category{
    
    UIView *printerView = [[UIView alloc]initWithFrame:CGRectMake(140, 63, 200, widgetboundsHeight(self.tableview))];
    printerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:printerView];
    int x = 10;
    int y = 40;
    
    for (int i =0; i<self.detailDatas.count; i++) {
        if (i==0 || i%2!=0) {
            CategoryBig *model = self.detailDatas[i];
            NSLog(@"%@",model.name);
            NSLog(@"x--%d",x);
            NSLog(@"y--%d",y);
//            UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 80, 30)];
//            LB1.text = [NSString stringWithFormat:@"%@",model.name];
//            LB1.font = [UIFont systemFontOfSize:12];
//            [printerView addSubview:LB1];
            
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 80, 30)];
            btn1.tag = i;
            [btn1 setTitle:[NSString stringWithFormat:@"%@",model.name] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(categoryBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            btn1.titleLabel.font = [UIFont systemFontOfSize:12];
     
            [printerView addSubview:btn1];

            x = x+10+80;
        }
        else{
            CategoryBig *model = self.detailDatas[i];
            NSLog(@"%@",model.name);
            y = y+40+30;
            x = 10;
//            UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 80, 30)];
//            LB1.text = [NSString stringWithFormat:@"%@",model.name];
//            LB1.font = [UIFont systemFontOfSize:12];
//            [printerView addSubview:LB1];
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(x, y, 80, 30)];
            [btn1 setTitle:[NSString stringWithFormat:@"%@",model.name] forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(categoryBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.tag = i;
            btn1.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [printerView addSubview:btn1];
            
            x = x+10+80;
        }
        
    }
    [self.detailDatas removeAllObjects];

    
}
-(void)categoryBtnPress:(UIButton *)btn{
    SingleModel *single = [SingleModel sharedSingleModel];
    
    CategoryBig *model = self.datas[btn.tag];
    
    NSLog(@"%@",model.MProductMedcategoryId);
    //将值存储到单例对象里面
    single.ids = model.MProductMedcategoryId;
    
    ComputerViewController *com = [[ComputerViewController alloc]init];
    [self.navigationController pushViewController:com animated:YES];
    

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
