//
//  ViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
/*#import "XMLHelper.h"
#import "UILabelExt.h"*/
#import "AppDelegate.h"
#import "MultiChoiceDlg.h"
@interface MultiChoiceViewController : AbstractViewController<MultiChoiceDlgDelegate>
{
    
    AppDelegate *app;
    __weak IBOutlet UIButton *m_btn_prev;
    __weak IBOutlet UIButton *m_btn_next;
    IBOutlet UIButton *m_btn_show_result;
    MultiChoiceDlg* m_dlg;
}
@property(nonatomic,strong) NSString* m_filename;
@property(nonatomic,strong) NSString* m_title;
- (IBAction)btnNextClick:(id)sender;
- (IBAction)btnPrevClick:(id)sender;
- (IBAction)btnShowResultClick:(id)sender;

@end
