//
//  FeedbackViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-10-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    http = [[HttpRequestTool alloc]init];
    http.delegate = self;
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"确认" target:self action:@selector(toolBarRight)];
    
    m_textview_feedback.delegate = self;
    [m_lbl_remain setText:[NSString stringWithFormat:@"0/150"]];
    
    m_dialog = [[DialogUtil alloc]init];
    m_dialog.delegate = self;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    GLfloat margin = 10;
    GLfloat height =[[UIScreen mainScreen] bounds].size.height;
    if (height<568) //4 inch
    {
        height = (self.view.frame.size.width-155);
    }
    else
    {
        height = (self.view.frame.size.width-100);
    }
    [m_textview_feedback setFrame:CGRectMake(margin, 0, self.view.frame.size.width-margin*2, height)];
    
    [PlatformUtil ResizeUIToTop:m_textview_feedback parentView:self.view offSetY:10];

    [m_lbl_remain setFrame:CGRectMake(margin, m_textview_feedback.frame.origin.y + m_textview_feedback.frame.size.height, self.view.frame.size.width-margin*2, m_lbl_remain.frame.size.height)];
    
    [m_lbl_remain setTextAlignment:NSTextAlignmentRight];
    
    [m_textview_feedback becomeFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) toolBarRight
{
    NSString *feedback = [m_textview_feedback.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(feedback == nil || [feedback isEqualToString:@""]){
        [m_dialog showDialogTitle:@"提示" message:@"内容不能为空" confirm:@"确定"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交"];
     http.url = @"http://iwanted.sinaapp.com/admin.php/API/feedback";
    [http.data removeAllObjects];
    [http.data setObject:m_textview_feedback.text forKey:@"subject"];
    [http.data setObject:@"0" forKey:@"app"];
    NSThread* myThread = [[NSThread alloc] initWithTarget:http selector:@selector(startPostRequest) object:nil];
    [myThread start];

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    //控制输入文字再150以内
    int MAX_LENGTH = 150;
    NSMutableString *newtxt = [NSMutableString stringWithString:textView.text];
    [newtxt replaceCharactersInRange:range withString:text];
    return (MAX_LENGTH >= [newtxt length]);
}

- (void)textViewDidChange:(UITextView *)textView
{
    [m_lbl_remain setText:[NSString stringWithFormat:@"%lu/150",(unsigned long)textView.text.length]];
//    tempString = [textView.text copy];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) onMsgReceive :(NSData*) msg :(NSInteger) errorCode :(NSInteger) statusCode :(HttpRequestTool*) httpRequestTool;
{
    [SVProgressHUD dismiss];
   
    NSError *parse_error=Nil;
    
        NSLogExt(@"error code = %i statusCode = %i",errorCode,statusCode);
        switch (errorCode) {
            case NSURLErrorNotConnectedToInternet://网络断开
                [SVProgressHUD showErrorWithStatus:@"无法连接到网络!"];
                return;
            case NSURLErrorTimedOut://请求超时
                [SVProgressHUD showErrorWithStatus:@"请求超时!"];
                return;
            default:
                break;
        }
  

   
    
    
    switch (statusCode) {
        case 200:
        {
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:msg options:NSJSONReadingMutableLeaves error:&parse_error];
            
            NSString *status =[dataDic objectForKey:@"status"];
            if ([status isEqualToString:@"1"])
            {
               
                dispatch_async(dispatch_get_main_queue(), ^{
                     [m_dialog showDialogTitle:@"提示" message:@"提交成功,多谢支持!" confirm:@"确定"];
                });
            }
            else
            {
                [SVProgressHUD showSuccessWithStatus:@"提交失败!"];
            }
            NSLogExt(@"status=%@",status);
        }
            break;
            
        default:
            break;
    }
    
}

-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    if(dialog == m_dialog)
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    
}
- (void)dealloc {
    [m_textview_feedback release];
    [m_lbl_remain release];
    [http.data removeAllObjects];
    [http.data release];
    [http release];
    [super dealloc];
}
@end
