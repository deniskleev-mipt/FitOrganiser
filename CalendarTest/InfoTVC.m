//
//  InfoTVC.m
//  Fitness
//
//  Created by Denis on 26.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "InfoTVC.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <QuartzCore/QuartzCore.h>

@interface InfoTVC ()

@end

@implementation InfoTVC {
    
    __weak IBOutlet UIImageView *greenColor;
}

- (IBAction)buyClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Подтвердите встроенную покупку"
                                                    message:@"Вы хотите купить 1 объект по цене 99 р.?"
                                                   delegate:self
                                          cancelButtonTitle:@"Купить"
                                          otherButtonTitles:@"Отменить",nil];
    [alert show];
}
- (IBAction)shareClicked:(id)sender {
    NSString *shareText = @"Fitman — бесплатное мобильное приложение. Тренируйся правильно, выполняй задачи, достигай результата!\n Скачай в App Store и Google play.";
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
- (IBAction)vkClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/club126407123"]];
}
- (IBAction)fbClicked:(id)sender {
    NSLog(@"fbfbfb");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/Fitman-281387668899622/?ref=bookmarks"]];
}
- (IBAction)instClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/club126407123"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    greenColor.layer.cornerRadius = 20.0;
    greenColor.layer.masksToBounds = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIFont fontWithName:@"Roboto-Regular" size:21.0f], NSFontAttributeName,
                                                                     [UIColor colorWithRed:(66/255.0) green:(101/255.0) blue:(140/255.0) alpha:1], NSForegroundColorAttributeName,
                                                                     nil, nil,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)star1:(id)sender {
    
    NSLog(@"star 1");
    
    if ([sender isSelected] == NO) {
        NSLog(@"not selected");
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
    
        
      //  [self ask];
        
    } else {
        // выключить все звезды
        [self offTheLights];
    }
    [self performSelector:@selector(offTheLights) withObject:nil afterDelay:0.1];
}
- (IBAction)star2:(id)sender {
    
    if ([sender isSelected] == NO) {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        
      //  [self ask];
        
    } else {
        // выключить все звезды
        [self offTheLights];
    }
    [self performSelector:@selector(offTheLights) withObject:nil afterDelay:0.1];
}
- (IBAction)star3:(id)sender {
    
    if ([sender isSelected] == NO) {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        
     //   [self ask];
        
    } else {
        // выключить все звезды
        [self offTheLights];
    }
    [self performSelector:@selector(offTheLights) withObject:nil afterDelay:0.1];
}
- (IBAction)star4:(id)sender {
    
    if ([sender isSelected] == NO) {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"star_activ_56.png"] forState:UIControlStateNormal];
        
     //   [self goToTheAppStore];
        
    } else {
        // выключить все звезды
        [self offTheLights];
    }
    [self performSelector:@selector(offTheLights) withObject:nil afterDelay:0.1];
}
- (IBAction)star5:(id)sender {
    
    if ([sender isSelected] == NO) {
        [self.star1 setBackgroundImage:[UIImage imageNamed:@"star_activ_56"] forState:UIControlStateNormal];
        [self.star2 setBackgroundImage:[UIImage imageNamed:@"star_activ_56"] forState:UIControlStateNormal];
        [self.star3 setBackgroundImage:[UIImage imageNamed:@"star_activ_56"] forState:UIControlStateNormal];
        [self.star4 setBackgroundImage:[UIImage imageNamed:@"star_activ_56"] forState:UIControlStateNormal];
        [self.star5 setBackgroundImage:[UIImage imageNamed:@"star_activ_56"] forState:UIControlStateNormal];
        
    //    [self goToTheAppStore];
        
    } else {
        // выключить все звезды
        
    }
    [self performSelector:@selector(offTheLights) withObject:nil afterDelay:0.1];
}

- (void) offTheLights {
    
    
    [self.star1 setBackgroundImage:[UIImage imageNamed:@"star_56"] forState:UIControlStateNormal];
    [self.star2 setBackgroundImage:[UIImage imageNamed:@"star_56"] forState:UIControlStateNormal];
    [self.star3 setBackgroundImage:[UIImage imageNamed:@"star_56"] forState:UIControlStateNormal];
    [self.star4 setBackgroundImage:[UIImage imageNamed:@"star_56"] forState:UIControlStateNormal];
    [self.star5 setBackgroundImage:[UIImage imageNamed:@"star_56"] forState:UIControlStateNormal];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.star1.layer addAnimation:transition forKey:nil];
    [self.star2.layer addAnimation:transition forKey:nil];
    [self.star3.layer addAnimation:transition forKey:nil];
    [self.star4.layer addAnimation:transition forKey:nil];
    [self.star5.layer addAnimation:transition forKey:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {    // self.tableview
            CGFloat cornerRadius = 13.f;
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

- (IBAction)send:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        NSString *subjectString = [NSString stringWithFormat:@"Обращение к команде Fitman"];
        [controller setSubject:subjectString];
        NSString *messagebodyString = [NSString stringWithFormat:@"Опишите Вашу проблему или пожелание, и команда Fitman обязательно рассмотрит ваше обращение. Спасибо!"];
        [controller setMessageBody:messagebodyString isHTML:NO];
        [controller setToRecipients:[NSArray arrayWithObjects:@"fitman-help@mail.ru",nil]];
        if (controller) [self presentModalViewController:controller animated:YES];
    } else {
        [self sorryMessagingIsUnavailable];
    }
}

- (void) sorryMessagingIsUnavailable {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                    message:@"На вашем устройстве не настроена почта.\nВыберите почтовый профиль в стандартном приложении «Почта»."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        
    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
