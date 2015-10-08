//
//  ExchangeViewController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/29.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#define TCP_FAIL @"socketFail"

#import "ExchangeViewController.h"
#import "HMSegmentedControl.h"
#import "RDVTabBarController.h"
#import "ExchageSuccessController.h"
#import "MXPullDownMenu.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "BackReasonModel.h"
#import "ReturnSuccessController.h"
#import "DynamicScrollView.h"


@interface ExchangeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,MXPullDownMenuDelegate,UIActionSheetDelegate,UIApplicationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)BOOL isle;
@property(nonatomic,strong)UILabel *validateLB;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSMutableArray *exchageDatas;
@property(nonatomic,strong)UIImageView *imageView ;
@property(nonatomic,strong)UITextView *explainTextView;
@property(nonatomic,strong)UITextView *reasonId;
@property(nonatomic,strong)UITextField  *nameField;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextView *addressTextView;

@end

@implementation ExchangeViewController
{
    DynamicScrollView *dynamicScrollView;
    
    NSArray *images;
    MXPullDownMenu *menu;
    
}
-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
-(NSMutableArray *)exchageDatas{
    if (_exchageDatas == nil) {
        _exchageDatas = [NSMutableArray array];
    }
    return _exchageDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"申请退换货";
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    [self exchageData];
    [self returnData];
    
    self.isle = YES;
    
    HMSegmentedControl *segmentedControl2 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"申请换货", @"申请退货"]];
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
    
    
    // Do any additional setup after loading the view.
}

//退货原因
- (void)returnData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:BACKBEASON,COMMON,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
        
        for(NSDictionary *subDict in array)
        {
            BackReasonModel *model = [BackReasonModel modelWithDic:subDict];
            [self.datas addObject: model];
            NSLog(@"%@",self.datas);
            
        }
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//换货原因
- (void)exchageData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    NSString *path= [NSString stringWithFormat:REPLACEEXPLAIN,COMMON,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
        NSArray *array = dic[@"data"];
        
        for(NSDictionary *subDict in array)
        {
            BackReasonModel *model = [BackReasonModel modelWithDic:subDict];
            [self.exchageDatas addObject: model];
            NSLog(@"%@",self.datas);
            
        }
        }
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl*)segmentedControl{
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        self.isle = YES;
        
    }
    if (segmentedControl.selectedSegmentIndex == 1) {
        
        
        NSLog(@"bbb");
        self.isle = NO;
        
    }
     [_tableView reloadData];
    
    
}
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_isle == YES) {
        return self.datas.count-self.datas.count+1;
    }
    else{
    
        return self.exchageDatas.count-self.exchageDatas.count+1;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 580;
    }
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    NSLog(@"datas--%@",self.datas);
    if (indexPath.section == 0) {
        _validateLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 70, 20)];
        _validateLB.font = [UIFont systemFontOfSize:12];
        
        _validateLB.textColor = [UIColor blackColor];
        [cell addSubview:_validateLB];
        

        if (self.isle == NO) {
        
        _validateLB.text = @"退货原因：";
        NSMutableArray *testArray = [NSMutableArray array];
        for (int i = 0; i<self.datas.count; i++) {
            BackReasonModel *model = self.datas[i];
            [testArray addObject:model.title];
            NSLog(@"datas--%@",testArray[i]);
        }
        
        NSLog(@"datas--%@",testArray);
        menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor grayColor]];
        menu.delegate = self;
        menu.clipsToBounds = YES;
        menu.layer.cornerRadius = 3;
        menu.layer.borderColor = [[UIColor blackColor]CGColor];
        menu.layer.borderWidth = 1;
        menu.frame = CGRectMake(CGRectGetMaxX(_validateLB.frame)-10,10, 240, 35);
        [cell addSubview:menu];
        }else{
            
        _validateLB.text = @"换货原因";
            NSMutableArray *testArray = [NSMutableArray array];
            for (int i = 0; i<self.exchageDatas.count; i++) {
                BackReasonModel *model = self.datas[i];
                [testArray addObject:model.title];
                NSLog(@"datas--%@",testArray[i]);
            }
            
            NSLog(@"datas--%@",testArray);
            menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:[UIColor grayColor]];
            menu.delegate = self;
            menu.clipsToBounds = YES;
            menu.layer.cornerRadius = 3;
            menu.layer.borderColor = [[UIColor blackColor]CGColor];
            menu.layer.borderWidth = 1;
            menu.frame = CGRectMake(CGRectGetMaxX(_validateLB.frame)-10,10, 240, 35);
            [cell addSubview:menu];
        }
        UILabel *explainLB = [[UILabel alloc]initWithFrame:CGRectMake(35, 75+20, 40, 20)];
        explainLB.font = [UIFont systemFontOfSize:12];
        explainLB.text = @"说明：";
        explainLB.textColor = [UIColor blackColor];
        [cell addSubview:explainLB];
        
        _explainTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(explainLB.frame)-5, 75+10, 240, 120)];
        _explainTextView.clipsToBounds = YES;
        _explainTextView.layer.cornerRadius = 5;
        _explainTextView.layer.borderWidth = 1;
        _explainTextView.layer.borderColor = [[UIColor grayColor]CGColor];
        _explainTextView.delegate = self;
        // TextView.text = @"最多输入100个汉字";
        [cell addSubview:_explainTextView];
        UILabel *photoLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_explainTextView.frame)+15, 120, 20)];
        photoLB.font = [UIFont systemFontOfSize:12];
        photoLB.text = @"上传问题商品图片：";
        photoLB.textColor = [UIColor blackColor];
        [cell addSubview:photoLB];
        
        UIButton *photoBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(photoLB.frame)-10, CGRectGetMaxY(_explainTextView.frame)+10, 30, 30)];
        [photoBtn setImage:[UIImage imageNamed:@"xiangji"] forState:UIControlStateNormal];
        // photoBtn.backgroundColor = [UIColor redColor];
        [photoBtn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:photoBtn];
        
        dynamicScrollView = [[DynamicScrollView alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(photoBtn.frame)+10, 230, 55) withImages:nil];
        [cell addSubview:dynamicScrollView];
        
        
        UILabel *nameLB = [[UILabel alloc]initWithFrame:CGRectMake(35, CGRectGetMaxY(photoBtn.frame)+85, 40, 20)];
        nameLB.font = [UIFont systemFontOfSize:12];
        nameLB.text = @"姓名：";
        nameLB.textColor = [UIColor blackColor];
        [cell addSubview:nameLB];
        
        _nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(nameLB.frame)-5,CGRectGetMaxY(photoBtn.frame)+80, 240, 35)];
        _nameField.backgroundColor = [UIColor whiteColor];
        _nameField.clipsToBounds = YES;
        _nameField.delegate = self;
        _nameField.layer.cornerRadius = 3;
        _nameField.layer.borderWidth = 1;
        _nameField.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:_nameField];
        
        UILabel *phoneLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameField.frame)+15, 70, 20)];
        phoneLB.font = [UIFont systemFontOfSize:12];
        phoneLB.text = @"联系电话：";
        phoneLB.textColor = [UIColor blackColor];
        [cell addSubview:phoneLB];
        
        _phoneField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phoneLB.frame)-10,CGRectGetMaxY(_nameField.frame)+10, 240, 35)];
        _phoneField.backgroundColor = [UIColor whiteColor];
        _phoneField.clipsToBounds = YES;
        _phoneField.delegate = self;
        _phoneField.layer.cornerRadius = 3;
        _phoneField.layer.borderWidth = 1;
        _phoneField.layer.borderColor = [[UIColor grayColor]CGColor];
        [cell addSubview:_phoneField];
        
        
        UILabel *addressLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_phoneField.frame)+15, 70, 20)];
        addressLB.font = [UIFont systemFontOfSize:12];
        addressLB.text = @"你的地址：";
        addressLB.textColor = [UIColor blackColor];
        [cell addSubview:addressLB];
        
        _addressTextView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(explainLB.frame)-5, CGRectGetMaxY(_phoneField.frame)+10, 240, 80)];
        _addressTextView.clipsToBounds = YES;
        _addressTextView.layer.cornerRadius = 5;
        _addressTextView.layer.borderWidth = 1;
        _addressTextView.layer.borderColor = [[UIColor grayColor]CGColor];
        _addressTextView.delegate = self;
        // TextView.text = @"最多输入100个汉字";
        [cell addSubview:_addressTextView];
        
        UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addressTextView.frame)+20, 300, 40)];
        sureBtn.clipsToBounds = YES;
        sureBtn.layer.cornerRadius = 5;
        [sureBtn setTitle:@"提交申请" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(surePress) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        [cell addSubview:sureBtn];
    }
    
    return cell;
}
// 实现代理.
#pragma mark - MXPullDownMenuDelegate

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row
{
    NSLog(@"%d -- %d", column, row);
}



-(void)addPhoto{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"添 加 图 片"
                                  delegate:self
                                  cancelButtonTitle:@"取 消"
                                  destructiveButtonTitle:@"打 开 照 相 机"
                                  otherButtonTitles:@"打 开 相 册",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}
-(void)surePress{
    
    if (self.isle == YES) {
        
        [self exchage];
        ExchageSuccessController *exs = [[ExchageSuccessController alloc]init];
        [self.navigationController pushViewController:exs animated:YES];
    }
    else{
        [self returnDatas];
        ReturnSuccessController *returnS = [[ReturnSuccessController alloc]init];
        [self.navigationController pushViewController:returnS animated:YES];
    }
    
}
-(void)exchage{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    int i = [(model.reasonId)intValue];
    
    NSLog(@"%d",i);
    BackReasonModel *backReason = self.exchageDatas[i];
    
    NSLog(@"%@",backReason.reasonId);
    NSString *path= [NSString stringWithFormat:EXPLACE,COMMON,model.jsessionid,model.userkey,model.serviceOrderId];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"content":_explainTextView.text,@"reasonId":model.reasonId,@"name":_nameField.text,@"phone":_phoneField,@"address":_addressTextView} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)returnDatas{
    
    SingleModel *model = [SingleModel sharedSingleModel];
    int i = [(model.reasonId)intValue];
    
    NSLog(@"%d",i);
    BackReasonModel *backReason = self.datas[i];
    
    NSLog(@"%@",backReason.reasonId);
    NSString *path= [NSString stringWithFormat:RETUNGOODSEXPLAIN,COMMON,model.jsessionid,model.userkey,model.serviceOrderId];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"content":_explainTextView.text,@"reasonId":model.reasonId,@"name":_nameField.text,@"phone":_phoneField,@"address":_addressTextView} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
/**
 *  打开ActionSheet
 *
 *  @param actionSheet 对象
 *  @param buttonIndex 按钮的索引
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //照相机
    if (buttonIndex == 0)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
        [self removeNofify];
    }
    //相册
    else if (buttonIndex == 1)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
        [self removeNofify];
    }
    else
    {
        
    }
}

/**
 *  选中照片
 *
 *  @param picker 选择器
 *  @param info   字典
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //媒体格式：图片和视频
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    
    if ([mediaType isEqualToString:@"public.image"])
    {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (image == nil)
        {
            return;
        }
        
        [dynamicScrollView addImageView:image];
        
        
        
        NSLog(@"%@",image);
    }
    else if ([mediaType isEqualToString:@"public.movie"])
    {
        NSLog(@"不支持视频！");
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  取消相册
 *
 *  @param picker picker
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  删除通知
 */
-(void)removeNofify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"picUpload" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"textUpload" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TCP_FAIL object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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



@end
