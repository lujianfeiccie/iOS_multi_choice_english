//
//  NSMutableArrayExt.m
//  Multi_Choice
//
//  Created by Apple on 14/11/4.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NSMutableArrayExt.h"

@implementation NSMutableArrayExt
@synthesize m_type;

-(id)init
{
    if (self = [super init])
    {
        m_list = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void) addObject:(id) obj
{
    [m_list addObject:obj];
}
-(id) objectAtIndex:(NSUInteger) index
{
    return [m_list objectAtIndex:index];
}
-(NSUInteger) count
{
    return [m_list count];
}
-(void) dealloc
{
    [super dealloc];
    [m_list release];
    m_list = nil;
}
@end
