//
//  XMLCalcHelper.m
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLCalcHelper.h"
#import "NSLogExt.h"
#import "Util.h"
@implementation XMLCalcHelper

-(id) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) load:(NSString*) fileName
{
    NSString* result = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSLogExt(@"filename=%@",fileName)
    NSData *data = [[NSData alloc]initWithContentsOfFile:result];
    
    self.parser = [[NSXMLParser alloc]initWithData:data];
    
    self.parser.delegate = self;
    
    [[self.rootElement m_subElements] removeAllObjects];
    self.rootElement = nil;
    if([self.parser parse])
    {
        
    }
}
-(void) loadMultiple:(NSUInteger) numOfQuestions : (NSString*) fileName,...
{
    va_list arguments;
    id eachObject;
    
    NSMutableArray *questions = [[NSMutableArray alloc] init];
    if (fileName) {
        NSLogExt(@"%@",fileName);
        
        
        NSString* result = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
        NSData *data = [[NSData alloc]initWithContentsOfFile:result];
        
        self.parser = [[NSXMLParser alloc]initWithData:data];
        
        self.parser.delegate = self;
        
        [[self.rootElement m_subElements] removeAllObjects];
        self.rootElement = nil;
        
        if([self.parser parse]){
            [questions addObjectsFromArray:self.rootElement.m_subElements];
        }
        va_start(arguments, fileName);
        
        
        
        while ((eachObject = va_arg(arguments, id))) {
            result = [[NSBundle mainBundle] pathForResource:eachObject ofType:@"xml"];
            data = [[NSData alloc]initWithContentsOfFile:result];
            
            self.parser = [[NSXMLParser alloc]initWithData:data];
            
            self.parser.delegate = self;
            
            if([self.parser parse])
            {
                [questions addObjectsFromArray:self.rootElement.m_subElements];
            }
            NSLogExt(@"%@",eachObject);
        }
        
        va_end(arguments);
    }
    
    NSUInteger count = [questions count];
    NSMutableArray *questions_tmp = [[NSMutableArray alloc] init];
    NSUInteger *randnum_questions= [Util getRandomNumOfOut:numOfQuestions NumOfIn:count];
    
    // NSLogExt(@"count=%i",count);
    
    // Random the questions
    for (int i=0; i<numOfQuestions; ++i) {
        [questions_tmp addObject:[questions objectAtIndex:randnum_questions[i]]];
        
    }
    [questions removeAllObjects];
    free(randnum_questions);
    randnum_questions = nil;
    
    self.rootElement.m_subElements = questions_tmp;
}
// 文档开始
-(void)parserDidStartDocument:(NSXMLParser *)parser

{
    NSLogExt(@"parserDidStartDocument");
    self.rootElement = nil;
    
    self.currentElementPointer = nil;
    
}

// 文档结束
-(void)parserDidEndDocument:(NSXMLParser *)parser

{
    NSLogExt(@"parserDidEndDocument");
    self.currentElementPointer = nil;
    
}

// 元素开始
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    
    if(self.rootElement == nil){
        
        self.rootElement = [[XMLCalcElement alloc]init];
        
        self.currentElementPointer = self.rootElement;
        
    }else{
        
        XMLCalcElement *newElement = [[XMLCalcElement alloc]init];
        
        newElement.m_parent = self.currentElementPointer;
        
        [self.currentElementPointer.m_subElements addObject:newElement];
        
        self.currentElementPointer = newElement;
        
    }
    
    self.currentElementPointer.m_elementName = elementName;
    if ([self.currentElementPointer.m_elementName isEqual:@"text"])
    {
        self.currentElementPointer.m_tag = [attributeDict objectForKey:@"tag"];
        self.currentElementPointer.m_value = [attributeDict objectForKey:@"value"];
      //  NSLogExt(@"name:%@" , elementName);
    }
    else
    {
        self.currentElementPointer.m_tag = [attributeDict objectForKey:@"tag"];
        self.currentElementPointer.m_value = [attributeDict objectForKey:@"value"];
        
    }
   // NSLogExt(@"name:%@" , elementName);
}

// 元素结束

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

{
    
    self.currentElementPointer = self.currentElementPointer.m_parent;
    
    //NSLogExt(@"end name:%@" , elementName);
    
}

// 解析文本,会多次解析，每次只解析1000个字符，如果多月1000个就会多次进入这个方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
  //  if([self.currentElementPointer.m_elementName isEqualToString:@"answer"])
     //   self.currentElementPointer.m_choice = string;
    
    
    
    // NSLogExt(@"string:%@" , string);
}

@end
