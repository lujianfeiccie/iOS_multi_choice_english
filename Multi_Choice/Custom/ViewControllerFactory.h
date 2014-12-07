//
//  ViewControllerFactory.h
//  Multi_Choice
//
//  Created by mac on 14/12/7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractViewController.h"
#import "AbstractDetailViewController.h"
#import "AbstractSearchViewController.h"
@interface ViewControllerFactory : NSObject
+(AbstractViewController*) getMultiChoice : (AbstractViewController*) context;

+(AbstractDetailViewController*) getMultiChoiceDetail : (AbstractViewController*) context;

+(AbstractViewController*) getShortAnswerOrCalc : (AbstractViewController*) context;

+(AbstractDetailViewController*) getShortAnswerOrCalcDetail : (AbstractViewController*) context;

+(AbstractSearchViewController*) getSearchView : (AbstractViewController*) context;

+(AbstractViewController*) getAboutDlg : (AbstractViewController*) context;

+(AbstractViewController*) getFeedbackDlg : (AbstractViewController*) context;
@end
