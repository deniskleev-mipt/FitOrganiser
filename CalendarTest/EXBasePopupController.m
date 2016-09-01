//
//  EXBasePopupController.m
//  Ovation
//
//  Created by Vladimir on 11.07.16.
//  Copyright © 2016 OV. All rights reserved.
//

#import "EXBasePopupController.h"
#import <Masonry/Masonry.h>

@interface EXBasePopupController ()
@property (strong, nonatomic)UIView *backView;
@property (strong, nonatomic)UITapGestureRecognizer *recognizer;
@end

@implementation EXBasePopupController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    

    self.recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditing)];
    self.backView = [[UIView alloc]init];
    [self.view addSubview:self.backView];
    [self.view sendSubviewToBack:self.backView];
    [self.backView addGestureRecognizer:self.recognizer];
    self.backView.backgroundColor = [UIColor blackColor];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top); 
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
    }];

}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.view.alpha = 0.0f;
    self.backView.alpha = 0.0f;
    
    [self showPopupControllerAnimation];
}

- (void)showPopupControllerAnimation {
   [UIView animateWithDuration:0.5f animations:^{
       
       self.view.alpha = 1.0f;
       self.backView.alpha = 0.5f;
       
       
   }];
}

- (void)dismissPopupControllerAnimation {
    
    [UIView animateWithDuration:0.5f animations:^{
        self.view.alpha = 0.0f;
        self.backView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (IBAction)dissmissPopupControlerAction:(UIButton *)sender {
    [self dismissPopupControllerAnimation];
}

- (void)endEditing {
    [self.view endEditing:YES];
}

@end
