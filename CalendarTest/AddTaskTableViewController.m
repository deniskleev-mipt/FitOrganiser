//
//  AddTaskTableViewController.m
//  CalendarTest
//
//  Created by Denis on 06.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "AddTaskTableViewController.h"
#import <CoreData/CoreData.h>
#import "ReapeatViewController.h"
#import "AppDelegate.h"

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

@interface AddTaskTableViewController ()

@end

@implementation AddTaskTableViewController {
    __weak IBOutlet UIImageView *back;
    __weak IBOutlet UITextField *nameTask;
    
    __weak IBOutlet UIButton *repbutton;
    /*
    BOOL ponedelnik;
    BOOL vtornik;
    BOOL sreda;
    BOOL chetverg;
    BOOL pyatnica;
    BOOL subbota;
    BOOL voskresenie;
    */
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    
    __weak IBOutlet UISegmentedControl *segm;
    BOOL defautSection;
    __weak IBOutlet UITextField *timeTextField;
    
    UIToolbar *keyboardToolbar;
    UIToolbar *keyboardToolbar1;
}

- (IBAction)segmValueChanged:(id)sender {
    if (segm.selectedSegmentIndex == 1) {
        defautSection = NO;
    }
    else {
        defautSection  = YES;
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        if (defautSection) {
            return 5;
        } else return 0;
    } else if (section == 2) {
        if (defautSection) {
            return 0;
        } else return 17;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
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
        
    [newDevice setValue:timeTextField.text forKey:@"timeStart"];
    
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
    [timeTextField resignFirstResponder];
}

- (IBAction)datePickerValueChanged:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:@"dd.M.yyyy"];
    
    self.dateStartTextField.text = [dateFormat stringFromDate:[datePicker date]];
    [self.dateStartTextField resignFirstResponder];
}

//timePickerValueChanged

- (IBAction)timePickerValueChanged:(id)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormat setDateFormat:@"HH:mm"];
    
    timeTextField.text = [dateFormat stringFromDate:[timePicker date]];
    [timeTextField resignFirstResponder];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defautSection = YES;
    
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
    //[datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.tag = 11;
    self.dateStartTextField.inputView = datePicker;
    
    timePicker = [[UIDatePicker alloc] init];
    timePicker.datePickerMode = UIDatePickerModeTime;
    //v[timePicker addTarget:self action:@selector(timePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    timePicker.tag = 12;
    timeTextField.inputView = timePicker;
    
    [timePicker setDate:[NSDate date]];
    [self timePickerValueChanged:nil];
    
    /**/
    keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [keyboardToolbar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"Выбрать дату" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerValueChanged:)];
    
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, next, nil]];

    self.dateStartTextField.inputAccessoryView = keyboardToolbar;
    /**/
    
    /**/
    keyboardToolbar1 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [keyboardToolbar1 setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *extraSpace1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *next1 = [[UIBarButtonItem alloc] initWithTitle:@"Выбрать время" style:UIBarButtonItemStyleDone target:self action:@selector(timePickerValueChanged:)];
    
    [keyboardToolbar1 setItems:[[NSArray alloc] initWithObjects: extraSpace1, next1, nil]];
    
    timeTextField.inputAccessoryView = keyboardToolbar1;
    /**/
    
    
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



- (IBAction)ponedelnik:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik = @"YES";
}

- (IBAction)vtornik:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik = @"YES";
}

- (IBAction)sreda:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda = @"YES";
}

- (IBAction)chetverg:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg = @"YES";
}

- (IBAction)pyatnica:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica = @"YES";
}

- (IBAction)subbota:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota = @"YES";
}

- (IBAction)voskresenie:(id)sender {
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie = @"YES";
}


- (IBAction)showReapeatWindow:(id)sender {
    ReapeatViewController *vc;
    if (IS_IPHONE_4_OR_LESS) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RepeatiPhone4"];
    }
    else if (IS_IPHONE_5) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RepeatiPhone5"];
    }
    else if (IS_IPHONE_6) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RepeatiPhone6"];
    }
    else if (IS_IPHONE_6P) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RepeatiPhone6Plus"];
    }
    else if ((IS_IPAD) || (IS_IPAD_PRO)) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RepeatiPad"];
    }
    
    
    //[self presentModalViewController:vc animated:YES];
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentModalViewController:vc animated:YES];
}

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
                lineLayer.backgroundColor = [UIColor clearColor].CGColor;//tableView.separatorColor.CGColor;
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

- (IBAction)vkClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.vk.com"]];
}

- (IBAction)fbClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 10;
    else
        return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section:(NSInteger)section {

    return 0.01;
}

@end
