
#import "OVTRoundedButton.h"

@interface OVTRoundedButton ()

@property (assign, nonatomic, getter=isConfirmState) IBInspectable NSInteger cornerRadius;

@end

@implementation OVTRoundedButton



- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self cropAndColor];
}

- (void)cropAndColor {
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
}


- (void)prepareForInterfaceBuilder {
    
    [self customInit];
}

- (void)customInit {
    
    [self cropAndColor];
    
}

- (void)drawRect:(CGRect)rect {
    [self customInit];
}


- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.alpha = 1.0f;
    } else {
        self.alpha = 0.5f;
    }
}



@end
