//
//  GPHeaderView.h
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPHeaderView;

enum GPHeaderViewStatus
{
    GPHeaderViewStatusDragging,  //下拉刷新更多
    GPHeaderViewStatusLoading,   //正在刷新
};
typedef enum GPHeaderViewStatus GPHeaderViewStatus;

@protocol GPHeaderViewDelegate <NSObject>

- (void)headerViewStatus:(GPHeaderView *)headerView status:(GPHeaderViewStatus)status;

@end

@interface GPHeaderView : UIView
@property(nonatomic,weak)id<GPHeaderViewDelegate> delegate;

@property(nonatomic,assign)GPHeaderViewStatus status;

- (void)stopAnimation;

+ (id)headerView;

- (void)setTitle:(NSString *)title forState:(GPHeaderViewStatus)status;

@end
