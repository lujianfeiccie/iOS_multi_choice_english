//
//  UILabelExt.h
//  Multi_Choice
//
//  Created by Apple on 14-8-24.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UILabelImageExtDelegate <NSObject>
@optional
-(void) onLabelImageExtClick:(id)sender;
@end

@interface UILabelImageExt : UILabel
{
    NSString* m_image_name;
}
@property(nonatomic,strong) id<UILabelImageExtDelegate> delegateExt;
-(NSString*) getImageName;
-(void) setImageName:(NSString*) str;
@end
