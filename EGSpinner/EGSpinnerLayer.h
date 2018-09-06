//
//  EGSpinnerLayer.h
//  EGSpinner
//
//  Created by Евгений Глухов on 20.04.2018.
//  Copyright © 2018 Evgeny Glukhov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface EGSpinnerLayer : CAShapeLayer

- (instancetype) initWithFrame:(CGRect)frame;
- (void) startSpin;
- (void) stopSpin;

@end
