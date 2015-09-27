//
//  UIScrollView+Extend.m
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright © 2015年 clearlove. All rights reserved.
//


#import "NSObject+Model.h"

@implementation NSObject (Model)

+(id)objectWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
