//
//  UIScrollView+Extend.m
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright © 2015年 clearlove. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GPSubject.h"
#import "UITableViewCell+initcell.h"

@interface GPSubejctCell : UITableViewCell

@property(nonatomic,strong)GPSubject * subject;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

+(id)subejctCellWithTableView:(UITableView *)tableView;

@end
