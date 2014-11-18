//
//  ViewController.h
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "TaskDetailViewController.h"

@interface ViewController : UIViewController <AddTaskViewControllerDelegate, TaskDetailViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButtonItem;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tasksArray;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

