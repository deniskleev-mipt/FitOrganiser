//
//  EditTableViewController.m
//  CalendarTest
//
//  Created by Denis on 20.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//
#import "EditTableViewController.h"
#import "AppDelegate.h"

#import "AddTaskTableViewController.h"
#import <CoreData/CoreData.h>
#import "ReapeatViewController.h"


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD_PRO (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)

#import "EditTableViewController.h"

@interface EditTableViewController ()

@end

@implementation EditTableViewController {
    __weak IBOutlet UIImageView *back;
    __weak IBOutlet UITextField *nameTask;
    
    __weak IBOutlet UIButton *repbutton;

    UIDatePicker *datePicker;
    
    BOOL ponPressed;
    BOOL vtPressed;
    BOOL srPressed;
    BOOL chtPressed;
    BOOL pyatPressed;
    BOOL subPressed;
    BOOL voskrPressed;
    
    __weak IBOutlet UISwitch *switcher;
    
    __weak IBOutlet UIButton *ponButton;
    __weak IBOutlet UIButton *btButton;
    __weak IBOutlet UIButton *srButton;
    __weak IBOutlet UIButton *chtButton;
    __weak IBOutlet UIButton *pyatButton;
    __weak IBOutlet UIButton *subButton;
    __weak IBOutlet UIButton *vsButton;
    
    __weak IBOutlet UIView *whiteView;
    
    BOOL switcherZero;
}

- (IBAction)switchValueChanged:(id)sender {
    if (switcher.isOn == YES) {
        whiteView.hidden = NO;
        switcherZero = YES;
    }
    else
    {
        whiteView.hidden = YES;
    }
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void) showAlertView {
    UIAlertView *myAlertView= [[UIAlertView alloc]init];
    myAlertView.title= @"Выберите название задачи";
    [myAlertView addButtonWithTitle:@"OK"];
    [myAlertView show];
}


- (IBAction)doneClicked:(id)sender {
    
    NSLog(@"Значение понедельник = %d",_ponedelnik);
    
    if  ([nameTask.text  isEqual: @""])  {
        [self showAlertView];
        //return;
    }
    else {
        
        
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"EntityTask" inManagedObjectContext:context];
        
        [newDevice setValue: nameTask.text forKey:@"name"];
        
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"ponedelnik"];
        }
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"vtornik"];
        }
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"sreda"];
        }
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"chetverg"];
        }
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"pyatnica"];
        }
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"subbota"];
        }
        
        if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie  isEqual: @"YES"]) {
            [newDevice setValue:@"YES" forKey:@"voskresenie"];
        }
        
        
        
        
        
        
        
        [newDevice setValue:_dateStartTextField.text forKey:@"dateStart"]; // 11.1.2011
        
        // [newDevice setValue:string forKey:@"dayStart"];
        // [newDevice setValue:string forKey:@"monthStart"];
        // [newDevice setValue:string forKey:@"yearStart"];
        // poned
        // vt
        
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DoUpdateTableView" object:nil userInfo:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

-(void)dismissKeyboard {
    [nameTask resignFirstResponder];
    [_dateStartTextField resignFirstResponder];
}

- (IBAction)datePickerValueChanged:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:@"dd.M.yyyy"];
    
    self.dateStartTextField.text = [dateFormat stringFromDate:[datePicker date]];
    [self.dateStartTextField resignFirstResponder];
}

- (void) updateR {
    
    NSLog(@"updateR");
    
    NSString *asd = @"";
    
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik  isEqual: @"YES"]) {
        asd =[asd stringByAppendingString:@"Пн "];
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik  isEqual: @"YES"]) {
        asd =[asd stringByAppendingString:@"Вт "];
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda  isEqual: @"YES"]) {
        asd =[asd stringByAppendingString:@"Ср "];
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg  isEqual: @"YES"]) {
        asd= [asd stringByAppendingString:@"Чт "];
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica  isEqual: @"YES"]) {
        asd= [asd stringByAppendingString:@"Пт "];
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota  isEqual: @"YES"]) {
        asd =[asd stringByAppendingString:@"Сб "];
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie  isEqual: @"YES"]) {
        asd= [asd stringByAppendingString:@"Вс "];
    }
    
    if ([asd  isEqual: @""]) {
        asd = @"Не повторять";
    }
    
    [repbutton setTitle:asd forState:UIControlStateNormal];
}

-(IBAction)deleteClicked:(id)sender {
    
    NSManagedObject *selectedDevice = self.contactdb;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [context deleteObject:self.contactdb];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoUpdateTableView" object:nil userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveClicked:(id)sender {
    NSManagedObject *selectedDevice = self.contactdb;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Update existing device
    
    [selectedDevice setValue:nameTask.text forKey:@"name"];
    
    
    [selectedDevice setValue:@"NO" forKey:@"ponedelnik"];
    [selectedDevice setValue:@"NO" forKey:@"vtornik"];
    [selectedDevice setValue:@"NO" forKey:@"sreda"];
    [selectedDevice setValue:@"NO" forKey:@"chetverg"];
    [selectedDevice setValue:@"NO" forKey:@"pyatnica"];
    [selectedDevice setValue:@"NO" forKey:@"subbota"];
    [selectedDevice setValue:@"NO" forKey:@"voskresenie"];
    
    if (!switcherZero) {
        if (ponPressed) {
            [selectedDevice setValue:@"YES" forKey:@"ponedelnik"];
        }
        if (vtPressed) {
            [selectedDevice setValue:@"YES" forKey:@"vtornik"];
        }
        if (srPressed) {
            [selectedDevice setValue:@"YES" forKey:@"sreda"];
        }
        if (chtPressed) {
            [selectedDevice setValue:@"YES" forKey:@"chetverg"];
        }
        if (pyatPressed) {
            [selectedDevice setValue:@"YES" forKey:@"pyatnica"];
        }
        if (subPressed) {
            [selectedDevice setValue:@"YES" forKey:@"subbota"];
        }
        if (voskrPressed) {
            [selectedDevice setValue:@"YES" forKey:@"voskresenie"];
        }
    }
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoUpdateTableView" object:nil userInfo:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    //self.tabBarController.tabBar.backgroundColor = [UIColor whiteColor];
    
    [self daysBorders];
    
    ponPressed = NO;
    vtPressed = NO;
    srPressed = NO;
    chtPressed = NO;
    pyatPressed = NO;
    subPressed = NO;
    voskrPressed = NO;
    
    
    // filling  empty gaps
    if (self.contactdb) {
        [nameTask setText:[self.contactdb valueForKey:@"name"]];
        
        
        BOOL noDays = YES;
        
        if ([[self.contactdb valueForKey:@"ponedelnik"]  isEqual: @"YES"]) {
            [self ponedelnik:nil];
            ponPressed = YES;
            noDays = NO;
        }
        if ([[self.contactdb valueForKey:@"vtornik"]  isEqual: @"YES"]) {
            [self vtornik:nil];
            vtPressed = YES;
            noDays = NO;
        }
        if ([[self.contactdb valueForKey:@"sreda"]  isEqual: @"YES"]) {
            [self sreda:nil];
            srPressed = YES;
            noDays = NO;
        }
        if ([[self.contactdb valueForKey:@"chetverg"]  isEqual: @"YES"]) {
            [self chetverg:nil];
            chtPressed = YES;
            noDays = NO;
        }
        if ([[self.contactdb valueForKey:@"pyatnica"]  isEqual: @"YES"]) {
            [self pyatnica:nil];
            pyatPressed = YES;
            noDays = NO;
        }
        if ([[self.contactdb valueForKey:@"subbota"]  isEqual: @"YES"]) {
            [self subbota:nil];
            subPressed = YES;
            noDays = NO;
        }
        if ([[self.contactdb valueForKey:@"voskresenie"]  isEqual: @"YES"]) {
            [self voskresenie:nil];
            voskrPressed = YES;
            noDays = NO;
        }
        
        if (noDays) {
            [switcher setOn:YES];
            whiteView.hidden = NO;
        }
        
    }
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateR) name:@"UpdateRLabel" object:nil];
    
    
    // обнуляем все дни недели
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik = @"NO";
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik = @"NO";
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda = @"NO";
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg = @"NO";
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica = @"NO";
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota = @"NO";
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie = @"NO";
    
    
    
    //////////////////////
    
    
    
    
    
    ///////////////////////
    
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)day, (long)week, (long)year];
    
    _dateStartTextField.text = string;
    
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.tag = 11;
    self.dateStartTextField.inputView = datePicker;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    back.layer.cornerRadius = 16.0;
    back.layer.masksToBounds = YES;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"RobotoCondensed-Regular" size:18.0f], NSFontAttributeName,
                                                                     [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1], NSForegroundColorAttributeName,
                                                                     nil, nil,nil]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

/*
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (indexPath.section == 0) {
 return;
 }
 
 if ([cell respondsToSelector:@selector(tintColor)]) {
 if (tableView == self.tableView) {    // self.tableview
 CGFloat cornerRadius = 15.f;
 cell.backgroundColor = UIColor.clearColor;
 CAShapeLayer *layer = [[CAShapeLayer alloc] init];
 CGMutablePathRef pathRef = CGPathCreateMutable();
 CGRect bounds = CGRectInset(cell.bounds, 0, 0);
 BOOL addLine = NO;
 if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
 CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
 } else if (indexPath.row == 0) {
 CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
 CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
 CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
 addLine = YES;
 } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
 CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
 CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
 CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
 CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
 } else {
 CGPathAddRect(pathRef, nil, bounds);
 addLine = YES;
 }
 layer.path = pathRef;
 CFRelease(pathRef);
 layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
 
 if (addLine == YES) {
 CALayer *lineLayer = [[CALayer alloc] init];
 CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
 lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+5, bounds.size.height-lineHeight, bounds.size.width-5, lineHeight);
 lineLayer.backgroundColor = tableView.separatorColor.CGColor;
 [layer addSublayer:lineLayer];
 }
 UIView *testView = [[UIView alloc] initWithFrame:bounds];
 [testView.layer insertSublayer:layer atIndex:0];
 testView.backgroundColor = UIColor.clearColor;
 cell.backgroundView = testView;
 }
 }
 }
 */

- (IBAction)ponedelnik:(id)sender {
    
    
    if (ponPressed == NO) {
        
        ponPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik = @"YES";
        
        [ponButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ponButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (ponPressed == YES){
        
        ponPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik = @"NO";
        
        [ponButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        ponButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
    
}

- (IBAction)vtornik:(id)sender {
    if (vtPressed == NO) {
        
        vtPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik = @"YES";
        
        [btButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (vtPressed == YES) {
        
        vtPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik = @"NO";
        
        [btButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        btButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)sreda:(id)sender {
    if (srPressed == NO) {
        
        srPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda = @"YES";
        
        [srButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        srButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (srPressed == YES){
        
        srPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda = @"NO";
        
        [srButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        srButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
    
}

- (IBAction)chetverg:(id)sender {
    if (chtPressed == NO) {
        
        chtPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg = @"YES";
        
        [chtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        chtButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (chtPressed == YES) {
        
        chtPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg = @"NO";
        
        [chtButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        chtButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)pyatnica:(id)sender {
    if (pyatPressed == NO) {
        
        pyatPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica = @"YES";
        
        [pyatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        pyatButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (pyatPressed == YES){
        
        pyatPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica = @"NO";
        
        [pyatButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        pyatButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)subbota:(id)sender {
    if (subPressed == NO) {
        
        subPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota = @"YES";
        
        [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        subButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (subPressed == YES){
        
        subPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota = @"NO";
        
        [subButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        subButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)voskresenie:(id)sender {
    if (voskrPressed == NO) {
        
        voskrPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie = @"YES";
        
        [vsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        vsButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (voskrPressed == YES){
        
        voskrPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie = @"NO";
        
        [vsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        vsButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}



- (void) daysBorders {
    
    ponButton.layer.cornerRadius = 11.0;
    ponButton.layer.masksToBounds = YES;
    ponButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    ponButton.layer.borderWidth = 1.5;
    
    //
    
    btButton.layer.cornerRadius = 11.0;
    btButton.layer.masksToBounds = YES;
    btButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    btButton.layer.borderWidth = 1.5;
    
    //
    
    srButton.layer.cornerRadius = 11.0;
    srButton.layer.masksToBounds = YES;
    srButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    srButton.layer.borderWidth = 1.5;
    
    chtButton.layer.cornerRadius = 11.0;
    chtButton.layer.masksToBounds = YES;
    chtButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    chtButton.layer.borderWidth = 1.5;
    
    pyatButton.layer.cornerRadius = 11.0;
    pyatButton.layer.masksToBounds = YES;
    pyatButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    pyatButton.layer.borderWidth = 1.5;
    
    subButton.layer.cornerRadius = 11.0;
    subButton.layer.masksToBounds = YES;
    subButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    subButton.layer.borderWidth = 1.5;
    
    vsButton.layer.cornerRadius = 11.0;
    vsButton.layer.masksToBounds = YES;
    vsButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    vsButton.layer.borderWidth = 1.5;
    
    
    
}

@end
