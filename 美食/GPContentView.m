//
//  GPContentView.m
//  美食
//
//  Created by qianfeng on 15-9-23.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPContentView.h"
#import "GPSubejctCell.h"
#import "GPFooterView.h"
#import "GPHeaderView.h"
#import "UIScrollView+Extend.h"

@interface GPContentView()<UITableViewDataSource,UITableViewDelegate,GPFooterViewDelegate,GPHeaderViewDelegate>

@property(nonatomic,weak)GPFooterView * footerView;
@property(nonatomic,weak)GPHeaderView * headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GPContentView

- (void)setSubjectArray:(NSArray *)subjectArray
{
    _subjectArray = subjectArray;

    [self.tableView reloadData];
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}

//当self对象是从xib文件加载而来的时候,会调用这个方法,并且只调用一次
//创建一些子控件,设置改变一些控件的属性
- (void)awakeFromNib
{
    [self.tableView addRefreshHeaderViewWithAniViewClass:[GPHeaderView class] beginRefresh:nil];
    
    //1.添加子控件
    [self.tableView addRefreshFooterViewWithAniViewClass:[GPFooterView  class] beginRefresh:nil];
}

+(id)contentView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
    self.backgroundColor = [UIColor yellowColor];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subjectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GPSubejctCell * cell = [GPSubejctCell subejctCellWithTableView:tableView];
    cell.subject = self.subjectArray[indexPath.row];
    
    NSLog(@"%p",cell);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
