//
//  HexColor.h
//  GsHex
//
//  Created by Peter Arato on 1/21/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HexColor : NSObject {
	int r256;
	int g256;
	int b256;
}

@property int r256;
@property int g256;
@property int b256;

- (id)initWithRandomColor;
- (NSString *)getHexName;
- (UIColor *)getColor;

+ (NSString *)intToHexString:(int)value;

@end
