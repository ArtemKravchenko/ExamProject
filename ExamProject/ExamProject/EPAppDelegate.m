//
//  EPAppDelegate.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPAppDelegate.h"
#import "EPHistoryViewController.h"
#import "EPFavoritesViewController.h"
#import "EPWeatherTracker.h"

@implementation EPAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.tabbarController = [[UITabBarController new] autorelease];
    
    self.dv = [[EPDetailViewController new] autorelease];
    UINavigationController *detailNC = [[[UINavigationController alloc] initWithRootViewController:self.dv] autorelease];
    detailNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostViewed tag:0];
    [EPWeatherTracker share].delegate = self.dv;
    
    EPFavoritesViewController *fv = [[EPFavoritesViewController new] autorelease];
    UINavigationController *favoriteNC = [[[UINavigationController alloc] initWithRootViewController:fv] autorelease];
    favoriteNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    self.dv.delegate = fv;
    
    EPHistoryViewController *hv = [[EPHistoryViewController new] autorelease];
    UINavigationController *historyNC = [[[UINavigationController alloc] initWithRootViewController:hv] autorelease];
    historyNC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    
    NSArray *controllers = [NSArray arrayWithObjects: detailNC, favoriteNC, historyNC, nil];
    
    self.tabbarController.viewControllers = controllers;
    self.window.rootViewController = self.tabbarController;
    
    [[EPWeatherTracker share] enable];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
