//
//  ShoppingCarController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/28.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "ShoppingCarController.h"
#import "RDVTabBarController.h"
#import "SingleModel.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "ShopCarModel.h"
#import "OrderController.h"
#import "ShopCartId.h"
#import "CMDetailsViewController.h"
#import "ShopCarCell.h"
@interface ShoppingCarController ()<UITableViewDataSource,UITableViewDelegate,celldelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic, strong)UIButton *numberBtn1;
@property(nonatomic,strong)UILabel *numberLb1;
@property (strong,nonatomic)UIButton * tmpBtn;
@property(nonatomic,assign)NSString *cartId;
@property (strong,nonatomic)UIButton *selectButton;
@end

@implementation ShoppingCarController

{
    BOOL invoiceSelector;
    NSIndexPath *selectIndexPath;
    UIButton *chooseBtn;
    UIButton *chooseBtn1;
    UIButton *chooseBtn2;
    UIButton *allBtn;
    UILabel *totoalBL;
    NSMutableArray *totoalArray;
    NSMutableArray *totoalCount;
    int total;
    int everyCount;
    int totalEvery;
    int otherAllTotal;
    
    UIButton *versionButton;
    NSMutableArray *btnMutableArray;
    NSMutableArray *numberIndex;
   
     NSMutableArray *DeleteRow;
    int number;
    BOOL isAllDelete;
    UIButton *editorBtn;
    UIButton *currentbutton;
    NSString *chooseType;
    UIButton *selectButton;
    UILabel *countBL;
    ShopCarModel *countModel;
    
    NSMutableArray *cartIdArray;
    UIButton *versionSelectButton;
    
    NSMutableArray *versionGoodId;
    NSString *goodId;
    NSMutableArray *versionCartId;
    NSString *cartIdTwo;
    NSMutableArray *versionCount;
    NSString *count;
    
    NSString *changeCount;
    BOOL isAllOrder;
    BOOL selectedAll;
    
    NSMutableArray *cellarraydata;
    
    NSMutableArray *contacts;
    NSMutableArray *totalPrice;
    
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contacts = [NSMutableArray array];
    totalPrice = [NSMutableArray array];
    otherAllTotal = 0;
    cellarraydata = [NSMutableArray array];
    totoalArray = [NSMutableArray array];
    totoalCount = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@"我的购物车"];
    
    [self downData];
    
    selectedAll = NO;
    versionGoodId = [NSMutableArray array];
    
    versionCartId = [NSMutableArray array];
    
    versionCount = [NSMutableArray array];
    
    invoiceSelector = 0;
    isAllDelete = NO;
    total = 0;
    numberIndex = [NSMutableArray array];
    DeleteRow = [NSMutableArray array];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    // _tableView.showsVerticalScrollIndicator = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1000;
    [self.view addSubview:_tableView];
    
    UIView *totView = [[UIView alloc]initWithFrame:CGRectMake(0, 440, 320, 80)];
    totView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:totView];
    
    allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(10, 20, 20, 20);
    [allBtn setImage:[UIImage imageNamed:@"checkNO"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"checkYES"] forState:UIControlStateSelected];
    [allBtn addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    [totView addSubview:allBtn];
    
    UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(allBtn.frame)+10, allBtn.frame.origin.y, 40, 20)];
    LB.font = [UIFont systemFontOfSize:17];
    LB.text = @"全选";
    LB.textColor = [UIColor blackColor];
    [totView addSubview:LB];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(LB.frame)+10, allBtn.frame.origin.y, 40, 20)];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(delegatePress) forControlEvents:UIControlEventTouchUpInside];
    [totView addSubview:btn];
    
    totoalBL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+10, allBtn.frame.origin.y-10, 100, 20)];
    totoalBL.font = [UIFont systemFontOfSize:13];
    
    totoalBL.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",totalEvery];
    [totView addSubview:totoalBL];
    UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+50, CGRectGetMaxY(totoalBL.frame), 60, 20)];
    LB1.font = [UIFont systemFontOfSize:13];
    LB1.text = @"不含运费";
    LB1.textColor = [UIColor blackColor];
    [totView addSubview:LB1];
    
    cartIdArray = [NSMutableArray array];
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totoalBL.frame)+10, 10, 60, 50)];
    sure.titleLabel.font = [UIFont systemFontOfSize:17];
    sure.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    sure.clipsToBounds = YES;
    sure.layer.cornerRadius = 5;
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sureShopCar) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [totView addSubview:sure];
    
    // Do any additional setup after loading the view.
}
-(void)sureShopCar{
 NSLog(@"%@",cartIdArray);
    [self cartData];
    
}
-(void)cartData{

    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *carString = [[NSString alloc]init] ;
    carString = cartIdArray[0];
    for (int i = 1; i<cartIdArray.count; i++) {
        
        carString = [NSString stringWithFormat:@"%@,%@",carString, cartIdArray[i]];
        
    }
    NSLog(@"%@",carString);
   
    
    NSString *path= [NSString stringWithFormat:SHOPCARTID,COMMON,model.userkey,carString];
    
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            NSDictionary *array = dic[@"data"];
            
                ShopCartId *model = [ShopCartId modelWithDic:array];
                NSLog(@"%lu",(unsigned long)model.list.count);
            OrderController *order  = [[OrderController alloc]init];
            order.shopCartId = model.list[0][@"cartId"];
    
            for (int i = 1; i<model.list.count; i++) {
                
                
                order.shopCartId = [NSString stringWithFormat:@"%@,%@",order.shopCartId,model.list[i][@"cartId"]];

                
                
    
            }
            NSLog(@"%@",order.shopCartId);
            [self.navigationController pushViewController:order animated:YES];
        }else {
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(void)delegatePress{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除订单" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消",nil];
    //设置提示框样式（可以输入账号密码）
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        NSLog(@"....");
    }else{
        if (isAllDelete == NO) {
            for (int i = 0; i<numberIndex.count; i++) {
                
                NSLog(@"%@",numberIndex[i]);
                NSLog(@"count-%lu",(unsigned long)numberIndex.count);
                NSLog(@"%ld",[[NSString stringWithFormat:@"%@",numberIndex[i]] integerValue]/2);
                [self.datas removeObjectAtIndex:[[NSString stringWithFormat:@"%@",numberIndex[i]] integerValue]/2];
                
                NSLog(@"number--%d",number);
                
                
                number = i;
        }
            [self deleteData];
            // [self downData];
            [numberIndex removeAllObjects];
        }
        if(isAllDelete == YES){
            
            [self AllDeleteData];
            [self.datas removeAllObjects];
            // [self downData];
           
            
        }
        
        
        [_tableView reloadData];
        
        //[self deleteData];
        
    }
}
-(void)deleteData{
    
    NSLog(@"%@",DeleteRow);
    for (int i = 0; i<DeleteRow.count; i++) {
    NSLog(@"%d",number);
    NSString *path= [NSString stringWithFormat:DELETESHOPCAR,COMMON,DeleteRow[i]];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"status"];
        NSString *string = [NSString stringWithFormat:@"%@",array];
        NSLog(@"array--%@",string);
        if ([string isEqualToString:@"1"]) {
            
            
        }
        else{
        }
        
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    }
    
}

-(void)AllDeleteData{
    
    NSLog(@"%@",DeleteRow);
    for (int i = 0; i<self.datas.count; i++) {
        NSLog(@"%d",number);
        
        ShopCarModel *model = self.datas[i];
        
        NSString *path= [NSString stringWithFormat:DELETESHOPCAR,COMMON,model.cartId];
        NSLog(@"%@",path);
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (dic[@"data"] !=[NSNull null]){
                NSArray *array = dic[@"status"];
                NSString *string = [NSString stringWithFormat:@"%@",array];
                NSLog(@"array--%@",string);
                if ([string isEqualToString:@"1"]) {
                    
                    
                }
                else{
                }
                
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}

- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)allSelect:(UIButton*)sender{
    

    
   // selectedAll = ! selectedAll;
           allBtn.selected = !allBtn.selected;
    if (sender.selected == YES) {
        
        isAllDelete = YES;
        NSLog(@"%lu",(unsigned long)self.datas.count);
        for (int i=0; i<self.datas.count; i++) {
            ShopCarModel *model = self.datas[i];
            
            [cartIdArray addObject:model.cartId];
        }
        selectedAll = YES;

    }else{
        isAllDelete = NO;
        selectedAll = NO;
    }

    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        ShopCarCell *cell = (ShopCarCell*)[_tableView cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSLog(@"%lu",(unsigned long)row);
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        if (sender.selected == YES) {
             [dic setObject:@"YES" forKey:@"checked"];
            [cell setChecked:YES];
        }else {
             [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
        }
    }
    if (sender.selected == YES){
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"YES" forKey:@"checked"];
        }
        otherAllTotal = totalEvery;
        NSLog(@"%d",totalEvery);
        totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",otherAllTotal];
    }else{
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"NO" forKey:@"checked"];
        }
        totoalBL.text = @"合计: ￥";
       // [(UIButton*)sender setTitle:@"全选" forState:UIControlStateNormal];
    }

    
}

- (void)downData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SHOPCAR,COMMON,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
        
        for(NSDictionary *subDict in array)
        {
            ShopCarModel *model = [ShopCarModel modelWithDic:subDict];
            [self.datas addObject:model];
            
            [totoalArray addObject:[NSString stringWithFormat:@"%@",model.price]];
            [totoalCount addObject:[NSString stringWithFormat:@"%@",model.count]];
            
        }
            NSLog(@"%@",totoalArray);
            total = 0;
            everyCount = 0;
            totalEvery = 0;
            
            for (int i = 0; i<totoalArray.count; i++) {
                
                NSLog(@"totoalArray--%@",totoalArray[i]);
                NSLog(@"totoalCount--%@",totoalCount[i]);
                total = [[NSString stringWithFormat:@"%@",totoalArray[i]]intValue];
                everyCount = [[NSString stringWithFormat:@"%@",totoalCount[i]]intValue];
                totalEvery = total*everyCount + totalEvery;
                
            }
            
           // totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",totalEvery];
//            int n = [[NSString stringWithFormat:@"%d",totalEvery]intValue];
//             otherAllTotal = n ;
        }else {
        
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

        return 120;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%lu",(unsigned long)self.datas.count);
    
    for (int i = 0; i <self.datas.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"NO" forKey:@"checked"];
        [contacts addObject:dic];
    }
    NSLog(@"%lu",contacts.count);
    
    
     static NSString * identifier = @"Cell";
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.numbercell = indexPath.row;
    cell.myModel = self.datas[indexPath.row];
    cell.delegate = self;
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }

    
    return cell;
}
-(void)signMutablearray:(UIButton *)btn{
   
    
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    
    NSLog(@"count--%lu",(unsigned long)anArrayOfIndexPath.count);
    NSLog(@"btn.tag--%ld",(long)btn.tag);
   // NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:btn.tag];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    ShopCarCell *cell = (ShopCarCell*)[_tableView cellForRowAtIndexPath:path];
    
    NSUInteger row = [path row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
    }
    
    ShopCarModel *model = self.datas[btn.tag];
    
    [cartIdArray addObject:model.cartId];
    
    NSLog(@"%ld",(long)btn.tag);
    NSString *string = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    [numberIndex addObject:string];
    NSLog(@"%@",numberIndex);
    
    
   // btn.selected = !btn.selected;
    if (btn.selected == YES) {
        ShopCarModel *model = self.datas[btn.tag];
        _cartId = model.cartId;
        [DeleteRow addObject:_cartId];
    }
    
    
    NSLog(@"%@",DeleteRow);
    
    
}
-(void)subCount:(NSString *)subCountLB{
    
    int m = [[NSString stringWithFormat:@"%@",subCountLB]intValue];
    totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",otherAllTotal-m];
    otherAllTotal = [[NSString stringWithFormat:@"%d",otherAllTotal-m]intValue];
    NSLog(@"totalEvery--%d",totalEvery);
    if (selectedAll == YES) {
        
    totalEvery = totalEvery - m;
    totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",totalEvery];
    NSLog(@"totalEvery-m--%d",totalEvery);
        
    }
    
    
}
-(void)addCount:(NSString *)addCountLB{

    int m = [[NSString stringWithFormat:@"%@",addCountLB]intValue];
    totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",m+otherAllTotal];
    otherAllTotal = [[NSString stringWithFormat:@"%d",m+otherAllTotal]intValue];
    if (selectedAll == YES) {
    totalEvery = totalEvery + m;
    totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",totalEvery];

    }
}

-(void)chooseCount:(NSString *)chooseCountLB{
    //    NSLog(@"addCountLB--%d",totalEvery);
    
    int m = [[NSString stringWithFormat:@"%@",chooseCountLB]intValue];
    //int n = [[NSString stringWithFormat:@"%d",totalEvery]intValue];
    
    NSLog(@"m--%d",m);
    NSLog(@"otherAllTotal--%d",otherAllTotal);
    NSLog(@"m+otherAllTotal--%d",m+otherAllTotal);
    if (selectedAll == NO) {
        int n = [[NSString stringWithFormat:@"合计: ￥%@",totoalBL.text]intValue];
        
    totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",m+n];
    
   // otherAllTotal = [[NSString stringWithFormat:@"%d",m+otherAllTotal]intValue];
        selectedAll = YES;
    }else{
    
        totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",m+otherAllTotal];
        otherAllTotal = [[NSString stringWithFormat:@"%d",m+otherAllTotal]intValue];
        selectedAll=NO;
    }
}

-(void)noChooseCount:(NSString *)chooseCountLB{
    allBtn.selected = NO;
    int m = [[NSString stringWithFormat:@"%@",chooseCountLB]intValue];
    if (selectedAll == NO) {
        
        totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",otherAllTotal-m];
        
        otherAllTotal = [[NSString stringWithFormat:@"%d",otherAllTotal-m]intValue];
    }else{
        totalEvery = totalEvery - m;
        totoalBL.text = [NSString stringWithFormat:@"合计: ￥%d",totalEvery];
        
    }
    
    
}

-(void)versionPress:(UIButton *)btn{
    
    goodId = versionGoodId[(btn.tag-10)/2];
    cartIdTwo = versionCartId[(btn.tag-10)/2];
    
    if (versionSelectButton == btn) {
        return;
    }
    versionSelectButton.selected = NO;
    btn.selected = YES;
    if(versionSelectButton.selected == NO){
        versionSelectButton.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    if (btn.selected) {
        
        btn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];
        
    }
    versionSelectButton = btn;
}


-(void)colorBtnPress:(UIButton *)btn{

   
    if (_selectButton == btn) {
        return;
    }
    _selectButton.selected = NO;
    btn.selected = YES;
    if(_selectButton.selected == NO){
        _selectButton.layer.borderColor = [[UIColor grayColor] CGColor];
    }
    if (btn.selected) {
        
        btn.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] CGColor];
        
    }
    _selectButton = btn;
}


-(void)editorPress:(UIButton *)btn{
    
  
    
    changeCount = [NSString stringWithFormat:@"%@",countBL.text];
    if (currentbutton==btn) {
        
        invoiceSelector = !invoiceSelector;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag+1 inSection:0];
        
        
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    NSLog(@"%@",btn.titleLabel.text);
        btn.selected =! btn.selected;
        NSLog(@"%@",btn.titleLabel.text);
        if (!invoiceSelector) {
             [self editorData];
           
        }
                return;
    }
    if (invoiceSelector) {
    
    }
    currentbutton.selected = NO;
    btn.selected =! btn.selected;
    currentbutton = btn;
    
    NSLog(@"%@",btn.titleLabel.text);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag+1 inSection:0];
    
    selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    
    invoiceSelector = !invoiceSelector;

//    if (!invoiceSelector) {
//        invoiceSelector = YES;
//        
//        }
    [_tableView reloadRowsAtIndexPaths:@[selectIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
    
}

-(void)editorData{
    
    
    NSString *path= [NSString stringWithFormat:EDITORVERSION,COMMON,cartIdTwo,goodId,count];
    
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            NSDictionary *array = dic[@"data"];
            
            
            ShopCartId *model = [ShopCartId modelWithDic:array];
            NSLog(@"%lu",(unsigned long)model.list.count);
            OrderController *order  = [[OrderController alloc]init];
            order.shopCartId = model.list[0][@"cartId"];
            
            for (int i = 1; i<model.list.count; i++) {
                
                
                order.shopCartId = [NSString stringWithFormat:@"%@,%@",order.shopCartId,model.list[i][@"cartId"]];
                
                
                
                
            }
            NSLog(@"%@",order.shopCartId);
            [self.navigationController pushViewController:order animated:YES];
        }else {
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCarModel *model = self.datas[indexPath.row/2];
    SingleModel *sing = [SingleModel sharedSingleModel];
    sing.goodsId = model.goodsId;
    NSLog(@"%@",model.goodsId);
    sing.paraId = @"123";
    sing.cPartnerId = @"443";
    
    CMDetailsViewController *cmd = [[CMDetailsViewController alloc]init];
    [self.navigationController pushViewController:cmd animated:YES];
    
    
}

- (void)isPublicBtnPress:(UIButton*)btn{
    NSLog(@"%ld",(long)btn.tag);
    
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    
    NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:btn.tag];
    
    ShopCarCell *cell = (ShopCarCell*)[_tableView cellForRowAtIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
    }

    
    ShopCarModel *model = self.datas[btn.tag];
    
    [cartIdArray addObject:model.cartId];
    
    NSLog(@"%ld",(long)btn.tag);
    NSString *string = [NSString stringWithFormat:@"%ld",(long)btn.tag-50];
    [numberIndex addObject:string];
    NSLog(@"%@",numberIndex);
    
    
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        ShopCarModel *model = self.datas[btn.tag];
        _cartId = model.cartId;
        [DeleteRow addObject:_cartId];
    }
    
    
    NSLog(@"%@",DeleteRow);
    
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
