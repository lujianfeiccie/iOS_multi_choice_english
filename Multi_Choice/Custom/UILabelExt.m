//
//  UILabelExt.m
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UILabelExt.h"
#import "NSLogExt.h"
@implementation UILabelExt
@synthesize m_prefix;
@synthesize delegateExt;
@synthesize m_IsSelected;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        m_prefix=@"";
        m_text = @"";
        m_IsSelected = NO;
      //  NSLogExt(@"initWithCoder");
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        m_prefix = @"";
        m_text =@"";
        m_IsSelected = NO;
       // NSLogExt(@"initWithFrame");
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(NSString*) getTextExt{
   // NSLogExt(@"getText");

    return m_text;
}
-(void) setTextExt:(NSString*) str{
    m_text = str;
   // NSLogExt(@"%@",str);
    if(m_text == nil || [m_text isEqualToString:@""]){
        m_text = @"无";
    }
    self.text = [NSString stringWithFormat:@"%@%@",m_prefix,m_text];
}

-(void) setNormal{
    self.backgroundColor = [UIColor clearColor];
    m_IsSelected = NO;
}
-(void) setRight{
    self.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    m_IsSelected = YES;
}
-(void) setWrong{
    self.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    m_IsSelected = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
 //  NSLogExt(@"touchesBegan");
  // [self.nextResponder touchesBegan:touches withEvent:event];  // 接受到事件后继续向上传递事件
    
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    
  // NSLogExt(@"touchesCancelled");
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
      // NSLogExt(@"touchesEnded");
    if (delegateExt!=nil) {
        [delegateExt onLabelExtClick:self];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLogExt(@"touchesMoved");
}
-(void) dealloc
{
    [m_text release];
    [m_prefix release];
    m_text = nil;
    m_prefix = nil;
    delegateExt = nil;
    [super dealloc];
}
@end
