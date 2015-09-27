//
//  UIScrollView+Extend.m
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright © 2015年 clearlove. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIScrollView (Extend)
/**
 *  添加下拉刷新HeaderView
 *
 *  @param aniViewClass 需要执行的动画的Class
 *  @param beginRefresh 开始刷新时需要执行的操作，如网络请求等
 */
- (void)addRefreshHeaderViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh;
/**
 *  添加上拉加载FooterView
 *
 *  @param aniViewClass 需要执行的动画的Class
 *  @param beginRefresh 开始刷新时需要执行的操作，如网络请求等
 */
- (void)addRefreshFooterViewWithAniViewClass:(Class)aniViewClass beginRefresh:(void (^)())beginRefresh;

/**
 *  结束下拉刷新
 *
 *  @param result 刷新结果
 */
- (void)headerEndRefreshing;
/**
 *  结束上拉加载
 */
- (void)footerEndRefreshing;

@end
