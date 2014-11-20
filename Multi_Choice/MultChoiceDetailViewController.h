//
//  MultChoiceDetailViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-11-1.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AbstractViewController.h"
#import "MultiChoiceDlg.h"
@interface MultChoiceDetailViewController : AbstractViewController
{
    AppDelegate* app;
    MultiChoiceDlg *m_dlg;
   
    IBOutlet UIButton *m_btn_prev;
    IBOutlet UIButton *m_btn_next;
}
@property(nonatomic,strong) NSMutableArray* m_array_detail;
@property(nonatomic) NSInteger m_currentIndex;
@property(nonatomic,strong) NSString* m_title;
- (IBAction)onPrevClick:(id)sender;
- (IBAction)onNextClick:(id)sender;
@end
