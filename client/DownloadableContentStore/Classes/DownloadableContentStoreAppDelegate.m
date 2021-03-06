//
//  DownloadableContentStoreAppDelegate.m
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

#import "DownloadableContentStoreAppDelegate.h"


@implementation DownloadableContentStoreAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(windowDidBecomeHidden:)
                   name:UIWindowDidBecomeHiddenNotification
                 object:nil];
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}

- (void)windowDidBecomeHidden:(UIWindow *)hiddenWindow {
    if (hiddenWindow != window) {
        [window makeKeyAndVisible];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

