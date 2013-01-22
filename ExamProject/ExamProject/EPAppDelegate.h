//
//  EPAppDelegate.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPDetailViewController.h"

@class EPViewController;

@interface EPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (retain, nonatomic) UITabBarController* tabbarController;
@property (retain, nonatomic) EPDetailViewController *dv;

@end
