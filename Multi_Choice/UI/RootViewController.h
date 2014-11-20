//
//  RootViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "XMLHelper.h"
#import "XMLElement.h"
@interface RootViewController : AbstractViewController<UITableViewDelegate,
UITableViewDataSource,UIAlertViewDelegate>

{
    AppDelegate* app;
    __weak IBOutlet UITableView *m_tableview_list;
    NSMutableArray* m_datalist;
    
    DialogUtil* m_dialog_search;
    
   VersionCheckTool *m_versionCheckTool;
}

@end
