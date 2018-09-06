//
//  EGSpinnerLayer.m
//  EGSpinner
//
//  Created by Евгений Глухов on 20.04.2018.
//  Copyright © 2018 Evgeny Glukhov. All rights reserved.
//

#import "EGSpinnerLayer.h"

@interface EGSpinnerLayer () <CAAnimationDelegate>

@property (nonatomic, assign) BOOL isSpinning;

@end

@implementation EGSpinnerLayer

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.cornerRadius = 20;
        self.fillColor = [UIColor clearColor].CGColor;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.lineWidth = 2;
        self.lineCap = kCALineCapRound;
        self.strokeStart = 0;
        self.strokeEnd = 0.01;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 2, 2) cornerRadius:20-2];
        self.path = path.CGPath;
    }
    return self;
}

- (void) startSpin {
    self.isSpinning = YES;
    [self spinWithAngle:M_PI];
}

- (void) spinWithAngle:(CGFloat)angle {
    self.strokeEnd = 0.5;
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI-0.5);
    rotationAnimation.duration = 0.3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE;
    [self addAnimation:rotationAnimation forKey:nil];
}

- (void) stopSpin {
    self.isSpinning = NO;
    [self removeAllAnimations];
}

@end
