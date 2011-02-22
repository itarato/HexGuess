//
//  ColorBox.h
//  GsHex
//
//  Created by Peter Arato on 1/21/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HexColor;

@interface ColorBox : UIControl {
	UIColor *color;
	NSString *colorHexName;
	BOOL isWinner;
	BOOL isShowCode;
	UILabel *label;
}

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSString *colorHexName;
@property BOOL isWinner;
@property BOOL isShowCode;
@property (nonatomic, retain) UILabel *label;

- (id)initWithColor:(HexColor *)newColor showCode:(BOOL)isShowCode;
- (void)failed;
- (void)succeeded;
- (void)pressedBox:(id)sender;

@end
