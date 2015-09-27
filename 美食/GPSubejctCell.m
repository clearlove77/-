//
//  GPSubejctCell.m
//  美食
//
//  Created by qianfeng on 15-9-22.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPSubejctCell.h"

@interface GPSubejctCell()



@end

@implementation GPSubejctCell

- (void)setSubject:(GPSubject *)subject
{
    _subject = subject;
    
    //更新子控件内容
    self.iconImageView.image = [UIImage imageNamed:subject.icon];
    self.nameLabel.text = subject.title;
}

+(id)subejctCellWithTableView:(UITableView *)tableView
{
    /*
    GPSubejctCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[GPSubejctCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"adf";
    */
    
    
    /*
   return  [[[NSBundle mainBundle] loadNibNamed:@"GPSubejctCell" owner:nil options:nil] lastObject];
    */
    
    /*
    GPSubejctCell * cell = [tableView dequeueReusableCellWithIdentifier:@"A"];
    
    if (cell == nil)
    {
    //苹果建议我们经常性加载的xib文件要使用UINIb
        UINib * nib = [UINib nibWithNibName:@"GPSubejctCell" bundle:nil];
        cell = [[nib instantiateWithOwner:nil options:nil] lastObject];
    }
    */

    /*
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    
    //如果有可重用的返回,如果没有可重用的创建一个新的返回
    return [tableView dequeueReusableCellWithIdentifier:className];
    */
    
    return [self cellWithTableView:tableView];
    
//    return cell;
}

@end
