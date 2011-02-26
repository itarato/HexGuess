//
//  GameCenterManager.m
//  GuessHex
//
//  Created by Peter Arato on 2/23/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "GameCenterManager.h"
#import <GameKit/GKLocalPlayer.h>


static BOOL _isUserAuthenticated = NO;


@implementation GameCenterManager


+ (void)authenticateUser {
	// @TODO put it into a game manager class
	[[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		if (error == nil) {
			// Insert code here to handle a successful authentication.
			NSLog(@"GKLocalPlayer is authenticated.");
			_isUserAuthenticated = YES;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"GameCenterConnected" object:nil];
		} else {
			// Your application can process the error parameter to report the error to the player.
			NSLog(@"Error occured during GKLocalPlayer authentication.");
		}
	}];
}


+ (BOOL)isGameCenterAvailable {
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}


+ (BOOL)isUserAuthenticated {
	return _isUserAuthenticated;
}


+ (void)showDefaultErrorAlert {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GameCenter Error" message:@"Can't get results. Maybe there is no connection." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


@end
