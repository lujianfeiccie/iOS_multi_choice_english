//
//  ModelData.m
//  Multi_Choice
//
//  Created by Apple on 14-9-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "ModelData.h"
#import "NSLogExt.h"
@implementation ModelData
@synthesize m_text;
@synthesize m_value;
-(id)init{
    self = [super init];
    if (self) {
        m_text = @"";
        m_value = @"";
    }
    return self;
}
@end
