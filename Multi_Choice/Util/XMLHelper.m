//
//  XMLHelper.m
//  Multi_Choice
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "XMLHelper.h"
#import "NSLogExt.h"
#import "Util.h"
@implementation XMLHelper

-(id) init{
    self = [super init];
    if (self) {
        self.m_random = NO;
    }
    return self;
}

-(void) load:(NSString*) fileName
{
    NSString* result = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
  //  NSLogExt(@"filename=%@",fileName)
    NSData *data = [[NSData alloc]initWithContentsOfFile:result];
    
    self.parser = [[NSXMLParser alloc]initWithData:data];
    
    self.parser.delegate = self;
    
    [self.rootElement.m_subElements removeAllObjects];
     self.rootElement= nil;
    if([self.parser parse])
    {
        
      //  NSLogExt(@"The XML is Parsed");
        
        if (self.m_random == YES)
        {
       
            NSMutableArray *questions = self.rootElement.m_subElements;

            NSUInteger count_questions = [questions count];
            
            //Random the questions
            NSMutableArray *questions_tmp = [[NSMutableArray alloc]init];
            NSUInteger* randnum_question = [Util getRandomNumOfOut:count_questions NumOfIn:count_questions];
            
            for (int i_q=0; i_q<count_questions; i_q++) {
                [questions_tmp addObject:[questions objectAtIndex:randnum_question[i_q]]];
            }
            free(randnum_question);
            randnum_question = nil;
            [questions removeAllObjects];
            questions = nil;
            //Random the choices
            
            
            for (int i_q=0; i_q<count_questions; i_q++)
            {
                NSMutableArray *choices = [[questions_tmp objectAtIndex:i_q] m_subElements];
                
                NSMutableArray* choices_tmp = [[NSMutableArray alloc]init];
                
                NSUInteger count_choices = [choices count];
               
               NSUInteger *randnum_choice = [Util getRandomNumOfOut:count_choices NumOfIn:count_choices];
                
               
             
                for (int i_c=0; i_c<count_choices; i_c++)
                {
                    [choices_tmp addObject:[choices objectAtIndex:randnum_choice[i_c]]];
                }
                free(randnum_choice);
                randnum_choice = nil;
                [choices removeAllObjects];
                choices = nil;
                ((XMLElement*)[questions_tmp objectAtIndex:i_q]).m_subElements = choices_tmp;
            }
            
            self.rootElement.m_subElements = questions_tmp;
           
        }
        
       
       
    }
    else
    {
        
        NSLogExt(@"Failed to parse the XML");
        
    }

}

-(void) loadMultiple:(NSUInteger) numOfQuestions : (NSString *)fileName, ...
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
       
        if([self.parser parse]){
            [questions addObjectsFromArray:self.rootElement.m_subElements];
        }
        va_start(arguments, fileName);
       
        
       
        while ((eachObject = va_arg(arguments, id))) {
            result = [[NSBundle mainBundle] pathForResource:eachObject ofType:@"xml"];
            data = [[NSData alloc]initWithContentsOfFile:result];
            
            self.parser = [[NSXMLParser alloc]initWithData:data];
            
            self.parser.delegate = self;
            
            if([self.parser parse]){
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
    // Random the choices which questions randomed

   
     for (int i=0; i<numOfQuestions; ++i)
     {
        NSMutableArray *choices = [[questions_tmp objectAtIndex:i] m_subElements];

       NSUInteger count_chocies = [choices count];

        NSUInteger *randnum_choices = [Util getRandomNumOfOut:(count_chocies) NumOfIn:count_chocies];
         
        NSMutableArray* choices_tmp = [[NSMutableArray alloc]init];
         
        for (int j=0; j<count_chocies; j++)
        {
            [choices_tmp addObject:[choices objectAtIndex:randnum_choices[j]]];
        }
        free(randnum_choices);
         randnum_choices = nil;
        [choices removeAllObjects];
         ((XMLElement*)[questions_tmp objectAtIndex:i]).m_subElements = choices_tmp;
    }
    
    self.rootElement.m_subElements = questions_tmp;
    
}
 
// 文档开始
-(void)parserDidStartDocument:(NSXMLParser *)parser

{
    //NSLogExt(@"parserDidStartDocument");
    self.rootElement = nil;
    
    self.currentElementPointer = nil;
    
}

// 文档结束
-(void)parserDidEndDocument:(NSXMLParser *)parser

{
    //NSLogExt(@"parserDidEndDocument");
    self.currentElementPointer = nil;
    
}

// 元素开始
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    
    if(self.rootElement == nil){
        
        self.rootElement = [[XMLElement alloc]init];
        
        self.currentElementPointer = self.rootElement;
        
    }else{
        
        XMLElement *newElement = [[XMLElement alloc]init];
        
        newElement.m_parent = self.currentElementPointer;
        
        [self.currentElementPointer.m_subElements addObject:newElement];
        
        self.currentElementPointer = newElement;
        
    }
    
    self.currentElementPointer.m_elementName = elementName;
    
    self.currentElementPointer.m_title = [attributeDict objectForKey:@"title"];
    self.currentElementPointer.m_answer = [attributeDict objectForKey:@"answer"];
    self.currentElementPointer.m_note =[attributeDict objectForKey:@"note"];
 //   NSLogExt(@"name:%@" , elementName);
    
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
    
    if([self.currentElementPointer.m_elementName isEqualToString:@"choice"])
        self.currentElementPointer.m_choice = string;
    

    if([self.currentElementPointer.m_elementName isEqualToString:@"title"])
        self.currentElementPointer.m_title = string;
    
    
   // NSLogExt(@"string:%@" , string);
}
@end
