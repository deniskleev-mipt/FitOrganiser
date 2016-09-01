//
//  ProfileTVC.m
//  Fitness
//
//  Created by Denis on 26.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "ProfileTVC.h"

#import "AddWeightViewController.h"

#import "EmptyViewController.h"

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

@interface ProfileTVC ()

@end

@implementation ProfileTVC {
    
    __weak IBOutlet UIImageView *backW;
    __weak IBOutlet UIImageView *back2;
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)shareClicked:(id)sender {
    NSString *shareText = @"Тут будет график";
    NSArray *itemsToShare = @[shareText];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage, UIActivityTypeMail];
    
    
    //  [self presentViewController:activityVC animated:YES completion:nil];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityVC animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityVC];
        [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}


- (void) updateMe {
    NSLog(@"updateMe");


    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Entity"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    NSInteger min = 0, max = 0;
    
    if (self.contactArray.count == 0) {
        return;
    }
    for (int i = 1; i < self.contactArray.count; i++) {
        if ([[self.contactArray[i] valueForKey:@"weight"] intValue] < [[self.contactArray[min] valueForKey:@"weight"] intValue]) {
            min  = i;
        }
        
        if ([[self.contactArray[i] valueForKey:@"weight"] intValue] > [[self.contactArray[max] valueForKey:@"weight"] intValue]) {
            max  = i;
        }
    }
    
    self.minLabel.text = [self.contactArray[min] valueForKey:@"weight"];
    self.maxLabel.text = [self.contactArray[max] valueForKey:@"weight"];
    
    self.weight.text =[self.contactArray.lastObject valueForKey:@"weight"];
    
    
    if (self.contactArray.count > 1) {
        int result = [[self.contactArray.lastObject valueForKey:@"weight"] intValue] - [[self.contactArray[self.contactArray.count - 2] valueForKey:@"weight"] intValue];
        
        if (result > 0) {
            self.currentDelta.text = [NSString stringWithFormat:@"+%d",result];
        }
        self.currentDelta.text = [NSString stringWithFormat:@"%d",result];
    }


}

- (void) updateLabel {
    [self updateMe];
}

- (void) viewDidAppear:(BOOL)animated {
    [self updateMe];
}
 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"DoUpdateLabel" object:nil];
    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Entity"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    [self updateMe];
    
    
    NSLog(@"count = %lu",(unsigned long)self.contactArray.count);
    
    for (int i = 0; i < self.contactArray.count; i++) {
        NSLog(@"%@ ; %@",[self.contactArray[i] valueForKey:@"weight"],[self.contactArray[i] valueForKey:@"date"]);
    }

    
    
    backW.layer.cornerRadius = 7.0;
    backW.layer.masksToBounds = YES;
    
    back2.layer.cornerRadius = 7.0;
    back2.layer.masksToBounds = YES;
    back2.layer.borderColor = [UIColor colorWithRed:(64/255.0) green:(98/255.0) blue:(138/255.0) alpha:0.4].CGColor;
    back2.layer.borderWidth = 2.0;
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"Roboto-Regular" size:21.0f], NSFontAttributeName,
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

- (IBAction)addWeight:(id)sender {
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

   // vc.providesPresentationContextTransitionStyle = YES;
   // vc.definesPresentationContext = YES;
  //  [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    
   // [self presentViewController:vc animated:YES completion:nil];
 //   [self presentModalViewController:vc animated:YES];
    
    
}

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

@end
