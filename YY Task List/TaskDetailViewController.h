//
//  TaskDetailViewController.h
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTask.h"
#import "EditTaskViewController.h"

@protocol TaskDetailViewControllerDelegate <NSObject>

- (void)updateTask;

@end

@interface TaskDetailViewController : UIViewController <EditTaskViewControllerDelegate>

@property (strong, nonatomic) YYTask *task;

@property (weak, nonatomic) id <TaskDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *completionLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
