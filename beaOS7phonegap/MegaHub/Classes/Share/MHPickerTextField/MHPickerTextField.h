//
//  MHPickerTextField.h
//  Test
//
//  Created by MegaHub on 30/09/2010.
//  Copyright 2010 MegaHub. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 Version 20140805 Chris
 Support iOS 8: Change inputView of textField
 - touch on dismiss view as inputAccessoryView
 - pickerView and toolbar as inputView
 
 Version 2011-08-30
 - Added: Functions
	 - (void)setTitleMove:(float)x y:(float)y ;
	 - (CGRect)textRectForBounds:(CGRect)bounds ;
	 - (CGRect)editingRectForBounds:(CGRect)bounds ;
 - Added: Var:
	m_fMoveX, m_fMoveY
 
 Version 2011-07-05
 - Added: Allow adding target to compose button when it is pressed.
 
 Version 2011-02-21
 - Changed: do not use alertview for input when custom button is pressed
 
 */

//#define USER_ALERT_VIEW		0

#define MHLanguage_MHPickerTextField			@"MHPickerTextField"

@interface TextFieldInputView : UIView
@end

@interface DefaultHandlerClass : NSObject 
<UITextFieldDelegate,
UIAlertViewDelegate,
UIPickerViewDelegate, UIPickerViewDataSource,
UIGestureRecognizerDelegate> {
    
	UITextField			*	_textField;
	
	NSArray				*	_pickerDataSource;
	NSInteger				_selectedRow;
	
	NSUInteger				_maxStringLength;
	
	BOOL					_enableComposeButton;
	BOOL					_useMHNumberKeyboard;
	int						_decimalPlace;
	BOOL					_enableComma;
	
	
	NSString			*	_inputViewTitle;
	NSString			*	_inputViewPlaceHolder;
	NSString			*	_inputViewMessage;
	UIKeyboardType			_keyboardType;
	
	id						_doneButtonTarget;
	SEL						_doneButtonSelector;
	
	id						_enterButtonTarget;
	SEL						_enterButtonSelector;
	
	id						_composeButtonTarget;
	SEL						_composeButtonSelector;
	
	id						_keyboardWillAppearTarget;
	SEL						_keyboardWillAppearSelector;
	SEL						_keyboardWillDisappearSelector;
    
    UIPickerView            *_pickerView;
	UIToolbar				*_pickerToolBar;
	
	id<UITextFieldDelegate> _customTextFieldDelegate;
	
	BOOL					_enableDismissPickerTouchOnOutside;
	
@private
	BOOL					_delegateCalled;			// determine if the textFieldShouldBeginEditing is being called
	BOOL					_showKeyboard;				// determine if the textfield should show keyboard
	BOOL					pressedDone;
    
	
    TextFieldInputView*     _pickerSubView;
//    TextFieldInputView*     _underlayView;
	UIView*					_dismissOnTouchSubView;
	
	NSString*				_perviousText;
	
}
@property (nonatomic, assign) UITextField		*_textField;
@property (nonatomic, retain) NSArray			*_pickerDataSource;
@property (nonatomic, retain) NSString			*_inputViewTitle;
@property (nonatomic, retain) NSString			*_inputViewPlaceHolder;
@property (nonatomic, retain) NSString			*_inputViewMessage;

@property (nonatomic) NSInteger					_selectedRow;
@property (nonatomic) NSUInteger				_maxStringLength;

@property (nonatomic) BOOL						_enableComposeButton;
@property (nonatomic) BOOL						_enableDoneButton;
@property (nonatomic) BOOL						_useMHNumberKeyboard;
@property (nonatomic) int						_decimalPlace;
@property (nonatomic) BOOL						_enableComma;

@property (nonatomic) UIKeyboardType			_keyboardType;

@property (nonatomic, assign) id				_doneButtonTarget;
@property (nonatomic) SEL						_doneButtonSelector;

@property (nonatomic, assign) id<UITextFieldDelegate> _customTextFieldDelegate;

@property (nonatomic, retain) TextFieldInputView	*_pickerSubView;
//@property (nonatomic, retain) UIView				*_underlayView;
@property (nonatomic, retain) UIView				*_dismissOnTouchSubView;

@property (nonatomic) BOOL						_enableDismissPickerTouchOnOutside;

// TextField Delegate
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField;
- (void) textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField;
- (void) textFieldDidEndEditing:(UITextField *)textField;
- (BOOL) textFieldShouldReturn:(UITextField *)textField;

// UIPickerView Delegate
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

// Compose Button
- (void)setComposeButtonTarget:(id)aTarget action:(SEL)aSelector;

// Button call back
- (void)onDoneButtonPressed:(id)sender;
- (void)onComposeButtonPressed:(id)sender;
//- (void)dismissActionSheet;
- (void)addTarget:(id)aTarget keyboardWillAppear:(SEL)aSelector keyboardWillDisappear:(SEL)aSelector2;

// Memory Management
- (void) dealloc;

@end

//=============================================================================
@interface MHPickerTextField : UITextField {
	
	// Data source of the Picker View	
	NSArray				*	_pickerDataSource;
	// Width of the Picker View 
	NSInteger				_pickerWidth;
	// Number of component of the picker view
	NSInteger				_pickerComponentCount;
	
	NSInteger				_selectRow;
	
	// max. length of the string in the textfield
	NSUInteger				_maxStringLength;
	
	BOOL					_enableComposeButton;
    BOOL					_enableDoneButton;
	SEL						_doneButtonSelector;
	SEL						_enterButtonSelector;
	SEL						_composeButtonSelector;
	//	NSInteger				_maxLength;
	
	id<UITextFieldDelegate> _customTextFieldDelegate;
	
	BOOL					_useMHNumberKeyboard;
	int						_decimalPlace;
	BOOL					_enableComma;
	BOOL					_enableCaret;	// show cursor when textfield is editing
	
	BOOL					_enableDismissTouchOnOutside;
	
@private
	
	UIPickerView		*	_pickerView;
	DefaultHandlerClass *	_textFieldDelegate;
	
	float					m_fMoveX;
	float					m_fMoveY;
    
    float                   m_fLeftPadding;
    float                   m_fRightPadding;
	
	
	BOOL					_clearOnBeginEditing;
}

@property (nonatomic, retain) NSArray*	_pickerDataSource;
@property (nonatomic) NSInteger			_maxLength;
@property (nonatomic, assign) BOOL		_closeOnRotate;
@property (nonatomic, assign) BOOL		_enableCaret;
@property (nonatomic, assign) BOOL		_clearOnBeginEditing;

- (id)initWithFrame:(CGRect)frame;
- (void)setUpTextField;
- (void)clearCachedValue;

- (NSInteger)get_selectRow;
- (void)set_maxStringLength:(NSUInteger)aLength;
- (void)set_inputViewTitle:(NSString *)aTitle;
- (void)set_inputViewMessage:(NSString *)aMessage;
- (void)set_inputViewPlaceHolder:(NSString *)aPlaceHolder;
- (void)set_keyboardType:(UIKeyboardType)aKeyboardType;	
- (void)set_enableComposeButton:(BOOL)enableComposeButton;
- (void)set_enableDoneButton:(BOOL)aBool;
- (void)set_pickerDataSource:(NSArray *)aArray;
- (void)set_selectRow:(NSInteger)aSelectRow;
- (void)set_customTextFieldDelegate:(id<UITextFieldDelegate>) aDelegate;
//- (void)set_maxLength:(NSInteger)maxLength;
- (void)set_useMHNumberKeyboard:(BOOL)aBoolean;
- (void)set_decimalPlace:(int)aDecimalPlace;
- (void)set_enableComma:(BOOL)aBoolean;
- (void)set_enableDismissTouchOnOutside:(BOOL)aBoolean;
- (void)set_enableCaret:(BOOL)aBoolean;

- (void)addTarget:(id)target doneAction:(SEL)selector;
- (void)addTarget:(id)target enterAction:(SEL)selector;
- (void)addTarget:(id)target composeAction:(SEL)selector;
- (void)addTarget:(id)target keyboardWillAppear:(SEL)selector keyboardWillDisappear:(SEL)selector2;
- (void)dealloc;


// Overrider TextField
- (void)setTitleMove:(float)x y:(float)y ;
- (void)setTitleMove:(float)x y:(float)y withLeftPadding:(float)leftPadding withRightPadding:(float)rightPadding;

- (CGRect)textRectForBounds:(CGRect)bounds ;
- (CGRect)editingRectForBounds:(CGRect)bounds ;

@end

