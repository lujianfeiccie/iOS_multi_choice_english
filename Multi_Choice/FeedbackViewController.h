//
//  FeedbackViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-10-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface FeedbackViewController : AbstractViewController<UITextViewDelegate,HttpRequestToolDelegate,DialogUtilDelegate>
{

    IBOutlet UITextView *m_textview_feedback;
    IBOutlet UILabel *m_lbl_remain;
    HttpRequestTool* http;
    DialogUtil *m_dialog;
}
-(void) toolBarRight;
@end
