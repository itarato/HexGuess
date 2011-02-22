//
//  MainViewController.h
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController {
	UIButton *startButton;
}

@property (nonatomic, retain) IBOutlet UIButton *startButton;

- (IBAction) pressStartGameButton:(id)sender;

@end
