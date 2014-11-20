//
//  XMLHelper.h
//  Multi_Choice
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLElement.h"
@interface XMLHelper : NSObject<NSXMLParserDelegate>

// 解析器对象
@property (nonatomic,strong) NSXMLParser *parser;

// 根元素
@property (nonatomic,strong) XMLElement *rootElement;

// 当前的元素
@property (nonatomic,strong) XMLElement *currentElementPointer;

@property (nonatomic) BOOL m_random;

-(void) load:(NSString*) fileName;
-(void) loadMultiple:(NSUInteger) numOfQuestions : (NSString*) fileName,...;

@end
