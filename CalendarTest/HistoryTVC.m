//
//  HistoryTVC.m
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "HistoryTVC.h"
#import "MyCell.h"
#import "AppDelegate.h"
#import "AddWeightViewController.h"

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

@interface HistoryTVC ()

@end

@implementation HistoryTVC {
}


-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // Navigation button was pressed. Do some stuff
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DoUpdateLabel" object:nil userInfo:nil];

        
        
        [self.navigationController popViewControllerAnimated:NO];
    }
    [super viewWillDisappear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingRow) name:@"updateTV" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableDesel) name:@"closeandComeToHistory" object:nil];
    
    //tableDesel
    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Entity"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    
    /**/
    
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"RobotoCondensed-Regular" size:21.0f], NSFontAttributeName,
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).lastweight = [self.contactArray[indexPath.row] valueForKey:@"weight"];
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).toEdit = @"YES";
    //[self editingRow];
    // show edit window
    
    AddWeightViewController *vc;
    if (IS_IPHONE_4_OR_LESS) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddWeightViewControlleriPhone4"];
    }
    else if (IS_IPHONE_5) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddWeightViewControlleriPhone5"];
    }
    else if (IS_IPHONE_6) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddWeightViewControlleriPhone6"];
    }
    else if (IS_IPHONE_6P) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddWeightViewControlleriPhone6Plus"];
    }
    else if ((IS_IPAD) || (IS_IPAD_PRO)) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddWeightViewControlleriPad"];
    }
    
    
    //[self presentModalViewController:vc animated:YES];
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentModalViewController:vc animated:YES];
}

- (void) tableDesel {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void) editingRow {
    
    NSInteger *integerS = [[self.tableView indexPathForSelectedRow] row];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).toEdit = @"NO";
    
    //NSManagedObject *selectedDevice = [self.contactArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    //integerS
    NSManagedObject *selectedDevice = [self.contactArray objectAtIndex:integerS];

    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Update existing device
    
    
    
    [selectedDevice setValue:((AppDelegate*)[[UIApplication sharedApplication] delegate]).toChangeExistingWeight forKey:@"weight"];
    
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    
    
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactArray.count;

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
        cell.weight.text = [NSString stringWithFormat:@"%@", [[self.contactArray objectAtIndex:indexPath.row] valueForKey:@"weight"]];
        cell.ddmm.text = [NSString stringWithFormat:@"%@", [[self.contactArray objectAtIndex:indexPath.row] valueForKey:@"date"]];
    
    if ((self.contactArray.count == 1) ||  (indexPath.row == 0)){
        cell.delta.text = @"0";
    }
    else {
        float result = [[[self.contactArray objectAtIndex:indexPath.row] valueForKey:@"weight"] floatValue] - [[[self.contactArray objectAtIndex:indexPath.row-1] valueForKey:@"weight"] floatValue];
        
        if (result > 0) {
            cell.delta.text = [NSString stringWithFormat:@"+%0.1f",result];
        }
        else
            cell.delta.text = [NSString stringWithFormat:@"%0.1f",result];
    }
    
    
    
    NSString *dateString = [[self.contactArray objectAtIndex:indexPath.row] valueForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:dateString];
    
    NSDate *date = dateFromString;
   // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *dayName = [dateFormatter stringFromDate:date];
    
    
    cell.dayName.text = dayName;//[NSString stringWithFormat:@"%ld",(long)day];
    
    
    

    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    
            // Delete object from database
            [context deleteObject:[self.contactArray objectAtIndex:indexPath.row]];
            
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
                return;
            }
            
            // Remove device from table view
            [self.contactArray removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Удалить";
}

@end
