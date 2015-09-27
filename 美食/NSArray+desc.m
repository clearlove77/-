//
//  UIScrollView+Extend.m
//  美食
//
//  Created by Looper on 15/9/26.
//  Copyright © 2015年 clearlove. All rights reserved.
//


#import "NSArray+desc.h"

@implementation NSArray (desc)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString * mutString = [NSMutableString string];
    [mutString appendString:@"(\n"];
    for (id obj in self)
    {
        NSString * str = [obj description];
        [mutString appendFormat:@"\t\n%@",str];
    }
    
    [mutString appendString:@")\n"];
    
    return mutString;
}

- (NSString *)description
{
    return @"adfsd";
}

@end
