//
//  AboutDlgViewController.m
//  Multi_Choice
//
//  Created by Apple on 14-9-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AboutDlgViewController.h"
#import "PlatformUtil.h"
@interface AboutDlgViewController ()

@end

@implementation AboutDlgViewController

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
    self.navigationItem.title = @"关于";
    
    m_tableview_setting.delegate = self;
    m_tableview_setting.dataSource = self;
    
     NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString *appname =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
   

    
    m_lbl_version.text = [NSString stringWithFormat:@"%@ %@",appname,version];
    
    m_datalist = [[NSMutableArray alloc]init];
    
    [m_datalist addObject:@"意见反馈"];
    [m_datalist addObject:@"版本更新"];
    
   // m_tableview_setting.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableview_setting.bounces = false;
   
     app = [[UIApplication sharedApplication]delegate];
    
    m_versionCheckTool = [[VersionCheckTool alloc]init];
    m_versionCheckTool.m_app_id = GLOBAL_APP_ID;
   }
- (void)viewDidLayoutSubviews
{
    [PlatformUtil ResizeUIToTop:m_img_logo parentView:self.view offSetY:20];
    
    [m_lbl_version setFrame:CGRectMake(0,
                                       m_img_logo.frame.origin.y + m_img_logo.frame.size.height
                                       ,
                                       self.view.frame.size.width,
                                       m_lbl_version.frame.size.height)];
    
    [m_lbl_version setTextAlignment:NSTextAlignmentCenter];

    
    GLfloat m_margin = 10;
    [m_tableview_setting setFrame:CGRectMake(m_margin, m_lbl_version.frame.origin.y+m_lbl_version.frame.size.height+10, self.view.frame.size.width-m_margin*2, [m_datalist count]*40)];
    
    [PlatformUtil ResizeUIToBottom:m_lbl_copyright parentView:self.view offSetY:-10];
    
    [m_tableview_setting deselectRowAtIndexPath:[m_tableview_setting indexPathForSelectedRow] animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [m_datalist count];

}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [m_datalist objectAtIndex:row];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 40;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    switch (row) {
        case 0:
        {
            //Go to feedback
            AbstractViewController *next = [ViewControllerFactory getFeedbackDlg:self];
            [[app navController] pushViewController:next animated:YES];
        }
            break;
        case 1:
        {
           //Go to check the latest version
            [m_versionCheckTool request];
            
        }
            break;
        default:
            break;
    }
}
- (void)dealloc {
    [m_lbl_version release];
    [m_lbl_copyright release];
    [m_img_logo release];
    [m_tableview_setting release];
    [m_versionCheckTool releaseExt];
    [super dealloc];
}
@end
