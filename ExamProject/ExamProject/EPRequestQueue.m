//
//  EPRequestQueue.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPRequestQueue.h"

static EPRequestQueue *requestsQueue = nil;

@interface EPRequestQueue ()

@property (nonatomic, retain) EPWeatherRequest *currentRequest;

@end

@implementation EPRequestQueue

+ (void)initialize
{
	if(self == [EPRequestQueue class])
		requestsQueue = [EPRequestQueue new];
}

+ (EPRequestQueue*)queue
{
    return requestsQueue;
}

- (id)init
{
    if(self = [super init])
    {
        self.operationQueue = [[NSOperationQueue new] autorelease];
    }
    return self;
}

- (void)addRequest:(EPWeatherRequest*)request
{
    self.currentRequest = request;
	[self.operationQueue addOperation:self.currentRequest];
}

- (void)cancelRequst
{
    if(self.currentRequest)
    {
        [self.currentRequest cancel];
    }
}

-(void)dealloc
{
    self.currentRequest = nil;
    [super dealloc];
}

@end
