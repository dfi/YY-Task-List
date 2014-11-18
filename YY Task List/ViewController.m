//
//  ViewController.m
//  YY Task List
//
//  Created by ppl on 11/8/14.
//  Copyright (c) 2014 yyl. All rights reserved.
//

#import "ViewController.h"
#import "TaskDetailViewController.h"
#import "DateHelperClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSMutableArray *)tasksArray
{
    if (!_tasksArray) {
        _tasksArray = [[NSMutableArray alloc] init];
    }
    return _tasksArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK];
    for (NSDictionary *dictionary in tasksAsPropertyLists) {
        YYTask *task = [self taskFromDictionary:dictionary];
        [self.tasksArray addObject:task];
    }
    
    [self updateEditBarButtonItemStateAndTableViewEditingMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Configure the tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasksArray count];
}

- tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    YYTask *task = self.tasksArray[indexPath.row];
    cell.textLabel.text = task.title;
    cell.detailTextLabel.text = task.date;
    
    BOOL isOverDue = [self isOneDate:[NSDate date] greaterThanAnotherDate:[DateHelperClass dateFromString:task.date]];
    if (task.isCompleted) cell.backgroundColor = [UIColor greenColor];
    else if (isOverDue) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
  
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView isEditing]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableView isEditing]) {
        return YES;
    } else {
        return NO;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasksArray removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTasksArray = [[NSMutableArray alloc] init];
        for (YYTask *task in self.tasksArray) [newTasksArray addObject:[self taskAsPropertyList:task]];
        [[NSUserDefaults standardUserDefaults] setObject:newTasksArray forKey:ADDED_TASK];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    if (!self.tasksArray.count) {
        [self updateEditBarButtonItemStateAndTableViewEditingMode];
    }
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.tasksArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    [self saveTasks];
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTaskDetailViewController" sender:indexPath];
}


// Add Checkmark
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    if (cell.accessoryType == UITableViewCellAccessoryNone) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        
//
//        
//    } else if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        
//        
//    }
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYTask *task = self.tasksArray[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *addTackVC = segue.destinationViewController;
        addTackVC.delegate = self;
    }
    
    else if ([segue.destinationViewController isKindOfClass:[TaskDetailViewController class]]) {
        TaskDetailViewController *taskDetailVC = segue.destinationViewController;
        NSIndexPath *path = sender;
        YYTask *task = self.tasksArray[path.row];
        taskDetailVC.task = task;
        taskDetailVC.delegate = self;
    }
}

#pragma mark - Buttons pressed

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:sender];
}

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender
{
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        self.editBarButtonItem.title = @"编辑";
    } else {
        [self.tableView setEditing:YES animated:YES];
        self.editBarButtonItem.title = @"锁定";
    }
}

#pragma mark - AddTaskViewController Delegate

- (void)addTask:(YYTask *)task
{
    
    [self.tasksArray insertObject:task atIndex:0];
    
    NSMutableArray *tasksArrayAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK] mutableCopy];
    if (!tasksArrayAsPropertyLists) tasksArrayAsPropertyLists = [[NSMutableArray alloc] init];
    [tasksArrayAsPropertyLists addObject:[self taskAsPropertyList:task]];
    NSArray *reversedTasksArrayAsPropertyLists = [[tasksArrayAsPropertyLists reverseObjectEnumerator] allObjects];
    [[NSUserDefaults standardUserDefaults] setObject:reversedTasksArrayAsPropertyLists forKey:ADDED_TASK];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];

    [self updateEditBarButtonItemStateAndTableViewEditingMode];
}

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self updateEditBarButtonItemStateAndTableViewEditingMode];
}

#pragma mark - TaskDetailViewController Delegate

- (void)updateTask
{
    [self saveTasks];
    
    [self.tableView reloadData];
    
    [self updateEditBarButtonItemStateAndTableViewEditingMode];
}

#pragma mark - helper method

- (NSDictionary *)taskAsPropertyList:(YYTask *)task
{
    NSDictionary *dictionary = @{TASK_TITLE : task.title,
                                 TASK_DETAIL : task.detail,
                                 TASK_DATE : task.date,
                                 TASK_COMPLETION : @(task.isCompleted)};
    return dictionary;
}

- (YYTask *)taskFromDictionary:(NSDictionary *)dictionary
{
    YYTask *task = [[YYTask alloc] initWithData:dictionary];
    return task;
}

- (void)saveTasks
{
    NSMutableArray *tasksAsPropertyLists = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.tasksArray.count; i++) {
        [tasksAsPropertyLists addObject:[self taskAsPropertyList:self.tasksArray[i]]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:ADDED_TASK];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isOneDate:(NSDate *)oneDate greaterThanAnotherDate:(NSDate *)anotherDate
{
    NSTimeInterval oneDateTimeInterval = [oneDate timeIntervalSinceNow];
    NSTimeInterval anotherDateTimeInterval = [anotherDate timeIntervalSinceNow];
    if (oneDateTimeInterval > anotherDateTimeInterval) return YES;
    else return NO;
}

- (void)updateEditBarButtonItemStateAndTableViewEditingMode
{
    if (self.tasksArray.count) {
        [self.editBarButtonItem setTitle:@"编辑"];
        [self.editBarButtonItem setEnabled:YES];
    } else {
        [self.editBarButtonItem setTitle:@""];
        [self.editBarButtonItem setEnabled:NO];
    }
    
    [self.tableView setEditing:NO];
}

- (void)updateCompletionOfTask:(YYTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK] mutableCopy];
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc] init];
    
    if (task.isCompleted) task.isCompleted = NO;
    else task.isCompleted = YES;

    [tasksAsPropertyLists replaceObjectAtIndex:indexPath.row withObject:[self taskAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:ADDED_TASK];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

@end
