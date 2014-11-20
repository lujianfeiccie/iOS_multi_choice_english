//
//  UserInfo.h
//  Multi_Choice
//
//  Created by Apple on 14-10-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>
{
    NSString* m_checkversion_date;
}
@property(nonatomic,retain) NSString* m_checkversion_date;
@end
