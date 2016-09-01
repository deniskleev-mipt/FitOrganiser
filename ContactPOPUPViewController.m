//
//  ContactPOPUPViewController.m
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "ContactPOPUPViewController.h"

@interface ContactPOPUPViewController ()

@end

@implementation ContactPOPUPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
- (IBAction)yesClicked:(id)sender {
}
- (IBAction)noClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
