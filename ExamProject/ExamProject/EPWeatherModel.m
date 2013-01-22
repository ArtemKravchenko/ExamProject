//
//  EPWeatherModel.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPWeatherModel.h"

static EPWeatherModel* weatherModel = nil;
static dispatch_once_t predicate;

@implementation EPWeatherModel

+ (void)initialize
{
	if(self == [EPWeatherModel class])
		weatherModel = [EPWeatherModel new];
}

+ (EPWeatherModel*)share
{
    if (self == [EPWeatherModel class])
    {
        dispatch_once( &predicate, ^
                      {
                          weatherModel = [ [ self alloc ] init ];
                      } );
    }
    return weatherModel;
}

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kCoder];
}

-(void)dealloc
{
    self.lat = nil;
    self.lon = nil;
    self.date = nil;
    self.tempMaxC = nil;
    self.tempMaxF = nil;
    self.tempMinC = nil;
    self.tempMinF = nil;
    self.weatherDesc = nil;
    self.windspeedKmph = nil;
    self.windspeedMiles = nil;
    self.cloudcover = nil;
    self.humidity = nil;
    self.pressure = nil;
    self.observationTime = nil;
    self.icon = nil;
    self.weatherDictionary = nil;
    [super dealloc];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.lat                = [aDecoder decodeObjectForKey:kLat];
        self.lon                = [aDecoder decodeObjectForKey:kLon];
        self.date               = [aDecoder decodeObjectForKey:kDate];
        self.tempMaxC           = [aDecoder decodeObjectForKey:kTempMaxC];
        self.tempMaxF           = [aDecoder decodeObjectForKey:kTempMaxF];
        self.tempMinC           = [aDecoder decodeObjectForKey:kTempMinC];
        self.tempMinF           = [aDecoder decodeObjectForKey:kTempMinF];
        self.weatherDesc        = [aDecoder decodeObjectForKey:kWeatherDesc];
        self.windspeedKmph      = [aDecoder decodeObjectForKey:kWindSpeedKmph];
        self.windspeedMiles     = [aDecoder decodeObjectForKey:kWindSpeedMiles];
        self.cloudcover         = [aDecoder decodeObjectForKey:kCloudcover];
        self.humidity           = [aDecoder decodeObjectForKey:kHumidity];
        self.pressure           = [aDecoder decodeObjectForKey:kPressure];
        self.observationTime    = [aDecoder decodeObjectForKey:kObservationTime];
        self.icon               = [aDecoder decodeObjectForKey:kIcon];
        self.weatherDictionary  = [aDecoder decodeObjectForKey:kDictionary];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lat               forKey: kLat];
    [aCoder encodeObject:self.lon               forKey: kLon];
    [aCoder encodeObject:self.date              forKey: kDate];
    [aCoder encodeObject:self.tempMaxC          forKey: kTempMaxC];
    [aCoder encodeObject:self.tempMaxF          forKey: kTempMaxF];
    [aCoder encodeObject:self.tempMinC          forKey: kTempMinC];
    [aCoder encodeObject:self.tempMinF          forKey: kTempMinF];
    [aCoder encodeObject:self.weatherDesc       forKey: kWeatherDesc];
    [aCoder encodeObject:self.windspeedKmph     forKey: kWindSpeedKmph];
    [aCoder encodeObject:self.windspeedMiles    forKey: kWindSpeedMiles];
    [aCoder encodeObject:self.cloudcover        forKey: kCloudcover];
    [aCoder encodeObject:self.humidity          forKey: kHumidity];
    [aCoder encodeObject:self.pressure          forKey: kPressure];
    [aCoder encodeObject:self.observationTime   forKey: kObservationTime];
    [aCoder encodeObject:self.icon              forKey: kIcon];
    [aCoder encodeObject:self.weatherDictionary forKey: kDictionary];
}
@end