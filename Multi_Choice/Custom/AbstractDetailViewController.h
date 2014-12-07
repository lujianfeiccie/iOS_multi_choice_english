//
//  AbstractDetailViewController.h
//  Multi_Choice
//
//  Created by mac on 14/12/7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AbstractViewController.h"

@interface AbstractDetailViewController : AbstractViewController
@property(nonatomic,strong) NSMutableArray* m_array_detail;
@property(nonatomic) NSInteger m_currentIndex;
@end
