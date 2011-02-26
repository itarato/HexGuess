    //
//  ApplicationViewController.m
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "ApplicationViewController.h"

#import "MainViewController.h"
#import "GameViewController.h"
#import "SetupViewController.h"
#import "HelpViewController.h"
#import "GameCenterManager.h"
#import <GameKit/GKLeaderboardViewController.h>

#define UIVIEW_FLIP_ANIMATION_DURATION 0.8

@implementation ApplicationViewController


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[GameCenterManager authenticateUser];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToGame:)		name:@"GoGame"			object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToSetup:)		name:@"GoSetup"			object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToLeaderBoard:)	name:@"GoLeaderBoard"	object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToHelp:)		name:@"GoHelp"			object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToHome:)		name:@"GoHome"			object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsSaved:)	name:@"SettingsSaved"	object:nil];
	
	mainVC = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	[self.view insertSubview:mainVC.view atIndex:0];
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mainVC release];
	mainVC = nil;
	[gameVC release];
	gameVC = nil;
	[setupVC release];
	setupVC = nil;
	[helpVC release];
	helpVC = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Custom actions

- (void)goToGame:(NSNotification *)notification {
	if (gameVC == nil) {
		gameVC = [[GameViewController alloc] initWithNibName:@"GameView" bundle:nil];
	} else {
		[gameVC startNewRound];
	}
	[gameVC.view layoutSubviews];
	[self swapViews:gameVC.view];
}


- (void)goToLeaderBoard:(NSNotification *)notification {
	if (![GameCenterManager isGameCenterAvailable] || ![GameCenterManager isUserAuthenticated]) {
		[GameCenterManager showDefaultErrorAlert];
		return;
	}
	
	GKLeaderboardViewController *leaderboard = [[GKLeaderboardViewController alloc] init];
	if (leaderboard != NULL) {
		leaderboard.category = @"colornum_2";
		leaderboard.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboard.leaderboardDelegate = mainVC;
		[mainVC presentModalViewController:leaderboard animated:YES];
		[leaderboard release];
	}
	// @TODO handle error
}


- (void)goToHelp:(NSNotification *)notification {
	if (helpVC == nil) {
		helpVC = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
	}
	[helpVC.view layoutSubviews];
	[self swapViews:helpVC.view];
}


- (void)goToSetup:(NSNotification *)notification {
	if (setupVC == nil) {
		setupVC = [[SetupViewController alloc] initWithNibName:@"SetupView" bundle:nil];
	}
	[setupVC.view layoutSubviews];
	[self swapViews:setupVC.view];
	isSetupAskedFromGame = [[notification object] isKindOfClass:[GameViewController class]];
}


- (void)goToHome:(NSNotification *)notification {
	if (mainVC == nil) {
		mainVC = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	}
	[mainVC.view layoutSubviews];
	[self swapViews:mainVC.view];
}


- (void)settingsSaved:(NSNotification *)notification {
	if (isSetupAskedFromGame) {
		[self goToGame:notification];
	} else {
		[self goToHome:notification];
	}
	isSetupAskedFromGame = NO;
}


- (void)finishGame {
	if (mainVC == nil) {
		mainVC = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	}
	[mainVC.view layoutSubviews];
	[self swapViews:mainVC.view];
}


- (void)swapViews:(UIView *)newView {
	[UIView beginAnimations:@"Flip" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:UIVIEW_FLIP_ANIMATION_DURATION];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	[(UIView *)[self.view.subviews objectAtIndex:0] removeFromSuperview];
	[self.view insertSubview:newView atIndex:0];
	[UIView commitAnimations];
}



@end
