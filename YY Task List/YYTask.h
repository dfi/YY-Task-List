//
//  YYTask.h
//  YY Task List
//
//  Created by ppl on 11/12/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYTask : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *date; //date string
@property (nonatomic) BOOL isCompleted;

- (id)initWithData:(NSDictionary *)data;

@end
