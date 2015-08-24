//
//  DropDown1.m
//  demo
//
//  Created by gyz on 15/5/7.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "DropDown1.h"
#define kOptionHeight 40
#define kOptionSpacing 1
#define kAnimationDuration 0.2
@implementation DropDown1{

    CGRect mBaseFrame;
    BOOL mControlIsActive;
    NSMutableArray *mSelectionCells;
}
@synthesize tv,tableArray,textButton;



-(id)initWithFrame:(CGRect)frame
{
    tableArray = [[NSArray alloc]init];
    if (frame.size.height<200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight - 60;
    
    frame.size.height = 30.0f;
    
    self=[super initWithFrame:frame];
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 100, 50)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor grayColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        textButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        textButton.backgroundColor = [UIColor clearColor];
        textButton.font = [UIFont systemFontOfSize:12];
        [textButton setTitleColor:[UIColor colorWithRed:63.24/255. green:64.00/255. blue:127.00/255. alpha:1] forState:UIControlStateNormal];
        [textButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
        [textButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        
        [self addSubview:textButton];
        
       
        
    }
    return self;
}
-(void)dropdown{
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        tv.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = tv.frame;
        frame.size.height = 0;
        tv.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        tv.frame = frame;
        [UIView commitAnimations];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     //dropDownMenu.title = [NSString stringWithFormat:@"%@▼",selection];
    
    [textButton setTitle:[NSString stringWithFormat:@"%@▼",[tableArray objectAtIndex:[indexPath row]]] forState:UIControlStateNormal];
    showList = NO;
    tv.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = tv.frame;
    frame.size.height = 0;
    tv.frame = frame;
    [self.delegate dropDownControlView:self didFinishWithSelection:[NSString stringWithFormat:@"%@",[tableArray objectAtIndex:[indexPath row]]]];
}
#pragma mark - Configuration

- (void)setSelectionOptions:(NSArray *)selectionOptions withTitles:(NSArray *)selectionOptionTitles {
    
    if ([selectionOptions count] != [selectionOptionTitles count]) {
        [NSException raise:NSInternalInconsistencyException format:@"selectionOptions and selectionOptionTitles must contain the same number of objects"];
    }
    selectionOptions = selectionOptions;
    mSelectionCells = selectionOptionTitles;
    //mSelectionCells = nil;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
