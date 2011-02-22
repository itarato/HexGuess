//
//  GameViewController.h
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GameViewController : UIViewController <UIAlertViewDelegate> {
	IBOutlet UIScrollView *scrollView;
	IBOutlet UILabel *colorLabel;
	IBOutlet UIButton *setupButton;
	
	int winnerIDX;
	int winningSeriesCount;
	BOOL wrongGuessFlag;
}

@property int winnerIDX;

- (IBAction)pressSetupButton:(id)sender;
- (void)startNewRound;
- (void)clearColors;
- (BOOL)checkBestSeries;


+ (int)getColorNum;
+ (void)setColorNum:(int)newValue;

+ (BOOL)getShowFailedHexcode;
+ (void)setShowFailedHexcode:(BOOL)newValue;

+ (int)getSeriesBestForColorNumber:(int)colorNumber;
+ (void)setSeriesBestForColorNumber:(int)colorNumber value:(int)value;


@end
