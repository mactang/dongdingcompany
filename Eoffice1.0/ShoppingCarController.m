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
#import "CommodityViewController.h"
@interface ShoppingCarController ()<UITableViewDataSource,UITableViewDelegate,celldelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic, strong)UIButton *numberBtn1;
@property(nonatomic,strong)UILabel *numberLb1;
@property (strong,nonatomic)UIButton * tmpBtn;
@property(nonatomic,assign)NSString *cartId;
@property (strong,nonatomic)UIButton *selectButton;

@property(nonatomic,strong)UILabel *labelsign;
@property(nonatomic,strong)UIButton *strollbutton;
@end

@implementation ShoppingCarController

{
    
    UIView *totView;
    BOOL invoiceSelector;
    NSIndexPath *selectIndexPath;
    UIButton *chooseBtn;
    UIButton *chooseBtn1;
    UIButton *chooseBtn2;
    UIButton *allBtn;
    UILabel *totoalBL;
    NSMutableArray *totoalArray;
    NSMutableArray *totoalCount;
    float total;
    float everyCount;
    float totalEvery;
    float otherAllTotal;
    float onAllChoosePrice;
    
    BOOL onAllChoose;
    
    //记录总价格
    int isAllChoose;
    
    UIButton *versionButton;
    NSMutableArray *btnMutableArray;
    NSMutableArray *numberIndex;
    
    NSMutableArray *DeleteRow;
    NSMutableArray *remainRow;
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
    
    NSMutableArray *isCheck;
    
    
    NSMutableArray *cellarraydata;
    
    NSMutableArray *contacts;
    NSMutableArray *totalPrice;
    
    //选中的价格
    float choosePriceAll;
    
    BOOL isDeleteText;
    
    
    
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isDeleteText = NO;
    
    contacts = [NSMutableArray array];
    totalPrice = [NSMutableArray array];
    otherAllTotal = 0;
    choosePriceAll = 0;
    cellarraydata = [NSMutableArray array];
    totoalArray = [NSMutableArray array];
    totoalCount = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@"我的购物车"];
    
    [self downData];
    
    selectedAll = YES;
    isCheck = [NSMutableArray array];
    
    
    versionGoodId = [NSMutableArray array];
    
    versionCartId = [NSMutableArray array];
    
    versionCount = [NSMutableArray array];
    
    remainRow = [NSMutableArray array];
    
    invoiceSelector = 0;
    isAllDelete = NO;
    total = 0;
    onAllChoosePrice = 0;
    onAllChoose = NO;
    
    isAllChoose = 0;
    numberIndex = [NSMutableArray array];
    DeleteRow = [NSMutableArray array];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 440) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    // _tableView.showsVerticalScrollIndicator = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    _tableView.scrollEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 1000;
    [self.view addSubview:_tableView];
    
    totView = [[UIView alloc]initWithFrame:CGRectMake(0, 440, 320, 80)];
    totView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:totView];
    
    allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame = CGRectMake(10, 20, 20, 20);
    allBtn.selected = YES;
    if (allBtn.selected == YES) {
        isAllDelete = YES;
    }else{
        
        isAllDelete = NO;
    }
    [allBtn setImage:[UIImage imageNamed:@"check-NO"] forState:UIControlStateNormal];
    [allBtn setImage:[UIImage imageNamed:@"check-YES"] forState:UIControlStateSelected];
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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+20, allBtn.frame.origin.y-10, 50, 20)];
    label.text = @"合计: ￥";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [totView addSubview:label];
    
    totoalBL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), allBtn.frame.origin.y-10, 100, 20)];
    totoalBL.font = [UIFont systemFontOfSize:13];
    totoalBL.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    totoalBL.text = [NSString stringWithFormat:@"%.2f",totalEvery];
    [totView addSubview:totoalBL];
    UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+50, CGRectGetMaxY(totoalBL.frame), 60, 20)];
    LB1.font = [UIFont systemFontOfSize:13];
    LB1.text = @"不含运费";
    LB1.textColor = [UIColor blackColor];
    [totView addSubview:LB1];
    
    cartIdArray = [NSMutableArray array];
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(LB1.frame)+10, 10, 60, 50)];
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
    if (cartIdArray.count != 0) {
        [self cartData];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请选择商品" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [alert show];
    }
    
    
}
-(void)cartData{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    NSString *carString = [[NSString alloc]init] ;
    NSLog(@"%@",cartIdArray);
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
            
            isDeleteText = YES;
            NSLog(@"choosePriceAll--%f",choosePriceAll);
            NSLog(@"totalEvery--%f",totalEvery);
            otherAllTotal = 0;
            totoalBL.text = @"";
            
            totalEvery = 0;
            choosePriceAll = 0;
            
            
            for (int i = 0; i<isCheck.count; i++) {
                
                NSString *checkStr = isCheck[i];
                NSInteger check = [checkStr integerValue];
                NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
                
                NSLog(@"count--%lu",(unsigned long)anArrayOfIndexPath.count);
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:check inSection:0];
                
                ShopCarCell *cell = (ShopCarCell*)[_tableView cellForRowAtIndexPath:path];
                
                NSUInteger row = [path row];
                NSMutableDictionary *dic = [contacts objectAtIndex:row];
                if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
                    [dic setObject:@"NO" forKey:@"checked"];
                    [cell setChecked:NO];
                }else {
                    [dic setObject:@"NO" forKey:@"checked"];
                    [cell setChecked:NO];
                }
                
            }
            NSLog(@"numberIndex--%@",numberIndex);
            for (int i = 0; i<numberIndex.count; i++) {
                
                NSLog(@"%@",numberIndex[i]);
                NSLog(@"count-%lu",(unsigned long)numberIndex.count);
                NSLog(@"%ld",[[NSString stringWithFormat:@"%@",numberIndex[i]] integerValue]/2);
                //[self.datas removeObjectAtIndex:[[NSString stringWithFormat:@"%@",numberIndex[i]] integerValue]/2];
                
                NSLog(@"number--%d",number);
                
                
                number = i;
            }
            [self deleteData];
            [self.datas removeAllObjects];
            [self downData];
            totoalBL.text = @"";
            [numberIndex removeAllObjects];
        }
        if(isAllDelete == YES){
            if (allBtn.selected == YES) {
                [self AllDeleteData];
                [self.datas removeAllObjects];
                [self noData];
            }else{
                
                for (int i = 0; i<remainRow.count; i++) {
                    
                    UIButton *button = remainRow[i];
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:button.tag inSection:0];
                    
                    ShopCarCell *cell = (ShopCarCell*)[_tableView cellForRowAtIndexPath:path];
                    
                    NSUInteger row = [path row];
                    NSMutableDictionary *dic = [contacts objectAtIndex:row];
                    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
                        [dic setObject:@"YES" forKey:@"checked"];
                        [cell setChecked:YES];
                    }else {
                        [dic setObject:@"YES" forKey:@"checked"];
                        [cell setChecked:YES];
                    }
                }
                NSLog(@"noallchoose");
                [self remainDeleteData];
                [self.datas removeAllObjects];
                allBtn.selected = YES;
                [self downData];
                
            }
            
            
            
            // [self downData];
            
            
        }
        
        
        //   [_tableView reloadData];
        
        //[self deleteData];
        
    }
}
-(void)remainDeleteData{
    //    UIButton *button = remainRow[0];
    //    NSLog(@"%ld",(long)button.tag);
    NSLog(@"%lu",(unsigned long)self.datas.count);
    
    NSMutableArray *discardedItems = [NSMutableArray array];
    for (int i = 0; i<remainRow.count; i++) {
        
        UIButton *button = remainRow[i];
        NSLog(@"%lu",(unsigned long)self.datas.count);
        NSLog(@"%ld",(long)button.tag);
        ShopCarModel *model = self.datas[button.tag];
        
        
        [discardedItems addObject:model];
        
        //        [self.datas removeObjectAtIndex:button.tag];
        
    }
    [remainRow removeAllObjects];
    NSLog(@"%@",discardedItems);
    NSLog(@"%@",self.datas);
    if (self.datas.count == discardedItems.count) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未选择删除商品" message:@"请选择删除商品" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        [self.datas removeObjectsInArray:discardedItems];
        NSLog(@"%@",self.datas);
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
    
    NSLog(@"%@",_shopNumber);
    
    if ([_shopNumber isEqualToString:@"relead"]) {
        if (_delegate &&[_delegate respondsToSelector:@selector(releadCartNumber)]) {
            [_delegate releadCartNumber];
            
        }
    }
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)allSelect:(UIButton*)sender{
    
    [cartIdArray removeAllObjects];
    allBtn.selected = !allBtn.selected;
    if (sender.selected == YES) {
        
        isAllDelete = YES;
        selectedAll = YES;
        NSLog(@"%lu",(unsigned long)self.datas.count);
        for (int i=0; i<self.datas.count; i++) {
            ShopCarModel *model = self.datas[i];
            
            [cartIdArray addObject:model.cartId];
        }
        
        
    }else{
        isAllDelete = NO;
        selectedAll = NO;
        [cartIdArray removeAllObjects];
        //        totoalBL.text = @"0";
        // selectedAll = NO;
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
        
        if (onAllChoose == YES) {
            totalEvery = totalEvery + onAllChoosePrice;
            
            totoalBL.text = [NSString stringWithFormat:@"%.2f",totalEvery];
            
            onAllChoose = NO;
            onAllChoosePrice = 0;
        }else{
            
            totoalBL.text = [NSString stringWithFormat:@"%.2f",totalEvery];
            
            
        }
        otherAllTotal = 0;
    }else{
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"NO" forKey:@"checked"];
        }
        totoalBL.text = @"0";
        
        // totalEvery = 0;
        // [(UIButton*)sender setTitle:@"全选" forState:UIControlStateNormal];
    }
    
    
}

- (void)downData{
    
    [totoalArray removeAllObjects];
    [totoalCount removeAllObjects];
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SHOPCAR,COMMON,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
            NSArray *array = dic[@"data"];
            [self.labelsign removeFromSuperview];
            [self.strollbutton removeFromSuperview];
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
            [cartIdArray removeAllObjects];
            for (int i = 0; i<totoalArray.count; i++) {
                
                NSLog(@"totoalArray--%@",totoalArray[i]);
                NSLog(@"totoalCount--%@",totoalCount[i]);
                total = [[NSString stringWithFormat:@"%@",totoalArray[i]]floatValue];
                everyCount = [[NSString stringWithFormat:@"%@",totoalCount[i]]floatValue];
                totalEvery = total*everyCount + totalEvery;
                
                
            }
            NSLog(@"totalEvery--%f",totalEvery);
            if (isDeleteText == YES) {
                totoalBL.text = @"0";
            }
            else{
                
                totoalBL.text = [NSString stringWithFormat:@"%.2f",totalEvery];
            }
            if (allBtn.selected == YES) {
                
                for (int i=0; i<self.datas.count; i++) {
                    ShopCarModel *model = self.datas[i];
                    
                    [cartIdArray addObject:model.cartId];
                }
            }else{
                
                [cartIdArray removeAllObjects];
            }
            
            
        }else {
            
            [self noData];
            
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)noData{
    
    [_tableView removeFromSuperview];
    [totView removeFromSuperview];
    if (!self.labelsign) {
        self.labelsign = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, 40)];
    }
    self.labelsign.text = @"抱歉,你的购物车空空如也";
    self.labelsign.textAlignment = NSTextAlignmentCenter;
    self.labelsign.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.labelsign];
    
    if (!self.strollbutton) {
        self.strollbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    self.strollbutton.frame = CGRectMake((SCREEN_WIDTH-SCREEN_WIDTH/3.5)/2, CGRectGetMaxY(self.labelsign.frame)+10, SCREEN_WIDTH/3.5, SCREEN_WIDTH/10.5);
    self.strollbutton.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.strollbutton.layer.borderWidth = 1;
    self.strollbutton.layer.cornerRadius = 2;
    self.strollbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.strollbutton setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [self.strollbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.strollbutton addTarget:self action:@selector(gotolookPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.strollbutton];
}
-(void)gotolookPressed{
    CommodityViewController *cmd = [[CommodityViewController alloc]init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:cmd animated:YES];
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
        [dic setValue:@"YES" forKey:@"checked"];
        [contacts addObject:dic];
    }
    NSLog(@"%lu",(unsigned long)contacts.count);
    
    
    static NSString * identifier = @"Cell";
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (cell == nil) {
        cell = [[ShopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.numbercell = indexPath.row;
    cell.myModel = self.datas[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    NSString *checkString = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    
    [isCheck addObject:checkString];
    
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    
    NSLog(@"count--%lu",(unsigned long)anArrayOfIndexPath.count);
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    ShopCarCell *cell = (ShopCarCell*)[_tableView cellForRowAtIndexPath:path];
    
    NSUInteger row = [path row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
        
        ShopCarModel *model = self.datas[btn.tag];
        
        [cartIdArray addObject:model.cartId];
        
        
        
    }else {
        
        ShopCarModel *model = self.datas[btn.tag];
        NSString *cartid = [NSString stringWithFormat:@"%@",model.cartId];
        for (int i = 0; i<cartIdArray.count; i++) {
            NSString *stringC = [NSString stringWithFormat:@"%@",cartIdArray[i]];
            if ([stringC isEqualToString:cartid]) {
                [cartIdArray removeObjectAtIndex:i];
            }
        }
        NSLog(@"%@",cartIdArray);
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
    }
    
    
    
    
    NSString *string = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    [numberIndex addObject:string];
    
    if (btn.selected == YES) {
        
        ShopCarModel *model = self.datas[btn.tag];
        _cartId = model.cartId;
        [DeleteRow addObject:_cartId];
        
        [remainRow removeObject:btn];
    }else{
        
        
        [remainRow addObject:btn];
    }
    
    
    NSLog(@"%@",DeleteRow);
    
    
}
-(void)subCount:(NSString *)subCountLB{
    
    
    int m = [[NSString stringWithFormat:@"%@",subCountLB]floatValue];
    if (selectedAll == YES || allBtn.selected == YES) {
        totalEvery = totalEvery - m;
        NSString *string1 = [NSString stringWithFormat:@"%f",totalEvery];
        totoalBL.text = [NSString stringWithFormat:@"%.2f",[string1 floatValue]];
        
    }else{
        NSString *string1 = [NSString stringWithFormat:@"%f",otherAllTotal-m];
        totoalBL.text = [NSString stringWithFormat:@"%.2f",[string1 floatValue]];
        
        otherAllTotal = [[NSString stringWithFormat:@"%f",otherAllTotal-m]floatValue];
    }
    isAllChoose = isAllChoose - m;
    
}
-(void)noChooseSubCount:(NSString *)noChooseSubCount{
    
    
    
    float m = [[NSString stringWithFormat:@"%@",noChooseSubCount]floatValue];
    if (selectedAll == YES || allBtn.selected == YES) {
        totalEvery = totalEvery - m;
    }
    isAllChoose = isAllChoose - m;
    
    onAllChoosePrice = 0;
}
-(void)addCount:(NSString *)addCountLB{
    
    float m = [[NSString stringWithFormat:@"%@",addCountLB]floatValue];
    
    if (selectedAll == YES || (allBtn.selected == YES&&totalEvery!=0)) {
        totalEvery = totalEvery + m;
        
        
        totoalBL.text = [NSString stringWithFormat:@"%.2f",totalEvery];
        
        
    }else{
        totalEvery = totalEvery + m;
        
        
        totoalBL.text = [NSString stringWithFormat:@"%.2f",m+otherAllTotal];
        //otherAllTotal = [[NSString stringWithFormat:@"%d",m+otherAllTotal]intValue];
        
    }
    
    isAllChoose = isAllChoose +m;
    
}
-(void)noChooseAddCount:(NSString *)noChooseAddCount{
    
    float m = [[NSString stringWithFormat:@"%@",noChooseAddCount]floatValue];
    
    if (selectedAll == YES || (allBtn.selected == YES&&totalEvery!=0)) {
        //totalEvery = totalEvery + m;
        
    }else{
        NSLog(@"aa");
        totalEvery = totalEvery + m;
        //otherAllTotal = [[NSString stringWithFormat:@"%d",m+otherAllTotal]intValue];
    }
    
    isAllChoose = isAllChoose +m;
    NSLog(@"isAllChoose***%d",isAllChoose);
    onAllChoosePrice = 0;
    
}

-(void)chooseCount:(NSString *)chooseCountLB{
    
    NSLog(@"%@",chooseCountLB);
    float m = [[NSString stringWithFormat:@"%@",chooseCountLB]floatValue];
    NSLog(@"%f",m);
    choosePriceAll = m+choosePriceAll;
    
    if (selectedAll == YES &&(allBtn.selected == NO&&totalEvery!=0)) {
        
        
        totoalBL.text = [NSString stringWithFormat:@"%.2f",m+totalEvery];
        
        totalEvery = totalEvery+m;
        
        onAllChoosePrice = onAllChoosePrice - m;
        
        if (onAllChoosePrice<=0) {
            onAllChoosePrice = 0;
        }
        NSLog(@"isAllChoose***%d",isAllChoose);
        NSLog(@"totalEvery***%f",totalEvery);
        if (isAllChoose == totalEvery) {
            allBtn.selected = YES;
        }
        otherAllTotal = 0;
        
        
    }else{
        
        NSLog(@"otherAllTotal--%f",m+otherAllTotal);
        totoalBL.text = [NSString stringWithFormat:@"%.2f",m+otherAllTotal];
        
        
        otherAllTotal = [[NSString stringWithFormat:@"%.2f",m+otherAllTotal]floatValue];
        
        if (otherAllTotal == totalEvery) {
            allBtn.selected = YES;
        }
        
        
    }
    
    
    
}

-(void)noChooseCount:(NSString *)chooseCountLB{
    allBtn.selected = NO;
    isAllChoose = NO;
    
    float m = [[NSString stringWithFormat:@"%@",chooseCountLB]floatValue];
    NSLog(@"%f",m);
    if (selectedAll == YES&&(allBtn.selected == NO&&totalEvery!=0)) {
        
        onAllChoose = YES;
        
        onAllChoosePrice = m + onAllChoosePrice;
        
        totalEvery = totalEvery - m;
        isAllChoose =   onAllChoosePrice  + totalEvery;
        
        
        totoalBL.text = [NSString stringWithFormat:@"%.2f",totalEvery];
        
        
        
    }else{
        
        
        totoalBL.text = [NSString stringWithFormat:@"%.2f",otherAllTotal-m];
        
        
        otherAllTotal = [[NSString stringWithFormat:@"%.2f",otherAllTotal-m]floatValue];
        
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
        
        btn.selected =! btn.selected;
        
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag+1 inSection:0];
    
    selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    
    invoiceSelector = !invoiceSelector;
    
    
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

-(void)goodDetailButton:(NSInteger)goodDetail{
    
    ShopCarModel *model = self.datas[goodDetail];
    SingleModel *sing = [SingleModel sharedSingleModel];
    sing.goodsId = model.goodsId;
    NSLog(@"%@",model.goodsId);
    sing.paraId = @"123";
    sing.cPartnerId = @"443";
    
    CMDetailsViewController *cmd = [[CMDetailsViewController alloc]init];
    [self.navigationController pushViewController:cmd animated:YES];
}

-(void)changeCountAdd:(NSString *)addCount cartIdData:(NSInteger)cartId{
    
    ShopCarModel *model = self.datas[cartId];
    
    NSString *path= [NSString stringWithFormat:CHANGECOUNT,COMMON,model.cartId,addCount];
    
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)changeCountRevise:(NSString *)reviseCount cartIdData:(NSInteger)cartId{
    
    ShopCarModel *model = self.datas[cartId];
    
    NSString *path= [NSString stringWithFormat:CHANGECOUNT,COMMON,model.cartId,reviseCount];
    
    NSLog(@"%@",path);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
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
