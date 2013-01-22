//
//  EPWeatherTracker.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPWeatherTracker.h"
#import "EPWeatherModel.h"
#import "EPRequestQueue.h"
#import "NSDate+Format.h"

static EPWeatherTracker* weatherTraker = nil;
static dispatch_once_t predicate;

@interface EPWeatherTracker ()

@property (nonatomic, retain) EPWeatherRequest *request;
@property (nonatomic, readwrite, retain) NSTimer* systemTimer;
@property (nonatomic, retain) NSString* lastLat;
@property (nonatomic, retain) NSString* lastLon;
@property (nonatomic, retain) NSString* lastTime;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@implementation EPWeatherTracker

- (id)initData
{
    if (self= [super init])
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WeatherTrackerData" ofType:@"plist"];
        NSDictionary *tmpDictionary = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
        
        self.lastLat = tmpDictionary[@"LastLat"];
        self.lastLon = tmpDictionary[@"LastLon"];
        self.lastTime = tmpDictionary[@"LastTime"];
    }
    return self;
}

+(EPWeatherTracker*)share
{
    if (self == [EPWeatherTracker class])
    {
        dispatch_once( &predicate, ^
                      {
                          weatherTraker = [ [ self alloc ] initData ];
                      } );
    }
    return weatherTraker;
}

- (void) enable
{
    NSDate * currentDate = [NSDate date];
    self.lastLat = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
    self.lastLon = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults]setObject:self.lastLat forKey:kRequestLat];
    [[NSUserDefaults standardUserDefaults]setObject:self.lastLon forKey:kRequestLon];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[[EPWeatherModel share] dataFilePath]])
    {
        unsigned int unitFlags = NSHourCalendarUnit;
        NSDateComponents *breakdownInfo = [[NSCalendar currentCalendar] components:unitFlags fromDate:currentDate  toDate:[NSDate dateFromString:self.lastTime]  options:0];
        if ([breakdownInfo hour] > 0)
        {
            self.lastTime = [currentDate stringFromDate];
            [self makeRequest];
        }
        else
        {
            EPWeatherModel* obj = [NSKeyedUnarchiver unarchiveObjectWithFile:[[EPWeatherModel share] dataFilePath]];
            Assert(obj);
            [[EPWeatherModel share]setWeatherDictionary:obj.weatherDictionary];
            [self.delegate modelCompletedInitialize];
        }
    }
    else
    {
        [self startUpdating];
    }
}

- (void)makeRequest
{
    self.request = [[EPWeatherRequest new] autorelease];
    self.request.delegate = self;
    [[EPRequestQueue queue] addRequest:self.request];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.lastLat = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    self.lastLon = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    self.lastTime = [[NSDate date] stringFromDate];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.lastLat forKey:kRequestLat];
    [[NSUserDefaults standardUserDefaults]setObject:self.lastLon forKey:kRequestLon];
    
    [self writeToPlist];
    
    [self makeRequest];
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
}

- (void) writeToPlist
{
    NSString* plistPath = nil;
    NSFileManager* manager = [NSFileManager defaultManager];
    if ((plistPath = [[NSBundle mainBundle] pathForResource:@"WeatherTrackerData" ofType:@"plist"]))
    {
        if ([manager isWritableFileAtPath:plistPath])
        {
            NSMutableDictionary* infoDict = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
            [infoDict setObject:self.lastLat forKey:@"LastLat"];
            [infoDict setObject:self.lastLon forKey:@"LastLon"];
            [infoDict setObject:self.lastTime forKey:@"LastTime"];
            [infoDict writeToFile:plistPath atomically:YES];
        }
    }
}

#pragma mark - Weather request delegate

- (void) requestDidFinishSuccessful
{
    [self.delegate modelCompletedInitialize];
}

- (void) requestDidFinishFail:(NSError**)error
{
    
}

- (void)startUpdating
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    [self.locationManager startUpdatingLocation];
}

-(void)dealloc
{
    self.lastLat = nil;
    self.lastLon = nil;
    self.lastTime = nil;
    self.request = nil;
    self.locationManager = nil;
    [super dealloc];
}

@end
