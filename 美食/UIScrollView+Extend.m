//
//  UIScrollView+Extend.m
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright © 2015年 clearlove. All rights reserved.
//

#import "UIScrollView+Extend.h"
#import "GPHeaderView.h"
#import "GPFooterView.h"
#import <objc/runtime.h>

@interface UIScrollView()<GPFooterViewDelegate,GPHeaderViewDelegate>
@property(nonatomic, weak) GPHeaderView *headerView;
@property(nonatomic, weak) GPFooterView *footerView;

@end
@implementation UIScrollView (Extend)
#pragma mark -- 关联属性
static char GPHeaderViewKey;
static char GPFooterViewKey;


- (void)setHeaderView:(GPHeaderView *)headerView
{
    [self willChangeValueForKey:@"GPHeaderViewKey"];
    objc_setAssociatedObject(self, &GPHeaderViewKey, headerView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GPHeaderViewKey"];
}

- (GPHeaderView *)headerView
{
    return objc_getAssociatedObject(self, &GPHeaderViewKey);
}

- (void)setFooterView:(GPFooterView *)footerView
{
    [self willChangeValueForKey:@"GPFooterViewKey"];
    objc_setAssociatedObject(self, &GPFooterViewKey, footerView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"GPFooterViewKey"];
}

- (GPFooterView *)footerView
{
    return objc_getAssociatedObject(self, &GPFooterViewKey);
}

- (void)addRefreshHeaderViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh
{
    assert([aniViewClass isSubclassOfClass:[GPHeaderView class]]);
    if(!self.headerView)
    {
        GPHeaderView *headerView = [GPHeaderView headerView];
        [self addSubview:headerView];
        self.headerView = headerView;
        headerView.delegate = self;
    }
}

- (void)addRefreshFooterViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh
{
    assert([aniViewClass isSubclassOfClass:[GPFooterView class]]);
    if(!self.footerView)
    {
        GPFooterView *footerView = [GPFooterView footerView];
        [self addSubview:footerView];
        self.footerView = footerView;
        footerView.delegate = self;
    }
}

- (void)headerEndRefreshing
{
    NSLog(@"刷新--请求结束");
    [self.headerView stopAnimation];
}

- (void)footerEndRefreshing
{
    NSLog(@"加载--请求结束");
    [self.footerView stopAnimation];
}

#pragma mark GPFooterViewDelegate

- (void)footerViewStatus:(GPFooterView *)footerView status:(GPFooterViewStatus)status
{
    NSLog(@"开始网络请求");
    [self performSelector:@selector(footerEndRefreshing) withObject:nil afterDelay:5];
}

#pragma mark GPHeaderViewDelegate
- (void)headerViewStatus:(GPHeaderView *)headerView status:(GPHeaderViewStatus)status
{
    NSLog(@"开始刷新请求");
    [self performSelector:@selector(headerEndRefreshing) withObject:nil afterDelay:5];
}

@end
