	//
	//  UpdateUITableViewCell.m
	//  PhoneStream
	//
	//  Created by Megahub on 08/09/2010.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "UpdateUITableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@implementation UpdateUITableViewCell
-(void)displayAnimationWithDuration:(double)second{
		UIColor *targetColor;
		targetColor = [UIColor blueColor];
		
		CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
		theAnimation.duration = second;
		theAnimation.toValue = (id)targetColor.CGColor;
		[self.layer addAnimation:theAnimation forKey:nil];
}




@end
