//
//  GuessHexAppDelegate.h
//  GuessHex
//
//  Created by Peter Arato on 2/10/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplicationViewController;

@interface GuessHexAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ApplicationViewController *applicationViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ApplicationViewController *applicationViewController;

+ (BOOL) isGameCenterAvailable;

@end

