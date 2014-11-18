//
//  DateHelperClass.m
//  YY Task List
//
//  Created by ppl on 11/10/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import "DateHelperClass.h"

@implementation DateHelperClass

#define DATE_FORMAT @"yyyy-MM-dd HH:mm"

+ (NSDate *)dateFromString:(NSString *)string
{
    return [[self dateFormatter] dateFromString:string];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    return [[self dateFormatter] stringFromDate:date];
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    return dateFormatter;
}

@end
