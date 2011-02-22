//
//  SetupViewController.h
//  GsHex
//
//  Created by Peter Arato on 1/17/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SetupViewController : UIViewController <UIActionSheetDelegate> {
	IBOutlet UILabel *colorNumLabel;
	IBOutlet UISlider *slider;
	UIButton *saveButton;
	UISwitch *showFailedHexcodeSwitch;
	UIButton *resetButton;
	int colorNum;
}

@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UISwitch *showFailedHexcodeSwitch;
@property (nonatomic, retain) IBOutlet UIButton *resetButton;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)pressedSaveButton:(id)sender;
- (IBAction)pressedShowFailedHexcodesButton:(id)sender;
- (IBAction)pressedResetButton:(id)sender;

@end
