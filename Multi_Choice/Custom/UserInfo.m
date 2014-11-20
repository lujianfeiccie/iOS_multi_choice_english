//
//  UserInfo.m
//  Multi_Choice
//
//  Created by Apple on 14-10-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize m_checkversion_date;

-(id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.m_checkversion_date = [coder decodeObjectForKey:@"m_checkversion_date"];
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:m_checkversion_date forKey:@"m_checkversion_date"];
}
- (void)dealloc{
    [m_checkversion_date release];
    [super dealloc];
}
@end
