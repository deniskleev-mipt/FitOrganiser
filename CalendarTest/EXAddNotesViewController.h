//
//  EXPassRecoveryPopupViewController.h
//  Ovation
//
//  Created by Vladimir on 11.07.16.
//  Copyright © 2016 OV. All rights reserved.
//

#import "EXBasePopupController.h"
@protocol EXAddNotesViewControllerDelegate;
@interface EXAddNotesViewController : EXBasePopupController
@property (weak, nonatomic)id <EXAddNotesViewControllerDelegate>delegate; 
@end

@protocol EXAddNotesViewControllerDelegate <NSObject>

- (void)notesViewController:(UIViewController*)controller  didFinishWithNote:(NSString *)noteString;

@end