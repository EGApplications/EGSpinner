//
//  EGCleverProgress.h
//  EGSpinner
//
//  Created by Евгений Глухов on 20.04.2018.
//  Copyright © 2018 Evgeny Glukhov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGSpinnerLayer.h"

@class EGCleverProgress;

static NSString* loadingNotification = @"EGCleverProgressLoadingNotification";
static NSString* hasBeenDownloadedNotification = @"EGCleverProgressHasBeenDownloadedNotification";

@protocol EGCleverProgressDelegate <NSObject>

@optional

- (void) didSelectCleverButton:(EGCleverProgress*) clever;
- (void) cleverProgress:(EGCleverProgress*) clever didSelectCloseButton:(UIButton*) closeButton;

@end

@interface EGCleverProgress : UIView

// system
@property (strong, nonatomic) UIView* cleverView;
@property (strong, nonatomic) UILabel* alertLabel;
@property (strong, nonatomic) UIButton* closeButton;
@property (strong, nonatomic) EGSpinnerLayer* spinner;

// for user
@property (strong, nonatomic) UIColor* cleverBackgroundColor;
@property (weak, nonatomic) id <EGCleverProgressDelegate> delegate;

@end
