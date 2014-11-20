//
//  HttpRequestToolVersionCheck.h
//  Multi_Choice
//
//  Created by Apple on 14-10-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequestTool.h"
#import "DialogUtil.h"
#import "AbstractViewController.h"
#import "UserInfoTool.h"
#import "Util.h"
#import "NSLogExt.h"
#import "SVProgressHUD.h"
@interface VersionCheckTool : NSObject<HttpRequestToolDelegate,DialogUtilDelegate>
{
    HttpRequestTool *m_http;
    DialogUtil *m_dialog;
    NSInteger m_app_id;
    NSString *m_trackViewUrl;
    BOOL m_isAboutDlg;
}
@property(nonatomic)  NSInteger m_app_id;
@property(nonatomic)  BOOL m_isAboutDlg;
-(void) request;
-(void) releaseExt;
@end
