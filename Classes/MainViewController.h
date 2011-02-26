//
//  MainViewController.h
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GKLeaderboardViewController.h>

@interface MainViewController : UIViewController <GKLeaderboardViewControllerDelegate> {
	UIButton *startButton;
	UIButton *settingsButton;
	UIButton *leaderBoardButton;
	UIButton *helpButton;
}

@property (nonatomic, retain) IBOutlet UIButton *startButton;
@property (nonatomic, retain) IBOutlet UIButton *settingsButton;
@property (nonatomic, retain) IBOutlet UIButton *leaderBoardButton;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;

- (IBAction)pressStartGameButton:(id)sender;
- (IBAction)pressSettingsButton:(id)sender;
- (IBAction)pressLeaderBoardButton:(id)sender;
- (IBAction)pressHelpButton:(id)sender;

- (void)gameCenterIsConnected:(NSNotification *)notification;

@end
