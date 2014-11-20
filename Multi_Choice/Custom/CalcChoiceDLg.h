//
//  CalcChoiceDLg.h
//  Multi_Choice
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLCalcHelper.h"
#import "UILabelImageExt.h"
#import "AppDelegate.h"
@interface CalcChoiceDLg : NSObject<UILabelImageExtDelegate>

{
    XMLCalcHelper *m_xmlHelper;
    NSMutableArray* m_questions;
   
    NSMutableArray *m_array_lablel_questions;
    NSMutableArray *m_array_lablel_answers;
    UIScrollView *m_scrollview;
    
    NSInteger m_current_index;
    
    NSUInteger m_max_height_question;
    
    UIView *m_view;
    CGRect m_rect;
    NSString* m_filename;
    
    BOOL m_isShowingAnswer;
}
@property(nonatomic) BOOL m_bShowSearchDetail;
@property(nonatomic,strong) NSMutableArray* m_questions;
@property(nonatomic) NSInteger m_current_index;

-(id) initWithView : (UIView*) view DisplayRect : (CGRect) rect DataFile : (NSString*) filename;
- (void)load;
- (void)prev;
- (void)next;
- (void)showAnswer;
- (void)hideAnswer;
-(void) updateUI;
@end
