//
//  EPDetailViewController.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPWeatherTracker.h"

@protocol EPDetailViewControllerAddToFavoritesDelegate <NSObject>

- (void) addCurrentModelToFavorites;

@end

@interface EPDetailViewController : UIViewController <EPWeatherTrackerDelegate>

@property (nonatomic, retain) id<EPDetailViewControllerAddToFavoritesDelegate> delegate;

@end
