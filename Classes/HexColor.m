//
//  HexColor.m
//  GsHex
//
//  Created by Peter Arato on 1/21/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "HexColor.h"


@implementation HexColor

@synthesize r256;
@synthesize g256;
@synthesize b256;


- (id)initWithRandomColor {
	if ((self = [super init])) {
		self.r256 = arc4random() % 256;
		self.g256 = arc4random() % 256;
		self.b256 = arc4random() % 256;
	}
	return self;
}

- (NSString *)getHexName {
	return [NSString stringWithFormat:@"#%@%@%@",	
			[HexColor intToHexString:r256],
			[HexColor intToHexString:g256],
			[HexColor intToHexString:b256]];
}


- (UIColor *)getColor {
	float r = (r256 == 0) ? 0 : (float)r256 / 255.0;
	float g = (g256 == 0) ? 0 : (float)g256 / 255.0;
	float b = (b256 == 0) ? 0 : (float)b256 / 255.0;
	return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}


#pragma mark -
#pragma mark Custom functions

+ (NSString *)intToHexString:(int)value {
	NSString *digits = @"0123456789ABCDEF";
	return [NSString stringWithFormat:@"%c%c",[digits characterAtIndex:floor(value / 16)], [digits characterAtIndex:(value % 16)]];
}

@end
