//
//  MultChoiceDetailViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-11-1.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "MultChoiceDetailViewController.h"

@interface MultChoiceDetailViewController ()

@end

@implementation MultChoiceDetailViewController
@synthesize m_array_detail;
@synthesize m_currentIndex;
@synthesize m_title;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = m_title;
    
     app = [[UIApplication sharedApplication]delegate];
    m_dlg = [[ MultiChoiceDlg alloc]initWithView:self.view
                                     DisplayRect:CGRectMake(0, 0,
                                                            self.view.frame.size.width,
                                                            self.view.frame.size.height-m_btn_next.frame.size.height-self.navigationController.navigationBar.frame.size.height-20)
                                        DataFile:@""];

    m_dlg.m_currentIndex = m_currentIndex;
    m_dlg.m_bShowSearchDetail = YES;
    m_dlg.m_questions = m_array_detail;
    [m_dlg load];
    [m_dlg updateUI];
    [m_dlg showAnswer];
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [PlatformUtil ResizeUIToBottomLeft:m_btn_prev parentView:self.view];
    [PlatformUtil ResizeUIToBottomRight:m_btn_next parentView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [m_btn_prev release];
    [m_btn_next release];
    [super dealloc];
}
- (IBAction)onPrevClick:(id)sender {
    [m_dlg prev];
    [m_dlg showAnswer];
}

- (IBAction)onNextClick:(id)sender {
    [m_dlg next];
    [m_dlg showAnswer];
}
@end
