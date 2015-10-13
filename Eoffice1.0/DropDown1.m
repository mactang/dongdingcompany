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
    tabheight = frameHeight - 25;
    
    frame.size.height = 30.0f;
    
    self=[super initWithFrame:frame];
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 120, 50)];
        tv.delegate = self;
        tv.dataSource = self;
        tv.backgroundColor = [UIColor grayColor];
        tv.separatorColor = [UIColor lightGrayColor];
        tv.hidden = YES;
        [self addSubview:tv];
        textButton = [[classifyButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width-10, 25)];
        textButton.backgroundColor = [UIColor clearColor];
        textButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [textButton setTitleColor:[UIColor colorWithRed:63.24/255. green:64.00/255. blue:127.00/255. alpha:1] forState:UIControlStateNormal];
        textButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [textButton setImage:[UIImage imageNamed:@"classify"] forState:UIControlStateNormal];
        [textButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:textButton];
        
        UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textButton.frame)-10, textButton.frame.origin.y+10, 13, 13)];
        [button setImage:[UIImage imageNamed:@"clBelow"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"below2"] forState:UIControlStateSelected];
        button.tag = 100;
        [self addSubview:button];
        
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    cell.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     //dropDownMenu.title = [NSString stringWithFormat:@"%@▼",selection];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1];
    cell.backgroundColor = [UIColor whiteColor];
    
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
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor colorWithRed:237./255 green:237./255 blue:237./255 alpha:1];
    
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
