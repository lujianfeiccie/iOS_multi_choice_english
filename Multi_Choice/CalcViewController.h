//
//  CalcViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AbstractViewController.h"
#import "AppDelegate.h"
#import "CalcChoiceDLg.h"
@interface CalcViewController : AbstractViewController
{
    AppDelegate *app;
   
    IBOutlet UIButton *m_btn_prev;
    IBOutlet UIButton *m_btn_next;
    IBOutlet UIButton *m_btn_showAnswer;
   
    
    BOOL m_isShowingAnswer;
    CalcChoiceDLg* m_dlg;
}
- (IBAction)btnPrevClick:(id)sender;
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnShowAnswerClick:(id)sender;

@property(nonatomic,strong) NSString* m_title;
@property(nonatomic) BOOL m_bCalcView;
@property(nonatomic,strong) NSString* m_filename;
@end
