//
//  ApplicationViewController.h
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class GameViewController;
@class SetupViewController;

@interface ApplicationViewController : UIViewController {
	MainViewController *mainVC;
	GameViewController *gameVC;
	SetupViewController *setupVC;
}

- (void)pressStartGameButton:(NSNotification *)notification;
- (void)pressSetupSaveButton;
- (void)goToSetup;
- (void)finishGame;

@end
