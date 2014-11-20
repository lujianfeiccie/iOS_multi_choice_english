//
//  UILabelExt.h
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UILabelExtDelegate <NSObject>
@optional
-(void) onLabelExtClick:(id)sender;
@end

@interface UILabelExt : UILabel
{
    NSString* m_text;
}
@property(nonatomic,strong) NSString *m_prefix;
@property(nonatomic,strong) id<UILabelExtDelegate> delegateExt;
@property(nonatomic) BOOL  m_IsSelected;
-(NSString*) getTextExt;
-(void) setTextExt:(NSString*) str;
-(void) setNormal;
-(void) setRight;
-(void) setWrong;
@end
