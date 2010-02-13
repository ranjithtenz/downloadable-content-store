//
//  DCSTouchCaptureView.m
//  DCSKit
//
//  Created by Randy Becker on 2/12/10.
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

#import "DCSTouchCaptureView.h"


@implementation DCSTouchCaptureView

@synthesize passThroughViews=passThroughViews_;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self passThroughViews]) {
            CGPoint subviewPoint = [self convertPoint:point toView:subview];
            if ([subview pointInside:subviewPoint withEvent:event] &&
                ![subview isHidden] &&
                [subview isUserInteractionEnabled] &&
                [subview alpha] > 0.1
            ) {
                return [subview hitTest:subviewPoint withEvent:event];
            }
        }
        return self;
    }
    return nil;
}

- (void)dealloc {
    [passThroughViews_ release];
    [super dealloc];
}

@end
