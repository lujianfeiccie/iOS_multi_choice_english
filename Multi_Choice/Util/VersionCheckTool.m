//
//  HttpRequestToolVersionCheck.m
//  Multi_Choice
//
//  Created by Apple on 14-10-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "VersionCheckTool.h"

@implementation VersionCheckTool
@synthesize m_app_id;
@synthesize m_isAboutDlg;
-(id)init
{
    if (self=[super init])
    {
       
        m_http = [[HttpRequestTool alloc]init];
        m_dialog = [[DialogUtil alloc] init];
        m_app_id = 0;

        m_isAboutDlg = YES;
        m_http.url = @"http://itunes.apple.com/lookup";
        m_http.delegate = self;
        m_dialog.delegate = self;
    }
    return self;
}
-(void) requestThread
{
    if (m_isAboutDlg)
    {
        [m_http.data removeAllObjects];
        [m_http.data setObject:[NSString stringWithFormat:@"%li",(long)m_app_id] forKey:@"id"];
        [m_http startGetRequest];
    }
    else
    {

       UserInfo* userinfo = [UserInfoTool getUserInfo];
        if(userinfo==nil)
        {
            userinfo = [[UserInfo alloc] init];
            NSString *  nsDateString= [Util getDate];
            userinfo.m_checkversion_date = nsDateString;
            [UserInfoTool setUserInfo:userinfo];
        //NSLog(nsDateString);
        
        }
        else if(![userinfo.m_checkversion_date isEqualToString:[Util getDate]]
            )
        {
        //check version
            userinfo.m_checkversion_date = [Util getDate];
            [UserInfoTool setUserInfo:userinfo];
        // NSLog(@"check version");
        
            [m_http.data removeAllObjects];
            [m_http.data setObject:[NSString stringWithFormat:@"%li",(long)m_app_id] forKey:@"id"];
            [m_http startGetRequest];
        }
    }
}
-(void) request
{
    NSLogExt(@"request %i",m_isAboutDlg)
    if(m_isAboutDlg)
    {
      [SVProgressHUD showWithStatus:@"正在检查最新版本"];
    }
    NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(requestThread) object:nil];
    [myThread start];
}


#pragma marks -- DialogUtilDelegate --
-(void) onMsgReceive :(NSData*) msg :(NSInteger) errorCode :(NSInteger) statusCode :(HttpRequestTool*) httpRequestTool
{
    [SVProgressHUD dismiss];
    NSError *parse_error=Nil;
    
    NSLogExt(@"error code = %i statusCode = %i",errorCode,statusCode);
    switch (errorCode) {
        case NSURLErrorNotConnectedToInternet://网络断开
            if (m_isAboutDlg)
            {
                [SVProgressHUD showErrorWithStatus:@"无法连接到网络!"];
            }
            return;
        case NSURLErrorTimedOut://请求超时
            if (m_isAboutDlg)
            {
                 [SVProgressHUD showErrorWithStatus:@"请求超时!"];
            }
            return;
        default:
            break;
    }
    
    
    
    
    
    switch (statusCode) {
        case 200:
        {
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:msg options:NSJSONReadingMutableLeaves error:&parse_error];
            
            NSDictionary *results =[dataDic objectForKey:@"results"];
            
            NSString *latestVersion = @"";
            NSString *trackViewUrl = @"";
            NSString *trackName = @"";
            for (NSDictionary* result in results){
                latestVersion =[result objectForKey:@"version"];
                trackViewUrl =[result objectForKey:@"trackViewUrl"];
                trackName =[result objectForKey:@"trackName"];
            }
            
            NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            
            NSLogExt(@"\nlatestVersion=%@\ntrackViewUrl=%@\ntrackName=%@\ncurrentVersion=%@",
                     latestVersion,trackViewUrl,trackName,currentVersion);
            
            
            if ([currentVersion isEqualToString:latestVersion] || [latestVersion isEqualToString:@""] ||
                latestVersion == nil)
            {
                if (m_isAboutDlg)
                {
                    NSLogExt(@"The latest version %@",latestVersion);
                    [SVProgressHUD showSuccessWithStatus:@"已经是最新版本!"];
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    m_trackViewUrl = [[trackViewUrl stringByReplacingOccurrencesOfString:@"https://" withString:@"itms-apps://"] copy];
                    //NSLog(@" %@",m_trackViewUrl);
                    // 更新UI
                    [m_dialog showDialogTitle:@"提示"
                                      message: [NSString stringWithFormat:@"有更新版本(%@), 现在去升级?"
                                                ,
                                                latestVersion]
                                      confirm:@"是的"
                                       cancel:@"以后再说"];
                });
            }
            //NSLogExt(@"status=%@",status);
        }
            return;
            
        default:
            break;
    }
    

}

#pragma marks -- DialogUtilDelegate --
-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    if (dialog == m_dialog) {
        if(m_trackViewUrl!=nil){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:m_trackViewUrl]];
        }
    }
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    
}

-(void)releaseExt{
    [m_http.data removeAllObjects];
    [m_http.data release];
    [m_http release];
    [m_dialog release];
    [super release];
}
@end
