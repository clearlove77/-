//
//  GPFooterView.h
//  美食
//
//  Created by qianfeng on 15-9-23.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GPFooterView;

enum GPFooterViewStatus
{
    GPFooterViewStatusBeginDrag, //拖拽读取更多
    GPFooterViewStatusDragging,  //松开读取更多
    GPFooterViewStatusLoading,   //正在读取
};

typedef enum GPFooterViewStatus GPFooterViewStatus;


@protocol GPFooterViewDelegate <NSObject>

- (void)footerViewStatus:(GPFooterView *)footerView status:(GPFooterViewStatus)status;

@end

@interface GPFooterView : UIView


@property(nonatomic,weak)id<GPFooterViewDelegate> delegate;

@property(nonatomic,assign)GPFooterViewStatus status;



- (void)stopAnimation;

+ (id)footerView;

- (void)setTitle:(NSString *)title forState:(GPFooterViewStatus)status;

@end
