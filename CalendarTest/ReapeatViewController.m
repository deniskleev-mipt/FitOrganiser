//
//  ReapeatViewController.m
//  CalendarTest
//
//  Created by Denis on 18.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "ReapeatViewController.h"
#import "AddTaskTableViewController.h"
#import "AppDelegate.h"
@interface ReapeatViewController ()

@end

@implementation ReapeatViewController {
    BOOL ponedelnik;
    BOOL vtornik;
    BOOL sreda;
    BOOL chetverg;
    BOOL pyatnica;
    BOOL subbota;
    BOOL voskresenie;
    
    
    __weak IBOutlet UIButton *ponButton;
    __weak IBOutlet UIButton *btButton;
    __weak IBOutlet UIButton *srButton;
    __weak IBOutlet UIButton *chtButton;
    __weak IBOutlet UIButton *pyatButton;
    __weak IBOutlet UIButton *subButton;
    __weak IBOutlet UIButton *vsButton;
    
    BOOL ponPressed;
    BOOL vtPressed;
    BOOL srPressed;
    BOOL chtPressed;
    BOOL pyatPressed;
    BOOL subPressed;
    BOOL voskrPressed;

    __weak IBOutlet UIView *whiteView;
    __weak IBOutlet UISwitch *switcher;
}

- (void) daysBorders {
    
    ponButton.layer.cornerRadius = 11.0;
    ponButton.layer.masksToBounds = YES;
    ponButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    ponButton.layer.borderWidth = 1.5;
    
    //
    
    btButton.layer.cornerRadius = 11.0;
    btButton.layer.masksToBounds = YES;
    btButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    btButton.layer.borderWidth = 1.5;
    
    //
    
    srButton.layer.cornerRadius = 11.0;
    srButton.layer.masksToBounds = YES;
    srButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    srButton.layer.borderWidth = 1.5;
    
    chtButton.layer.cornerRadius = 11.0;
    chtButton.layer.masksToBounds = YES;
    chtButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    chtButton.layer.borderWidth = 1.5;
    
    pyatButton.layer.cornerRadius = 11.0;
    pyatButton.layer.masksToBounds = YES;
    pyatButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    pyatButton.layer.borderWidth = 1.5;
    
    subButton.layer.cornerRadius = 11.0;
    subButton.layer.masksToBounds = YES;
    subButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    subButton.layer.borderWidth = 1.5;
    
    vsButton.layer.cornerRadius = 11.0;
    vsButton.layer.masksToBounds = YES;
    vsButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    vsButton.layer.borderWidth = 1.5;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ponPressed = NO;
    vtPressed = NO;
    srPressed = NO;
    chtPressed = NO;
    pyatPressed = NO;
    subPressed = NO;
    voskrPressed = NO;
    
    
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik  isEqual: @"YES"]) {
        [self ponedelnik:nil];
    }
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik  isEqual: @"YES"]) {
        [self vtornik:nil];
    }
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda  isEqual: @"YES"]) {
        [self sreda:nil];
    }
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg  isEqual: @"YES"]) {
        [self chetverg:nil];
    }
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica  isEqual: @"YES"]) {
        [self pyatnica:nil];
    }
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota  isEqual: @"YES"]) {
        [self subbota:nil];
    }
    if ([((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie  isEqual: @"YES"]) {
        [self voskresenie:nil];
    }
    
    self.white.layer.cornerRadius = 18.0;
    self.white.layer.masksToBounds = YES;
    
    
    [self daysBorders];
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

- (IBAction)switchValueChanged:(id)sender {
    if (switcher.isOn == YES) {
        whiteView.hidden = NO;
    }
    else
        whiteView.hidden = YES;
}

- (IBAction)yesClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateRLabel" object:nil userInfo:nil];
}
- (IBAction)noClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)ponedelnik:(id)sender {
    
    
    if (ponPressed == NO) {
        
        ponPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik = @"YES";
        
        [ponButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ponButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (ponPressed == YES){
        
        ponPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).ponedelnik = @"NO";
        
        [ponButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        ponButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];

    }
    
}

- (IBAction)vtornik:(id)sender {
    if (vtPressed == NO) {
        
        vtPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik = @"YES";
        
        [btButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (vtPressed == YES) {
        
        vtPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).vtornik = @"NO";
        
        [btButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        btButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)sreda:(id)sender {
    if (srPressed == NO) {
        
        srPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda = @"YES";
        
        [srButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        srButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (srPressed == YES){
        
        srPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).sreda = @"NO";
        
        [srButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        srButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }

}

- (IBAction)chetverg:(id)sender {
    if (chtPressed == NO) {
        
        chtPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg = @"YES";
        
        [chtButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        chtButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (chtPressed == YES) {
        
        chtPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).chetverg = @"NO";
        
        [chtButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        chtButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)pyatnica:(id)sender {
    if (pyatPressed == NO) {
        
        pyatPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica = @"YES";
        
        [pyatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        pyatButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (pyatPressed == YES){
        
        pyatPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).pyatnica = @"NO";
        
        [pyatButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:110.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        pyatButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)subbota:(id)sender {
    if (subPressed == NO) {
        
        subPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota = @"YES";
        
        [subButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        subButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (subPressed == YES){
        
        subPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).subbota = @"NO";
        
        [subButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        subButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}

- (IBAction)voskresenie:(id)sender {
    if (voskrPressed == NO) {
        
        voskrPressed = YES;
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie = @"YES";
        
        [vsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        vsButton.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:119.0/255.0 blue:191.0/255.0 alpha:1];
    }
    else if (voskrPressed == YES){
        
        voskrPressed = NO;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).voskresenie = @"NO";
        
        [vsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        vsButton.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:1];
        
    }
}



@end
