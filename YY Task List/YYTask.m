//
//  YYTask.m
//  YY Task List
//
//  Created by ppl on 11/12/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import "YYTask.h"

@implementation YYTask

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        self.title = data[TASK_TITLE];
        self.detail = data[TASK_DETAIL];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }
    
    return self;
}

- (id)init
{
    self = [self initWithData:nil];
    
    return self;
}

@end
