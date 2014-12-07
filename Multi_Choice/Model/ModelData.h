//
//  ModelData.h
//  Multi_Choice
//
//  Created by Apple on 14-9-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum TYPE_MODEL
{
  TYPE_MULTI_CHOICE,
  TYPE_SHORT_ANSWER
}TYPE_MODEL_DATA;
@interface ModelData : NSObject
@property (nonatomic,strong) NSString *m_text;
@property (nonatomic,strong) NSString *m_value;
@property (nonatomic) TYPE_MODEL_DATA m_type;
@end
