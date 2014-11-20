//
//  NSLogExt.c
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//
#include <stdio.h>
#include "NSLogExt.h"
//#define LOG_DEBUG
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    #if defined(LOG_DEBUG)
    // Type to hold information about variable arguments.
    va_list ap;
    // Initialize a variable argument list.
    va_start (ap, format);
    // NSLog only adds a newline to the end of the NSLog format if
    // one is not already there.
    // Here we are utilizing this feature of NSLog()
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    // End using variable argument list.
    va_end (ap);
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "(%s) (%s:%d) %s",
            functionName, [fileName UTF8String],
            lineNumber, [body UTF8String]);
    #endif
}
