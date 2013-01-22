//
//  EPRequestQueue.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPWeatherRequest.h"

@interface EPRequestQueue : NSObject

@property (nonatomic, retain) NSOperationQueue *operationQueue;

+ (EPRequestQueue*)queue;

- (void)addRequest:(EPWeatherRequest*)request;
- (void)cancelRequst;

@end
