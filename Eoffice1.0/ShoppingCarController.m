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
#import "ShopCarModel.h"

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
    int _currentNumber;
    UIButton *colorBtn;
    NSMutableArray *btnMutableArray;
    NSMutableArray *numberIndex;
   
     NSMutableArray *DeleteRow;
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
    invoiceSelector = 0;
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
    totoalBL.text = @"合计:￥34000.00";
    totoalBL.textColor = [UIColor redColor];
    [totView addSubview:totoalBL];
    UILabel *LB1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+50, CGRectGetMaxY(totoalBL.frame), 60, 20)];
    LB1.font = [UIFont systemFontOfSize:13];
    LB1.text = @"不含运费";
    LB1.textColor = [UIColor blackColor];
    [totView addSubview:LB1];
    
    
    UIButton *sure = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(totoalBL.frame)+10, 10, 60, 50)];
    sure.font = [UIFont systemFontOfSize:17];
    sure.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    sure.clipsToBounds = YES;
    sure.layer.cornerRadius = 5;
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [totView addSubview:sure];
    
    // Do any additional setup after loading the view.
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
        for (int i = 0; i<numberIndex.count; i++) {
            NSLog(@"%@",numberIndex[i]);
            NSLog(@"count-%lu",(unsigned long)numberIndex.count);
            NSLog(@"%ld",[[NSString stringWithFormat:@"%@",numberIndex[i]] integerValue]/2);
            [self.datas removeObjectAtIndex:[[NSString stringWithFormat:@"%@",numberIndex[i]] integerValue]/2];
            
        }
        
        
        [self downData];
        [numberIndex removeAllObjects];
        [_tableView reloadData];
        
        [self deleteData];
        
    }
}
-(void)deleteData{
    
    NSLog(@"%@",DeleteRow);
    for (int i = 0; i<DeleteRow.count; i++) {
    
    NSString *path= [NSString stringWithFormat:DELETESHOPCAR,DeleteRow[i]];
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
            UIButton *btn = (UIButton *)[_tableView viewWithTag:i];
            NSLog(@"btn--%@",btn);
            btn.selected = !btn.selected;
        }
    }
    allBtn.selected = !allBtn.selected;
    
}
- (void)downData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:SHOPCAR,model.jsessionid,model.userkey];
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
        
        
        if (invoiceSelector && selectIndexPath.row + 1 == indexPath.row) {
            return 230;
            
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
        if (indexPath.row == 0) {
           ShopCarModel *model = self.datas[indexPath.row];
            _cartId = model.cartId;
        }else{
        ShopCarModel *model = self.datas[indexPath.row/2];
            _cartId = model.cartId;
        }
        
        chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame = CGRectMake(10, 30, 20, 20);
        [chooseBtn setImage:[UIImage imageNamed:@"check-NO"] forState:UIControlStateNormal];
        [chooseBtn setImage:[UIImage imageNamed:@"check-YES"] forState:UIControlStateSelected];
        [chooseBtn addTarget:self action:@selector(isPublicBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        chooseBtn.tag = indexPath.row+1;
        
        [cell addSubview:chooseBtn];
        
        UILabel *LB = [[UILabel alloc]initWithFrame:CGRectMake(230, 10, 100, 20)];
        LB.font = [UIFont systemFontOfSize:17];
        LB.text = @"￥6800.00";
        LB.textColor = [UIColor grayColor];
        [cell addSubview:LB];
        
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(290, 30, 50, 20)];
        bl.font = [UIFont systemFontOfSize:17];
        bl.text = @"X1";
        [bl setTextColor:[UIColor grayColor]];
        [cell addSubview:bl];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(290, 60, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"editor"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(editorPress:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = indexPath.row +100;
        [cell addSubview:btn];
        
        

    }
    
        if(indexPath.row%2 !=0){
        UILabel *bl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 20)];
        bl.font = [UIFont systemFontOfSize:17];
        bl.text = @"颜色";
        [bl setTextColor:[UIColor grayColor]];
        [cell addSubview:bl];
            
            int x = 0;
            int pag = 10;
            
            btnMutableArray = [[NSMutableArray alloc]init]; //将button放到数组里面
            for (int i = 0; i<4; i++) {
            
            colorBtn = [[UIButton alloc]initWithFrame:CGRectMake(x +pag , CGRectGetMaxY(bl.frame)+10, 70, 35)];
            colorBtn.backgroundColor = [UIColor whiteColor];
            colorBtn.clipsToBounds = YES;
            colorBtn.layer.cornerRadius = 3;
            colorBtn.layer.borderWidth = 0.8;
            colorBtn.layer.borderColor = [[UIColor grayColor] CGColor];
            [colorBtn setTitle:@"学蓝色" forState:UIControlStateNormal];
            [colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [colorBtn addTarget:self action:@selector(colorBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            cell.tag = i +10;
            [cell addSubview:colorBtn];
            x = CGRectGetMaxX(colorBtn.frame);
           [btnMutableArray addObject:colorBtn];
            }
        ((UIButton *)[btnMutableArray objectAtIndex:2]).selected = YES;
        UILabel *bl1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 50, 20)];
        bl1.font = [UIFont systemFontOfSize:17];
        bl1.text = @"版本";
        [bl1 setTextColor:[UIColor grayColor]];
        [cell addSubview:bl1];
        
        UILabel *bl2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, 100, 20)];
        bl2.font = [UIFont systemFontOfSize:17];
        bl2.text = @"购买数量";
        [bl2 setTextColor:[UIColor grayColor]];
        [cell addSubview:bl2];
        
        _numberBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(bl2.frame)+50, 185, 30, 30)];
        _numberBtn1.backgroundColor = [UIColor whiteColor];
        [_numberBtn1 setImage:[UIImage imageNamed:@"圆角矩形-3"] forState:UIControlStateNormal];
        
        _numberBtn1.clipsToBounds = YES;
        _numberBtn1.layer.cornerRadius = 3;
        _numberBtn1.layer.borderWidth = 0.8;
        _numberBtn1.layer.borderColor = [[UIColor grayColor] CGColor];
        [_numberBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_numberBtn1 addTarget:self action:@selector(NumBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        _numberBtn1.tag = 10000;
        [cell addSubview:_numberBtn1];
        
        UIButton *numberBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+60, _numberBtn1.frame.origin.y, 30, 30)];
        numberBtn2.backgroundColor = [UIColor whiteColor];
        [numberBtn2 setImage:[UIImage imageNamed:@"圆角矩形-3-2"] forState:UIControlStateNormal];
        numberBtn2.clipsToBounds = YES;
        numberBtn2.layer.cornerRadius = 3;
        numberBtn2.layer.borderWidth = 0.8;
        numberBtn2.layer.borderColor = [[UIColor grayColor] CGColor];
        [numberBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [numberBtn2 addTarget:self action:@selector(NumBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        numberBtn2.tag = 10001;
        [cell addSubview:numberBtn2];
        
        _numberLb1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberBtn1.frame)+5, _numberBtn1.frame.origin.y, 50, 30)];
        _numberLb1.backgroundColor = [UIColor whiteColor];
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
        [_numberLb1 setText:string];
        [_numberLb1 setTextColor:[UIColor blackColor]];
        _numberLb1.clipsToBounds = YES;
        _numberLb1.layer.cornerRadius = 3;
        _numberLb1.layer.borderWidth = 0.8;
        _numberLb1.layer.borderColor = [[UIColor grayColor] CGColor];
        [cell addSubview:_numberLb1];

        
        
        
    }
    
    return cell;
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
    
    
    if (btn.tag ==10000) {
        if (_currentNumber>1) {
            
            
            _currentNumber--;
            NSLog(@"%d",_currentNumber);
            
            NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
            [_numberLb1 setText:string];
            [_tableView reloadData];
    
        }
    }
    if (btn.tag == 10001) {
        _currentNumber++;
        
        NSLog(@"%d",_currentNumber);
        NSString *string = [[NSString alloc]initWithString:[NSString stringWithFormat:@"    %d",_currentNumber]];
        [_numberLb1 setText:string];
        [_tableView reloadData];
        NSLog(@"%@",_numberLb1.text);
        
    }
    
    
}

-(void)editorPress:(UIButton *)btn{
     NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[_tableView indexPathsForVisibleRows]];
    
    NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:btn.tag-100];
    if (!selectIndexPath) {//第一次
        selectIndexPath = indexPath;
        
        _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height+130);
        
    }
    invoiceSelector = !invoiceSelector;
    
    BOOL isOtherIndex = NO;
    
    if (selectIndexPath.row != indexPath.row) {
        isOtherIndex = YES;
    }
    selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (isOtherIndex && !invoiceSelector) {
        invoiceSelector = YES;
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
  
    
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)isPublicBtnPress:(UIButton*)btn{
    
    NSLog(@"%ld",(long)btn.tag);
    NSString *string = [NSString stringWithFormat:@"%ld",(long)btn.tag-1];
    [numberIndex addObject:string];
    NSLog(@"%@",numberIndex);
    
    
    btn.selected = !btn.selected;
    [DeleteRow addObject:_cartId];
    
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
