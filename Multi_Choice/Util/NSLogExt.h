//
//  NSLogExt.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#ifndef aacalc_NSLogExt_h
#define aacalc_NSLogExt_h

#define NSLogExt(args...)  ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
void   ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
#endif
