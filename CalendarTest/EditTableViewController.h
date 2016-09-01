//
//  EditTableViewController.h
//  CalendarTest
//
//  Created by Denis on 20.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EditTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *dateStartTextField;

@property BOOL ponedelnik;
@property BOOL vtornik;
@property BOOL sreda;
@property BOOL chetverg;
@property BOOL pyatnica;
@property BOOL subbota;
@property BOOL voskresenie;

@property (strong) NSManagedObject *contactdb;

@end
