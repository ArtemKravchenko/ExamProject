//
//  NSDate+Format.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "NSDate+Format.h"

NSString* const kDateFormat = @"hh:mm:ss";

@implementation NSDate (Format)

+ (NSDate*)dateFromString:(NSString*)date
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:kDateFormat];
    return [dateFormatter dateFromString:date];
}

- (NSString*)stringFromDate
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:kDateFormat];
    return [dateFormatter stringFromDate:self];
}

@end
