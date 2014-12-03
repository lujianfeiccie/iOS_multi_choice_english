//
//  XMLElement.m
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLElement.h"

@implementation XMLElement

@synthesize m_title;
@synthesize m_answer;
@synthesize m_choice;
@synthesize m_note;
@synthesize m_parent;
@synthesize m_subElements;
@synthesize m_selected;
@synthesize m_bCorrect;
-(id)init{
   self = [super init];
    if (self) {
        m_selected = -1;
        m_bCorrect = NO;
    }
    return self;
}
-(NSMutableArray*) m_subElements{
    if(m_subElements == nil){
        m_subElements = [[NSMutableArray alloc]init];
    }
    return m_subElements;
}
-(void) setSelectExt:(NSInteger) selected{
    m_selected = selected;
}
-(void) setCorrect: (BOOL) isCorrected
{
    m_bCorrect = isCorrected;
}
-(BOOL) isCorrect
{
    return m_bCorrect;
}
@end
