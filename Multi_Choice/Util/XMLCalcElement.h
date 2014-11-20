//
//  XMLCalcElement.h
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLCalcElement : NSObject
@property (nonatomic,strong) NSString *m_elementName;
@property (nonatomic,strong) NSString *m_tag;
@property (nonatomic,strong) NSString *m_value;
@property (nonatomic,strong) NSMutableArray *m_subElements;
@property (nonatomic,strong) XMLCalcElement *m_parent;
@end
