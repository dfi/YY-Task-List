//
//  EditTaskViewController.m
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import "EditTaskViewController.h"
#import "DateHelperClass.h"

@interface EditTaskViewController ()

@end


@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.textField.text = self.task.title;
    self.textView.text = self.task.detail;
    self.dateLabel.text = self.task.date;
    [self.datePicker setDate:[DateHelperClass dateFromString:self.dateLabel.text]];
    
    self.textField.delegate = self;
    self.textView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)datePickerScrolled:(UIDatePicker *)sender
{
    self.dateLabel.text = [DateHelperClass stringFromDate:sender.date];
}

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender
{
    [self editTask];
    [self.delegate didEditTask];
}

#pragma mark - Helper Methods

- (void)editTask
{
    self.task.title = self.textField.text;
    self.task.detail = self.textView.text;
    self.task.date = self.dateLabel.text;
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
