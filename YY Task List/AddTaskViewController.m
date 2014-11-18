//
//  AddTaskViewController.m
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import "AddTaskViewController.h"
#import "DateHelperClass.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField.delegate = self;
    self.textView.delegate = self;
    
    self.dateLabel.text = [DateHelperClass stringFromDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
*/

#pragma mark - Buttons Pressed

- (IBAction)addButtonPressed:(UIButton *)sender
{
    [self.delegate addTask:[self newTask]];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

- (IBAction)datePickerScrolled:(UIDatePicker *)sender
{
    self.dateLabel.text = [DateHelperClass stringFromDate:sender.date];
}


#pragma mark - Helper Methods

- (YYTask *)newTask
{
    YYTask *newTask = [[YYTask alloc] init];
    newTask.title = self.textField.text;
    newTask.detail = self.textView.text;
    newTask.date = self.dateLabel.text;
    newTask.isCompleted = NO;
    
    return newTask;
}

#pragma mark - UITextFieldDelegate and UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
