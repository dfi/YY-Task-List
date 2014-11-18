//
//  EditTaskViewController.h
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTask.h"

@protocol EditTaskViewControllerDelegate <NSObject>

- (void)didEditTask;

@end

@interface EditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) YYTask *task;

@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)datePickerScrolled:(UIDatePicker *)sender;
- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;

@end
