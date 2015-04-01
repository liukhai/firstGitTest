//
//  UIButton+RoundCornerStyle.m
//  WellHonest
//
//  Created by MegaHub on 17/2/14.
//
//

#import "UIButton+RoundCornerStyle.h"
#import "MHUtility.h"

@implementation UIButton (RoundCornerStyle)

- (void) setNewRoundCornerStyle {
	
	if([MHUtility checkVersionGreater:@"7.0"]) {
		UIColor *ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
		
		self.layer.borderColor = ios7BlueColor.CGColor;
//		self.layer.borderColor = [[[UIApplication sharedApplication] delegate] window].tintColor.CGColor;
		self.layer.borderWidth = 1.0;
		self.layer.cornerRadius = 8.0;
		
		self.backgroundColor = [UIColor whiteColor];
		[self setTitleColor:ios7BlueColor forState:UIControlStateNormal];
		
		[self setNeedsDisplay];
	}
}

@end
