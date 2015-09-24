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
@interface ShoppingCarController ()<UITableViewDataSource,UITableViewDelegate>
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
    int total;
    
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
    NSString *cartId;
    NSMutableArray *versionCount;
    NSString *count;
    
    NSString *changeCount;
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    [self.navigationItem setTitle:@"我的购物车"];
    
    [self downData];
    
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
    btn.font = [UIFont systemFontOfSize:17];
    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(delegatePress) forControlEvents:UIControlEventTouchUpInside];
    [totView addSubview:btn];
    
    totoalBL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+10, allBtn.frame.origin.y-10, 100, 20)];
    totoalBL.font = [UIFont systemFontOfSize:13];
    
    totoalBL.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    [totView addSubview:totoalBL];
    UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+50, CGRectGetMaxY(totoalBL.frame), 60, 20)];
    LB1.font = [UIFont systemFontOfSize:13];
    LB1.text = @"不含运费";
    LB1.textColor = [UIColor blackColor];
    [totView addSubview:LB1];
    
    cartIdArray = [NSMutableArray array];
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totoalBL.frame)+10, 10, 60, 50)];
    sure.font = [UIFont systemFontOfSize:17];
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
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        
       
        if (i%2!=0) {
            UIButton *btn = (UIButton *)[_tableView viewWithTag:i+49];
            NSLog(@"btn--%@",btn);
            btn.selected =! btn.selected;
        }
    }
   // if (sender.selected == YES) {
        isAllDelete = YES;
   // }
    allBtn.selected = !allBtn.selected;
    
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
            
        }
        }else {
        
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count*2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row!=0&&indexPath.row%2!=0) {
        
        
        if (invoiceSelector && selectIndexPath.row == indexPath.row) {
            return 170;
            
        }
        return 0;
        //   tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
        
    }
    else{
        return 90;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.clipsToBounds = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    
    if (indexPath.row == 0||indexPath.row%2==0) {
        
        
        ShopCarModel *model = self.datas[indexPath.row/2];
        
        cartIdArray[indexPath.row/2] = model.cartId;
       
        chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame = CGRectMake(10, 30, 20, 20);
        [chooseBtn setImage:[UIImage imageNamed:@"check-NO"] forState:UIControlStateNormal];
        [chooseBtn setImage:[UIImage imageNamed:@"check-YES"] forState:UIControlStateSelected];
        [chooseBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        chooseBtn.tag = indexPath.row + 50;
        
        [cell addSubview:chooseBtn];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(chooseBtn.frame)+10, 10, 60, 60)];
       
        [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cartImg]]];
        [cell addSubview:imageView];
        
        UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, imageView.frame.origin.y, 120, 40)];
        lb1.font = [UIFont systemFontOfSize:10];
        //lb3.backgroundColor = [UIColor redColor];
        lb1.lineBreakMode = NSLineBreakByTruncatingTail;
        lb1.numberOfLines = 2;
        lb1.text = [NSString stringWithFormat:@"%@",model.name];
        [cell addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb2.font = [UIFont systemFontOfSize:10];
        lb2.text = @"颜色:";
        [cell addSubview:lb2];
        
        UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), CGRectGetMaxY(lb1.frame), 30, 20)];
        lb3.font = [UIFont systemFontOfSize:10];
        lb3.text = @"宾利蓝";
        [cell addSubview:lb3];
        
        UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame)+15, CGRectGetMaxY(lb1.frame), 30, 20)];
        lb4.font = [UIFont systemFontOfSize:10];
        lb4.text = @"尺寸:";
        [cell addSubview:lb4];
        
        UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb4.frame), CGRectGetMaxY(lb1.frame), 30, 20)];
        lb5.font = [UIFont systemFontOfSize:10];
        lb5.text = @"128G";
        [cell addSubview:lb5];
        
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(235, 10, 13, 20)];
        LB.font = [UIFont systemFontOfSize:15];
        LB.text = @"￥";
        LB.textColor = [UIColor blackColor];
        [cell addSubview:LB];
        UILabel *priceLB = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(LB.frame), 10, 40, 20)];
        priceLB.font = [UIFont systemFontOfSize:15];
        priceLB.text = [NSString stringWithFormat:@"%@",model.price];
        priceLB.tag = indexPath.row + 40;
        priceLB.textColor = [UIColor blackColor];
        [cell addSubview:priceLB];
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(275, 30, 11, 20)];
        bl.font = [UIFont systemFontOfSize:15];
        bl.text = @"x";
        [bl setTextColor:[UIColor grayColor]];
        [cell addSubview:bl];
        
        countBL = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bl.frame), 30, 50, 20)];
        countBL.font = [UIFont systemFontOfSize:15];
        countBL.text = [NSString stringWithFormat:@"%@",model.count];
        [countBL setTextColor:[UIColor grayColor]];
        countBL.tag = indexPath.row+100;
        [cell addSubview:countBL];
        
        
        total= [[NSString stringWithFormat:@"%@",model.price]intValue]*[[NSString stringWithFormat:@"%@",model.count]intValue] +total;
        NSString *totalString = [NSString stringWithFormat:@"%d",total];
        totoalBL.text = [NSString stringWithFormat:@"合计:￥%@",totalString];
        
       editorBtn = [[UIButton alloc]initWithFrame:CGRectMake(268, 60, 40, 20)];
        //[btn setImage:[UIImage imageNamed:@"editor"] forState:UIControlStateNormal];
        [editorBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editorBtn setTitle:@"确定" forState:UIControlStateSelected];
        editorBtn.font = [UIFont systemFontOfSize:15];
        [editorBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [editorBtn setTitleColor:[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateSelected];
        [editorBtn addTarget:self action:@selector(editorPress:) forControlEvents:UIControlEventTouchUpInside];
        editorBtn.tag = indexPath.row;
       // currentbutton = editorBtn;
        [cell addSubview:editorBtn];
        
        

    }
    
        if(indexPath.row%2 !=0){
        ShopCarModel *model = self.datas[indexPath.row/2];
            NSLog(@"%ld",indexPath.row%2);
        versionCartId[indexPath.row/2] = model.cartId;
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
        bl.font = [UIFont systemFontOfSize:17];
        bl.text = @"版本信息";
        [bl setTextColor:[UIColor grayColor]];
        [cell addSubview:bl];
            for (int i = 0; i<model.version.count; i++) {
                
                versionButton = [[UIButton alloc]initWithFrame:CGRectMake(10+(i%2)*((SCREEN_WIDTH-45)/2)+(i%2)*15, CGRectGetMaxY(bl.frame)+18+(i/2)*35, 145, 30)];
                versionButton.clipsToBounds = YES;
                versionButton.layer.cornerRadius = 2;
                versionButton.layer.borderWidth = 1;
                [versionButton setTitle:model.version[i][@"maValue"] forState:UIControlStateNormal];
                [versionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                versionButton.font = [UIFont systemFontOfSize:10];
                versionGoodId[i] = model.version[i][@"goodsId"];
                
                if ([model.version[i][@"maValue"] isEqualToString:chooseType]) {
                    versionButton.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1]CGColor];
                    selectButton = versionButton;
                }else{
                    versionButton.layer.borderColor = [[UIColor grayColor]CGColor];
                }
                versionButton.tag = i+10;
                [versionButton addTarget:self action:@selector(versionPress:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:versionButton];
                
            }

        
        UILabel *bl2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(versionButton.frame)+25, 100, 20)];
        bl2.font = [UIFont systemFontOfSize:17];
        bl2.text = @"购买数量";
        [bl2 setTextColor:[UIColor grayColor]];
        [cell addSubview:bl2];
        
        _numberBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bl2.frame)+50, CGRectGetMaxY(versionButton.frame)+20, 30, 30)];
        _numberBtn1.backgroundColor = [UIColor whiteColor];
        [_numberBtn1 setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        
        _numberBtn1.clipsToBounds = YES;
        _numberBtn1.layer.cornerRadius = 3;
        _numberBtn1.layer.borderWidth = 0.8;
        _numberBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [_numberBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_numberBtn1 addTarget:self action:@selector(NumBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        _numberBtn1.tag = indexPath.row;
        [cell addSubview:_numberBtn1];
        
        UIButton *numberBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+60, _numberBtn1.frame.origin.y, 30, 30)];
        numberBtn2.backgroundColor = [UIColor whiteColor];
        [numberBtn2 setImage:[UIImage imageNamed:@"圆角矩形-3-2"] forState:UIControlStateNormal];
        numberBtn2.clipsToBounds = YES;
        numberBtn2.layer.cornerRadius = 3;
        numberBtn2.layer.borderWidth = 0.8;
        numberBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [numberBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numberBtn2 addTarget:self action:@selector(addNumBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        numberBtn2.tag = indexPath.row;
        
        [cell addSubview:numberBtn2];
        
            if (indexPath.row > 1) {
                countModel = self.datas[indexPath.row%2];
            }else{
            
                countModel = self.datas[0];
            }

            
            
            

        _numberLb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+5, _numberBtn1.frame.origin.y, 50, 30)];
        _numberLb1.backgroundColor = [UIColor whiteColor];
        
        changeCount = [NSString stringWithFormat:@"%@",countBL.text];
    
        [_numberLb1 setText:changeCount];
        [_numberLb1 setTextColor:[UIColor blackColor]];
        _numberLb1.clipsToBounds = YES;
        _numberLb1.layer.cornerRadius = 3;
        _numberLb1.layer.borderWidth = 0.8;
            _numberLb1.textAlignment = NSTextAlignmentCenter;
        _numberLb1.layer.borderColor = [[UIColor grayColor] CGColor];
        [cell addSubview:_numberLb1];

            
        
        
    }
    
    return cell;
}
-(void)versionPress:(UIButton *)btn{
    goodId = versionGoodId[(btn.tag-10)/2];
    cartId = versionCartId[(btn.tag-10)/2];
    
    NSLog(@"%@",cartId);
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
-(void)NumBtnPress:(UIButton *)btn{
    
    UILabel *lb = (UILabel *)[_tableView viewWithTag:btn.tag-1+100];
    UILabel *priceLb = (UILabel *)[_tableView viewWithTag:btn.tag-1+40];
    
    int price = [[NSString stringWithFormat:@"%@",priceLb.text]intValue];
    
    int addCount = [[NSString stringWithFormat:@"%@",_numberLb1.text]intValue];
    
        if (addCount>1) {
            
            addCount--;
            NSString *string = [NSString stringWithFormat:@"%d",addCount];
            [_numberLb1 setText:string];
            lb.text = string;
            
            total = total - price;
            NSString *totalString = [NSString stringWithFormat:@"%d",total];
            totoalBL.text = [NSString stringWithFormat:@"合计:￥%@",totalString];
            
        }
    
    count = [NSString stringWithFormat:@"%@",lb.text];
    
}
-(void)addNumBtnPress:(UIButton *)btn{
    
    UILabel *lb = (UILabel *)[self.view viewWithTag:btn.tag-1+100];
    NSLog(@"%@",lb);
    
    UILabel *priceLb = (UILabel *)[_tableView viewWithTag:btn.tag-1+40];
    
    int price = [[NSString stringWithFormat:@"%@",priceLb.text]intValue];
    int addCount = [[NSString stringWithFormat:@"%@",_numberLb1.text]intValue];
    
        
        addCount++;
        NSString *string = [NSString stringWithFormat:@"%d",addCount];
        [_numberLb1 setText:string];
        lb.text = string;
        
    total = total + price;
    NSString *totalString = [NSString stringWithFormat:@"%d",total];
    totoalBL.text = [NSString stringWithFormat:@"合计:￥%@",totalString];
    
    count = [NSString stringWithFormat:@"%@",lb.text];
    
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
    
    
    NSString *path= [NSString stringWithFormat:EDITORVERSION,COMMON,cartId,goodId,count];
    
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
    
}

- (void)isPublicBtnPress:(UIButton*)btn{
    
    NSLog(@"%ld",(long)btn.tag);
    NSString *string = [NSString stringWithFormat:@"%ld",(long)btn.tag-50];
    [numberIndex addObject:string];
    NSLog(@"%@",numberIndex);
    
    
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        ShopCarModel *model = self.datas[(btn.tag-1-49)%2];
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
