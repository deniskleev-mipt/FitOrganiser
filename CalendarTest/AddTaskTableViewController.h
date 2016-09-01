//
//  AddTaskTableViewController.h
//  CalendarTest
//
//  Created by Denis on 06.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskTableViewController : UITableViewController


@property BOOL ponedelnik;
@property BOOL vtornik;
@property BOOL sreda;
@property BOOL chetverg;
@property BOOL pyatnica;
@property BOOL subbota;
@property BOOL voskresenie;

@property (weak, nonatomic) IBOutlet UITextField *dateStartTextField;



@end
