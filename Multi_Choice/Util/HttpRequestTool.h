//
//  HttpRequestTool.h
//  creditcard
//
//  Created by Apple on 13-10-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpRequestTool;
//接口定义

@protocol HttpRequestToolDelegate <NSObject>
@required
#pragma marks -- HttpRequestToolDelegate --
-(void) onMsgReceive :(NSData*) msg :(NSInteger) errorCode :(NSInteger) statusCode :(HttpRequestTool*) httpRequestTool;
@end

@interface HttpRequestTool : NSObject{
    id<HttpRequestToolDelegate> delegate;
    NSString* url;
    NSMutableDictionary* data;
}
@property(nonatomic,retain) id delegate;
@property(nonatomic,retain) NSString* url;
@property(nonatomic,retain) NSMutableDictionary* data;
-(void)startGetRequest;
-(void)startPostRequest;
@end
