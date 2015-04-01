//
//  MHUILabel.h
//  MagicTrader
//
//  Created by Megahub on 22/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MHUILabel : UILabel {
	UIImageView		*m_oBackgroundImageView;
}

@property (nonatomic, retain) UIImageView *m_oBackgroundImageView;

-(void)setBackgroundImage:(UIImage *)aImage;
-(void)setTextWithAnimation:(NSString *)aString color:(UIColor *)aAnimateColor duration:(double)aSecond animateIfNoChange:(BOOL)isAnimate;

//Default will use text color as animation color 
-(void)setTextWithAnimationUseTextColor:(NSString *)aString duration:(double)aSecond animateIfNoChange:(BOOL)isAnimate;

@end
