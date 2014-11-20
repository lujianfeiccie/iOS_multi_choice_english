//
//  XMLCalcElement.m
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLCalcElement.h"

@implementation XMLCalcElement
@synthesize m_elementName;
@synthesize m_tag;
@synthesize m_value;
@synthesize m_parent;
@synthesize m_subElements;
-(id)init{
    self = [super init];
    if (self)
    {
    }
    return self;
}
-(NSMutableArray*) m_subElements{
    if(m_subElements == nil){
        m_subElements = [[NSMutableArray alloc]init];
    }
    return m_subElements;
}

@end
