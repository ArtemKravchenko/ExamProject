//
//  EPWeatherRequest.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EPWeatherRequestDelegate <NSObject>

@optional

- (void) requestDidFinishSuccessful;
- (void) requestDidFinishFail:(NSError**)error;

@end

@interface EPWeatherRequest : NSOperation

@property (nonatomic, assign) id<EPWeatherRequestDelegate> delegate;

@end
