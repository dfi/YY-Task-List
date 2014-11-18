//
//  TaskDetailViewController.m
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()

@end

@implementation TaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.detail;
    self.dateLabel.text = self.task.date;
    if (self.task.isCompleted) self.completionLabel.text = @"已完成";
    else self.completionLabel.text = @"未完成";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]) {
        EditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
    }
}

#pragma mark - Buttons Pressed

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:sender];
//    UIStoryboard *sb = self.storyboard;
//    EditTaskViewController *etVC = [sb instantiateViewControllerWithIdentifier:@"EditTaskViewControllerStoryboard"];
//    [self.navigationController pushViewController:etVC animated:NO];
}

#pragma mark - EditTaskViewController Delegate

- (void)didEditTask
{
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.detail;
    self.dateLabel.text = self.task.date;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
}

@end
