    //
//  HelpViewController.m
//  GuessHex
//
//  Created by Peter Arato on 2/25/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "HelpViewController.h"


@implementation HelpViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization.
//    }
//    return self;
//}



// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView {
//	[super loadView];
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	UIImage *bgr = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchedBgr = [bgr stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[okButton setBackgroundImage:stretchedBgr forState:UIControlStateNormal];
	
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[okButton release];
	okButton = nil;
    [super dealloc];
}


- (IBAction)pressedOK:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"GoHome" object:self];
}


@end
