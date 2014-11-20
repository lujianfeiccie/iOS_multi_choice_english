//
//  CalcChoiceDLg.m
//  Multi_Choice
//
//  Created by Apple on 14-10-17.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "CalcChoiceDLg.h"
#import "Util.h"
#import "NSLogExt.h"
#import "GGFullScreenImageViewController.h"
@implementation CalcChoiceDLg
@synthesize m_bShowSearchDetail;
@synthesize m_current_index;
@synthesize m_questions;
-(id) initWithView : (UIView*) view DisplayRect : (CGRect) rect DataFile : (NSString*) filename
{
    if (self = [super init])
    {
        m_view = view;
        m_rect = rect;
        m_filename = filename;
        m_bShowSearchDetail = NO;
        m_isShowingAnswer = NO;
    }
    return  self;
}
- (void)load
{
    if (!m_bShowSearchDetail)
    {

        m_xmlHelper = [[XMLCalcHelper alloc]init];
        
        if([m_filename isEqualToString:@"all"])
        {
            [m_xmlHelper loadMultiple:4:
             @"2009_10_short_answer",
             @"2010_10_short_answer",
             @"2011_10_short_answer",
             @"2012_10_short_answer",
             @"2013_01_short_answer",
             @"2013_10_short_answer",
             @"2014_04_short_answer",nil];
            //        return;
        }
        else if([m_filename isEqualToString:@"all_calc"])
        {
            [m_xmlHelper loadMultiple:4:
             @"2009_10_calc",
             @"2010_10_calc",
             @"2011_10_calc",
             @"2012_10_calc",
             @"2013_01_calc",
             @"2013_10_calc",
             @"2014_04_calc",nil];
            //        return;
        }
        else
        {
          [m_xmlHelper load:m_filename];
        }
        m_questions = [[m_xmlHelper rootElement] m_subElements];
        
        m_current_index = 0;
    }
    
    m_array_lablel_questions = [[NSMutableArray alloc]init];
    m_array_lablel_answers = [[NSMutableArray alloc]init];

    
    m_scrollview = [[UIScrollView alloc]initWithFrame:m_rect];
    
    m_scrollview.scrollEnabled = YES;
    m_scrollview.bounces = YES;
    m_scrollview.showsVerticalScrollIndicator = NO;
    m_scrollview.showsHorizontalScrollIndicator = NO;
    
    //    m_scrollview.delegate = self;
    
    m_scrollview.contentSize = CGSizeMake(m_rect.size.width,m_rect.size.height);
    
    NSUInteger count = [m_questions count];
    // NSLogExt(@"count=%i",count);
    for (NSUInteger i=0; i<count; i++) //num of questions
    {
        XMLCalcElement* obj =[m_questions objectAtIndex:i];
        NSUInteger count_items = [obj.m_subElements count];
        
        NSMutableArray *question_items = [[NSMutableArray alloc] init];
        for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
        {
            XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
            
            [question_items addObject:item];
        }
        [m_array_lablel_questions addObject:question_items];
    }
    [m_view addSubview:m_scrollview];
    // m_scrollview.backgroundColor = [UIColor redColor];
    [self updateUI];
}
-(void) updateUI
{
    //m_isShowingAnswer = NO;
    //[self setShowAnswerButton: m_isShowingAnswer];
    
    NSMutableArray *question = [m_array_lablel_questions objectAtIndex:m_current_index];
    [m_array_lablel_answers removeAllObjects];
    
    m_max_height_question = 20 ;
    
    for (id obj in m_scrollview.subviews)
    {
        if ([obj viewWithTag:1])
        {
            [obj removeFromSuperview];
        }
    }
    
    for (NSUInteger i=0; i<[question count]; i++)
    {
        XMLCalcElement* item = [question objectAtIndex:i];
        // NSLogExt(@"ElementName=%@, tag=%@, value=%@",[item m_elementName],[item m_tag],[item m_value]);
        UILabelImageExt* lbl_item = [[UILabelImageExt alloc]init];
        lbl_item.tag = 1;
        
        if ([[item m_tag] isEqualToString:@"question"])
        {
            if ([[item m_elementName] isEqualToString:@"text"])
            {
                lbl_item.text = [item m_value];
                [Util setLabelToAutoSize:lbl_item];
            }
            else if ([[item m_elementName] isEqualToString:@"image"])
            {
                [lbl_item setImageName:[item m_value]];
                lbl_item.userInteractionEnabled = YES;
                lbl_item.delegateExt = self;

            }
            else
            {
                
                return;
            }
            if (i==0) //Show question no
            {
                NSString *questionNo = [NSString stringWithFormat:@"(%li/%li)",(unsigned long)(m_current_index+1),(unsigned long)[m_questions count]];
        //        NSLogExt(questionNo);
              lbl_item.text = [lbl_item.text stringByAppendingString:questionNo];
                  [Util setLabelToAutoSize:lbl_item];
            }
            [m_scrollview addSubview:lbl_item];
            [lbl_item setFrame:CGRectMake(0, m_max_height_question, lbl_item.frame.size.width, lbl_item.frame.size.height)];
            m_max_height_question = lbl_item.frame.origin.y + lbl_item.frame.size.height;
        }
        if ([[item m_tag] isEqualToString:@"answer"])
        {
            if ([[item m_elementName] isEqualToString:@"text"])
            {
                if ([m_array_lablel_answers count]==0)//First answer
                {
                lbl_item.text = [NSString stringWithFormat:@"答:\n%@",[item m_value]];
                }
                else
                {
                lbl_item.text = [item m_value];
                }
                [Util setLabelToAutoSize:lbl_item];
            }
            else if ([[item m_elementName] isEqualToString:@"image"])
            {
                [lbl_item setImageName:[item m_value]];
                lbl_item.userInteractionEnabled = YES;
                lbl_item.delegateExt = self;

            }
            else
            {
                return;
            }
            [m_array_lablel_answers addObject:lbl_item];
            
            
        }
        
    }

     m_scrollview.contentSize = CGSizeMake(m_view.frame.size.width, m_max_height_question);
}
- (void)prev
{
    if (m_current_index-1 >= 0)
    {
        --m_current_index;
        [self updateUI];
    }
}
- (void)next
{
    if (m_current_index+1<[m_array_lablel_questions count])
    {
        ++m_current_index;
        [self updateUI];
    }
}
- (void)showAnswer
{
    NSUInteger max_height_answer = m_max_height_question+20;
    
    if (!m_isShowingAnswer)
    {
        
        NSUInteger count = [m_array_lablel_answers count];
        for (NSUInteger i=0; i<count; i++)
        {
            UILabel *answer = [m_array_lablel_answers objectAtIndex:i];
            [answer setFrame:CGRectMake(0, max_height_answer, answer.frame.size.width, answer.frame.size.height)];
            max_height_answer = answer.frame.origin.y + answer.frame.size.height;
            [m_scrollview addSubview:answer];
        }
        m_scrollview.contentSize = CGSizeMake(m_view.frame.size.width, max_height_answer);
        m_isShowingAnswer = YES;
    }
}
- (void)hideAnswer
{
    NSUInteger max_height_answer = m_max_height_question;
    
    if(m_isShowingAnswer)
    {
        NSUInteger count = [m_array_lablel_answers count];
        // NSLogExt(@"count=%i",count);
        for (NSUInteger i=0; i<count; i++)
        {
            UILabel *answer = [m_array_lablel_answers objectAtIndex:i];
            [answer removeFromSuperview];
        }
        m_scrollview.contentSize = CGSizeMake(m_view.frame.size.width, max_height_answer);
        m_isShowingAnswer = NO;
    }

}

-(void) onLabelImageExtClick:(id)sender
{
    UILabelImageExt *obj = (UILabelImageExt*)sender;
     UIImage *image = [UIImage imageNamed:[obj getImageName]];
    UIImageView* imageview = [[UIImageView alloc]initWithImage:image];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    GGFullscreenImageViewController *vc = [[GGFullscreenImageViewController alloc] init];
    vc.liftedImageView = imageview;

    AppDelegate* app = [[UIApplication sharedApplication]delegate];
    [app.navController presentViewController:vc animated:YES completion:nil];
    //NSLogExt(@"image clicked %@",[obj getImageName]);
}

-(void)dealloc
{
    if (!m_bShowSearchDetail)
    {
     [m_xmlHelper release];
    }
    [m_questions release];
    
    [m_array_lablel_questions release];
    [m_array_lablel_answers release];
    [super dealloc];
}

@end
