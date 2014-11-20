//
//  ButtonUtil.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonUtil : NSObject
+(UIBarButtonItem*) createToolBarButton:(NSString *)title target:(id)target action:(SEL)action;
@end
