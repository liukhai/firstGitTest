//
//  MHUILabel.m
//  MagicTrader
//
//  Created by Megahub on 22/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MHUILabel.h"
#import "MHUtility.h"
#import "StyleConstant.h"
#import <QuartzCore/QuartzCore.h>
#import "MagicTraderAppDelegate.h"

@implementation MHUILabel
@synthesize m_oBackgroundImageView;

-(id)init{
	if(self = [super init]){
		self.backgroundColor	= [UIColor clearColor];
		self.textColor			= Default_label_text_color;
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame{
	if(self = [super initWithFrame:frame]){

		self.backgroundColor	= [UIColor clearColor];
		self.textColor			= Default_label_text_color;
		
		// Background image
		m_oBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
		[self addSubview:m_oBackgroundImageView];
	}
	
	return self;
}

- (void)dealloc {
	[m_oBackgroundImageView release];
	[super dealloc];
}

-(void)setBackgroundImage:(UIImage *)aImage{
	self.m_oBackgroundImageView.image = aImage;
}

-(void)setTextWithAnimation:(NSString *)aString color:(UIColor *)aAnimateColor duration:(double)aSecond animateIfNoChange:(BOOL)isAnimate{
	//if the old text == new text && animate when old text != new text -> isAnimate = YES
	if((!isAnimate) && [MHUtility equalsIgnoreCase:self.text anotherString:aString]){
		return;
	}
	
	//animate it whether it is oldtext == new text
	if (self.text != nil && [self.text length] > 0) {
		CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"backgroundColor"];
		theAnimation.duration = aSecond;
				
		theAnimation.toValue = (id)[MHUtility uicolorWithHexValueString:[MT_DELEGATE loadFlashColor]].CGColor;
		[self.layer addAnimation:theAnimation forKey:nil];
	}
	[self setText:aString];
}

-(void)setTextWithAnimationUseTextColor:(NSString *)aString duration:(double)aSecond animateIfNoChange:(BOOL)isAnimate{
	[self setTextWithAnimation:aString color:self.textColor duration:aSecond animateIfNoChange:isAnimate];
}

@end
