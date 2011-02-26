    //
//  GameViewController.m
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "GameViewController.h"
#import "HexColor.h"
#import "ColorBox.h"
#import "GuessHexAppDelegate.h"
#import "ApplicationViewController.h"
#import <GameKit/GKScore.h>
#import "GameCenterManager.h"

#define COLOR_BOX_PADDING 8.0
#define COLOR_BOX_WIDTH 70.0
#define COLOR_BOX_HEIGHT 80.0

#define DEFAULT_COLOR_NUM 3
#define FAILED_HEXCODE_SHOW 1
#define FAILED_HEXCODE_DO_NOT_SHOW 2


@implementation GameViewController

@synthesize winnerIDX;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorIsSelected:) name:@"ColorBoxSelected" object:nil];
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
	[self startNewRound];
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
//	colorLabel = nil;
//	setupButton	= nil;
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[scrollView release];
	scrollView = nil;
	[colorLabel release];
	colorLabel = nil;
	[setupButton release];
	setupButton = nil;
	[bestSeriesLabel release];
	bestSeriesLabel = nil;
	[currentSeriesLabel release];
	currentSeriesLabel = nil;
	[homeButton release];
	homeButton = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Custom Actions

- (void)startNewRound {
	// Remove all the color boxes
	[self clearColors];
	wrongGuessFlag = NO;
	currentSeriesLabel.text = [NSString stringWithFormat:@"%d", winningSeriesCount];
	bestSeriesLabel.text = [NSString stringWithFormat:@"%d", [GameViewController getSeriesBestForColorNumber:[GameViewController getColorNum]]];
	
	self.winnerIDX = arc4random() % [GameViewController getColorNum];
	
	int total = [GameViewController getColorNum];
	for (int i = 0; i < total; i++) {
		HexColor *hc = [[HexColor alloc] initWithRandomColor];
		
		ColorBox *cb = [[ColorBox alloc] initWithColor:hc showCode:[GameViewController getShowFailedHexcode]];
		[scrollView addSubview:cb];
		float lastLineCorrection = floor(((float)i + 0.5) * 0.25) == floor(((float)total - 0.5) * 0.25) ? 0.5 * (3 - ((total - 1) % 4)) * (COLOR_BOX_PADDING + COLOR_BOX_WIDTH) : 0.0;
		cb.center = CGPointMake(
			(i % 4) * (COLOR_BOX_PADDING + COLOR_BOX_WIDTH) + COLOR_BOX_PADDING + (COLOR_BOX_WIDTH * 0.5) + lastLineCorrection, 
			floor(i / 4.0) * (COLOR_BOX_HEIGHT + COLOR_BOX_PADDING) + (4 - floor((total - 0.5) / 4.0)) * (COLOR_BOX_HEIGHT + COLOR_BOX_PADDING) * 0.5
		);
	
		if (i == self.winnerIDX) {
			colorLabel.text = [hc getHexName];
			cb.isWinner = YES;
		}

		[hc release];
	}
	
	[scrollView layoutSubviews];
}


- (void)colorIsSelected:(NSNotification *)notification {
	ColorBox *cb = (ColorBox *)[notification object];
	if (cb.isWinner) {
		BOOL newRecord = NO;
		if (!wrongGuessFlag) {
			winningSeriesCount++;
			newRecord = [self checkBestSeries];
		}
		
		UIAlertView *alert;
		if (newRecord) {
			alert = [[UIAlertView alloc] initWithTitle:@"New record!" message:[NSString stringWithFormat:@"%d perfect guess in a row with %d colors.", winningSeriesCount, [GameViewController getColorNum]] delegate:self cancelButtonTitle:@"New game" otherButtonTitles:nil];
		} else if (!wrongGuessFlag) {
			alert = [[UIAlertView alloc] initWithTitle:@"Nice catch!" message:@"Congratulation, you were right!" delegate:self cancelButtonTitle:@"New game" otherButtonTitles:nil];
		} else {
			alert = [[UIAlertView alloc] initWithTitle:@"Finally!" message:@"Don't give it up." delegate:self cancelButtonTitle:@"New game" otherButtonTitles:nil];
		}

		[alert show];
		[alert release];
		[cb succeeded];
	} else {
		wrongGuessFlag = YES;
		winningSeriesCount = 0;
		[cb failed];
	}
	// @todo check it out
//	[cb release];
}


- (IBAction)pressHomeButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoHome" object:self];
}

- (IBAction)pressSetupButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoSetup" object:self];
}


#pragma mark -
#pragma mark UIAlertViewDelegate functions

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self clearColors];
	[self startNewRound];
}


#pragma mark -
#pragma mark Custom functions

- (void)clearColors {
	NSArray *cbs = [scrollView subviews];
	for (UIView *subview in cbs) {
		[subview removeFromSuperview];
	}
}


- (BOOL)checkBestSeries {
	int colorNum = [GameViewController getColorNum];
	if (winningSeriesCount > [GameViewController getSeriesBestForColorNumber:colorNum]) {
		[GameViewController setSeriesBestForColorNumber:colorNum value:winningSeriesCount];
		
		if ([GameCenterManager isUserAuthenticated]) {
			GKScore *score = [[[GKScore alloc] initWithCategory:[NSString stringWithFormat:@"colornum_%d", [GameViewController getColorNum]]] autorelease];
			score.value = winningSeriesCount;
			[score reportScoreWithCompletionHandler:^(NSError *error) {
				if (error == nil) {
					NSLog(@"GKScore is saved.");
				} else {
					NSLog(@"Failed to save GKScore.");
				}
			}];
		}
		
		return YES;
	}
	
	return NO;
}


+ (int)getColorNum {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	int defaultColorNum = [defaults integerForKey:@"colorNum"];
	if (!defaultColorNum) {
		defaultColorNum = DEFAULT_COLOR_NUM;
	}
	
	return defaultColorNum;
}


+ (void)setColorNum:(int)newValue {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:newValue forKey:@"colorNum"];
	[defaults synchronize];
}


+ (BOOL)getShowFailedHexcode {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	int value = [defaults integerForKey:@"showFailedHexcode"];
	if (!value || value <= 0 || value == FAILED_HEXCODE_SHOW) {
		return YES;
	}
	
	return NO;
}


+ (void)setShowFailedHexcode:(BOOL)newValue {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setInteger:(newValue ? FAILED_HEXCODE_SHOW : FAILED_HEXCODE_DO_NOT_SHOW) forKey:@"showFailedHexcode"];
	[defaults synchronize];
}



+ (int)getSeriesBestForColorNumber:(int)colorNumber {
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	return [defs integerForKey:[NSString stringWithFormat:@"longestSeriesWith %d", colorNumber]];
}


+ (void)setSeriesBestForColorNumber:(int)colorNumber value:(int)value {
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	[defs setInteger:value forKey:[NSString stringWithFormat:@"longestSeriesWith %d", colorNumber]];
	[defs synchronize];
}


@end
