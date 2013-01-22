//
//  EPWeatherModel.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPWeatherModel : NSObject

@property (nonatomic, retain) NSString* lat;
@property (nonatomic, retain) NSString* lon;
@property (nonatomic, retain) NSString* date;
@property (nonatomic, retain) NSString* tempMaxC;
@property (nonatomic, retain) NSString* tempMaxF;
@property (nonatomic, retain) NSString* tempMinC;
@property (nonatomic, retain) NSString* tempMinF;
@property (nonatomic, retain) NSString* weatherDesc;
@property (nonatomic, retain) NSString* windspeedKmph;
@property (nonatomic, retain) NSString* windspeedMiles;
@property (nonatomic, retain) NSString* cloudcover;
@property (nonatomic, retain) NSString* humidity;
@property (nonatomic, retain) NSString* pressure;
@property (nonatomic, retain) NSString* observationTime;
@property (nonatomic, retain) NSString* icon;

@property (nonatomic, retain) NSDictionary *weatherDictionary;

- (void)encodeWithCoder:(NSCoder *)aCoder;
- (id)initWithCoder:(NSCoder *)aDecoder;

+ (EPWeatherModel*)share;
- (NSString *)dataFilePath;

@end
