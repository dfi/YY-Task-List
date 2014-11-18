//
//  DateHelperClass.h
//  YY Task List
//
//  Created by ppl on 11/10/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelperClass : NSObject

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;

@end