//
//  UINavigationControllerExt.m
//  Multi_Choice
//
//  Created by Apple on 14/11/9.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UINavigationControllerExt.h"

@interface UINavigationControllerExt ()

@end

@implementation UINavigationControllerExt

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
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
/*
-(BOOL)shouldAutorotate {
    return YES;
}
*/
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
/*
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationMaskAll;
}
*/
@end
