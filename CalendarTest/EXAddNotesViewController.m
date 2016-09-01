//
//  EXPassRecoveryPopupViewController.m
//  Ovation
//
//  Created by Vladimir on 11.07.16.
//  Copyright © 2016 OV. All rights reserved.
//

#import "EXAddNotesViewController.h"
#import "MGRKeyboardConfigurator.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface EXAddNotesViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)MGRKeyboardConfigurator *keyboardConfigurator;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UIView *completedView;
@property (strong, nonatomic)UITapGestureRecognizer * tapRecognizer;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation EXAddNotesViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mailTextField.delegate = self;
    self.tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    [self.contentView addGestureRecognizer:self.tapRecognizer];
    
    self.keyboardConfigurator = [[MGRKeyboardConfigurator alloc]initWithScrollView:self.scrollView];
    self.popupView.layer.cornerRadius = 10.0f;
    self.popupView.layer.masksToBounds = YES;
    self.completedView.layer.cornerRadius = 10.0f;
    self.completedView.layer.masksToBounds = YES;

}

- (IBAction)sendNewPasswordAction:(UIButton *)sender {
    [self.delegate notesViewController:self didFinishWithNote:self.mailTextField.text];
  }



#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.mailTextField){
        [self.mailTextField resignFirstResponder];
    }
    

    
    return YES;
}

#pragma mark - Private Methods

- (void)endEditing {
    [self.view endEditing:YES];
}


@end
