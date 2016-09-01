//
//  SharePopupViewController.m
//  CalendarTest
//
//  Created by Denis on 10.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "SharePopupViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface SharePopupViewController ()

@end

@implementation SharePopupViewController

{
    
    __weak IBOutlet UIView *lovelyView;
    __weak IBOutlet UIImageView *graphImage;
    __weak IBOutlet UILabel *minabel;
    __weak IBOutlet UILabel *maxabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    graphImage.image =  ((AppDelegate*)[[UIApplication sharedApplication] delegate]).image;
    minabel.text = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).min;
    maxabel.text = ((AppDelegate*)[[UIApplication sharedApplication] delegate]).max;
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(UIImage *)createSnapShotImagesFromUIview
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(lovelyView.frame.size.width,lovelyView.frame.size.height), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [lovelyView.layer renderInContext:context];
    UIImage *img_screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img_screenShot;
}

- (IBAction)yesClicked:(id)sender {
    NSString *textToShare = @"Моё достижение в приложении Fitman для iOS и Android";
    UIImage * image1 = [self createSnapShotImagesFromUIview];//imageOfGraph;
    
    NSArray *itemsToShare = @[textToShare, image1];
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
- (IBAction)noClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
