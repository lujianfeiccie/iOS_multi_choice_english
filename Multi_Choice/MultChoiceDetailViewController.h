//
//  MultChoiceDetailViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-11-1.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MultiChoiceDlg.h"
@interface MultChoiceDetailViewController : AbstractDetailViewController
{
    AppDelegate* app;
    MultiChoiceDlg *m_dlg;
   
    IBOutlet UIButton *m_btn_prev;
    IBOutlet UIButton *m_btn_next;
}
- (IBAction)onPrevClick:(id)sender;
- (IBAction)onNextClick:(id)sender;
@end
