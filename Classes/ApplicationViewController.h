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
@class HelpViewController;

@interface ApplicationViewController : UIViewController {
	MainViewController *mainVC;
	GameViewController *gameVC;
	SetupViewController *setupVC;
	HelpViewController *helpVC;
	BOOL isSetupAskedFromGame;
}

- (void)goToGame:(NSNotification *)notification;
- (void)goToSetup:(NSNotification *)notification;
- (void)goToLeaderBoard:(NSNotification *)notification;
- (void)goToHelp:(NSNotification *)notification;
- (void)goToHome:(NSNotification *)notification;
- (void)settingsSaved:(NSNotification *)notification;

- (void)finishGame;

- (void)swapViews:(UIView *)newView;

@end
