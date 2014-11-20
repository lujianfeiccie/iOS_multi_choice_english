//
//  AboutDlgViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-9-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "VersionCheckTool.h"
@interface AboutDlgViewController : AbstractViewController<UITableViewDelegate,
UITableViewDataSource>

{
         AppDelegate* app;
    IBOutlet UILabel *m_lbl_version;
    IBOutlet UILabel *m_lbl_copyright;
    IBOutlet UIImageView *m_img_logo;
    IBOutlet UITableView *m_tableview_setting;
    NSMutableArray* m_datalist;
    
    VersionCheckTool* m_versionCheckTool;
}
@end
