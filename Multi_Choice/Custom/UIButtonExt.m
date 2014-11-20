//
//  UIButtonExt.m
//  Multi_Choice
//
//  Created by Apple on 14-10-30.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UIButtonExt.h"
#import "NSLogExt.h"
@implementation UIButtonExt

-(id) init
{
    NSLogExt(@"init");
    if (self = [super init]) {
        m_lbl_title = [[UILabel alloc]init];
        m_lbl_title.textAlignment = NSTextAlignmentCenter;
        m_lbl_title.backgroundColor = [UIColor redColor];
           m_lbl_title.textColor = [UIColor blueColor];
       // [self addSubview:m_lbl_title];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        m_lbl_title = [[UILabel alloc]initWithFrame:frame];
        m_lbl_title.textAlignment = NSTextAlignmentCenter;
        m_lbl_title.backgroundColor = [UIColor redColor];
        m_lbl_title.textColor = [UIColor blueColor];
       // [self addSubview:m_lbl_title];
//        [m_lbl_title setNeedsDisplay];
//        self.titleLabel.backgroundColor = [UIColor blackColor];
        //self.backgroundColor = [UIColor blackColor];
      //  self.titleLabel.textColor = [UIColor blueColor];
    }
    return self;
}
-(void) setFrame:(CGRect)frame
{
    NSLogExt(@"setFrame");
    [super setFrame:frame];
    [m_lbl_title setFrame:frame];
}
-(void) setTitleExt : (NSString*) title
{
 //   m_lbl_title.text = title;
    //[self.titleLabel setText:title];
    [self setTitle:title forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
