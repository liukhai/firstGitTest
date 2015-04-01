//
//  MHDisclaimerBarView.h
//  WingFung
//
//  Created by Hong on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MHDisclaimerBarView : UIView {
	UILabel				*m_oTextLabel;
	UILabel				*m_oDelayTextLabel;
	UILabel				*m_oTextUPLabel;
	UIImageView			*m_oImageLabel;
	
	UIButton			*m_oLeftButton;
	UIButton			*m_oRightButton;
	
}

@property (nonatomic, retain) UILabel				*m_oTextLabel;
@property (nonatomic, retain) UILabel				*m_oDelayTextLabel;
@property (nonatomic, retain) UILabel				*m_oTextUPLabel;
@property (nonatomic, retain) UIImageView			*m_oImageLabel;
@property (nonatomic, retain) UIButton				*m_oLeftButton;
@property (nonatomic, retain) UIButton				*m_oRightButton;

// get the best size of this view
+ (CGSize)getSize;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;

// Button callback functions
- (void)onLeftButtonPressed:(id)sender;
- (void)onRightButtonPressed:(id)sender;

@end
