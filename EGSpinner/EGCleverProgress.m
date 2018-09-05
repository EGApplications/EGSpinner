//
//  EGCleverProgress.m
//  EGSpinner
//
//  Created by Евгений Глухов on 20.04.2018.
//  Copyright © 2018 Evgeny Glukhov. All rights reserved.
//

#import "EGCleverProgress.h"
#import <QuartzCore/QuartzCore.h>

#define CLEVER_VIEW_WIDTH           [UIScreen mainScreen].bounds.size.width / 1.5
#define CLEVER_VIEW_HEIGHT          60
#define PADDING                     8
#define SPINNER_SIZE                CGSizeMake(40, 40)
#define CLOSE_BUTTON_SIZE           CGSizeMake(40, 40)

@implementation EGCleverProgress

- (instancetype)init {
    self = [super init];
    if (self) {
        
        CGRect screenRect = [UIScreen mainScreen].bounds;
        CGRect generalRect = CGRectMake(0, CGRectGetMaxY(screenRect) - CLEVER_VIEW_HEIGHT, CGRectGetWidth([[UIScreen mainScreen] bounds]), CLEVER_VIEW_HEIGHT);
        [self setFrame:generalRect];
        self.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0];
        
        CGRect cleverRect = CGRectMake(CGRectGetMidX(self.bounds) - CLEVER_VIEW_WIDTH/2, CGRectGetMaxY(self.bounds) - CLEVER_VIEW_HEIGHT - PADDING, CLEVER_VIEW_WIDTH, CLEVER_VIEW_HEIGHT);
        
        UIView* cleverView = [[UIView alloc] initWithFrame:cleverRect];
        [cleverView layoutSubviews];
        cleverView.layer.cornerRadius = CLEVER_VIEW_HEIGHT/2;;
        cleverView.layer.masksToBounds = YES;
        cleverView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
        
        [self addSubview:cleverView];
        self.cleverView = cleverView;
        
        EGSpinnerLayer* spinner = [[EGSpinnerLayer alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.cleverView.bounds) - SPINNER_SIZE.width/2, CGRectGetMidY(self.cleverView.bounds) - SPINNER_SIZE.height/2, SPINNER_SIZE.width, SPINNER_SIZE.height)];
        spinner.position = CGPointMake(self.cleverView.frame.size.width/2, self.cleverView.frame.size.height/2);
        spinner.hidden = YES;
        [self.cleverView.layer addSublayer:spinner];
        
        self.spinner = spinner;
        
        UILabel* alertLabel = [[UILabel alloc] initWithFrame:self.cleverView.bounds];
        alertLabel.textColor = [UIColor whiteColor];
        alertLabel.font = [UIFont boldSystemFontOfSize:14];
        alertLabel.textAlignment = NSTextAlignmentCenter;
        alertLabel.hidden = YES;
        [self.cleverView addSubview:alertLabel];
        
        self.alertLabel = alertLabel;
        
        UIButton* closeButton = [[UIButton alloc] initWithFrame:CGRectMake(PADDING, CGRectGetMaxY(self.bounds) - PADDING - CLOSE_BUTTON_SIZE.height, CLOSE_BUTTON_SIZE.width, CLOSE_BUTTON_SIZE.height)];
        UIImage* btnImage = [UIImage imageNamed:@"closeIcon@2x.png"];
        [closeButton setImage:btnImage forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setHidden:YES];
        [self addSubview:closeButton];
        
        self.closeButton = closeButton;
        
        UITapGestureRecognizer* showGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMeWhatYouGotAction:)];
        [self.cleverView addGestureRecognizer:showGesture];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingProcess:) name:loadingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingHasBeenEnded:) name:hasBeenDownloadedNotification object:nil];
        
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setCleverBackgroundColor:(UIColor *)cleverBackgroundColor {
    self.cleverView.backgroundColor = cleverBackgroundColor;
}

#pragma mark - Actions

- (void) closeButtonAction:(UIButton*) sender {
    if ([self.delegate respondsToSelector:@selector(cleverProgress:didSelectCloseButton:)]) {
        [self.delegate cleverProgress:self didSelectCloseButton:sender];
    }
}

- (void) showMeWhatYouGotAction:(UITapGestureRecognizer*) gesture {
    if ([self.delegate respondsToSelector:@selector(didSelectCleverButton:)]) {
        [self.delegate didSelectCleverButton:self];
    }
}

#pragma mark - Notifications

- (void) loadingProcess:(NSNotification*) notification {
    self.spinner.hidden = NO;
    [self.spinner startSpin];
    self.alertLabel.text = @"";
}

- (void) loadingHasBeenEnded:(NSNotification*) notification {
    [self.spinner stopSpin];
    self.spinner.hidden = YES;
    self.alertLabel.hidden = NO;
    NSString* finalStatus = [notification.object objectForKey:@"status"];
    self.alertLabel.text = finalStatus;
}

@end
