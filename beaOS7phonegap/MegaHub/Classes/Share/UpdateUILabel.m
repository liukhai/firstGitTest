	//
	//  UpdateUILabel.m
	//  MagicTraderChief
	//
	//  Created by Megahub on 24/08/2010.
	//  Copyright 2010 Megahub. All rights reserved.
	//

#import "UpdateUILabel.h"
#import <QuartzCore/QuartzCore.h>


@implementation UpdateUILabel

-(void)updateLabel:(NSString *)newLabel Color:(UIColor *)color duration:(double)second{
	if (![self.text isEqualToString:newLabel]) {
		CABasicAnimation *theAnimation=[CABasicAnimation 
										animationWithKeyPath:@"backgroundColor"];
		theAnimation.duration = second;
		theAnimation.toValue = (id)color.CGColor;
		[self.layer addAnimation:theAnimation forKey:nil];
		[self setText:newLabel];
	}
}


@end
