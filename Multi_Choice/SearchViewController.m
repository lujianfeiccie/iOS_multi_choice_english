//
//  SearchViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-10-21.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "SearchViewController.h"
#import "XMLElement.h"
#import "MultChoiceDetailViewController.h"
#import "CalcDetailViewController.h"
#import "NSMutableArrayExt.h"
#import "ViewControllerFactory.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationItem.title = @"搜索结果";
    
    m_tableview = [[UITableView alloc]init];
    [self.view addSubview:m_tableview];
    [m_tableview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height)];
  
    m_tableview.dataSource = self;
    m_tableview.delegate = self;
     app = [[UIApplication sharedApplication]delegate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super.m_array_list count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *questions = [super.m_array_list objectAtIndex:section];
    return [questions count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    
    NSMutableArrayExt* questions = [super.m_array_list objectAtIndex:section];
 
    
    static NSString *GroupedTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             GroupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:GroupedTableIdentifier];
    }
    
    switch (questions.m_type)
    {
        case TYPE_Multi_Choice:
        {
            cell.textLabel.text = ((XMLElement*)[questions objectAtIndex:row]).m_title;
            cell.textLabel.numberOfLines = 2;
            NSLogExt(@"Multi choice");
        }
            break;
        case TYPE_Short_Answer:
        {
            XMLCalcElement* obj =[questions objectAtIndex:row];
            NSUInteger count_items = [obj.m_subElements count];
            NSString* titleForQuestion = @"";
            for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
            {
                XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
                if ([item.m_tag isEqualToString:@"question"])
                {
                    titleForQuestion = [titleForQuestion stringByAppendingString:item.m_value];
                }
            }
            
            cell.textLabel.text = titleForQuestion;
            cell.textLabel.numberOfLines = 5;
            
            NSLogExt(@"Calc");
        }
            break;
        case TYPE_Calc:
        {
            XMLCalcElement* obj =[questions objectAtIndex:row];
            NSUInteger count_items = [obj.m_subElements count];
            NSString* titleForQuestion = @"";
            for (NSUInteger j=0; j<count_items; j++)  //num of items in each question
            {
                XMLCalcElement* item = [obj.m_subElements objectAtIndex:j];
                if ([item.m_tag isEqualToString:@"question"])
                {
                    titleForQuestion = [titleForQuestion stringByAppendingString:item.m_value];
                    break;
                }
            }
            
            cell.textLabel.text = titleForQuestion;
            cell.textLabel.numberOfLines = 5;
            
            NSLogExt(@"Calc");

        }
            break;
        default:
            break;
    }
   
    cell.backgroundColor = GLOBAL_BGColor;
   
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title=@"";
    
    NSMutableArrayExt* questions = [super.m_array_list objectAtIndex:section];
    
    switch (questions.m_type)
    {
        case TYPE_Multi_Choice:
            title=@"选择题";
            break;
        case TYPE_Short_Answer:
            title=@"简答题";
            break;
        case TYPE_Calc:
            title=@"计算题";
            break;
        default:
            break;
    }
    return title;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 80.0f;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSMutableArrayExt* questions= [super.m_array_list objectAtIndex:section];
    
 
    if (questions.m_type == TYPE_Multi_Choice)
    {
        AbstractDetailViewController *next = [ViewControllerFactory getMultiChoiceDetail:self];
        
        next.m_array_detail = (NSMutableArray*)questions;
        next.m_currentIndex = row;
        next.m_title = @"选择题搜索结果";
        [app.navController pushViewController:next animated:YES];

    }
    else if (questions.m_type == TYPE_Short_Answer)
    {
        AbstractDetailViewController *next = [ViewControllerFactory getShortAnswerOrCalcDetail:self];
        
        ((MultChoiceDetailViewController*)next).m_array_detail = (NSMutableArray*)questions;
        next.m_currentIndex = row;
        next.m_title = @"简答题搜索结果";
        [app.navController pushViewController:next animated:YES];

    }
    else if (questions.m_type == TYPE_Calc)
    {
        AbstractDetailViewController *next = [ViewControllerFactory getShortAnswerOrCalcDetail:self];
        
        next.m_array_detail = (NSMutableArray*)questions;
        next.m_currentIndex = row;
        next.m_title = @"计算题搜索结果";
        [app.navController pushViewController:next animated:YES];
        
    }

  //  NSLogExt(@"section=%i\trow=%i",section,row);
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
    [m_tableview release];
    [super dealloc];
}
@end
