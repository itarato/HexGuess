    //
//  MainViewController.m
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "MainViewController.h"
#import <GameKit/GKLeaderboardViewController.h>


@implementation MainViewController

@synthesize startButton;
@synthesize settingsButton;
@synthesize leaderBoardButton;
@synthesize helpButton;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameCenterIsConnected:) name:@"GameCenterConnected" object:nil];
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIImage *startButtonImage = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableImage = [startButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[startButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];
	[settingsButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];
	[leaderBoardButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];
	[helpButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];
	
	self.leaderBoardButton.enabled = NO;
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
	[startButton release];
	startButton = nil;
	[settingsButton release];
	settingsButton = nil;
	[leaderBoardButton release];
	leaderBoardButton = nil;
	[helpButton release];
	helpButton = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Custom actions

- (IBAction) pressStartGameButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoGame" object:self];
}


- (IBAction)pressSettingsButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoSetup" object:self];
}


- (IBAction)pressLeaderBoardButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoLeaderBoard" object:self];
}


- (IBAction)pressHelpButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoHelp" object:self];
}


- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	[self dismissModalViewControllerAnimated:YES];
}


- (void)gameCenterIsConnected:(NSNotification *)notification {
	self.leaderBoardButton.enabled = YES;
}

@end
