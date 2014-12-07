//
//  CalcDetailViewController.h
//  Multi_Choice
//
//  Created by Apple on 14/11/2.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AbstractViewController.h"
#import "AppDelegate.h"
#import "CalcChoiceDLg.h"
@interface CalcDetailViewController : AbstractDetailViewController
{
    AppDelegate *app;
    IBOutlet UIButton *m_btn_prev;
    IBOutlet UIButton *m_btn_next;
    CalcChoiceDLg* m_dlg;
}

- (IBAction)onPrevClick:(id)sender;
- (IBAction)onNextClick:(id)sender;
@end
