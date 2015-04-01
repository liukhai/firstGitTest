//
//  SegmentedButton.h
//  TedSegmentedControl
//
//  Created by __MyCompanyName__ on 20/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
 Version 201203016
 - Added: function: - (UIButton *)getButtonAtIndex:(int)aIndex  {
 
 Version 20120305
 - Added: Function: removeAllButton, which remove all the button from superview and in the buttonarray.
 
 Version 20120224
 - Added     UIButton *btn = ([m_oButtonArray count] > aIndex || aIndex <0 )?@"":[m_oButtonArray objectAtIndex:aIndex];
 
 Version 20120111
 - Added: Variable: m_iPrevSelectedIndex
 
 Version 20120105
 - Added: functions: - (NSString *)getButtonTitle:(int)aIndex ;
 
 Version 20120103
 - Added: functions: - (id)initWithFrame:(CGRect)frame scrollable:(BOOL)aScrol ;
 
 Version 20110927
 - Added: setDisplayButton
 
 Version 20110915
 - Fixed: press the triangle (circled in red) in trading interface, the system will force me to quit to desktop.
 
 Version 20110613
 - Ben: 喂喂 你release system d 野呀
 
 Version 20110609
 - Fixed: m_iSelectedIndex will set as "-1" when init
 
 Version 20110531
 - Added: - (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray enableScroll:(BOOL)aEnableScroll {
 
 Version 20110516
 - Added: m_oBackgroundImageView for setting the background image of the scroll view
 - Added: m_oButtonFont for setting the font size of the button title
 - Added: m_oLeftArrowButton and m_oRightArrowButton
 
 Version 20110330
 - Added: functions for setting the left and right most button both selected and not selected images
 
 Version 20110310
 - Added: [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
 - Added: - (void)setSelectedButtonIndex:(int)aIndex;
 - Added: - (void)setButtonFont:(UIFont *)aFont;
 
 */

#import <UIKit/UIKit.h>


@interface SegmentedButton : UIView {
	UIImageView			*m_oBackgroundImageView;
	
	UIScrollView		*m_oScrollView;
	
	NSMutableArray		*m_oButtonArray;
	UIImage				*m_oSelectedImage;
	UIImage				*m_oUnSelectedImage;
	
	UIImage				*m_oLeftSelectedImage;
	UIImage				*m_oLeftUnSelectedImage;
	
	UIImage				*m_oRightSelectedImage;
	UIImage				*m_oRightUnSelectedImage;
	
	UIColor				*m_oUnSelectButtonTitleColor;
	UIColor				*m_oSelectedButtonTitleColor;
	
	UIButton			*m_oLeftArrowButton;
	UIButton			*m_oRightArrowButton;
	
	id					m_oTarget;
	SEL					m_oSelector;
	
	int                 m_iSelectedIndex;
    int                 m_iPrevSelectedIndex;
	Byte				m_iButtonNumberOfLine;
	UIFont				*m_oButtonFont;
	
	BOOL				m_isButtonEqualSize;
    BOOL                m_isScrollable;
}

@property(nonatomic, readonly) int m_iPrevSelectedIndex;    // the before selected index
@property(nonatomic, readonly) int m_iSelectedIndex;        // the current selected index

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame scrollable:(BOOL)aScrol ;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray;// fixed size
- (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray enableScroll:(BOOL)aEnableScroll buttonFrame:(CGSize)aBtnSize; // fixed equal size of button
- (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray enableScroll:(BOOL)aEnableScroll;	// variable size
- (void)reloadText;
- (void)dealloc;
- (void)setButtonTitle:(NSArray *)aTitleArrayInAscendingOrder;
- (void)onButtonPressed:(id)sender;
- (void)reloadButtonSizeEvenly;
- (void)reloadButtonSize;

// Public
- (void)setBackgroundImage:(UIImage *)aImage;
- (void)setButtonSelectedImage:(UIImage *)aImage;
- (void)setButtonUnSelectedImage:(UIImage *)aImage;
- (void)setLeftButtonSelectedImage:(UIImage *)aImage;
- (void)setLeftButtonUnSelectedImage:(UIImage *)aImage;
- (void)setRightButtonSelectedImage:(UIImage *)aImage;
- (void)setRightButtonUnSelectedImage:(UIImage *)aImage;

- (void)setButtonSelectedColor:(UIColor *)aSelectedColor unselectedColor:(UIColor *)aUnselectedColor;


- (void)setShowsTouchWhenHighlighted:(BOOL)aBoolean;
- (void)addTarget:(id)aTarget action:(SEL)aSelector forControlEvents:(UIControlEvents)aControlEvents;
- (void)setSelectedButtonIndex:(int)aIndex;
- (void)setSelectedButtonIndexDisplay:(int)aIndex ;
- (void)setDeselectButtonIndex;
- (void)setButtonFont:(UIFont *)aFont;

- (void)setLeftArrowImage:(UIImage *)aImage;
- (void)setRightArrowImage:(UIImage *)aImage;
- (void)onLeftButtonPressed:(id)sender;
- (void)onRightButtonPressed:(id)sender;

- (void)setDisplayButton:(int)aIndex animated:(BOOL)aAnimated ;
- (NSString *)getButtonTitle:(int)aIndex ;
- (UIButton *)getButtonAtIndex:(int)aIndex ;
- (NSArray *)getButtonArray ;
- (void)removeAllButton ;

@end
