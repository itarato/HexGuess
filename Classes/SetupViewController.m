    //
//  SetupViewController.m
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "SetupViewController.h"
#import "GuessHexAppDelegate.h"
#import "ApplicationViewController.h"
#import "GameViewController.h"


@implementation SetupViewController

@synthesize saveButton;
@synthesize showFailedHexcodeSwitch;
@synthesize resetButton;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
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
	slider.value = (float)[GameViewController getColorNum];
	colorNumLabel.text = [NSString stringWithFormat:@"%d", [GameViewController getColorNum]];
	
	UIImage *saveButtonImage = [UIImage imageNamed:@"whiteButton"];
	UIImage *strechedSaveButtonImage = [saveButtonImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[saveButton setBackgroundImage:strechedSaveButtonImage forState:UIControlStateNormal];
	[resetButton setBackgroundImage:strechedSaveButtonImage forState:UIControlStateNormal];
	
	[showFailedHexcodeSwitch setOn:[GameViewController getShowFailedHexcode] animated:NO];
	
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
	[colorNumLabel release];
	colorNumLabel = nil;
	[slider release];
	slider = nil;
	[saveButton release];
	saveButton = nil;
	[showFailedHexcodeSwitch release];
	showFailedHexcodeSwitch = nil;
	[resetButton release];
	resetButton = nil;
    [super dealloc];
}


- (IBAction)sliderValueChanged:(id)sender {
	colorNumLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
	[GameViewController setColorNum:(int)slider.value];
}


- (IBAction)pressedSaveButton:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsSaved" object:nil];
}


- (IBAction)pressedShowFailedHexcodesButton:(id)sender {
	[GameViewController setShowFailedHexcode:showFailedHexcodeSwitch.on];
}


- (IBAction)pressedResetButton:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] 
								  initWithTitle:@"Are you sure?"
								  delegate:self 
								  cancelButtonTitle:@"No, leave as it is" 
								  destructiveButtonTitle:@"Yes, reset, please" 
								  otherButtonTitles:nil];
	[actionSheet showInView:self.view];
	[actionSheet release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
//		int i;
//		for (i = 2; i <= 16; i++) {
//			[GameViewController setSeriesBestForColorNumber:i value:0];
//		}
		[GameViewController setShowFailedHexcode:YES];
		[GameViewController setColorNum:3];
		slider.value = 3.0;
		colorNumLabel.text = @"3";
		showFailedHexcodeSwitch.on = YES;
	}
}

@end
