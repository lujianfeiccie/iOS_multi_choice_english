//
//  PlatformUtil.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)   
#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))

@interface PlatformUtil : NSObject
+(void) ResizeUIAll: (UIView*) view;
+(void) ResizeUI: (UIView*) view;
+(void) ResizeUIToBottom: (UIView*) view parentView :(UIView*) parentView;
+(void) ResizeUIToBottom: (UIView*) view parentView :(UIView*) parentView offSetY :(NSInteger) offsetY;
+(void) ResizeUIToTop: (UIView*) view parentView :(UIView*) parentView;
+(void) ResizeUIToTop: (UIView*) view parentView :(UIView*) parentView offSetY :(NSInteger) offsetY;
+(void) ResizeUIToBottomCenter: (UIView*) view parentView :(UIView*) parentView;
+(void) ResizeUIToBottomCenter: (UIView*) view parentView :(UIView*) parentView offsetY :(NSInteger) offsetY;
+(void) ResizeUIToBottomLeft: (UIView*) view parentView :(UIView*) parentView offsetY :(NSInteger) offsetY;
+(void) ResizeUIToBottomRight: (UIView*) view parentView :(UIView*) parentView offsetY :(NSInteger) offsetY;

+(void) ResizeUIToBottomLeft: (UIView*) view parentView :(UIView*) parentView;
+(void) ResizeUIToBottomRight: (UIView*) view parentView :(UIView*) parentView;
@end
