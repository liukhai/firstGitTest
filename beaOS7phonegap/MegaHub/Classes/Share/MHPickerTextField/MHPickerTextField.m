//
//  MHPickerTextField.m
//  Test
//
//  Created by MegaHub on 30/09/2010.
//  Copyright 2010 MegaHub. All rights reserved.
//

/**
 
 version 20110_06_15 by Hong
 - Update: get localizable.string -> get MHLanguage_MHPickerTextField
 
 version 2010_03_01 by Hong
 - Added: support MHNumberKeyboard
 
 version 2010_01_04 by Hong
 - Fixed: memory leak when copying textField.text and array
 - Changed: NSMutableArray in DefaultHandlerClass -> NSArray
 - Added: _customTextFieldDelegate for call the UITextFieldDelegate outside this class
 
 version 2010_10_07 by Hong
 - Change: _doneButtonAction will pass the MHPickerTextField as parameter
 */

#import "MHPickerTextField.h"
#import "MHPickerPopUp.h"
#import "MHNumberKeyboardView.h"
#import "MHLanguage.h"
#import "MHUtility.h"

#define TAG_TEXTVIEWFIELD 5

// subclass of UIView to remove blur layer for inputview of textfield in iOS 7 
@implementation TextFieldInputView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
	// remove blur layer for textview inputview
    if ([MHUtility checkVersionGreater:@"7.0"] && newSuperview != nil)
    {
        CALayer *layer = newSuperview.layer;
        NSArray *subls = layer.sublayers;

		for (CALayer *layer in subls) {
			[layer setOpacity:0];
		}
    }
}

- (void)removeFromSuperview {
//	[super removeFromSuperview];
	
	if ([MHUtility checkVersionGreater:@"7.0"] && self.superview != nil)
    {
        CALayer *layer = self.superview.layer;
        NSArray *subls = layer.sublayers;
		
		for (CALayer *layer in subls) {
			[layer setOpacity:1];
		}
    }
	
	[super removeFromSuperview];
}

@end

// DefaultHanderClass
@implementation DefaultHandlerClass

@synthesize _maxStringLength;
@synthesize _textField, _pickerDataSource, _selectedRow, _enableComposeButton, _enableDoneButton;
@synthesize _inputViewTitle, _inputViewPlaceHolder, _inputViewMessage, _keyboardType;
@synthesize _doneButtonSelector, _doneButtonTarget;
@synthesize _customTextFieldDelegate;
@synthesize _useMHNumberKeyboard;
@synthesize _decimalPlace;
@synthesize _enableComma;
@synthesize _pickerSubView, _dismissOnTouchSubView;
@synthesize _enableDismissPickerTouchOnOutside;


- (id) initWithPickerDataSource:(NSArray *)aDataSource {
	self = [super init];
	if (self != nil) {
		_pickerDataSource		= [aDataSource retain];
		_delegateCalled			= NO;
		_showKeyboard			= NO;
		pressedDone				= NO;
		_selectedRow			= 0;
		_maxStringLength		= NSUIntegerMax;
		
		_inputViewTitle			= nil;
		_inputViewPlaceHolder	= nil;
		_inputViewMessage		= nil;
		_keyboardType			= UIKeyboardTypeNumberPad;
		
		_useMHNumberKeyboard	= NO; 
		_decimalPlace			= 0;
		_enableComma			= NO;
		
		_perviousText			= nil;
		
		// Tool Bar
		_pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
//		_pickerToolBar.barStyle = UIBarStyleBlackOpaque;
//		[_pickerToolBar sizeToFit];
		
		_pickerView = [[UIPickerView alloc] init];
		_pickerView.frame = CGRectMake(0.0, 0.0, 320, 216);
		_pickerView.showsSelectionIndicator = YES;
		_pickerView.dataSource = self;
		_pickerView.delegate = self;
		

		CGRect fullScreenFrame = CGRectMake(0, [MHUtility getOriginY], 320, [MHUtility getScreenHeight]);
		
//		_underlayView			= [[TextFieldInputView alloc] initWithFrame:fullScreenFrame];
		_dismissOnTouchSubView	= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, fullScreenFrame.size.height - 44 - 216)];
		_pickerSubView			= [[TextFieldInputView alloc] initWithFrame:CGRectMake(0, fullScreenFrame.size.height - 216, 320, 216 + 44)];
		
		[_pickerSubView setBackgroundColor: [UIColor whiteColor]];
//		[_underlayView setBackgroundColor: [UIColor clearColor]];
		[_dismissOnTouchSubView setBackgroundColor:[UIColor clearColor]];
		
		UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																						action:@selector(dismissPickerTouchOnOutside)];
		[tapRecognizer setNumberOfTapsRequired:1];
		[tapRecognizer setNumberOfTouchesRequired:1];
		
		[_dismissOnTouchSubView addGestureRecognizer:tapRecognizer];
		[_dismissOnTouchSubView setUserInteractionEnabled:YES];
		
		[tapRecognizer release];
        
        
        UITapGestureRecognizer *doneRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDoneRecognizerTapped:)];
        [doneRecognizer setDelegate:self];
        [doneRecognizer setNumberOfTapsRequired:1];
        [doneRecognizer setNumberOfTouchesRequired:1];
        [_pickerSubView addGestureRecognizer:doneRecognizer];
        [_pickerSubView setUserInteractionEnabled:YES];
        [doneRecognizer release];

		
		[_pickerSubView addSubview:_pickerToolBar];
		[_pickerSubView addSubview:_pickerView];
		
//		[_underlayView addSubview:_pickerSubView];
//		[_underlayView addSubview:_dismissOnTouchSubView];
		
		// enable by default;
		_enableDismissPickerTouchOnOutside = YES;
	}
	return self;
}

- (void) dealloc {
    
    _doneButtonTarget = nil;
    _enterButtonTarget = nil;
    _composeButtonTarget = nil;
    _keyboardWillAppearTarget = nil;
    
    [_inputViewTitle release];
    [_inputViewPlaceHolder release];
    [_inputViewMessage release];
    
    self._customTextFieldDelegate = nil;
    _pickerView.delegate = nil;
    _pickerView.dataSource = nil;
	[_pickerView release];
	
	[_pickerToolBar release];
	[_pickerDataSource release];
    
//    [_underlayView release];
    [_pickerSubView release];
	[_dismissOnTouchSubView release];
	
	[_perviousText release];
    
	[super dealloc];

}

#pragma mark -
#pragma mark Setter
- (void)set_pickerDataSource:(NSArray *)aArray {
	@synchronized(_pickerDataSource){
		if(_pickerDataSource){
			[_pickerDataSource release];
			_pickerDataSource = nil;
		}
		_pickerDataSource = [aArray retain];
	}
}

- (void)addTarget:(id)aTarget doneAction:(SEL)aSelector {
	_doneButtonTarget		= aTarget;
	_doneButtonSelector		= aSelector;
}

- (void)addTarget:(id)aTarget enterAction:(SEL)aSelector {
	_enterButtonTarget			= aTarget;
	_enterButtonSelector		= aSelector;
}


- (void)addTarget:(id)aTarget keyboardWillAppear:(SEL)aSelector keyboardWillDisappear:(SEL)aSelector2 {
	_keyboardWillAppearTarget		= aTarget;
	_keyboardWillAppearSelector		= aSelector;
	_keyboardWillDisappearSelector	= aSelector2;
}

#pragma mark - 
#pragma mark Clear cached value

- (void) clearPerviousValue {
	// clear pervious value
	if(_perviousText != nil) {
		[_perviousText release];
		_perviousText = nil;
	}
}


#pragma mark -
#pragma mark Gesture Delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if([gestureRecognizer isKindOfClass:[otherGestureRecognizer class]]){
        return YES;
    }else{
        return NO;
    }
}


#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	
	if ([_customTextFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
		[_customTextFieldDelegate textFieldShouldBeginEditing:textField];
	}
	
	[self clearPerviousValue];
	_perviousText = [[_textField text] length] >0 ? [[_textField text] retain]:@"";
	
	if (_showKeyboard == YES || 
		_pickerDataSource == nil || 
		[_pickerDataSource count] <= 0 ) { 
		_showKeyboard = NO;
		
		// check for keyboard type
		if (_useMHNumberKeyboard == YES) {
			// if use MHNumber keyboard
			
			// bring pervious value to number keyboard
			if(_perviousText && [_perviousText length] > 0)
				[textField setText:_perviousText];
			
			[MHNumberKeyboardView setDecimalPlace:_decimalPlace];
			[MHNumberKeyboardView setEnableComma:_enableComma];
			
			[MHNumberKeyboardView show:textField withDismissOnTouchOutside:YES keepOldValue:_perviousText];
			
			// pervious value will not being used anymore
			[self clearPerviousValue];
			
			if(((MHPickerTextField *)_textField)._clearOnBeginEditing) {
				[_textField setText:@""];
			}
			
			return NO;
		} 
		
		return YES;
		
	} else {
		if ([MHNumberKeyboardView isShownKeyboard]) {
			[MHNumberKeyboardView dismissWithReturn:NO withKeepInputValue:YES];
			
			[self clearPerviousValue];
			_perviousText = [[_textField text] length] >0 ? [[_textField text] retain]:@"";
		}
	}
	
	
	_delegateCalled		= YES;
	pressedDone			= NO;
	
	if(((MHPickerTextField *)_textField)._clearOnBeginEditing) {
		[_textField setText:@""];
	}
	
	[_pickerView selectRow:_selectedRow inComponent:0 animated:NO];
	[_pickerView reloadComponent:0];
	
	NSMutableArray *barItems = [[NSMutableArray alloc] init];
	
	
	if(_enableComposeButton) {
		UIBarButtonItem *composeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
																					target:self
																					action:@selector(onComposeButtonPressed:)];
		
		[barItems addObject:composeBtn];
		[composeBtn release];
	}
	
	UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			   target:self
																			   action:nil];
	[barItems addObject:flexSpace];
	[flexSpace release];
	
	// Done button
    if (_enableDoneButton) {
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:MHLocalizedStringFile(@"Done", nil, MHLanguage_MHPickerTextField)
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(onDoneButtonPressed:)];
	
        [barItems addObject:doneBtn];
        [doneBtn release];
    }
    
	[_pickerToolBar setItems:barItems animated:YES];
	[barItems release];
    
    int pickerSubViewHeight = _pickerToolBar.frame.size.height + _pickerView.frame.size.height;
    [_pickerSubView setFrame:CGRectMake(0, [MHUtility getScreenHeight] - pickerSubViewHeight, 320, pickerSubViewHeight)];
	
//	CGRect fullScreenFrame = CGRectMake(0, [MHUtility getOriginY], 320, [MHUtility getScreenHeight]);
//	[_underlayView setFrame:fullScreenFrame];
	
	if(_enableDismissPickerTouchOnOutside) {
		[_dismissOnTouchSubView setFrame:CGRectMake(0, [MHUtility getOriginY], 320, [MHUtility getScreenHeight] - pickerSubViewHeight)];
		[_dismissOnTouchSubView setHidden:NO];
	} else {
		[_dismissOnTouchSubView setHidden:YES];
	}
	
//	[_underlayView setFrame:fullScreenFrame];
//	[_textField setInputView:_underlayView];
	
	
	[_textField setInputView:_pickerSubView];
	[_textField setInputAccessoryView:_dismissOnTouchSubView];

	return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
	
	if ([_customTextFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
		[_customTextFieldDelegate textFieldDidBeginEditing:textField];
	}	
	
	// move the view
	if ([_keyboardWillAppearTarget respondsToSelector:_keyboardWillAppearSelector]) { 
		[_keyboardWillAppearTarget performSelector:_keyboardWillAppearSelector];
	}
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
	
	if(_perviousText && [_perviousText length] > 0 && [_textField.text length] == 0) {
		// restore pervious value if possible
		[_textField setText:_perviousText];
	}
	
	if ([_customTextFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
		[_customTextFieldDelegate textFieldShouldEndEditing:textField];
	}	
	
	if ([_keyboardWillAppearTarget respondsToSelector:_keyboardWillDisappearSelector]) { 
		[_keyboardWillAppearTarget performSelector:_keyboardWillDisappearSelector];
	}
	
	return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
	
	if ([_customTextFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
		[_customTextFieldDelegate textFieldDidEndEditing:textField];
	}
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	[_textField resignFirstResponder];
	
	if ([_customTextFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
		[_customTextFieldDelegate textFieldShouldReturn:textField];
	}
	
	if ([_keyboardWillAppearTarget respondsToSelector:_keyboardWillDisappearSelector]) { 
		[_keyboardWillAppearTarget performSelector:_keyboardWillDisappearSelector];
	}
	if ([_doneButtonTarget respondsToSelector:_doneButtonSelector]) { 
		[_doneButtonTarget performSelector:_doneButtonSelector];
	}

	
	return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if ([_customTextFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
		[_customTextFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}
	
	NSInteger insertDelta = string.length - range.length;
	
	if ((textField.text.length + insertDelta > _maxStringLength))	{
		return NO; // the new string would be longer than MAX_LENGTH
	}else{
		return YES;
	}
}


#pragma mark -
#pragma mark UIPickerView Delegate

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	
	return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	
	return [_pickerDataSource count];
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	
	return 320;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	return [_pickerDataSource objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	if (!pressedDone) { // use for lock the selection
		_selectedRow = row;
		
		if (_selectedRow < [_pickerDataSource count]) {
			_textField.text = [_pickerDataSource objectAtIndex:_selectedRow];
		}
	}
}

#pragma mark -
#pragma mark ComposeButton
- (void)setComposeButtonTarget:(id)aTarget action:(SEL)aSelector {
	_composeButtonTarget = aTarget;
	_composeButtonSelector = aSelector;
}

#pragma mark -
#pragma mark UIAlertView Delegate
-(void)alertView:(UIAlertView *)aview clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	//	[alertView.msgField resignFirstResponder];
	
	switch (buttonIndex) {
			
		case 0:		{
			// cancel button
			break;
		}
		case 1:		{
			// enter
			UITextField *aTextField = (UITextField*)[aview viewWithTag:TAG_TEXTVIEWFIELD];
			if ([_enterButtonTarget respondsToSelector:_enterButtonSelector]) {
				_textField.text = aTextField.text;
				[_enterButtonTarget performSelector:_enterButtonSelector withObject:_textField];
			}
			break;
		}
			
		default:
			break;
	}
	[aview dismissWithClickedButtonIndex:0 animated:YES];
}


#pragma mark -
#pragma mark Button call back
- (void)onDoneRecognizerTapped:(id)sender {
    if(!_enableDoneButton){
        [self onDoneButtonPressed:nil];
    }
}

- (void)onDoneButtonPressed:(id)sender {
	
    [self dismissPicker];
	
	if (_doneButtonTarget != nil &&
		[_doneButtonTarget respondsToSelector:_doneButtonSelector]) {
		[_doneButtonTarget performSelector:_doneButtonSelector withObject:_textField];
	}
    
}

- (void)onComposeButtonPressed:(id)sender {

    [self dismissPicker];
	_showKeyboard = YES;
	
	if (_composeButtonTarget != nil &&
		[_composeButtonTarget respondsToSelector:_composeButtonSelector]) {
		[_composeButtonTarget performSelector:_composeButtonSelector withObject:_textField];
	}
	
	if (_useMHNumberKeyboard == YES ) {
		
		// bring pervious value to number keyboard
		if (_perviousText != nil) {
			[_textField setText:_perviousText];
		}
		
		[_textField becomeFirstResponder];
	} else {
		MHPickerPopUp *inputPopup = [[[MHPickerPopUp alloc] initWithFrame:CGRectZero 
															 keyboardType:_keyboardType
																  textTag:TAG_TEXTVIEWFIELD 
																	title:_inputViewTitle 
																  message:_inputViewMessage 
															  placeholder:_inputViewPlaceHolder] autorelease];
		inputPopup.textInput.delegate = self;
		inputPopup.delegate = self;
		inputPopup.tag = 10;
		[inputPopup show];
	}	
}

- (void) dismissPickerTouchOnOutside {
	
    if(_enableDoneButton){
//      if(_perviousText && [_perviousText length] > 0 && [_textField.text length] == 0)
//          [_textField setText:_perviousText];
	
        [self dismissPicker];
    }
}

- (void) dismissPicker {
	
	// lock the picker when dismissing
	pressedDone = YES;
	
	[_textField resignFirstResponder];
}

@end

#pragma mark -
#pragma mark MHPickerTextField
//=============================================================================
@implementation MHPickerTextField 

@synthesize _pickerDataSource, _maxLength;
@synthesize _closeOnRotate;
@synthesize _enableCaret;
@synthesize _clearOnBeginEditing;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		_pickerDataSource		= nil;
		_enableComposeButton	= YES;
        _enableDoneButton		= YES;
		_selectRow				= 0;
//		_maxLength				= 0;
		m_fMoveX				= 5;
		m_fMoveY				= 0;
		
        // Initialization code
		_textFieldDelegate = [[DefaultHandlerClass alloc] initWithPickerDataSource:nil];
		[_textFieldDelegate set_textField:self];
        
		self.delegate = _textFieldDelegate;
		
        self._closeOnRotate = YES;
		self._enableCaret = NO;
		
		[self setClearsOnBeginEditing:YES];
    }
	
    return self;
}

// if the textfield is created from XIB, call this
- (void) setUpTextField {

	_pickerDataSource		= nil;
	_enableComposeButton	= YES;
	_selectRow				= 0;
	//		_maxLength				= 0;
	m_fMoveX				= 5;
	m_fMoveY				= 0;
	
	// Initialization code
	_textFieldDelegate = [[DefaultHandlerClass alloc] initWithPickerDataSource:nil];
	[_textFieldDelegate set_textField:self];
	
	self.delegate = _textFieldDelegate;
	
	self._closeOnRotate = YES;
	self._enableCaret = NO;
	
	[self setClearsOnBeginEditing:YES];
}

//Override
- (void) setClearsOnBeginEditing:(BOOL) aClearOnBeginEditing {
	_clearOnBeginEditing = aClearOnBeginEditing;
	[super setClearsOnBeginEditing:NO];
}

- (void)dealloc {
    
    self.delegate = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_textFieldDelegate release]; //Release retained defaulthandler class
    _textFieldDelegate = nil;
    _customTextFieldDelegate = nil;
    
	[_pickerDataSource release];
	[super dealloc];
}

#pragma mark - 
#pragma mark Getter/Setter

- (NSInteger)get_selectRow {
	
	return _textFieldDelegate._selectedRow;
}

- (NSUInteger)get_maxStringLength {
	return _textFieldDelegate._maxStringLength;
}

- (void)set_maxStringLength:(NSUInteger)aLength {
	[_textFieldDelegate set_maxStringLength:aLength];
}

- (void)set_inputViewTitle:(NSString *)aTitle {
	[_textFieldDelegate set_inputViewTitle:aTitle];
}

- (void)set_inputViewMessage:(NSString *)aMessage {
	[_textFieldDelegate set_inputViewMessage:aMessage];
}

- (void)set_inputViewPlaceHolder:(NSString *)aPlaceHolder {
	[_textFieldDelegate set_inputViewPlaceHolder:aPlaceHolder];
}

- (void)set_keyboardType:(UIKeyboardType)aKeyboardType {
	[_textFieldDelegate set_keyboardType:aKeyboardType];
}

- (void)set_enableComposeButton:(BOOL)enableComposeButton {
	_textFieldDelegate._enableComposeButton = enableComposeButton;
}

- (void)set_enableDoneButton:(BOOL)aBool {
    _textFieldDelegate._enableDoneButton = aBool;
}

- (void)set_selectRow:(NSInteger)aSelectRow {
	_selectRow = aSelectRow;
	_textFieldDelegate._selectedRow = aSelectRow;
	[_pickerView reloadAllComponents];
	
	if (_selectRow >= [_pickerDataSource count] ) {
		return;
	}
	self.text = [_pickerDataSource objectAtIndex:_selectRow];
	_textFieldDelegate._textField.text = [_pickerDataSource objectAtIndex:_selectRow];
}

- (void)set_pickerDataSource:(NSArray *)aArray {
	//2010_01_03
	@synchronized(_pickerDataSource){
		if (_pickerDataSource != nil) {
			[_pickerDataSource release];
			_pickerDataSource = nil;
		}
		_pickerDataSource = [aArray retain];
	}
	
	[_textFieldDelegate set_pickerDataSource:_pickerDataSource];
	[_pickerView reloadAllComponents];
}

- (void)set_customTextFieldDelegate:(id<UITextFieldDelegate>) aDelegate {
	_customTextFieldDelegate = aDelegate;	
	_textFieldDelegate._customTextFieldDelegate = _customTextFieldDelegate;
}

- (void)set_useMHNumberKeyboard:(BOOL)aBoolean {
	_useMHNumberKeyboard = aBoolean;
	_textFieldDelegate._useMHNumberKeyboard = _useMHNumberKeyboard;
}

- (void)set_decimalPlace:(int)aDecimalPlace {
	_decimalPlace = aDecimalPlace;
	_textFieldDelegate._decimalPlace = _decimalPlace;
}

- (void)set_enableComma:(BOOL)aBoolean {
	_enableComma = aBoolean;
	_textFieldDelegate._enableComma = _enableComma;
}

//-----------------------------------------------------------------------------
- (void)addTarget:(id)target doneAction:(SEL)selector {
	[_textFieldDelegate addTarget:target doneAction:selector];
}

- (void)addTarget:(id)target enterAction:(SEL)selector {
	[_textFieldDelegate addTarget:target enterAction:selector];
}

- (void)addTarget:(id)target composeAction:(SEL)selector {
	[_textFieldDelegate setComposeButtonTarget:target action:selector];
}

- (void)addTarget:(id)target keyboardWillAppear:(SEL)selector keyboardWillDisappear:(SEL)selector2 {
	[_textFieldDelegate addTarget:target keyboardWillAppear:selector keyboardWillDisappear:selector2];
}

// 20110830
- (void)setTitleMove:(float)x y:(float)y {
	m_fMoveX = x;
	m_fMoveY = y;
    
    m_fLeftPadding = 0;
    m_fRightPadding = 0;
    
	[self setNeedsDisplay];
}

- (void)setTitleMove:(float)x y:(float)y withLeftPadding:(float)leftPadding withRightPadding:(float)rightPadding {
    m_fMoveX = x;
	m_fMoveY = y;
    
    m_fLeftPadding = leftPadding;
    m_fRightPadding = rightPadding;
    
    [self setNeedsDisplay];
}

- (void)set_closeOnRotate:(BOOL)closeOnRotate {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    if (closeOnRotate) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onRotateDetected:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
    }
    
}

- (void)set_enableDismissTouchOnOutside:(BOOL)aBoolean {
	_enableDismissTouchOnOutside = aBoolean;
	_textFieldDelegate._enableDismissPickerTouchOnOutside = aBoolean;
}

- (void)set_enableCaret:(BOOL)aBoolean {
	_enableCaret = aBoolean;
}

- (void) clearCachedValue {
	[_textFieldDelegate clearPerviousValue];
}

#pragma mark -
#pragma mark Rotation

- (void)onRotateDetected:(NSNotification *)notification {
    [_textFieldDelegate dismissPicker];
}


#pragma mark -
#pragma mark Override

// override: cursor
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return _enableCaret?[super caretRectForPosition:position]:CGRectZero;
}

// override
- (CGRect)textRectForBounds:(CGRect)bounds {
	
    bounds.origin.x = m_fLeftPadding;
    bounds.size.width -= (m_fLeftPadding + m_fRightPadding);
	
	return CGRectInset( bounds , m_fMoveX , m_fMoveY );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
	
	bounds.origin.x = m_fLeftPadding;
    bounds.size.width -= (m_fLeftPadding + m_fRightPadding);
    
	// temporary fix by using CGRectOffset to move the frame as incorrect bounds is returned in textRectForBounds
	return CGRectOffset( bounds , m_fMoveX , m_fMoveY );
}

@end


