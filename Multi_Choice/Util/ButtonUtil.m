//
//  ButtonUtil.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "ButtonUtil.h"

@implementation ButtonUtil
+(UIBarButtonItem*) createToolBarButton:(NSString *)title target:(id)target action:(SEL)action
{
     UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:action];
    return button;
}
@end
