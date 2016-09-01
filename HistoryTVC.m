//
//  HistoryTVC.m
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "HistoryTVC.h"
#import "MyCell.h"

@interface HistoryTVC ()

@end

@implementation HistoryTVC


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
        CGFloat result = [[[self.contactArray objectAtIndex:indexPath.row] valueForKey:@"weight"] intValue] - [[[self.contactArray objectAtIndex:indexPath.row-1] valueForKey:@"weight"] intValue];
        
        if (result > 0) {
            cell.delta.text = [NSString stringWithFormat:@"+%ld",(long)result];
        }
        else
            cell.delta.text = [NSString stringWithFormat:@"%ld",(long)result];
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
