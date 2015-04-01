//
//  Badge.m
//  BEA
//
//  Created by Algebra Lo on 10年7月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Badge.h"


@implementation Badge

-(void)setNumber:(int)number {
	if (number<=0) {
		self.hidden = TRUE;
		[self setTitle:@"0" forState:UIControlStateNormal];
		return;
	} else {
		self.hidden = FALSE;
	}

	[self setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
	if (number>999) {
		[self setBackgroundImage:[UIImage imageNamed:@"badge_4.png"] forState:UIControlStateNormal];
	} else if (number>99) {
		[self setBackgroundImage:[UIImage imageNamed:@"badge_3.png"] forState:UIControlStateNormal];
	} else if (number>9) {
		[self setBackgroundImage:[UIImage imageNamed:@"badge_2.png"] forState:UIControlStateNormal];
	} else {
		[self setBackgroundImage:[UIImage imageNamed:@"badge_1.png"] forState:UIControlStateNormal];
	}
}

-(int)getNumber {
	return [[self titleForState:UIControlStateNormal] intValue];
}

@end
