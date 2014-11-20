//
//  MultiChoiceDlg.h
//  Multi_Choice
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UILabelExt.h"
#import "XMLHelper.h"
@interface MultiChoiceDlg : NSObject<UILabelExtDelegate>
{
    UIScrollView *m_scrollview;
    UILabel *m_lbl_title;
    UILabelExt *m_lbl_choice1;
    UILabelExt *m_lbl_choice2;
    UILabelExt *m_lbl_choice3;
    UILabelExt *m_lbl_choice4;
    UILabelExt *m_lbl_note;
    XMLHelper* m_xmlHelper;
    NSInteger m_count;
    NSMutableArray* m_questions;
    NSInteger m_currentIndex;
    NSString* m_str_answer;
    
    UIView *m_view;
    CGRect m_rect;
    NSString* m_filename;
}
@property(nonatomic,strong) NSString* m_title;
@property(nonatomic) BOOL m_bShowSearchDetail;
@property(nonatomic,strong) NSMutableArray* m_questions;
@property(nonatomic) NSInteger m_currentIndex;
-(id) initWithView : (UIView*) view DisplayRect : (CGRect) rect DataFile : (NSString*) filename;
-(void) load;
-(void) updateUI;
-(void) prev;
-(void) next;
-(void) showAnswer;
@end
