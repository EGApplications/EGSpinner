## EGSpinner

Simple ios spinner & button for loading procedures.

### Installation

You can install EGSpinner using cocoapods. Just write the following in your Podfile:
```objective-c
pod ‘EGSpinner’
```
    
### Usage

The main element of spinner is the EGCleverProgress class, which you can initialize and customize just like this:

```objective-c
- (void) viewDidLoad
{
[super viewDidLoad];

// example

// initialization
EGCleverProgress* clever = [[EGCleverProgress alloc] init];
clever.cleverBackgroundColor = [UIColor greenColor];

// custom delegate
clever.delegate = self;

// customization of button on clever progress
clever.closeButton.hidden = NO;
[clever.closeButton setImage:[UIImage imageNamed:@"closeIcon@2x.png"] forState:UIControlStateNormal];

// alertLabel & cleverView customization
clever.cleverView.backgroundColor = UIColor.redColor;
clever.alertLabel.textColor = UIColor.magentaColor;

[self.view addSubview:clever];

}
```

EGCleverProgress header file let you control main actions of loading procedures, such as notifications for loading process and when loading has been ended, and delegate methods for processing buttons actions.

```objective-c
@class EGCleverProgress;

static NSString* loadingNotification = @"EGCleverProgressLoadingNotification";
static NSString* hasBeenDownloadedNotification = @"EGCleverProgressHasBeenDownloadedNotification";

@protocol EGCleverProgressDelegate <NSObject>

@optional

- (void) didSelectCleverButton:(EGCleverProgress*) clever;
- (void) cleverProgress:(EGCleverProgress*) clever didSelectCloseButton:(UIButton*) closeButton;

@end

@interface EGCleverProgress : UIView

// initialization
- (instancetype)init;

// system
@property (strong, nonatomic) UIView* cleverView;
@property (strong, nonatomic) UILabel* alertLabel;
@property (strong, nonatomic) UIButton* closeButton;
@property (strong, nonatomic) EGSpinnerLayer* spinner;

// for user
@property (strong, nonatomic) UIColor* cleverBackgroundColor;
@property (weak, nonatomic) id <EGCleverProgressDelegate> delegate;

@end
```

You can also initialize and use spinner separately:

```objective-c
@interface EGSpinnerLayer : CAShapeLayer

- (instancetype) initWithFrame:(CGRect)frame;
- (void) startSpin;
- (void) stopSpin;

@end
```

Loading procedure example:

```objective-c

// notify Clever Progress to start the spinner at the beginning of loading process.
[[NSNotificationCenter defaultCenter] postNotificationName:loadingNotification object:nil];

// Here after 3 seconds spinner will stop and alertLabel will update its status to "Data has been downloaded"
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
[[NSNotificationCenter defaultCenter] postNotificationName:hasBeenDownloadedNotification object:@{@"status":@"Data has been downloaded"}];
clever.closeButton.hidden = YES;
});

```

**The MIT License (MIT)**

Copyright (c) 2018 EGApplications

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
