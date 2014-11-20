//
//  UILabelExt.m
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UILabelImageExt.h"
#import "NSLogExt.h"
@implementation UILabelImageExt
@synthesize delegateExt;


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
       m_image_name=@"";
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        m_image_name=@"";
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
-(NSString*) getImageName
{
    return m_image_name;
}
-(void) setImageName:(NSString*) str
{
    m_image_name = str;
    UIImage *itemBgImage = [UIImage imageNamed:str];
    UIColor *color = [UIColor colorWithPatternImage:itemBgImage];
    
  //  CGRect r = [ UIScreen mainScreen ].applicationFrame;
   // CGFloat ratio_with = r.size.width/itemBgImage.size.width;
    
    [self setFrame:CGRectMake(0, 0, itemBgImage.size.width, itemBgImage.size.height)];
    self.backgroundColor = color;
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
        [delegateExt onLabelImageExtClick:self];
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
   // NSLogExt(@"touchesMoved");
}
-(void) dealloc
{
    [m_image_name release];
    m_image_name = nil;
    delegateExt = nil;
    [super dealloc];
}
@end
