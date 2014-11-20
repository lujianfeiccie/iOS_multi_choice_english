//
//  HttpRequestTool.m
//  creditcard
//
//  Created by Apple on 13-10-1.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "HttpRequestTool.h"

@interface HttpRequestTool()
@end

@implementation HttpRequestTool

@synthesize delegate;
@synthesize url;
@synthesize data;
-(id)init{
    if(self=[super init]){
        data = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)startGetRequest{
    if(url==nil ||
       delegate == nil){
        return;
    }
    //参数1名字=参数1数据&参数2名字＝参数2数据&参数3名字＝参数3数据&...
    NSString *get = @"";
    NSString *url_tmp=@"";
    int i=0;
    for(id key in data.allKeys) {    // 正确的字典遍历方式
        NSString *value = [data objectForKey:key];
        if (i>0) {
            get = [get stringByAppendingString:@"&"];
        }
        
        get = [get stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
        ++i;
        //NSLog(@"['%@']=%@ post=%@",key,value,post);
    }
    url_tmp = [url stringByAppendingString:[NSString stringWithFormat:@"?%@",get]];
    
    NSError *error = Nil;
    //加载一个NSURL对象

       NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url_tmp] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    //将请求的url数据放到NSData对象中
   NSHTTPURLResponse* urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    [delegate onMsgReceive:response:[error code]:[urlResponse statusCode]:self];
 }
-(void)startPostRequest{
    if(url==nil ||
       delegate == nil || [data count]==0){
        return;
    }

    
    //参数1名字=参数1数据&参数2名字＝参数2数据&参数3名字＝参数3数据&...
    NSString *post = @"";

    int i=0;
    for(id key in data.allKeys) {    // 正确的字典遍历方式
        NSString *value = [data objectForKey:key];
        if (i>0) {
         post = [post stringByAppendingString:@"&"];
        }
        
         post = [post stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
         ++i;
        //NSLog(@"['%@']=%@ post=%@",key,value,post);
    }

    //将NSSrring格式的参数转换格式为NSData，POST提交必须用NSData数据。
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //计算POST提交数据的长度
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
   // NSLog(@"postLength=%@",postLength);
    //定义NSMutableURLRequest
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    //设置提交目的url
    [request setURL:[NSURL URLWithString:url]];
    //设置提交方式为 POST
    [request setHTTPMethod:@"POST"];
    //设置http-header:Content-Type
    //这里设置为 application/x-www-form-urlencoded ，如果设置为其它的，比如text/html;charset=utf-8，或者 text/html 等，都会出错。不知道什么原因。
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //设置http-header:Content-Length
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //设置需要post提交的内容
    [request setHTTPBody:postData];
    
    //定义
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    //同步提交:POST提交并等待返回值（同步），返回值是NSData类型。
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //将NSData类型的返回值转换成NSString类型
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
  //  NSLog(@"xml result:%@",result);
    
    
    [delegate onMsgReceive:responseData:[error code]:[urlResponse statusCode]:self];
   /* if ([@"success" compare:result]==NSOrderedSame) {
        return YES;
    }*/
}
@end



