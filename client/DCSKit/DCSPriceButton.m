//
//  DCSPriceButton.m
//  DCSKit
//
//  Created by Randy Becker on 2/5/10.
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

#import "DCSPriceButton.h"


@interface DCSPriceButton ()

- (void)setPriceButtonStyle:(DCSPriceButtonStyle)priceButtonStyle;
- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context;
- (void)setHighlightedTitle:(NSString *)title forState:(UIControlState)state;

@end


#pragma mark -

@implementation DCSPriceButton

@synthesize priceButtonStyle=priceButtonStyle_;
- (void)setPriceButtonStyle:(DCSPriceButtonStyle)priceButtonStyle {
    UILabel *label = [self titleLabel]; 
    [label setFont:[UIFont boldSystemFontOfSize:13.0]];
    [label setTextColor:[UIColor whiteColor]];
    [label setShadowColor:[UIColor colorWithWhite:0.28 alpha:1.0]];
    [label setShadowOffset:CGSizeMake(0, -1)];
    
    [self setAdjustsImageWhenHighlighted:NO];    
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"DCSKit"
                                                           ofType:@"bundle"];
    NSString *resourcesPath = [bundlePath stringByAppendingFormat:@"/images/"];
    
    UIImage *plain;
    UIImage *pressed;
    NSString *filename;
    NSString *imagePath;

    filename = @"PurchaseConfirmButton.png";
    imagePath = [resourcesPath stringByAppendingString:filename];
    UIImage *confirm = [UIImage imageWithContentsOfFile:imagePath];
    confirm = [confirm stretchableImageWithLeftCapWidth:3 topCapHeight:5];

    filename = @"PurchaseConfirmButtonPressed.png";
    imagePath = [resourcesPath stringByAppendingString:filename];
    UIImage *pressedConfirm = [UIImage imageWithContentsOfFile:imagePath];
    pressedConfirm = [pressedConfirm stretchableImageWithLeftCapWidth:3
                                                         topCapHeight:5];
    
    switch (priceButtonStyle) {
        case DCSPriceButtonStylePlain:
            filename = @"PurchaseButton.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            plain = [UIImage imageWithContentsOfFile:imagePath];
            plain = [plain stretchableImageWithLeftCapWidth:3 topCapHeight:5];

            filename = @"PurchaseButtonPressed.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            pressed = [UIImage imageWithContentsOfFile:imagePath];
            pressed = [pressed stretchableImageWithLeftCapWidth:3
                                                   topCapHeight:5];
            break;
            
        case DCSPriceButtonStylePlus:
            filename = @"PurchasePlusButton.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            plain = [UIImage imageWithContentsOfFile:imagePath];
            plain = [plain stretchableImageWithLeftCapWidth:10 topCapHeight:5];
            
            filename = @"PurchasePlusButtonPressed.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            pressed = [UIImage imageWithContentsOfFile:imagePath];
            pressed = [pressed stretchableImageWithLeftCapWidth:10
                                                   topCapHeight:5];         
            break;
            
        case DCSPriceButtonStyleBlue:
            filename = @"PurchaseButtonBlue.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            plain = [UIImage imageWithContentsOfFile:imagePath];
            plain = [plain stretchableImageWithLeftCapWidth:3 topCapHeight:7];
            
            filename = @"PurchaseButtonBluePressed.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            pressed = [UIImage imageWithContentsOfFile:imagePath];
            pressed = [pressed stretchableImageWithLeftCapWidth:3
                                                   topCapHeight:7];
            break;
            
        case DCSPriceButtonStyleAlreadyPurchased:
            filename = @"PurchasedAlready.png";
            imagePath = [resourcesPath stringByAppendingString:filename];
            plain = [UIImage imageWithContentsOfFile:imagePath];
            plain = [plain stretchableImageWithLeftCapWidth:3 topCapHeight:5];

            pressed = plain;
            UIColor *grayColor = [UIColor colorWithRed:0.604
                                                 green:0.612
                                                  blue:0.616
                                                 alpha:1.000];
            [self setTitleColor:grayColor forState:UIControlStateNormal];
            [self setTitleColor:grayColor forState:UIControlStateHighlighted];
            [label setShadowOffset:CGSizeMake(0, 0)];
            break;
            
        default:
            [NSException raise:@"DCSInvalidButtonType" format:@"No such type"];
    }
    
    [self setBackgroundImage:plain forState:UIControlStateNormal];
    [self setBackgroundImage:pressed forState:UIControlStateHighlighted];
    [self setBackgroundImage:confirm forState:UIControlStateSelected];
    [self setBackgroundImage:pressedConfirm
                    forState:( UIControlStateSelected |
                              UIControlStateHighlighted )];
    
    priceButtonStyle_ = priceButtonStyle;
}

@synthesize showingConfirmation=showingConfirmation_;
- (void)setShowingConfirmation:(BOOL)showingConfirmation {
    if (showingConfirmation == showingConfirmation_) {
        return;
    }
    
    showingConfirmation_ = showingConfirmation;
    
    // Keep the selected property in sync with this one.
    [self setSelected:showingConfirmation_];
}

@synthesize leftAnchored=leftAnchored_;

@synthesize title=title_;
- (void)setTitle:(NSString *)title {
    if (title == title_) {
        return;
    }
    [title release];
    title_ = [title copy];
    
    // Show the title in normal states.
    [self setHighlightedTitle:title_ forState:UIControlStateNormal];
}

@synthesize confirmationTitle=confirmationTitle_;
- (void)setConfirmationTitle:(NSString *)confirmationTitle {
    if (confirmationTitle == confirmationTitle_) {
        return;
    }
    [confirmationTitle_ release];
    confirmationTitle_ = [confirmationTitle copy];
    
    // Show the confirmation title in the selected states.
    [self setHighlightedTitle:confirmationTitle_
                     forState:UIControlStateSelected];
}

- (void)setHighlightedTitle:(NSString *)title forState:(UIControlState)state {
    [self setTitle:title forState:state];
    // Set the same title for the highlighted state as the desired state.
    [self setTitle:title forState:( UIControlStateHighlighted | state )];
}


#pragma mark -
#pragma mark Class Methods

+ (NSTimeInterval)defaultAnimationDuration {
    return 0.2;
}

+ (id)priceButtonWithStyle:(DCSPriceButtonStyle)style {
    DCSPriceButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setPriceButtonStyle:style];
    return button;
}


#pragma mark -
#pragma mark Instance Methods

- (void)setShowingConfirmation:(BOOL)showingConfirmation
                      duration:(NSTimeInterval)duration {
    if ([self isSelected] == showingConfirmation) {
        return;
    }

    // Blank out the titles.
    [self setHighlightedTitle:@"" forState:UIControlStateNormal];
    [self setHighlightedTitle:@"" forState:UIControlStateSelected];

    // Set up the animation
    [UIView beginAnimations:@"DCSPriceButtonAnimation"
                    context:[NSNumber numberWithBool:showingConfirmation]];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationDelegate:self];
    SEL didStop = @selector(animationDidStop:finished:context:);
    [UIView setAnimationDidStopSelector:didStop];

    // Change the button's animatable properties
    [self setSelected:showingConfirmation];
    [self sizeToFit];
}

- (void)animationDidStop:(NSString *)animationID
                finished:(NSNumber *)finished
                 context:(void *)context {
    // FIXME: If animations are committed earlier, it doesn't look right.
    [UIView commitAnimations];

    // Set the showingConfirmation property to match the post-animation state.
    NSNumber *showingConfirmation = context;
    [self setShowingConfirmation:[showingConfirmation boolValue]];

    if ([finished boolValue]) {
        // Restore the titles.
        [self setHighlightedTitle:[self title] forState:UIControlStateNormal];
        [self setHighlightedTitle:[self confirmationTitle]
                         forState:UIControlStateSelected];
    }
}


#pragma mark -
#pragma mark UIView methods

- (void)sizeToFit {
    CGRect currentFrame = [self frame];

    CGSize fitting = [self sizeThatFits:currentFrame.size];

    CGPoint newOrigin;
    newOrigin.y = currentFrame.origin.y;
    if ([self isLeftAnchored]) {
        newOrigin.x = currentFrame.origin.x;
    } else {
        CGFloat delta = currentFrame.size.width - fitting.width;
        newOrigin.x = currentFrame.origin.x + delta;
    }

    CGRect newBounds;
    newBounds.origin = newOrigin;
    newBounds.size = fitting;

    [self setFrame:newBounds];
}

- (CGSize)sizeThatFits:(CGSize)size {
    NSString *correctTitle;
    if ([self isSelected]) {
        correctTitle = [self confirmationTitle]; 
    } else {
        correctTitle = [self title];
    }

    CGSize labelSize = [correctTitle sizeWithFont:[[self titleLabel] font]];
    CGSize imageSize = [[self backgroundImageForState:[self state]] size];
    CGSize biggerSize;
    biggerSize.height = imageSize.height;
    biggerSize.width = 16 + labelSize.width;
    return biggerSize;
}


#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc {
    [title_ release];
    [confirmationTitle_ release];
    [super dealloc];
}


@end
