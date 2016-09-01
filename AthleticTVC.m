//
//  AthleticTVC.m
//  Fitness
//
//  Created by Denis on 26.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "AthleticTVC.h"

#import "ContactPOPUPViewController.h"

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

@interface AthleticTVC ()

@end

@implementation AthleticTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"Roboto-Regular" size:21.0f], NSFontAttributeName,
                                                                     [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1], NSForegroundColorAttributeName,
                                                                     nil, nil,nil]];
    
    ContactPOPUPViewController *vc;
    if (IS_IPHONE_4_OR_LESS) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactPOPUPViewControlleriPhone4"];
    }
    else if (IS_IPHONE_5) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactPOPUPViewControlleriPhone5"];
    }
    else if (IS_IPHONE_6) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactPOPUPViewControlleriPhone6"];
    }
    else if (IS_IPHONE_6P) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactPOPUPViewControlleriPhone6Plus"];
    }
    else if ((IS_IPAD) || (IS_IPAD_PRO)) {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactPOPUPViewControlleriPad"];
    }
    
    
    [vc setModalPresentationStyle:UIModalPresentationCustom];
    [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)vkClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.vk.com"]];
}

- (IBAction)fbClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];
}




@end
