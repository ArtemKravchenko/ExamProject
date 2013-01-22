//
//  NSDate+Format.h
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

+ (NSDate*)dateFromString:(NSString*)date;
- (NSString*)stringFromDate;

@end
