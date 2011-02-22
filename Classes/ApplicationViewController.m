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
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pressStartGameButton:) name:@"PressStartGameButton" object:nil];

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
	[gameVC release];
	[setupVC release];
    [super dealloc];
}


#pragma mark -
#pragma mark Custom actions

- (void)pressStartGameButton:(NSNotification *)notification {
	
	if (gameVC == nil) {
		gameVC = [[GameViewController alloc] initWithNibName:@"GameView" bundle:nil];
	} else {
		[gameVC startNewRound];
	}
	[gameVC.view layoutSubviews];
	
	[UIView beginAnimations:@"Flip" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:UIVIEW_FLIP_ANIMATION_DURATION];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	
	UIViewController *_mainVC = (UIViewController *)[notification object];
	[_mainVC.view removeFromSuperview];
	[self.view insertSubview:gameVC.view atIndex:0];
	
	[UIView commitAnimations];
}


- (void)pressSetupSaveButton {
	if (gameVC == nil) {
		gameVC = [[GameViewController alloc] initWithNibName:@"GameView" bundle:nil];
	}
	[gameVC startNewRound];
	[gameVC.view layoutSubviews];
	
	[UIView beginAnimations:@"Flip" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:UIVIEW_FLIP_ANIMATION_DURATION];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
	[setupVC.view removeFromSuperview];
	[self.view insertSubview:gameVC.view atIndex:0];
	
	[UIView commitAnimations];
}


- (void)goToSetup {
	if (setupVC == nil) {
		setupVC = [[SetupViewController alloc] initWithNibName:@"SetupView" bundle:nil];
	}
	[setupVC.view layoutSubviews];
	
	[UIView beginAnimations:@"Flip" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:UIVIEW_FLIP_ANIMATION_DURATION];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	
	[gameVC.view removeFromSuperview];
	[self.view insertSubview:setupVC.view atIndex:0];
	
	[UIView commitAnimations];
}


- (void)finishGame {
	if (mainVC == nil) {
		mainVC = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	}
	[mainVC.view layoutSubviews];
	
	[UIView beginAnimations:@"Flip" context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:UIVIEW_FLIP_ANIMATION_DURATION];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
	[gameVC.view removeFromSuperview];
	[self.view insertSubview:mainVC.view atIndex:0];
	
	[UIView commitAnimations];
}


@end
