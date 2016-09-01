//
//  AddWeightViewController.m
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "AddWeightViewController.h"
#import "ProfileTVC.h"
#import "AppDelegate.h"
@interface AddWeightViewController ()

@end

@implementation AddWeightViewController {
    NSMutableArray *hoursArray;
    NSMutableArray *minsArray;
    
    __weak IBOutlet UIPickerView *pickerView;
    
    
    __weak IBOutlet UIImageView *margosha;
    
    __weak IBOutlet UIButton *closeButton;
    __weak IBOutlet UILabel *titleLabel;
}


- (void) pickerCustomize {
    float fontSize = 20;
    float labelWidth = self.view.frame.size.width / [pickerView numberOfComponents];
    float y = (pickerView.frame.size.height / 2) - (fontSize / 2);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelWidth * 2, y, labelWidth, fontSize)];
    label.text = @"Кг";
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake (0,1);
    label.textAlignment = NSTextAlignmentRight;
    
    
    [pickerView insertSubview:label aboveSubview:[pickerView.subviews objectAtIndex:[pickerView.subviews count] - 1]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    pickerView.delegate = self;
    pickerView.dataSource= self;
    
    
    
    
   // [self pickerCustomize];
    
    self.view.backgroundColor = [UIColor whiteColor];
    margosha.hidden = NO;
    
    
    
    // Do any additional setup after loading the view.
    
    self.white.layer.cornerRadius = 18.0;
    self.white.layer.masksToBounds = YES;
    
    self.white.layer.cornerRadius = 18.0;
    self.white.layer.masksToBounds = YES;
    self.white.layer.borderColor = [UIColor colorWithRed:(21/255.0) green:(122/255.0) blue:(188/255.0) alpha:1.].CGColor;
    self.white.layer.borderWidth = 2.0;
    
    //
    
    self.blue.layer.cornerRadius = 18.0;
    self.blue.layer.masksToBounds = YES;
    
    self.blue.layer.cornerRadius = 18.0;
    self.blue.layer.masksToBounds = YES;
    self.blue.layer.borderColor = [UIColor colorWithRed:(21/255.0) green:(122/255.0) blue:(188/255.0) alpha:1.].CGColor;
    self.blue.layer.borderWidth = 2.0;
    
    

    
    
    
    
    // Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"behind_alert_view.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // border radius
    [self.captchaBackgroundView.layer setCornerRadius:11.0f];
    
    // border
    [self.captchaBackgroundView.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.captchaBackgroundView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [self.captchaBackgroundView.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.captchaBackgroundView.layer setShadowOpacity:0.8];
    [self.captchaBackgroundView.layer setShadowRadius:3.0];
    [self.captchaBackgroundView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    
    
    // DatePicker
    hoursArray = [[NSMutableArray alloc] init];
    minsArray = [[NSMutableArray alloc] init];
    
    for(int i=0; i<151; i++)
    {
        [hoursArray addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    
    for(int i=0; i<10; i++)
    {
        [minsArray addObject:[NSString stringWithFormat:@".%d",i]];
        
    }
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTimeOpened  isEqual: @"YES"]) {
        closeButton.hidden = YES;
        
        [pickerView reloadAllComponents];
        [pickerView selectRow:50 inComponent:0 animated:YES];
        
        titleLabel.text = @"Укажите Ваш вес";
        
       // ((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTimeOpened = @"NO";
        
       // [self addZero];
    } /*else if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).toChangeExistingWeight  isEqual: @"YES"]) {
        
    
    }*/
    else {
        
        
        
        // 50.0
        
        NSString *w = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).lastweight;
        
        [pickerView reloadAllComponents];
        
        [pickerView selectRow:[w integerValue] inComponent:0 animated:YES];
        
        
        NSArray *arr = [w componentsSeparatedByString:@"."];
        [pickerView selectRow:[arr.lastObject intValue] inComponent:1 animated:YES];
    }
    
}

- (void) addZero {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
    
    [newDevice setValue:@"0.0" forKey:@"weight"];
    
    /*
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    */
    
    [newDevice setValue:@"1.1.2016" forKey:@"date"];
    
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}

//Method to define how many columns/dials to show
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if (component==0)
    {
        return [hoursArray count];
    }
    else if (component==1)
    {
        return [minsArray count];
    }
    else if (component==2)
    {
        return 1;
    }
    else return 0;
}


// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return [hoursArray objectAtIndex:row];
            break;
        case 1:
            return [minsArray objectAtIndex:row];
            break;
            
        case 2:
            return @"Кг";
            break;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)doneClicked:(id)sender {
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).toEdit  isEqual: @"YES"]) {
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).toChangeExistingWeight = [NSString stringWithFormat:@"%ld.%ld",(long)[pickerView selectedRowInComponent:0],(long)[pickerView selectedRowInComponent:1]];
        
        //updateTV
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTV" object:nil userInfo:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
        
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:context];
        
    [newDevice setValue:[NSString stringWithFormat:@"%ld.%ld",(long)[pickerView selectedRowInComponent:0],(long)[pickerView selectedRowInComponent:1]] forKey:@"weight"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d.M.yyyy";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    
    [newDevice setValue:string forKey:@"date"];
        
        
    NSError *error = nil;
        
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    

    //updateTV
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DoUpdateLabel" object:nil userInfo:nil];
    
    
    
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTimeOpened  isEqual: @"YES"]) {

        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTimeOpened = @"NO";
        
               
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabbarSetEnabled" object:nil userInfo:nil];
    }

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabbarSetEnabled" object:nil userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)backClicked:(id)sender {
    //closeandComeToHistory
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeandComeToHistory" object:nil userInfo:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabbarSetEnabled" object:nil userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**/



@end
