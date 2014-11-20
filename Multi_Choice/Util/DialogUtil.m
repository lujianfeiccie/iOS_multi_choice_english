//
//  DialogUtil.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DialogUtil.h"

@implementation DialogUtil

@synthesize delegate;

-(id)init{
    if (self=[super init]) {
        delegate = nil;
        return self;
    }
    return nil;
}

-(void) showDialogTitle: (NSString *)title message:(NSString *)message confirm :(NSString*) confirm
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:confirm otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

-(void) showDialogTitle: (NSString *)title message:(NSString *)message confirm :(NSString*) confirm cancel :(NSString*) cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:confirm otherButtonTitles:cancel, nil];
    [alert show];
    alert = nil;
}
-(void) showDialogWithInputTitle: (NSString *)title message:(NSString *)message confirm :(NSString*) confirm cancel :(NSString*) cancel
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:confirm otherButtonTitles:cancel, nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
    alert = nil;
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            if (delegate!=nil)
            {
                [delegate onDialogConfirmClick:self];
                 UITextField *tf=[alertView textFieldAtIndex:0];
                if (tf!=nil)
                {
                    tf.keyboardType = UIKeyboardTypeDefault;
                    [tf becomeFirstResponder];
                    [delegate onDialogTextReceive:self Text:tf.text];
                }
            }
        }
            break;
        case 1:
        {
            if (delegate!=nil)
            {
                [delegate onDialogCancelClick:self];
            }
        }
            break;
        default:
            break;
    }
}
@end
