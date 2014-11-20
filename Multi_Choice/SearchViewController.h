//
//  SearchViewController.h
//  Multi_Choice
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SearchViewController : AbstractViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* m_tableview;
     AppDelegate* app;
}
@property(nonatomic,retain) NSMutableArray* m_array_list;
@end
