//
//  FirstViewController.m
//  DownloadableContentStore
//
//  Created by Randy Becker on 2/13/10.
//  Copyright 2010 Randy Becker
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "FirstViewController.h"


@implementation FirstViewController

@synthesize priceButton, guardWindow;


- (void)viewDidLoad {
    [super viewDidLoad];
    DCSPriceButtonStyle style = DCSPriceButtonStyleBlue;
    DCSPriceButton *button = [DCSPriceButton priceButtonWithStyle:style];
    [button setFrame:CGRectMake(128, 64, 1, 1)];
    [button setTitle:@"$0.99"];
    [button setConfirmationTitle:@"BUY NOW"];
    [button addTarget:self
               action:@selector(buttonTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [self setPriceButton:button];
    [[self view] addSubview:[self priceButton]];

    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenFrame];
    DCSTouchCaptureView *captureView = [DCSTouchCaptureView alloc];
    [captureView initWithFrame:screenFrame];
    [captureView setPassThroughViews:[NSArray arrayWithObject:button]];
    [captureView addTarget:self
                    action:@selector(cancelConfirmation:)
          forControlEvents:UIControlEventTouchDown];
    [window addSubview:captureView];
    [self setGuardWindow:window];
}

- (IBAction)buttonTapped:(id)sender {
    if ([priceButton isShowingConfirmation]) {
        NSLog(@"Buy now!");
    } else {
        [[self guardWindow] makeKeyAndVisible];
        NSTimeInterval duration = [DCSPriceButton defaultAnimationDuration];
        [[self priceButton] setShowingConfirmation:YES duration:duration];
    }
}

- (IBAction)cancelConfirmation:(id)sender {
    [[self guardWindow] setHidden:YES];
    NSTimeInterval duration = [DCSPriceButton defaultAnimationDuration];
    [[self priceButton] setShowingConfirmation:NO duration:duration];
}

- (void)dealloc {
    [priceButton release];
    [guardWindow release];
    [super dealloc];
}

@end
