//
//  LoadingView.h
//  MagicTrader
//
//  Created by Hong on 18/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//


/*
 
 Version 20110531
	- added functions to control if there are the Text Loading and the black blackground
 
 
 */
 
 
 
#import <UIKit/UIKit.h>


@interface LoadingView : UIView {
	
	UIView						*m_oLoadingMask;
	UILabel						*m_oLoadingLabel;
	UIActivityIndicatorView		*m_oSpinner;
	
	NSTimer						*m_oLoadingTimer;
	
	BOOL						m_isHaveBg;
	BOOL						m_isHaveLoadingText;
}

@property (nonatomic, retain) UIView						*m_oLoadingMask;
@property (nonatomic, retain) UILabel						*m_oLoadingLabel;
@property (nonatomic, retain) UIActivityIndicatorView		*m_oSpinner;

// size is (100, 100) is gooood
- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;

// set if there is a black background behind the spinner
- (void)setHaveBackground:(BOOL)aBool;
- (void)setHaveLoadingText:(BOOL)aBool;

- (void)reloadText;
- (void)startLoading;
- (void)stopLoading;

@end
