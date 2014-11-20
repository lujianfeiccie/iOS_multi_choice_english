//
//  UserInfoTool.m
//  Multi_Choice
//
//  Created by Apple on 14-10-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UserInfoTool.h"
@implementation UserInfoTool
+(void) setUserInfo :(UserInfo*) userInfo
{
  //  NSLog(@"setUserInfo %@ %@",userInfo,userInfo.m_checkversion_date);
    //保存数据
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [ud setObject:udObject forKey:@"userinfo"];
   // [userInfo release];
}
+(UserInfo*) getUserInfo
{
    //读取数据
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *udObject = [ud objectForKey:@"userinfo"];
    UserInfo* userinfo = [NSKeyedUnarchiver unarchiveObjectWithData:udObject];
    // NSLog(@"getUserInfo %@",userinfo);
    return userinfo;
}
@end
