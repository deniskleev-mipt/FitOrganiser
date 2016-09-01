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
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SharePopupViewController.h"
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

@interface ProfileTVC ()

@end

@implementation ProfileTVC {
    
    __weak IBOutlet BEMSimpleLineGraphView *myGraph;
    
    __weak IBOutlet UIImageView *backW;
    __weak IBOutlet UIImageView *back2;
    
    __weak IBOutlet UITableViewCell *firstCell;
    
    UIImage *imageOfGraph;
    __weak IBOutlet UIButton *shareButton;
    
    
    
    __weak IBOutlet UITableViewCell *cellZaglushka;
    __weak IBOutlet UITableViewCell *cellWithGraph;
}

- (IBAction)createGraph:(id)sender {
    [self addWeight:nil];
}

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return self.contactArray.count; // Number of points in the graph.
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.contactArray[index] valueForKey:@"weight"] floatValue];
}


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (void)lineGraphDidFinishDrawing:(BEMSimpleLineGraphView *)graph {
    // Update any interface elements that rely on a full rendered graph
    imageOfGraph = [myGraph graphSnapshotImage];
    shareButton.enabled=YES;
}

-(UIImage *)createSnapShotImagesFromUIview
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(myGraph.frame.size.width,myGraph.frame.size.height), NO, 0);
    //UIGraphicsBeginImageContext(CGSizeMake(myGraph.frame.size.width,myGraph.frame.size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [myGraph.layer renderInContext:context];
    UIImage *img_screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img_screenShot;
}

- (IBAction)shareClicked:(id)sender {
    
    SharePopupViewController *vc;
    if (IS_IPHONE_4_OR_LESS) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewControlleriPhone4"];
    }
    else if (IS_IPHONE_5) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewControlleriPhone5"];
    }
    else if (IS_IPHONE_6) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewControlleriPhone6"];
    }
    else if (IS_IPHONE_6P) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewControlleriPhone6Plus"];
    }

    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).image = [self createSnapShotImagesFromUIview];
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).min = self.minLabel.text;
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).max = self.maxLabel.text;
    
    [self presentModalViewController:vc animated:YES];
}


- (void) updateMe {
    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Entity"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    NSInteger min = 0, max = 0;
    
    if (self.contactArray.count == 0) {
        return;
    }
    for (int i = 1; i < self.contactArray.count; i++) {
        if ([[self.contactArray[i] valueForKey:@"weight"] floatValue] < [[self.contactArray[min] valueForKey:@"weight"] floatValue]) {
            min  = i;
        }
        
        if ([[self.contactArray[i] valueForKey:@"weight"] floatValue] > [[self.contactArray[max] valueForKey:@"weight"] floatValue]) {
            max  = i;
        }
    }
    
    self.minLabel.text = [self.contactArray[min] valueForKey:@"weight"];
    self.maxLabel.text = [self.contactArray[max] valueForKey:@"weight"];
    
    self.weight.text =[self.contactArray.lastObject valueForKey:@"weight"];
    
    
    if (self.contactArray.count > 1) {
        float result = [[self.contactArray.lastObject valueForKey:@"weight"] floatValue] - [[self.contactArray[self.contactArray.count - 2] valueForKey:@"weight"] floatValue];

        if (result > 0) {
            self.currentDelta.text = [NSString stringWithFormat:@"+%0.1f",result];
        }
        else
            self.currentDelta.text = [NSString stringWithFormat:@"%0.1f",result];
    }
    
    [self.tableView reloadData];
    
    if ((cellWithGraph.hidden == YES) && (self.contactArray.count > 1)) {

        
        
        cellWithGraph.hidden = NO;
        cellZaglushka.hidden = YES;
        
        [myGraph reloadGraph];
        
        shareButton.enabled = YES;
    }
    
    if ((cellWithGraph.hidden == NO) && (self.contactArray.count < 2)) {
        
        
        
        cellWithGraph.hidden = YES;
        cellZaglushka.hidden = NO;
        
        shareButton.enabled = NO;

    }
     
     [self.tableView reloadData];
}

- (void) updateLabel {
    [self updateMe];
    
    [myGraph reloadGraph];
}

- (void) viewDidAppear:(BOOL)animated {
    [self updateMe];
    
    if (self.contactArray.count == 0) {
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTimeOpened = @"YES";
        [self addWeight:nil];
    }
}
 

- (void) TabbarSetEnabled {
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:YES];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateMe];
    
    cellZaglushka.hidden = YES;
    
    if (self.contactArray.count < 2) {

        cellWithGraph.hidden = YES;
        cellZaglushka.hidden = NO;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *result = [userDefaults objectForKey:@"wasOpened"];
    if (![result length]) {
        
        
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
        [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
        
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTimeOpened = @"YES";
        [self addWeight:nil];
        
        [userDefaults setObject:@"was" forKey:@"wasOpened"];
        [userDefaults synchronize];
    }
    
   // [self first];
    
    
    myGraph.enableTouchReport = YES;
    myGraph.enablePopUpReport = YES;
    myGraph.enableXAxisLabel = YES;
    myGraph.alwaysDisplayDots = YES;


    myGraph.enableYAxisLabel = YES;
    myGraph.autoScaleYAxis = YES;
    myGraph.enableReferenceXAxisLines = YES;
    
    
    myGraph.enableReferenceYAxisLines = YES;
    myGraph.enableReferenceAxisFrame = YES;
    
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"DoUpdateLabel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabbarSetEnabled) name:@"TabbarSetEnabled" object:nil];
    
    NSManagedObjectContext *managedObjectContext1 = [self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"Entity"];
    self.contactArray = [[managedObjectContext1 executeFetchRequest:fetchRequest1 error:nil] mutableCopy];
    
    [self updateMe];
    
    
    NSLog(@"count = %lu",(unsigned long)self.contactArray.count);
    
    for (int i = 0; i < self.contactArray.count; i++) {
        NSLog(@"%@ ; %@",[self.contactArray[i] valueForKey:@"weight"],[self.contactArray[i] valueForKey:@"date"]);
    }

    
    
    myGraph.layer.cornerRadius = 8.0;
    myGraph.layer.masksToBounds = YES;
    
    
    backW.layer.cornerRadius = 8.0;
    backW.layer.masksToBounds = YES;
    
    back2.layer.cornerRadius = 7.0;
    back2.layer.masksToBounds = YES;
    back2.layer.borderColor = [UIColor colorWithRed:(64/255.0) green:(98/255.0) blue:(138/255.0) alpha:0.4].CGColor;
    back2.layer.borderWidth = 2.0;
    
    
    


    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"Roboto-Regular" size:21.0f], NSFontAttributeName,
                                                                     [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1], NSForegroundColorAttributeName,
                                                                     nil, nil,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addWeight:(id)sender {
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:FALSE];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:FALSE];
    
    if (![self.weight.text  isEqual: @"0"]) {
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).lastweight = self.weight.text;
    }

    
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

    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentModalViewController:vc animated:YES];
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



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell.hidden) {
        return 0;
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

@end
