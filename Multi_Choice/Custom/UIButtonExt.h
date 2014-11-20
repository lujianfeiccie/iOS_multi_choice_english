//
//  UIButtonExt.h
//  Multi_Choice
//
//  Created by Apple on 14-10-30.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonExt : UIButton
{
    UILabel* m_lbl_title;
}

-(void) setTitleExt : (NSString*) title;
@end
