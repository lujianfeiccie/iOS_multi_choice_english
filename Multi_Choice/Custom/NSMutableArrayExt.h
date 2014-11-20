//
//  NSMutableArrayExt.h
//  Multi_Choice
//
//  Created by Apple on 14/11/4.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum NSMutableArrayExtType
{
  TYPE_Multi_Choice,
  TYPE_Short_Answer,
  TYPE_Calc
}NSMutableArrayExtType;
@interface NSMutableArrayExt : NSObject
{
    NSMutableArray* m_list;
}
@property(nonatomic) NSMutableArrayExtType m_type;
@property(nonatomic) NSUInteger count;
-(void) addObject:(id) obj;
-(id) objectAtIndex:(NSUInteger) index;

@end
