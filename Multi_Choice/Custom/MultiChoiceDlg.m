//
//  MultiChoiceDlg.m
//  Multi_Choice
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "MultiChoiceDlg.h"
#import "PlatformUtil.h"
@implementation MultiChoiceDlg
@synthesize m_title;
@synthesize m_questions;
@synthesize m_bShowSearchDetail;
@synthesize m_currentIndex;
-(id) initWithView : (UIView*) view DisplayRect : (CGRect) rect DataFile : (NSString*) filename
{
    if (self = [super init])
    {
        m_view = view;
        m_rect = rect;
        m_filename = filename;
        m_bShowSearchDetail = NO;
        m_currentIndex = 0;
    }
    return  self;
}

-(void) load
{
    if(!m_bShowSearchDetail)
    {
        m_xmlHelper = [[XMLHelper alloc]init];
        m_xmlHelper.m_random = YES;
        
        if([m_filename isEqualToString:@"all"])
        {
            [m_xmlHelper loadMultiple:20:
             @"2009_10",
             @"2010_10",
             @"2011_10",
             @"2012_10",
             @"2013_01",
             @"2013_10",
             @"2014_04",nil];
            //        return;
        }
        else
        {
            [m_xmlHelper load:m_filename];
        }
       
        m_questions = [[m_xmlHelper rootElement] m_subElements];
    }
 
    m_count = [m_questions count];
    
  
    
    
    m_lbl_title   = [[UILabel alloc]init];
    m_lbl_note = [[UILabelExt alloc]init];
    m_lbl_choice1 = [[UILabelExt alloc]init];
    m_lbl_choice2 = [[UILabelExt alloc]init];
    m_lbl_choice3 = [[UILabelExt alloc]init];
    m_lbl_choice4 = [[UILabelExt alloc]init];
    
    [m_lbl_note setHidden:YES];
    //自动折行设置
    [m_lbl_title setFrame:CGRectMake(0, 80,
                                     [UIScreen mainScreen].applicationFrame.size.width-10, 100)];
    
    
    
    [PlatformUtil ResizeUIToTop:m_lbl_title parentView:m_view offSetY:20];
    
    
    m_lbl_choice1.m_prefix = @"A.";
    m_lbl_choice2.m_prefix = @"B.";
    m_lbl_choice3.m_prefix = @"C.";
    m_lbl_choice4.m_prefix = @"D.";
    m_lbl_note.m_prefix = @"注解：\r\n\r\n";
    
    
    
    
    m_lbl_choice1.userInteractionEnabled = YES;
    m_lbl_choice2.userInteractionEnabled = YES;
    m_lbl_choice3.userInteractionEnabled = YES;
    m_lbl_choice4.userInteractionEnabled = YES;
    
    m_lbl_choice1.delegateExt = self;
    m_lbl_choice2.delegateExt = self;
    m_lbl_choice3.delegateExt = self;
    m_lbl_choice4.delegateExt = self;
    
    
    
    m_scrollview = [[UIScrollView alloc]initWithFrame:m_rect];
    
    m_scrollview.scrollEnabled = YES;
    m_scrollview.bounces = YES;
    m_scrollview.showsVerticalScrollIndicator = NO;
    m_scrollview.showsHorizontalScrollIndicator = NO;
    
    m_scrollview.contentSize = CGSizeMake(m_rect.size.width,m_rect.size.height);
    
    //m_scrollview.backgroundColor = [UIColor blueColor];
    
    
    //m_btn_next.backgroundColor = [UIColor redColor];
    [m_scrollview addSubview:m_lbl_title];
    [m_scrollview addSubview:m_lbl_choice1];
    [m_scrollview addSubview:m_lbl_choice2];
    [m_scrollview addSubview:m_lbl_choice3];
    [m_scrollview addSubview:m_lbl_choice4];
    [m_scrollview addSubview:m_lbl_note];
    [m_view addSubview:m_scrollview];
    
}
-(void) updateUI
{
    [self updateQuestionView];
}
-(void) onLabelExtClick:(id)sender
{
    
    if (m_lbl_choice2.m_IsSelected == NO &&
        m_lbl_choice3.m_IsSelected == NO &&
        m_lbl_choice4.m_IsSelected == NO &&
        [sender isEqual:m_lbl_choice1]) {
       // NSLogExt(@"choice1");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:0];
        if ([[m_lbl_choice1 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice1 setRight];
        }
        else
        {
            [m_lbl_choice1 setWrong];
        }
    }
    else if (m_lbl_choice1.m_IsSelected == NO &&
             m_lbl_choice3.m_IsSelected == NO &&
             m_lbl_choice4.m_IsSelected == NO &&
             [sender isEqual:m_lbl_choice2]) {
        //NSLogExt(@"choice2");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:1];
        if ([[m_lbl_choice2 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice2 setRight];
        }
        else
        {
            [m_lbl_choice2 setWrong];
        }
    }
    else if (m_lbl_choice1.m_IsSelected == NO &&
             m_lbl_choice2.m_IsSelected == NO &&
             m_lbl_choice4.m_IsSelected == NO &&
             [sender isEqual:m_lbl_choice3]) {
       // NSLogExt(@"choice3");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:2];
        if ([[m_lbl_choice3 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice3 setRight];
        }
        else
        {
            [m_lbl_choice3 setWrong];
        }
    }
    else if (m_lbl_choice1.m_IsSelected == NO &&
             m_lbl_choice2.m_IsSelected == NO &&
             m_lbl_choice3.m_IsSelected == NO &&
             [sender isEqual:m_lbl_choice4]) {
      //  NSLogExt(@"choice4");
        [[m_questions objectAtIndex:m_currentIndex]setSelectExt:3];
        if ([[m_lbl_choice4 getTextExt] isEqualToString:m_str_answer])
        {
            [m_lbl_choice4 setRight];
        }
        else
        {
            [m_lbl_choice4 setWrong];
        }
    }
    
    if ([[m_lbl_choice1 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice1 setRight];
    }
    else if ([[m_lbl_choice2 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice2 setRight];
    }
    else if ([[m_lbl_choice3 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice3 setRight];
    }
    else if ([[m_lbl_choice4 getTextExt]isEqualToString:m_str_answer]) {
        [m_lbl_choice4 setRight];
    }
    
    if([[m_questions objectAtIndex:m_currentIndex] m_selected]!=-1){
        //Have selected
        [m_lbl_note setHidden:NO];
        m_scrollview.contentSize = CGSizeMake(m_view.frame.size.width, m_lbl_note.frame.origin.y+m_lbl_note.frame.size.height);
        
    }
    
    
    
}
- (void) updateQuestionView{
    m_scrollview.contentSize = CGSizeMake(m_view.frame.size.width, m_lbl_choice4.frame.origin.y+m_lbl_choice4.frame.size.height);
    
    NSString* title =[[m_questions objectAtIndex:m_currentIndex] m_title];
    m_lbl_title.text =[NSString stringWithFormat:@"%@(%li/%li)",title,(long)(m_currentIndex+1),(long)m_count];
    
    [Util setLabelToAutoSize:m_lbl_title];
    
    
    NSArray *choices = [[m_questions objectAtIndex:m_currentIndex] m_subElements];
    m_str_answer = [[m_questions objectAtIndex:m_currentIndex] m_answer];
    NSInteger selected =[[m_questions objectAtIndex:m_currentIndex] m_selected];
    NSUInteger count = [choices count];
    //    NSLogExt(@"count=%i",count);
    
    
    for (NSInteger i=0; i< count; ++i)
    {
        
        if (i==0) {
            [m_lbl_choice1 setTextExt:[[choices objectAtIndex:i] m_choice]];
            [Util setLabelToAutoSize:m_lbl_choice1];
        }
        else if (i==1) {
            [m_lbl_choice2 setTextExt:[[choices objectAtIndex:i] m_choice]];
            [Util setLabelToAutoSize:m_lbl_choice2];
        }
        else if (i==2) {
            [m_lbl_choice3 setTextExt:[[choices objectAtIndex:i] m_choice]];
            [Util setLabelToAutoSize:m_lbl_choice3];
        }
        else if (i==3) {
            [m_lbl_choice4 setTextExt:[[choices objectAtIndex:i] m_choice]];
            [Util setLabelToAutoSize:m_lbl_choice4];
        }
        
        
    }
    [m_lbl_note setTextExt:[[m_questions objectAtIndex:m_currentIndex] m_note]];
    [Util setLabelToAutoSize:m_lbl_note];
    
    [m_lbl_choice1 setFrame:CGRectMake(m_lbl_title.frame.origin.x,
                                       m_lbl_title.frame.origin.y+
                                       m_lbl_title.frame.size.height+20,
                                       m_lbl_choice1.frame.size.width,
                                       m_lbl_choice1.frame.size.height)];
    
    [m_lbl_choice2 setFrame:CGRectMake(m_lbl_choice1.frame.origin.x,
                                       m_lbl_choice1.frame.origin.y+                                  m_lbl_choice1.frame.size.height+30,
                                       m_lbl_choice2.frame.size.width,
                                       m_lbl_choice2.frame.size.height)];
    
    [m_lbl_choice3 setFrame:CGRectMake(m_lbl_choice2.frame.origin.x,
                                       m_lbl_choice2.frame.origin.y+                                   m_lbl_choice2.frame.size.height+30,
                                       m_lbl_choice3.frame.size.width,
                                       m_lbl_choice3.frame.size.height)];
    
    [m_lbl_choice4 setFrame:CGRectMake(m_lbl_choice3.frame.origin.x,
                                       m_lbl_choice3.frame.origin.y+
                                       m_lbl_choice3.frame.size.height+30,
                                       m_lbl_choice4.frame.size.width,
                                       m_lbl_choice4.frame.size.height)];
    
    [m_lbl_note setFrame:CGRectMake(m_lbl_choice4.frame.origin.x,
                                    m_lbl_choice4.frame.origin.y+
                                    m_lbl_choice4.frame.size.height+30,
                                    m_lbl_note.frame.size.width,
                                    m_lbl_note.frame.size.height)];
    
    
    [m_lbl_choice1 setNormal];
    [m_lbl_choice2 setNormal];
    [m_lbl_choice3 setNormal];
    [m_lbl_choice4 setNormal];
    
    if (selected==-1) {
        [m_lbl_note setHidden:YES];
    }else if(selected==0){
        [self onLabelExtClick: m_lbl_choice1];
    }else if(selected==1){
        [self onLabelExtClick: m_lbl_choice2];
    }else if(selected==2){
        [self onLabelExtClick: m_lbl_choice3];
    }else if(selected==3){
        [self onLabelExtClick: m_lbl_choice4];
    }
    
    
    
}
-(void) prev
{
    if (m_currentIndex > 0)
    {
        --m_currentIndex;
        [self updateQuestionView];
    }
}
-(void) next
{
    m_count = [m_questions count];
    if (m_currentIndex < m_count-1)
    {
        ++m_currentIndex;
        [self updateQuestionView];
    }
}
-(void) showAnswer
{
     m_str_answer = [[m_questions objectAtIndex:m_currentIndex] m_answer];
    
    if ([[m_lbl_choice1 getTextExt] isEqualToString:m_str_answer])
    {
        [m_lbl_choice1 setRight];
    }
    if ([[m_lbl_choice2 getTextExt] isEqualToString:m_str_answer])
    {
        [m_lbl_choice2 setRight];
    }
    if ([[m_lbl_choice3 getTextExt] isEqualToString:m_str_answer])
    {
        [m_lbl_choice3 setRight];
    }
    if ([[m_lbl_choice4 getTextExt] isEqualToString:m_str_answer])
    {
        [m_lbl_choice4 setRight];
    }
   // if([[m_questions objectAtIndex:m_currentIndex] m_selected]!=-1){
        //Have selected
    [m_lbl_note setHidden:NO];
        m_scrollview.contentSize = CGSizeMake(m_view.frame.size.width, m_lbl_note.frame.origin.y+m_lbl_note.frame.size.height);
        
  //  }
}
- (void)dealloc {
    NSLogExt(@"dealloc");
    [m_title release];
    [m_lbl_choice1 release];
    [m_lbl_choice2 release];
    [m_lbl_choice3 release];
    [m_lbl_choice4 release];
    [m_lbl_note release];
    [super dealloc];
}
@end
