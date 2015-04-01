//
//  UpdateUIButton.m
//  MagicTraderChief
//
//  Created by Megahub on 24/08/2010.
//  Copyright 2010 Megahub. All rights reserved.
//

#import "UpdateUIButton.h"


@implementation UpdateUIButton
//@synthesize updateColor;

//-(void)setUpdateColor:(UIColor *)color{
////	[self setUpdateColor:color];
//	updateColor = color;
//}

-(void)updateLabel:(NSString *)newLabel Color:(UIColor *)color duration:(double)second{
	if (![self.titleLabel.text isEqualToString:newLabel]) {
		UIColor *orgColor = self.backgroundColor;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		self.backgroundColor = color;
		[UIView commitAnimations];
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		self.backgroundColor = orgColor;
		[self setTitle:newLabel forState:UIControlStateNormal];
		[UIView commitAnimations];
		
	}
}

-(void)updateLabelEvenNoChange:(NSString *)newLabel Color:(UIColor *)color duration:(double)second{
	UIColor *orgColor = self.backgroundColor;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	self.backgroundColor = color;
	[UIView commitAnimations];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	self.backgroundColor = orgColor;
	[self setTitle:newLabel forState:UIControlStateNormal];
	[UIView commitAnimations];
}

@end
