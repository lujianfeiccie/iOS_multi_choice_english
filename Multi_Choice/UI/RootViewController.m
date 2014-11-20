//
//  RootViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "RootViewController.h"
#import "MultiChoiceViewController.h"
#import "ModelData.h"
#import "SearchViewController.h"
#import "NSMutableArrayExt.h"
@interface RootViewController ()

@end

@implementation RootViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) toolBarLeft
{
    [m_dialog_search showDialogWithInputTitle:@"提示" message:@"请输入搜索内容" confirm:@"确定" cancel:@"取消"];
}

-(void) toolBarRight
{
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"about_view"];
   [app.navController pushViewController:next animated:YES];
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    app = [[UIApplication sharedApplication]delegate];
    

    m_dialog_search = [[DialogUtil alloc] init];
    m_dialog_search.delegate = self;
    
    m_tableview_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableview_list.backgroundColor = GLOBAL_BGColor;
    self.navigationItem.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
    
    
    m_datalist = [[NSMutableArray alloc]init];
    ModelData *model = [[ModelData alloc]init];
    model.m_text = @"2010年11月";
    model.m_value = @"hunan_2010_11";
    [m_datalist addObject:model];
    
    

    [m_tableview_list setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-self.navigationController.navigationBar.frame.size.height)];

  
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"本地搜索" target:self action:@selector(toolBarLeft)];
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"关于" target:self action:@selector(toolBarRight)];
    
    m_tableview_list.delegate = self;
    m_tableview_list.dataSource = self;
     NSLogExt(@"%f %f", [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    
    NSLogExt(@"%f %f %f %f",m_tableview_list.frame.origin.x,
             m_tableview_list.frame.origin.y,
             m_tableview_list.frame.size.width,
             m_tableview_list.frame.size.height);
    
    m_versionCheckTool = [[VersionCheckTool alloc]init];
    m_versionCheckTool.m_app_id = GLOBAL_APP_ID;
    m_versionCheckTool.m_isAboutDlg = NO;
    NSLogExt(@"m_isAboutDlg=%i",m_versionCheckTool.m_isAboutDlg);

    //Check the version
    [m_versionCheckTool request];
//    m_tableview_list.backgroundColor = [UIColor redColor];
}

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
  //  NSLog(@"viewDidLayoutSubviews");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  [self MyLog:[NSString stringWithFormat:@"didReceiveMemoryWarning count=%d",[self.datalist count]]];
    return [m_datalist count];
//    return 1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    cell.tag = 1;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    cell.backgroundColor = GLOBAL_BGColor;
//    cell.backgroundColor = [UIColor greenColor];
    NSUInteger row = [indexPath row];
    cell.textLabel.text = ((ModelData*)[m_datalist objectAtIndex:row]).m_text;
    cell.textLabel.font = [UIFont fontWithName:@"" size:19.0f];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 50.0f;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    
   MultiChoiceViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"question_view"];
   next.m_filename = ((ModelData*)[m_datalist objectAtIndex:row]).m_value;
   next.m_title = ((ModelData*)[m_datalist objectAtIndex:row]).m_text;
   [[app navController] pushViewController:next animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0;
    
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

/*- (IBAction)btn_FirstClick:(id)sender {
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"question_view"];
    [[app navController] pushViewController:next animated:YES];
}*/

-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    if (m_dialog_search == dialog)
    {
      //  NSLogExt(@"onConfirm");
    }
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    if (m_dialog_search == dialog)
    {
       // NSLogExt(@"onCancel");
    }
}
-(void) onDialogTextReceive : (DialogUtil*) dialog Text:(NSString *)text
{
    if (m_dialog_search == dialog)
    {
        NSLogExt(@"search text=%@",text);
        if([text isEqualToString:@""])
        {
            DialogUtil *dialog = [[DialogUtil alloc]init];
            [dialog showDialogTitle:@"提示" message:@"输入不能为空!" confirm:@"知道"];
            return;
        }
        [SVProgressHUD showWithStatus:@"正在搜索"];
        NSThread* myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadSearch:) object:text];
        [myThread start];
        //[self threadSearch:text];
    }
}
-(void) threadSearch :(NSString*) keywords
{
    
     XMLHelper* xmlHelper = [[XMLHelper alloc]init];;
    
    
    ///////////////////For multi choice////////////////
    NSMutableArrayExt* results_multi_choice = [[NSMutableArrayExt alloc]init];
    results_multi_choice.m_type = TYPE_Multi_Choice;
    
    NSArray* mutli_question_filename = [NSArray arrayWithObjects:
                         @"2014_04",
                         @"2013_10",
                         @"2013_01",
                         @"2012_10",
                         @"2011_10",
                         @"2010_10",
                         @"2009_10",nil];


    
    for (NSString* filename in mutli_question_filename)
    {
        [xmlHelper load:filename];
       // NSLogExt(@"filename = %@",filename);
        NSMutableArray* questions = [[xmlHelper rootElement] m_subElements];
        
        for (XMLElement* question in questions)
        {
            if ([Util containString:question.m_title:keywords])
            {
                //    NSLogExt(@"keywords=%@ title=%@",keywords,question.m_title);
                [results_multi_choice addObject:question];
            }
        }

    }
    //////////////////End for Multi choice ///////////////
    
    ///////////////////For short answer////////////////
    XMLCalcHelper* xmlCalcHelper = [[XMLCalcHelper alloc]init];
    
    NSMutableArrayExt* results_short_answer = [[NSMutableArrayExt alloc]init];
    results_short_answer.m_type = TYPE_Short_Answer;
    
    NSArray* mutli_short_answer_filename = [NSArray arrayWithObjects:
                                        @"2014_04_short_answer",
                                        @"2013_10_short_answer",
                                        @"2013_01_short_answer",
                                        @"2012_10_short_answer",
                                        @"2011_10_short_answer",
                                        @"2010_10_short_answer",
                                        @"2009_10_short_answer",nil];
    
    
    for (NSString* filename in mutli_short_answer_filename)
    {
        [xmlCalcHelper load:filename];
        NSMutableArray *m_questions = [[xmlCalcHelper rootElement] m_subElements];
        
        NSUInteger count = [m_questions count];
        for (NSUInteger i=0; i<count; i++) //num of questions
        {
            XMLCalcElement* obj =[m_questions objectAtIndex:i];
            NSUInteger count_items = [obj.m_subElements count];
            
            for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
            {
                XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
                if ([[item m_tag] isEqualToString:@"question"] &&
                    [Util containString:item.m_value :keywords])
                {
                    [results_short_answer addObject:[m_questions objectAtIndex:i]];
//                    NSLogExt(@"tag=%@,value=%@",item.m_tag,item.m_value);
                }

            }
        }
        
    }
    //////////////////End for short answer ///////////////

    
    ///////////////////For calc////////////////
    
    NSMutableArrayExt* results_calc = [[NSMutableArrayExt alloc]init];
    results_calc.m_type = TYPE_Calc;
    
    NSArray* mutli_calc_filename = [NSArray arrayWithObjects:
                                            @"2014_04_calc",
                                            @"2013_10_calc",
                                            @"2013_01_calc",
                                            @"2012_10_calc",
                                            @"2011_10_calc",
                                            @"2010_10_calc",
                                            @"2009_10_calc",
                                            nil];
    
    
    for (NSString* filename in mutli_calc_filename)
    {
        [xmlCalcHelper load:filename];
        NSMutableArray *m_questions = [[xmlCalcHelper rootElement] m_subElements];
        
        NSUInteger count = [m_questions count];
        for (NSUInteger i=0; i<count; i++) //num of questions
        {
            XMLCalcElement* obj =[m_questions objectAtIndex:i];
            NSUInteger count_items = [obj.m_subElements count];
            
            for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
            {
                XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
                if ([[item m_tag] isEqualToString:@"question"] &&
                    [Util containString:item.m_value :keywords])
                {
                    [results_calc addObject:[m_questions objectAtIndex:i]];
                     NSLogExt(@"tag=%@,value=%@",item.m_tag,item.m_value);
                }
                
            }
        }
        
    }
    //////////////////End for calc ///////////////
    [SVProgressHUD dismiss];
    if ([results_multi_choice count] == 0
        && [results_short_answer count] == 0
        && [results_calc count] == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"没有找到相关内容"];
        return;
    }
    NSMutableArray* results_total = [[NSMutableArray alloc]init];
    if([results_multi_choice count]!=0)
    {
         [results_total addObject:results_multi_choice];
    }
    if ([results_short_answer count]!=0)
    {
         [results_total addObject:results_short_answer];
    }
    if ([results_calc count]!=0)
    {
        [results_total addObject:results_calc];
    }
    SearchViewController* search_view =[[self storyboard] instantiateViewControllerWithIdentifier:@"search_view"];
    search_view.m_array_list = results_total;
    [[app navController] pushViewController:search_view animated:YES];
}







- (void)dealloc {
    [m_tableview_list release];
    [m_datalist removeAllObjects];
    [m_datalist release];
    [m_versionCheckTool releaseExt];
    [super dealloc];
}
@end
