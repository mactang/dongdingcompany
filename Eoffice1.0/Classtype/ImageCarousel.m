//
//  ImageCarousel.m
//  315Demo
//
//  Created by My_Mac on 14-10-27.
//  Copyright (c) 2014年 My_Mac. All rights reserved.
//

#import "ImageCarousel.h"
#import "UIImageView+WebCache.h"
#import "MyAlertView.h"
#import "RequestAndJSON.h"
//#import "SearchView.h"
@interface ImageCarousel()<UIScrollViewDelegate>
{
    NSTimer *timer;
    int currentImage;
    NSMutableArray *imageArray;
    UIScrollView *scrollViewImage;
    NSInteger currentPage;
    NSInteger index ;
    NSMutableArray *arrayData;
    NSArray *arrayParameter;
    UIActivityIndicatorView *activityIndicatorView;
    ImageCarouselClickBlock clickBlock;
}
@end

@implementation ImageCarousel

- (id)initWithFrame:(CGRect)frame andDataSource:(NSArray *)parameter withClick:(ImageCarouselClickBlock)block
{
    self =  [self initWithFrame:frame andDataSource:parameter];
    if (self) {
        clickBlock = [block copy];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andDataSource:(NSArray *)parameter
{
   
    self = [super initWithFrame:frame];
    if (self) {
        arrayData = [NSMutableArray array];
        scrollViewImage = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollViewImage.contentSize = CGSizeMake(SCREEN_WIDTH * 3, scrollViewImage.bounds.size.height);
        scrollViewImage.pagingEnabled = YES;
        scrollViewImage.delegate = self;
        [self addSubview:scrollViewImage];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handleTap:)];
        [scrollViewImage addGestureRecognizer:tapGestureRecognizer];
        [self initDataSource:parameter];
    }
    return self;
}

/**
 *  初始化数据源
 *
 *  @param parameter 网络请求参数
 */
- (void)initDataSource:(NSArray *)parameter
{
    arrayParameter = [NSArray arrayWithArray:parameter];
    activityIndicatorView = [[UIActivityIndicatorView alloc] init];
    activityIndicatorView.center = scrollViewImage.center;
    activityIndicatorView.bounds = CGRectMake(0, 0, 30, 30);
    activityIndicatorView.activityIndicatorViewStyle= UIActivityIndicatorViewStyleGray;
    [scrollViewImage addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    imageArray = [NSMutableArray array];

    if ([parameter[1][@"URL"] isEqualToString:@""]) {
        [self startRefreshShop];
    }
    else
    {
        [self startRefresh];
    }
}



/**
 *  图片被点击后的回调事件
 *
 *  @param gesturer 手势类型
 */
- (void)handleTap:(UITapGestureRecognizer *)gesturer
{
//    clickBlock();
}
//循环自动播放
- (void)autoPlay
{
    //设置内容偏移量
    
    index = ++index%[imageArray count];
    [scrollViewImage setContentOffset:CGPointMake(index*320, 0) animated:YES];
    
    [self performSelector:_cmd withObject:nil afterDelay:2.0];
}


//启动计时器
- (void)startTimer
{
    //判断是否存在,入不存在则注册一个
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                   target:self
                                                 selector:@selector(processTimer:)
                                                 userInfo:nil
                                                  repeats:YES] ;
    }
    //配置timer的首次触发时间
    timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}
//暂停计时器
- (void)pauseTimer
{
    //若timer存在且激活,则暂停
    if (timer && timer.isValid) {
        timer.fireDate = [NSDate distantFuture];
    }
}
//停止计时器
//当页面需要退出,销毁时 需要手动停止timer,否则timer持有当前控制器无法正常释放销毁
- (void)stopTimer
{
    //如果timer存在且激活,则停止,注销
    [timer invalidate];
    timer = nil;
}
//处理计时器方法
- (void)processTimer:(NSTimer *)timer
{
    //设置内容偏移量
    [scrollViewImage setContentOffset:CGPointMake(320*2, 0) animated:YES];
}


//刷新数据
- (void)startRefresh
{
    [activityIndicatorView startAnimating];
    RequestAndJSON *requestJson = [[RequestAndJSON alloc] init];
    [requestJson asynchronousPOSTRequestOther:arrayParameter[1][@"URL"] params:arrayParameter[0] completionResultSuccess:^(id content) {
        [arrayData removeAllObjects];
        [arrayData addObjectsFromArray:content[@"data"]];
        if (content[@"data"] != [NSNull null]) {
            for (int i = 0; i < [content[@"data"] count]; i ++) {
                NSURL *url = [NSURL URLWithString:content[@"data"][i][@"img_url_path"]];
                if (!url) {
                    continue;
                }
                [imageArray addObject:url];
                
            }
            if ([imageArray count] > 0) {
                [self loadImage];
                [self startTimer];
            }
        }
    } failure:^(NSInteger buttonIndex) {
        [activityIndicatorView stopAnimating];
        if(buttonIndex == 0)
        {
            [self startRefresh];
        }

    }];

}

- (void)startRefreshShop
{
    [activityIndicatorView startAnimating];
    RequestAndJSON *requestJson = [[RequestAndJSON alloc] init];
    [requestJson asynchronousPOSTRequest:arrayParameter[1][@"URL"] params:arrayParameter[0] completionResultSuccess:^(id content) {
        [arrayData removeAllObjects];
        [arrayData addObjectsFromArray:content[@"data"][@"adv_list"]];
        if (content[@"data"] != [NSNull null]) {
            for (int i = 0; i < [content[@"data"][@"adv_list"] count]; i ++) {
                NSURL *url = [NSURL URLWithString:content[@"data"][@"adv_list"][i][@"image"]];
                if (!url) {
                    continue;
                }
                [imageArray addObject:url];
                
            }
            if ([imageArray count] > 0) {
                [self loadImage];
                [self startTimer];
            }
        }
    } failure:^(NSInteger buttonIndex) {
        [activityIndicatorView stopAnimating];
        if(buttonIndex == 0)
        {
            [self startRefresh];
        }
        
    }];
    
}


#pragma mark - UIScrollViewDelegate methods
//开始拖动时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}
//当出现任何滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x == 0  || scrollView.contentOffset.x == 640){
        if (scrollView.contentOffset.x  == 0) {
            currentPage =  (currentPage - 1 < 0) ? ([imageArray count] - 1) : (currentPage - 1);
        }else if (scrollView.contentOffset.x == 640) {
            currentPage =  (currentPage + 1 > [imageArray count] - 1) ? 0 : (currentPage + 1);
        }
        [self loadImage];
    }
}

//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    
    
}

//停止滚动时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    
    if(scrollView.contentOffset.x == 640)
    {

        if (currentPage > [imageArray count] - 1) {
           
            currentPage = 0;
        }
       // isCome = 0;
    }
    else if(scrollView.contentOffset.x == 0)
    {
        if (currentPage < 0) {
            
            currentPage = [imageArray count] - 1;
        }
        //isCome = 0;
    }
    [self loadImage];
    [scrollViewImage setContentOffset:CGPointMake(320, 0) animated:NO];
    [self startTimer];
    
}

- (void)updateAppearance
{

    index = round(scrollViewImage.contentOffset.x / scrollViewImage.bounds.size.width);

    for (int i = -1; i <= 1; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewImage.bounds.size.width * i, 0, scrollViewImage.bounds.size.width, scrollViewImage.bounds.size.height)];
        NSURL *imagePath = nil;
        if (currentPage + i < 0 ) {
            imagePath = imageArray[[imageArray count]- 1];
        }
        if (currentPage + i > [imageArray count] - 1 ) {
            imagePath = imageArray[0];
        }
        else
        {
            imagePath = imageArray[currentPage];
        }
        [imageView sd_setImageWithURL:imagePath];
        [scrollViewImage addSubview:imageView];
        
    }
    [self loadImage];
}

- (void)loadImage
{
    [scrollViewImage setContentOffset:CGPointMake(320, 0) animated:NO];
    [scrollViewImage.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSURL *imagePath = nil ;
    for (int i = -1; i <= 1; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewImage.bounds.size.width * (i+1), 0, scrollViewImage.bounds.size.width, scrollViewImage.bounds.size.height)];
        
        if (currentPage + i < 0 ) {
            imagePath = imageArray[[imageArray count]- 1];
        }
        else if (currentPage + i > [imageArray count] - 1 ) {
            imagePath = imageArray[0];
        }
        else
        {
            imagePath = imageArray[currentPage+i];
        }
//        SDWebImageManager *manager = [SDWebImageManager sharedManager];
//        UIImage *cachedImage = [manager imageCache:imagePath]; // 将需要缓存的图片加载进来
//        if (cachedImage) { // 如果Cache命中，则直接利用缓存的图片进行有关操作 // Use the cached image immediatly } else { // 如果Cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法 // Start an async download  [manager downloadWithURL:url delegate:self];
//        }
        [imageView sd_setImageWithURL:imagePath placeholderImage:[UIImage imageNamed:@"默认.jpg"]];
        [scrollViewImage addSubview:imageView];
       
    }
   
}

@end
