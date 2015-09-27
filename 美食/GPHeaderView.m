//
//  GPHeaderView.m
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPHeaderView.h"
@interface GPHeaderView()


@property(nonatomic,assign)UIScrollView * scrollView;

@property(nonatomic,weak)UIButton * alertButtonView;

@property(nonatomic,weak)UIView * loadingView;

@end


@implementation GPHeaderView
{
    NSString * _draggingText;
    NSString * _loadingText;
}

- (void)setTitle:(NSString *)title forState:(GPHeaderViewStatus)status
{
    switch (status) {
        case GPHeaderViewStatusDragging:
            _draggingText = title;
            break;
        case GPHeaderViewStatusLoading:
            _loadingText = title;
            break;
        default:
            break;
    }
}

// 如果没传入title,则默认给定一个值
- (NSString *)titleWithStatus:(GPHeaderViewStatus)status
{
    NSString * title = nil;
    
    switch (status) {
        case GPHeaderViewStatusDragging:
            title = _draggingText?_draggingText:@"下拉刷新";
            break;
        case GPHeaderViewStatusLoading:
            title = _loadingText?_loadingText:@"正在加载";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (void)stopAnimation
{
    self.scrollView.contentInset = UIEdgeInsetsMake(0,0,0,0);
    [self clear];
}

- (void)clear
{
    [self.alertButtonView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.status = GPHeaderViewStatusDragging;
}
- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    //1.移除旧的
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //2.保存成员变量
    _scrollView = scrollView;
    //3.添加新的监听
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.status == GPHeaderViewStatusLoading) return;
    
    [self willMoveToSuperview:self.scrollView];
    
    if (self.scrollView.isDragging){
        
        CGFloat maxY  = -60;
        NSLog(@"%f",_scrollView.contentOffset.y);
        if (_scrollView.contentOffset.y >= maxY)
        {
            [self setStatus:GPHeaderViewStatusDragging];
        }
        
    }//end  if (self.scrollView.isDragging)
    else
    {
            [self setStatus:GPHeaderViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
            [_delegate headerViewStatus:self status:GPHeaderViewStatusLoading];
        
        
    }//end else
    
}//end method

- (UIView *)loadingView
{
    if (_loadingView == nil)
    {
        //1.
        UIView * loadingView = [UIView new];//[[UIView alloc] init];
        //2.
        [self addSubview:loadingView];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
        
        //创建子控件
        UILabel * labelTitle = [UILabel new];
        [loadingView addSubview:labelTitle];
        labelTitle.text = [self titleWithStatus:GPHeaderViewStatusLoading];//_loadingText;//@"正在读取";
        labelTitle.frame = loadingView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView addSubview:activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
        
        
    }
    
    return _loadingView;
}

- (UIButton *)alertButtonView
{
    if (_alertButtonView == nil)
    {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        
        btn.frame = self.bounds;
        _alertButtonView = btn;
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        
        
    }
    return _alertButtonView;
}

+ (id)headerView
{
    return [[self alloc] init];
}

- (void)setStatus:(GPHeaderViewStatus)status
{
    _status = status;
    
    switch (status) {
        case GPHeaderViewStatusDragging:
            [self.alertButtonView setTitle:[self titleWithStatus:status]  forState:UIControlStateNormal];
            break;
        case GPHeaderViewStatusLoading:
            self.alertButtonView.hidden = YES;
            self.loadingView;
            break;
            
        default:
            break;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    //1.添加到那里?
    UITableView * tableView = (UITableView *)newSuperview;
    //2.添加到什么位置?
    CGFloat selfX = 0;
    CGFloat selfY = -60;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];
}

- (void)didMoveToSuperview
{
    self.scrollView = (UITableView *)self.superview;
}

@end
