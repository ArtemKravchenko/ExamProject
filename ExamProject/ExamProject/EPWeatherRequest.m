//
//  EPWeatherRequest.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPWeatherRequest.h"
#import "EPRequestQueue.h"
#import "SBJsonParser.h"
#import "EPWeatherModel.h"

@interface EPWeatherRequest ()

@property (nonatomic, retain) NSString* lat;
@property (nonatomic, retain) NSString* lon;

@end

@implementation EPWeatherRequest

-(void)main
{
    self.lat = [[NSUserDefaults standardUserDefaults] objectForKey:kRequestLat];
    self.lon = [[NSUserDefaults standardUserDefaults] objectForKey:kRequestLon];
    
    NSString *tmpRequestURL = kWeatherBaseURLJSONRequest;
    tmpRequestURL = [tmpRequestURL stringByReplacingOccurrencesOfString:kRequestLat withString:self.lat];
    tmpRequestURL = [tmpRequestURL stringByReplacingOccurrencesOfString:kRequestLon withString:self.lon];
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:tmpRequestURL]];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[EPRequestQueue queue].operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (self.delegate != nil)
         {
             if (error != nil)
             {
                 [self.delegate requestDidFinishFail:&error];
             }
             else
             {
                 Assert(data);
                 [self setDataModel:data];
                 [self.delegate requestDidFinishSuccessful];
             }
         }
     }];
}

- (void) setDataModel:(NSData*)responseData
{
    if(responseData != nil)
    {
        SBJsonParser *jsonParser = [[[SBJsonParser alloc] init] autorelease];
        NSMutableDictionary *weatherDictionary = [NSMutableDictionary dictionary];
        NSDictionary *data = [[jsonParser objectWithData:responseData] objectForKey:@"data"];
        
        NSDictionary *currentConditon = [data objectForKey:@"current_condition"][0];
        [weatherDictionary setObject:[currentConditon objectForKey:@"cloudcover"]           forKey:kCloudcover];
        [weatherDictionary setObject:[currentConditon objectForKey:@"humidity"]             forKey:kHumidity];
        [weatherDictionary setObject:[currentConditon objectForKey:@"observation_time"]     forKey:kObservationTime];
        [weatherDictionary setObject:[currentConditon objectForKey:@"pressure"]             forKey:kPressure];
        
        [weatherDictionary setObject:self.lat                                               forKey:kLat];
        [weatherDictionary setObject:self.lon                                               forKey:kLon];
        
        NSDictionary *weather = [data objectForKey:@"weather"][0];
        Assert(weather);
        [weatherDictionary setObject:[weather objectForKey:@"date"]                         forKey:kDate];
        [weatherDictionary setObject:[weather objectForKey:@"tempMaxC"]                     forKey:kTempMaxC];
        [weatherDictionary setObject:[weather objectForKey:@"tempMaxF"]                     forKey:kTempMaxF];
        [weatherDictionary setObject:[weather objectForKey:@"tempMinC"]                     forKey:kTempMinC];
        [weatherDictionary setObject:[weather objectForKey:@"tempMinF"]                     forKey:kTempMinF];
        [weatherDictionary setObject:[weather objectForKey:@"weatherDesc"][0][@"value"]     forKey:kWeatherDesc];
        [weatherDictionary setObject:[weather objectForKey:@"weatherIconUrl"][0][@"value"]  forKey:kIcon];
        [weatherDictionary setObject:[weather objectForKey:@"windspeedKmph"]                forKey:kWindSpeedKmph];
        [weatherDictionary setObject:[weather objectForKey:@"windspeedMiles"]               forKey:kWindSpeedMiles];
        
        [[EPWeatherModel share] setWeatherDictionary:weatherDictionary];
        [NSKeyedArchiver archiveRootObject:[EPWeatherModel share] toFile:[[EPWeatherModel share] dataFilePath]];
    }
}

-(void)dealloc
{
    self.lat = nil;
    self.lon = nil;
    self.delegate = nil;
    [super dealloc];
}
@end
