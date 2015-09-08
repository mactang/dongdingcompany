//
//  PersonalInformationController.m
//  Eoffice1.0
//
//  Created by gyz on 15/7/21.
//  Copyright (c) 2015年 gl. All rights reserved.
//
#define TCP_FAIL @"socketFail"

#import "PersonalInformationController.h"
#import "NickNameController.h"
#import "SixAlterView.h"
#import "birthdayAlterView.h"
#import "DatePickView.h"
#import "RDVTabBarController.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "SingleModel.h"
#import "PersonInformationModel.h"
@interface PersonalInformationController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIApplicationDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UIImage *imageName;
@property(nonatomic, strong)NSMutableArray *datas;
@property(nonatomic,strong)DatePickView *pickview;
@property(nonatomic,strong)UIImageView *imageView ;

@property(nonatomic,strong)UILabel *nameBl;
@property(nonatomic,strong)UITextField *nickName;


@end

@implementation PersonalInformationController

-(NSMutableArray *)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *ligthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ligthButton addTarget:self action:@selector(leftItemClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage *ligthImage = [UIImage imageNamed:@"youzhixiang11(1)"];
    [ligthButton setBackgroundImage:ligthImage forState:UIControlStateNormal];
    ligthButton.frame = CGRectMake(0, 0, ligthImage.size.width, ligthImage.size.height);
    UIBarButtonItem *lightItem2 = [[UIBarButtonItem alloc]initWithCustomView:ligthButton];
    [self.navigationItem setLeftBarButtonItem:lightItem2];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton addTarget:self action:@selector(rightItemClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
     self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.navigationItem.title = @"个人信息";
    [self downData];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 390) style:UITableViewStylePlain];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_tableView.frame)+20, 300, 40)];
    sureButton.backgroundColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    
    sureButton.font = [UIFont systemFontOfSize:15];
    
    [sureButton addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureButton];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(230, 5, 70, 70)];
    _imageView.image = [UIImage imageNamed:@"link.jpg"];
    _imageView.backgroundColor = [UIColor redColor];
    [_tableView addSubview:_imageView];
    
    // Do any additional setup after loading the view.
}
-(void)rightItemClicked{

    [self reviseData];
    
}
-(void)reviseData{

    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:PERSONREVISE,model.jsessionid,model.userkey];
    NSLog(@"path--%@",path);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:path parameters:@{@"nike":_nickName.text} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)downData{
    
    
    SingleModel *model = [SingleModel sharedSingleModel];
    
    
    NSString *path= [NSString stringWithFormat:PERSONCONME,model.jsessionid,model.userkey];
    NSLog(@"%@",path);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {//block里面：第一个参数：是默认参数  第二个参数：得到的数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"data"] !=[NSNull null]){
       NSDictionary *array = dic[@"data"];
        PersonInformationModel *model = [PersonInformationModel modelWithDic:array];
        
        [self.datas addObject: model];
                
        NSLog(@"%@",self.datas);
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


-(void)backPress{
    //LoginViewController *login = [[LoginViewController alloc]init];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datas.count*6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 80;
    }
    else
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identity = @"cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
    
    cell.clipsToBounds = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    PersonInformationModel *model = self.datas[0];
      NSLog(@"%@",model.name);
    if (indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"用户名";
        
        _nameBl = [[UILabel alloc]initWithFrame:CGRectMake(250, 10, 60, 20)];
        _nameBl.font = [UIFont systemFontOfSize:12];
        [_nameBl setText:[NSString stringWithFormat:@"%@",model.name]];
        [cell addSubview:_nameBl];
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = @"昵称";
        _nickName = [[UITextField alloc]initWithFrame:CGRectMake(210, 10, 100, 30)];
        _nickName.backgroundColor = [UIColor whiteColor];
        _nickName.placeholder = [NSString stringWithFormat:@"%@",model.shorname];
        _nickName.clearButtonMode = UITextFieldViewModeAlways;
        _nickName.delegate = self;
        [cell addSubview:_nickName];
    }
    if (indexPath.row == 3) {
        cell.textLabel.text = @"性别";
    }
    if (indexPath.row == 4) {
        cell.textLabel.text = @"生日";
    }
    if (indexPath.row == 5) {
        cell.textLabel.text = @"公司名字";
        UITextField *computerName = [[UITextField alloc]initWithFrame:CGRectMake(200, 10, 120, 30)];
        computerName.backgroundColor = [UIColor whiteColor];
        computerName.placeholder = @"东鼎泰和科技有限公司";
        computerName.clearsOnBeginEditing = YES;
        computerName.clearButtonMode = UITextFieldViewModeAlways;
        computerName.delegate = self;
        [cell addSubview:computerName];
    }
    
    return cell;
}
//点击return键执行的方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"添 加 图 片"
                                      delegate:self
                                      cancelButtonTitle:@"取 消"
                                      destructiveButtonTitle:@"打 开 照 相 机"
                                      otherButtonTitles:@"打 开 相 册",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
    
    if (indexPath.row == 3) {
        SixAlterView *alter=[[SixAlterView alloc]initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        alter.rightBlock=^()
        {
            NSLog(@"右边按钮被点击");
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
    if (indexPath.row == 4) {

        NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
        _pickview=[[DatePickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        [_pickview initWithTitle:nil leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        [_pickview show];    }
    
    
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
        
        _imageName = image;
        
        _imageView.image = _imageName;
        
       
        
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
- (void)leftItemClicked{
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = YES;
    
    
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
