//
//  GPSubject.m
//  美食
//
//  Created by qianfeng on 15-9-22.
//  Copyright (c) 2015年 肖喆. All rights reserved.
//

#import "GPSubject.h"

@implementation GPSubject

+(id)subjectWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"title = %@ note = %@    ", _title,_note];
}


@end
