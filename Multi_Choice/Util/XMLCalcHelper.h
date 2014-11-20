//
//  XMLCalcHelper.h
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLCalcElement.h"
@interface XMLCalcHelper : NSObject<NSXMLParserDelegate>
// 解析器对象
@property (nonatomic,strong) NSXMLParser *parser;

// 根元素
@property (nonatomic,strong) XMLCalcElement *rootElement;

// 当前的元素
@property (nonatomic,strong) XMLCalcElement *currentElementPointer;

-(void) load:(NSString*) fileName;
-(void) loadMultiple:(NSUInteger) numOfQuestions : (NSString*) fileName,...;
@end
