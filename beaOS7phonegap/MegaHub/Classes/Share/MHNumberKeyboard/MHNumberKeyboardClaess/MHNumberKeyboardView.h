//
//  MHNumberKeyboardView.h
//  MHNumberKeyboard
//
//  Created by Hong on 04/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

/*
 Version 2011-07-06
 // 20110706
 //if ([m_oTextField.delegate textField:m_oTextField shouldChangeCharactersInRange:range replacementString:m_sTextFieldText] == NO){ ->
 if ([m_oTextField.delegate textField:m_oTextField shouldChangeCharactersInRange:range replacementString:aInput] == NO){
 
 Version 2011-03-29
 - Added: sound setting,
 - Added: 000 enable setting
 - Fixed: return value of range.length
 
 
 Version 2011-03-08
 - Added: function: + (void)dismissWithoutReturn;
 
 Version 2011-02-21
 - Added: comma when editing the textfield
 
 */

#import <UIKit/UIKit.h>
#import "SoundEffect.h"


@interface MHNumberKeyboardView : UIView {
	
	UIButton			*m_oEnterButton;
	UIButton			*m_oDeleteButton;
	UIButton			*m_oDecimalButton;
	UIButton			*m_oClearButton;
	
	UIButton			*m_o0Button;
	UIButton			*m_o00Button;
	UIButton			*m_o1Button;
	UIButton			*m_o2Button;
	UIButton			*m_o3Button;
	UIButton			*m_o4Button;
	UIButton			*m_o5Button;
	UIButton			*m_o6Button;
	UIButton			*m_o7Button;
	UIButton			*m_o8Button;
	UIButton			*m_o9Button;
	
	BOOL				 m_isShownIndicator;
	
	SoundEffect			*m_oPressSound;
}

@property (nonatomic, retain) UIButton			*m_oEnterButton;
@property (nonatomic, retain) UIButton			*m_oDeleteButton;
@property (nonatomic, retain) UIButton			*m_oDecimalButton;
@property (nonatomic, retain) UIButton			*m_oClearButton;
@property (nonatomic, retain) UIButton			*m_o00Button;


- (id)initWithTextField:(UITextField *)aTextField;

// Update TextField
- (void)appendText:(NSString *)aInput;
- (void)deleteACharacter;
- (void)clearTextField;
- (void)reloadView;

// Button call back functions
- (void)onButtonPressed:(id)senderButton;

// show and dismiss
+ (BOOL)show:(UITextField *)aTextField;
//- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;
+ (void)dismissWithoutReturn;
+ (void)dismiss;

+ (BOOL)isShownKeyboard;

+ (void)setZeroCount:(int)aZeroCount;
+ (void)setDecimalPlace:(int)aDecimalPlace;
+ (int)getDecimalPlace;
+ (void)setEnableComma:(BOOL)aBoolean;
+ (BOOL)getEnanbleComma;
+ (void)setTribleZeroButton:(BOOL)aBool;
+ (BOOL)getEnableTribleZeroButton;
+ (void)setEnableSound:(BOOL)aBool;
+ (BOOL)getEnableSound;

@end



