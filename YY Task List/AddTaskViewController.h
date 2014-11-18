//
//  AddTaskViewController.h
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTask.h"

@protocol AddTaskViewControllerDelegate <NSObject>

- (void)addTask:(YYTask *)task;
- (void)didCancel;

@end

@interface AddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;


- (IBAction)datePickerScrolled:(UIDatePicker *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
