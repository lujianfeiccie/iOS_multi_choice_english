//
//  Util.h
//  Multi_Choice
//
//  Created by Apple on 14-8-25.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
+(void) setLabelToAutoSize:(UILabel*) label;
+(NSUInteger*) getRandomNumOfOut:(NSUInteger) numOfOut NumOfIn : (NSUInteger) numOfIn;
+(NSString*) getDate;
+(BOOL) isTimeToCheckVersion;
+(BOOL) containString : (NSString*) str1 :(NSString*) str2;
@end
