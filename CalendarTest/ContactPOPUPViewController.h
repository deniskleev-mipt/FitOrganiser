//
//  ContactPOPUPViewController.h
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactPOPUPViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *inputCaptchaTextField;

@property (weak, nonatomic) IBOutlet UIView *captchaBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *captchaImage;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)getCheckServiceInfoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UITextField *imya;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UIImageView *closeLabel;

@property (weak, nonatomic) IBOutlet UILabel *sendLabel;

@property (weak, nonatomic) IBOutlet UIImageView *white;
@property (weak, nonatomic) IBOutlet UIImageView *blue;
@end
