//
//  DCSPriceButton.h
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

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>


typedef enum {
    DCSPriceButtonStylePlain,            // iTunes
    DCSPriceButtonStylePlus,             // iTunes Plus
    DCSPriceButtonStyleAlbumOnly,        // iTunes Album Only
    DCSPriceButtonStyleBlue,             // App Store
    DCSPriceButtonStyleAlreadyPurchased, // App Store Installed
} DCSPriceButtonStyle;


@interface DCSPriceButton : UIButton {
  @private
    DCSPriceButtonStyle priceButtonStyle_;
    BOOL showingConfirmation_;
    BOOL leftAnchored_;
    NSString *title_;
    NSString *confirmationTitle_;
}

@property (nonatomic, readonly) DCSPriceButtonStyle priceButtonStyle;
@property (nonatomic, getter=isShowingConfirmation) BOOL showingConfirmation;
@property (nonatomic, getter=isLeftAnchored) BOOL leftAnchored;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *confirmationTitle;

+ (NSTimeInterval)defaultAnimationDuration;
+ (id)priceButtonWithStyle:(DCSPriceButtonStyle)style;

- (void)setShowingConfirmation:(BOOL)showingConfirmation
                      duration:(NSTimeInterval)duration;

@end
