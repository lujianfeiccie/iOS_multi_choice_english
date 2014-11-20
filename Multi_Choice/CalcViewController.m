//
//  CalcViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-10-14.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "CalcViewController.h"

@interface CalcViewController ()

@end

@implementation CalcViewController
@synthesize m_title;
@synthesize m_filename;
@synthesize m_bCalcView;
-(void) toolBarRight
{
   /* if(![[m_filename substringToIndex:7] isEqualToString:@"2009_10"]
       && ![[m_filename substringToIndex:7] isEqualToString:@"2011_10"]
       && ![[m_filename substringToIndex:7] isEqualToString:@"2013_10"]
       && ![[m_filename substringToIndex:7] isEqualToString:@"2012_10"])
    {
        DialogUtil *dialog = [[DialogUtil alloc]init];
        [dialog showDialogTitle:@"提示" message:@"有待加入" confirm:@"知道了"];
        return;
    }
    */
    //NSLogExt(@"m_filename=%@",m_filename);

    NSString *tmp_filename;
    NSString *tmp_title;
    if ([m_filename isEqualToString:@"all"]) {
        
        tmp_filename = m_filename;
        tmp_filename = [NSString stringWithFormat:@"%@_calc",tmp_filename];
        tmp_title = @"综合真题计算题";
    }
    else
    {
        tmp_filename = m_filename;
        tmp_title = [NSString stringWithFormat:@"%@计算题",[m_title substringToIndex:10]];
        tmp_filename = [tmp_filename substringToIndex:7];
        tmp_filename = [NSString stringWithFormat:@"%@_calc",tmp_filename];
        
    }
    
        CalcViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"calc_view"];
        
        next.m_filename=tmp_filename;
        next.m_title= tmp_title;
        next.m_bCalcView = YES;
        [[app navController] pushViewController:next animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    m_isShowingAnswer = NO;

    // Do any additional setup after loading the view.
    
    app = [[UIApplication sharedApplication]delegate];

    
    self.navigationItem.title = m_title;
    
    if(!m_bCalcView)
    {
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"计算题" target:self action:@selector(toolBarRight)];
    }
    m_dlg = [[ CalcChoiceDLg alloc] initWithView:self.view DisplayRect:CGRectMake(0, 0,
                                                                                 self.view.frame.size.width,
                                                                                 self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20)
                                        DataFile:m_filename];
    [m_dlg load];
    [m_btn_showAnswer setTitle:@"显示/隐藏答案" forState:UIControlStateNormal];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [PlatformUtil ResizeUIToBottomLeft:m_btn_prev parentView:self.view];
    [PlatformUtil ResizeUIToBottomRight:m_btn_next parentView:self.view];
    [PlatformUtil ResizeUIToBottomCenter:m_btn_showAnswer parentView:self.view];
    
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)btnPrevClick:(id)sender
{
    [m_dlg prev];
    m_isShowingAnswer = YES;
    [self btnShowAnswerClick:nil];
}

- (IBAction)btnNextClick:(id)sender
{
    [m_dlg next];
    
    m_isShowingAnswer = YES;
    [self btnShowAnswerClick:nil];
}

- (IBAction)btnShowAnswerClick:(id)sender {
  
    if (!m_isShowingAnswer)
    {
        [m_dlg showAnswer];
        m_isShowingAnswer = YES;
    }
    else
    {
       [m_dlg hideAnswer];
        m_isShowingAnswer = NO;
    }
 //   NSLogExt(@"btnShowAnswerClick %d",m_isShowingAnswer);
   // [self setShowAnswerButton: m_isShowingAnswer];
}

- (void)dealloc {
    [m_btn_prev release];
    [m_btn_next release];
    [m_btn_showAnswer release];

    [m_dlg release];
    m_dlg = nil;
    [super dealloc];
}


@end
