//
//  GPFooterView.m
//  美食
//
//  Created by qianfeng on 15-9-23.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

/*
 
 重构代码原则:
 1.要确定,那一部分逻辑是不会发生变化的,对其进行封装
 2.重构代码,要小步进行操作,尽可能的一步一测,不要因为代码的迁移,引入新的bug
 3.找出代码中,不合理的地方进行逐步的修正,也要保证一个功能一个功能的测试修改
 4.作为组件封装的视图,要站在使用者的角度进行思考,不要把复杂的实现逻辑抛给使用者
 */

#import "GPFooterView.h"

@interface GPFooterView()


@property(nonatomic,assign)UIScrollView * scrollView;

@property(nonatomic,weak)UIButton * alertButtonView;

@property(nonatomic,weak)UIView * loadingView;

@end

@implementation GPFooterView
{
    NSString * _beginDragText;
    NSString * _draggingText;
    NSString * _loadingText;
    
}

- (void)setTitle:(NSString *)title forState:(GPFooterViewStatus)status
{
    switch (status) {
            
        case GPFooterViewStatusBeginDrag:
            _beginDragText = title;
            break;
        case GPFooterViewStatusDragging:
            _draggingText = title;
            break;
        case GPFooterViewStatusLoading:
            _loadingText = title;
            break;
            
        default:
            break;
    }
}

// 如果没传入title,则默认给定一个值
- (NSString *)titleWithStatus:(GPFooterViewStatus)status
{
    NSString * title = nil;
    
    switch (status) {
            
        case GPFooterViewStatusBeginDrag:
            title = _beginDragText?_beginDragText:@"拖拽加载更多";
            break;
        case GPFooterViewStatusDragging:
            title = _draggingText?_draggingText:@"松开加载更多";
            break;
        case GPFooterViewStatusLoading:
            title = _loadingText?_loadingText:@"正在加载";
            break;
            
        default:
            break;
    }
    
    return title;
}

- (void)stopAnimation
{
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0,0);
    [self clear];
}

- (void)clear
{
    [self.alertButtonView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    self.status = GPFooterViewStatusBeginDrag;
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
    if(self.status == GPFooterViewStatusLoading) return;
    
    [self willMoveToSuperview:self.scrollView];

    if (self.scrollView.isDragging){
 
        CGFloat maxY  = _scrollView.contentSize.height - _scrollView.frame.size.height;
        CGFloat footerViewHeight = self.frame.size.height;
        
        if (_scrollView.contentOffset.y >= maxY && _scrollView.contentOffset.y < maxY + footerViewHeight)
        {
            [self setStatus:GPFooterViewStatusBeginDrag];
        }
        else if(_scrollView.contentOffset.y > maxY + footerViewHeight)
        {
            [self setStatus:GPFooterViewStatusDragging];
        }
        

    }//end  if (self.scrollView.isDragging)
    else
    {
        if (self.status == GPFooterViewStatusDragging)
        {
            [self setStatus:GPFooterViewStatusLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            
            [_delegate footerViewStatus:self status:GPFooterViewStatusLoading];
        }
        
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
        labelTitle.text = [self titleWithStatus:GPFooterViewStatusLoading];//_loadingText;//@"正在读取";
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

+ (id)footerView
{
    return [[self alloc] init];
}

- (void)setStatus:(GPFooterViewStatus)status
{
    _status = status;
    
    switch (status) {
            
        case GPFooterViewStatusBeginDrag:
            
            [self.alertButtonView setTitle:[self titleWithStatus:status] forState:UIControlStateNormal];
            break;
        case GPFooterViewStatusDragging:
//            NSLog(@"松开读取更多");
            [self.alertButtonView setTitle:[self titleWithStatus:status]  forState:UIControlStateNormal];
            break;
        case GPFooterViewStatusLoading:
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
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];
    
    
}

- (void)didMoveToSuperview
{
    self.scrollView = self.superview;
}

@end
