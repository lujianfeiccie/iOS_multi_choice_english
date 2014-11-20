//
//  UserInfoTool.h
//  Multi_Choice
//
//  Created by Apple on 14-10-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface UserInfoTool : NSObject
+(void) setUserInfo :(UserInfo*) userInfo;
+(UserInfo*) getUserInfo;
@end
