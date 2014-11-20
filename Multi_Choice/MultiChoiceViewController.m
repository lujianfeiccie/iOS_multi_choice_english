//
//  ViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-8-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "MultiChoiceViewController.h"
#import "CalcViewController.h"

@interface MultiChoiceViewController ()

@end

@implementation MultiChoiceViewController
@synthesize m_filename;
@synthesize m_title;

-(void) toolBarRight
{
    if ([m_filename isEqualToString:@"all"])
    {
        CalcViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"calc_view"];
        next.m_filename=m_filename;
        next.m_title= [m_title stringByAppendingString:@"简答题"];
        next.m_bCalcView = NO;
        [[app navController] pushViewController:next animated:YES];
        return;
    }

    NSString *tmp_filename = [NSString stringWithFormat:@"%@_short_answer",m_filename];
    NSString *tmp_title = [NSString stringWithFormat:@"%@简答题",m_title];
    NSString* result = [[NSBundle mainBundle] pathForResource:tmp_filename ofType:@"xml"];
//    NSLogExt(@"result=%@",result);
    if (result==nil)
    {
        DialogUtil *dialog = [[DialogUtil alloc]init];
        [dialog showDialogTitle:@"提示" message:@"有待加入" confirm:@"知道了"];
        [dialog release];
        dialog = nil;
    }
    else
    {
        UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"calc_view"];
        
       ((CalcViewController*)next).m_filename=tmp_filename;
        ((CalcViewController*)next).m_title= tmp_title;
       [[app navController] pushViewController:next animated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    app = [[UIApplication sharedApplication]delegate];
    
    self.navigationItem.title = m_title;
   
   // self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"简答题" target:self action:@selector(toolBarRight)];
    
    m_dlg = [[ MultiChoiceDlg alloc]initWithView:self.view
                                     DisplayRect:CGRectMake(0, 0,
                                                            self.view.frame.size.width,
                                                            self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20)
                                        DataFile:m_filename];
    
    [m_dlg load];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if([m_filename isEqualToString:@"all"])
    {
       // return;
    }
    [PlatformUtil ResizeUIToBottomRight:m_btn_next parentView:self.view];
    [PlatformUtil ResizeUIToBottomLeft:m_btn_prev parentView:self.view];
    [m_dlg updateUI];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnNextClick:(id)sender {
    NSLogExt(@"next");
    [m_dlg next];
}

- (IBAction)btnPrevClick:(id)sender {
    NSLogExt(@"previous");
    [m_dlg prev];
}


- (void)dealloc {
    NSLogExt(@"dealloc");
    [m_title release];
    [m_btn_prev release];
    [m_btn_next release];
    [m_dlg release];
    [super dealloc];
}
@end
