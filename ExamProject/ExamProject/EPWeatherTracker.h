//
//  EPWeatherTracker.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPWeatherRequest.h"
#import <CoreLocation/CoreLocation.h>

@protocol EPWeatherTrackerDelegate <NSObject>

@optional
- (void)modelCompletedInitialize;

@end

@interface EPWeatherTracker : NSObject <CLLocationManagerDelegate, EPWeatherRequestDelegate>

@property (nonatomic, assign) id<EPWeatherTrackerDelegate> delegate;

- (void) enable;
+(EPWeatherTracker*)share;

@end
