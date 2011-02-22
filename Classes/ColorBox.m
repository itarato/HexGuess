//
//  ColorBox.m
//  GsHex
//
//  Created by Peter Arato on 1/21/11.
//  Copyright 2011 Pronovix. All rights reserved.
//

#import "ColorBox.h"
#import "HexColor.h"


@implementation ColorBox

@synthesize color;
@synthesize colorHexName;
@synthesize isWinner;
@synthesize isShowCode;
@synthesize label;


- (id)initWithColor:(HexColor *)newColor showCode:(BOOL)isShowCodeValue {	
	if ((self = [super initWithFrame:CGRectMake(0, 0, 70, 80)])) {
		self.isShowCode = isShowCodeValue;

		self.color = [newColor getColor];
		self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
		self.isWinner = NO;
		
		self.label = [[UILabel alloc] initWithFrame:CGRectMake(3.0, 54.0, 64.0, 24.0)];
		self.label.textAlignment = UITextAlignmentCenter;
		self.label.text = [newColor getHexName];
		self.label.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
		self.label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
		self.label.font = [UIFont boldSystemFontOfSize:12.0];
		
		self.label.alpha = 0.0;
		[self addSubview:self.label];
		
		[self addTarget:self action:@selector(pressedBox:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGRect box_rect = CGRectMake(3.0, 3.0, 64.0, 74.0);
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetFillColor(c, CGColorGetComponents(self.color.CGColor));
	CGContextFillRect(c, box_rect);
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesEnded:touches withEvent:event];
}


- (void)pressedBox:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ColorBoxSelected" object:self];
}


- (void)dealloc {
	[self.label dealloc];
	[self.color release];
	[self.colorHexName release];
    [super dealloc];
}


- (void)failed {
	self.backgroundColor = [UIColor lightGrayColor];
	self.label.alpha = self.isShowCode ? 1.0 : 0.0;
}

- (void)succeeded {
	self.backgroundColor = [UIColor orangeColor];
	self.label.alpha = self.isShowCode ? 1.0 : 0.0;
}

@end
