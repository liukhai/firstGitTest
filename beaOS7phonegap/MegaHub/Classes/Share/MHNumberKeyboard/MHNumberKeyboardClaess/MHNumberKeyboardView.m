//
//  MHNumberKeyboardView.m
//  MHNumberKeyboard
//
//  Created by Hong on 04/11/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MHNumberKeyboardView.h"
#import "PTConstant.h"

#define MHNUMBERKEYBOARD_IMAGE_PRESSED		[UIImage imageNamed:@"button_pressed.png"]
#define MHNUMBERKEYBOARD_IMAGE_UNPRESS		[UIImage imageNamed:@"button_unpress.png"]

#define BUTTON_FONT_SIZE		30

@implementation MHNumberKeyboardView

@synthesize m_oEnterButton;
@synthesize m_oDeleteButton;
@synthesize m_oDecimalButton;
@synthesize m_oClearButton;
@synthesize m_o00Button;

static UIWindow				*m_oWindow;

static MHNumberKeyboardView *sharedMHNumberKeyboardView = nil;
static UITextField			*m_oTextField = nil;
static NSString				*m_sIndicator = nil;
static NSMutableString		*m_sTextFieldText= nil;
static BOOL					m_isShownKeyboard=NO;
static NSTimer				*m_oIndicatorTimer=nil;

static BOOL					m_isEnableDecimal=NO;
static BOOL					m_isEnableComma=NO;
static int					m_iDecimalPlace=3;
static int					m_iCurrentInputedDecimal=0;
static BOOL					m_isDisplayedDecimal=NO;

static BOOL					m_isPrevEnableDecimal=NO;
static BOOL					m_isPrevEnableComma=NO;
static int					m_iPrevDecimalPlace=3;

static int					m_iZeroCount=3;				// the number of zero in the button near "enter"

static BOOL					m_isEnableTribleZeroButton = YES;
static BOOL					m_isEnableSound = NO;

//-----------------------------------------------------------------------------

+ (NSString *) formatDecimalString:(NSString *)input decPlace:(NSInteger) aDecPlace {
	
	if (input == nil || [input length] <= 0) {
		return @"";
	}
	
	static NSNumberFormatter *formatter;
	
	if (formatter == nil) {
		formatter = [[NSNumberFormatter alloc] init];
	}
	
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[formatter setLocale:locale];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:aDecPlace];
	[formatter setMinimumFractionDigits:aDecPlace];
	[formatter setMinimumIntegerDigits:1];
	
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:input];
	NSString *string = [formatter stringFromNumber:decNum];
	
	NSRange lastCharRange = NSMakeRange( [m_sTextFieldText length]-1, 1);
	NSString *lastCharString = [[[NSString alloc] initWithString:[m_sTextFieldText substringWithRange:lastCharRange]] autorelease];
	if ([lastCharString caseInsensitiveCompare:@"."] == NSOrderedSame) {
		if (m_isDisplayedDecimal) {
			return [NSString stringWithFormat:@"%@.", string];
		}
	}
	
	return string;
}

+ (NSString *) removeComma:(NSString *)aStringWithComma{
	if (aStringWithComma == nil || [aStringWithComma length] <=0 ) {
		return @"";
	}
	
	return [aStringWithComma stringByReplacingOccurrencesOfString:@"," withString:@""];
}

//-----------------------------------------------------------------------------
+ (MHNumberKeyboardView *)sharedMHNumberKeyboardView {
	return sharedMHNumberKeyboardView;
}

+ (MHNumberKeyboardView *)sharedMHNumberKeyboardView:(UITextField *)aTextField {
	@synchronized(self) {
		if (sharedMHNumberKeyboardView == nil) {
			sharedMHNumberKeyboardView	= [[self alloc] initWithTextField:aTextField];// init];
		} else {
			m_oTextField = aTextField;
		}
	}
	return sharedMHNumberKeyboardView;
}

- (oneway void)release {
}

- (id)autorelease {
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}
- (id)retain {
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedMHNumberKeyboardView == nil) {
			sharedMHNumberKeyboardView = [super allocWithZone:zone];
			return sharedMHNumberKeyboardView;
		}
	}
	
	return nil;
}


//=============================================================================
- (id)initWithTextField:(UITextField *)aTextField {
	
	if (aTextField == nil) { return nil; }
	m_oTextField = aTextField;
	
	m_oTextField.userInteractionEnabled = NO;
	
	// out of bound
	// it wil show with animation when show is called
	CGRect frame = CGRectMake(0, 0, 320, 240);
	
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		
		CGFloat x=0, y = 0, h=60, w=80;
		NSInteger number=1;
		
		
		m_o1Button = [UIButton buttonWithType:UIButtonTypeCustom];//WithType:UIButtonTypeCustom];
		[m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o1Button setFrame:CGRectMake(x,y,w,h)];
		[m_o1Button setTag:number];
		[m_o1Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o1Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o1Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o1Button];
		
		number++;
		x += w;
		m_o2Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o2Button setFrame:CGRectMake(x,y,w,h)];
		[m_o2Button setTag:number];
		[m_o2Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o2Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o2Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o2Button];
		
		number++;
		x += w;
		m_o3Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o3Button setFrame:CGRectMake(x,y,w,h)];
		[m_o3Button setTag:number];
		[m_o3Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o3Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o3Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o3Button];
		
		number++;
		x = 0;	y += h;
		m_o4Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o4Button setFrame:CGRectMake(x,y,w,h)];
		[m_o4Button setTag:number];
		[m_o4Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o4Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o4Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o4Button];
		
		number++;
		x += w;
		m_o5Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o5Button setFrame:CGRectMake(x,y,w,h)];
		[m_o5Button setTag:number];
		[m_o5Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o5Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o5Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o5Button];
		
		number++;
		x += w;
		m_o6Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o6Button setFrame:CGRectMake(x,y,w,h)];
		[m_o6Button setTag:number];
		[m_o6Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o6Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o6Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o6Button];
		
		number++;
		x = 0;	y += h;
		m_o7Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o7Button setFrame:CGRectMake(x,y,w,h)];
		[m_o7Button setTag:number];
		[m_o7Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o7Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o7Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o7Button];
		
		number++;
		x += w;
		m_o8Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o8Button setFrame:CGRectMake(x,y,w,h)];
		[m_o8Button setTag:number];
		[m_o8Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o8Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o8Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o8Button];
		
		number++;
		x += w;
		m_o9Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o9Button setFrame:CGRectMake(x,y,w,h)];
		[m_o9Button setTag:number];
		[m_o9Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o9Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o9Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o9Button];
		
		x = 0;	y += h;
		// decimal button background
		UIImageView *dbg = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
		[dbg setImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS];
		[self addSubview:dbg];
		[dbg release];
		
		m_oDecimalButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oDecimalButton setFrame:CGRectMake(x,y,w,h)];
		[m_oDecimalButton setTag:10];
		[m_oDecimalButton setTitle:@"." forState:UIControlStateNormal];
		[m_oDecimalButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_oDecimalButton.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_oDecimalButton];
		
		x += w;
		m_o0Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o0Button setFrame:CGRectMake(x,y,w,h)];
		[m_o0Button setTag:11];
		[m_o0Button setTitle:[NSString stringWithFormat:@"%d",0] forState:UIControlStateNormal];
		[m_o0Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o0Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o0Button];
		
		
		x += w;
		// 000 button background
		dbg = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
		[dbg setImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS];
		[self addSubview:dbg];
		[dbg release];
		
		NSMutableString *zeroString = [[[NSMutableString alloc] init] autorelease];
		for (int i=0; i<m_iZeroCount; i++) {
			[zeroString appendString:@"0"];
		}
		m_o00Button = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o00Button setFrame:CGRectMake(x,y,w,h)];
		[m_o00Button setTag:12];
		[m_o00Button setTitle:zeroString forState:UIControlStateNormal];
		[m_o00Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o00Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o00Button];
		
		
		m_oDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_delete.png"] forState:UIControlStateNormal];
		//		[m_oDeleteButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		//		[m_oDeleteButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oDeleteButton setTag:13];
		[m_oDeleteButton setFrame:CGRectMake(240,0,w,h)];
		//		[m_oDeleteButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oDeleteButton", nil) forState:UIControlStateNormal];
		[m_oDeleteButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oDeleteButton];
		
		
		m_oEnterButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oEnterButton setBackgroundImage:[UIImage imageNamed:@"button_enter.png"] forState:UIControlStateNormal];
		//		[m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		//		[m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oEnterButton setTag:14];
		[m_oEnterButton setFrame:CGRectMake(240,120,w,h*2)];
		//		[m_oEnterButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oEnterButton", nil) forState:UIControlStateNormal];
		[m_oEnterButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oEnterButton];
		
		m_oClearButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oClearButton setBackgroundImage:[UIImage imageNamed:@"button_clear.png"] forState:UIControlStateNormal];
		//		[m_oClearButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		//		[m_oClearButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oClearButton setTag:15];
		[m_oClearButton setFrame:CGRectMake(3*w,1*h,w,h)];
		//		[m_oClearButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oClearButton", nil) forState:UIControlStateNormal];
		[m_oClearButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oClearButton];
		
		// show indicator
		if (m_oIndicatorTimer) {
			[m_oIndicatorTimer invalidate];
			[m_oIndicatorTimer release];
			m_oIndicatorTimer = nil;
		}
		m_oIndicatorTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)0.5 target:self selector:@selector(showIndicator) userInfo:nil repeats:YES];
		[m_oIndicatorTimer retain];
		m_sIndicator = @"|";
		m_isShownIndicator = YES;
		
		m_sTextFieldText = [[NSMutableString alloc] init];
		
		// init sound
		// Load the sounds
		NSBundle *mainBundle = [NSBundle mainBundle];
		m_oPressSound =  [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"select" ofType:@"caf"]];
		
    }
    return self;
}

//-----------------------------------------------------------------------------
- (void)dealloc {
	if (m_oIndicatorTimer) {
		[m_oIndicatorTimer invalidate];
		[m_oIndicatorTimer release];
		m_oIndicatorTimer = nil;
	}
	[m_sTextFieldText release];
	
    [super dealloc];
}


#pragma mark -
#pragma mark Update TextField
//-----------------------------------------------------------------------------
- (void)appendText:(NSString *)aInput {
	if ([m_oTextField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
		NSRange range;
		range.location = (m_sTextFieldText)?[m_sTextFieldText length]:0;
        //		range.length = range.location -1 + [aInput length];
		range.length = [aInput length];
		
		// 20110706
		//if ([m_oTextField.delegate textField:m_oTextField shouldChangeCharactersInRange:range replacementString:m_sTextFieldText] == NO){
		if ([m_oTextField.delegate textField:m_oTextField shouldChangeCharactersInRange:range replacementString:aInput] == NO){
			return;
		}
	}
	@synchronized(m_oTextField.text) {
		if (m_isDisplayedDecimal && [aInput caseInsensitiveCompare:@"."] == NSOrderedSame) {
			// not allow two decimal
			return;
		}
		if ([aInput caseInsensitiveCompare:@"."] == NSOrderedSame) {
			m_isDisplayedDecimal = YES;
		}
		// don't allow input
		if (m_isDisplayedDecimal) {
			if (m_iCurrentInputedDecimal >= m_iDecimalPlace) {
				return;
			}
		}
		if (m_isDisplayedDecimal) {
			// have input decimal, so the following input is a after decimal point
			m_iCurrentInputedDecimal += 1;
		}
		[m_sTextFieldText appendString:aInput];// [NSString stringWithFormat:@"%@%@", m_oTextField.text? m_oTextField.text:@"", aInput];
		
		NSString *string=m_sTextFieldText? m_sTextFieldText:@"";
		if (m_isEnableComma) {
			string = [MHNumberKeyboardView formatDecimalString:string decPlace:MIN(m_iCurrentInputedDecimal, m_iDecimalPlace)];
		}
		m_oTextField.text = [NSString stringWithFormat:@"%@%@", string, m_sIndicator];
	}
}

//-----------------------------------------------------------------------------
- (void)deleteACharacter {
	if ([m_sTextFieldText length] <= 0) { return; }
	
	@synchronized(m_sTextFieldText) {
		if (m_isDisplayedDecimal) {
			m_iCurrentInputedDecimal -= 1;
		}
		NSRange lastCharRange = NSMakeRange( [m_sTextFieldText length]-1, 1);
		NSString *lastCharString = [[NSMutableString alloc] initWithString:[m_sTextFieldText substringWithRange:lastCharRange]];
		if ([lastCharString caseInsensitiveCompare:@"."] == NSOrderedSame) {
			m_isDisplayedDecimal = NO;
		}
		[lastCharString release];
		
		//NSMutableString *existingString = [NSMutableString stringWithString:m_sTextFieldText];
		NSRange range = NSMakeRange( 0, [m_sTextFieldText length]-1);
		NSString *temp = [[NSString alloc] initWithString:m_sTextFieldText];
		if (m_sTextFieldText) {
			[m_sTextFieldText release];
			m_sTextFieldText = nil;
		}
		m_sTextFieldText = [[NSMutableString alloc] initWithString:[temp substringWithRange:range]];
		NSString *string=m_sTextFieldText? m_sTextFieldText:@"";
		if (m_isEnableComma ) {
			string = [MHNumberKeyboardView formatDecimalString:string decPlace:MIN(m_iCurrentInputedDecimal,m_iDecimalPlace)];
		}
		m_oTextField.text = [NSString stringWithFormat:@"%@%@", string, m_sIndicator];
		[temp release];
	}
}

- (void)clearTextField {
	m_isDisplayedDecimal = NO;
	m_iCurrentInputedDecimal = -1;
	
	
	NSRange range = NSMakeRange( 0, [m_sTextFieldText length]);
	[m_sTextFieldText deleteCharactersInRange:range];
	m_oTextField.text = [NSString stringWithFormat:@"%@%@", m_sTextFieldText, m_sIndicator];
}

- (void)reloadView {
	/*
	 printf("%s %s %s\n", [NSLocalizedString(@"MHNumberKeyboard.m_oDeleteButton", nil) UTF8String],
	 [NSLocalizedString(@"MHNumberKeyboard.m_oEnterButton", nil) UTF8String],
	 [NSLocalizedString(@"MHNumberKeyboard.m_oClearButton", nil) UTF8String] );
	 [m_oDeleteButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oDeleteButton", nil) forState:UIControlStateNormal];
	 [m_oEnterButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oEnterButton", nil) forState:UIControlStateNormal];
	 [m_oClearButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oClearButton", nil) forState:UIControlStateNormal];
	 */
}

- (void)showIndicator {
	
	m_isShownIndicator = !m_isShownIndicator;
	m_sIndicator = m_isShownIndicator?@"|":@" ";
	@synchronized(m_oTextField.text) {
		NSString *string=m_sTextFieldText? m_sTextFieldText:@"";
		if (m_isEnableComma ) {
			string = [MHNumberKeyboardView formatDecimalString:string decPlace:MIN(m_iCurrentInputedDecimal, m_iDecimalPlace)];
		}
		m_oTextField.text = [NSString stringWithFormat:@"%@%@", string, m_sIndicator];
	}
}

#pragma mark -
#pragma mark Button call back functions
- (void)onButtonPressed:(UIButton *)senderButton {
	if(m_isEnableSound){
		[m_oPressSound play];
	}
	
	switch (senderButton.tag) {
		case 1:{		[sharedMHNumberKeyboardView appendText:@"1"];		break; }
		case 2:{		[sharedMHNumberKeyboardView appendText:@"2"];		break; }
		case 3:{		[sharedMHNumberKeyboardView appendText:@"3"];		break; }
		case 4:{		[sharedMHNumberKeyboardView appendText:@"4"];		break; }
		case 5:{		[sharedMHNumberKeyboardView appendText:@"5"];		break; }
		case 6:{		[sharedMHNumberKeyboardView appendText:@"6"];		break; }
		case 7:{		[sharedMHNumberKeyboardView appendText:@"7"];		break; }
		case 8:{		[sharedMHNumberKeyboardView appendText:@"8"];		break; }
		case 9:{		[sharedMHNumberKeyboardView appendText:@"9"];		break; }
		case 10:{		[sharedMHNumberKeyboardView appendText:@"."];		break; }
		case 11:{		[sharedMHNumberKeyboardView appendText:@"0"];		break; }
		case 12:{
			NSMutableString *zeroString = [[[NSMutableString alloc] init] autorelease];
			for (int i=0; i<m_iZeroCount; i++) {
				[zeroString appendString:@"0"];
			}
			[sharedMHNumberKeyboardView appendText:zeroString];
			break;
		}
		case 13:{		[sharedMHNumberKeyboardView deleteACharacter];		break; }
		case 14:{		[MHNumberKeyboardView dismiss];		break; }
		case 15:{		[sharedMHNumberKeyboardView clearTextField];		break; }
		default: break;
	}
}

#pragma mark -
#pragma mark Show and dismiss

//-----------------------------------------------------------------------------
+ (BOOL)show:(UITextField *)aTextField {
	
	if (aTextField.clearsOnBeginEditing == YES) {
		aTextField.text = @"";
	}
	
	// if the keyboard is shown current and the new textfield is the old textfield -> return
	if (m_isShownKeyboard == YES) {
		if ([aTextField isEqual:m_oTextField]) {
			return NO;
		}
		// change the current textfield from m_oTextField to aTextField
		// so set the text to old textfield
		if (m_isPrevEnableComma) {
			m_oTextField.text = [MHNumberKeyboardView formatDecimalString:m_sTextFieldText?m_sTextFieldText:@"" decPlace:MIN(m_iCurrentInputedDecimal, m_iPrevDecimalPlace)];//m_iPrevDecimalPlace];
		} else {
			m_oTextField.text = m_sTextFieldText?m_sTextFieldText:@"";
		}
        
		[m_oTextField setUserInteractionEnabled:YES];
		
		// dispatch done event to the previous m_oTextField
		//----------------------------------------
		// call back UITextField delegate function
		if ([m_oTextField.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
			[m_oTextField.delegate textFieldShouldEndEditing:m_oTextField];
		}
		// call back UITextField delegate function
		if ([m_oTextField.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
			[m_oTextField.delegate textFieldShouldReturn:m_oTextField];
		}
		// call back UITextField delegate function
		if ([m_oTextField.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
			[m_oTextField.delegate textFieldDidEndEditing:m_oTextField];
		}
		//----------------------------------------
	}
	
	m_isShownKeyboard = YES;
	m_oTextField = aTextField;
	
	if (m_sTextFieldText) {
		[m_sTextFieldText release];
		m_sTextFieldText = nil;
	}
	NSString *noCommaString = [MHNumberKeyboardView removeComma:aTextField.text?aTextField.text:@""];
	
	// set the current decimal place of the textField
	NSArray *array = [noCommaString componentsSeparatedByString:@"."];
	NSString *intString = ([array count] > 0)?[array objectAtIndex:0]:nil;
	NSString *decimalString = ([array count] > 1)?[array objectAtIndex:1]:nil;
	int decimalLength = [decimalString length];
	int decimalInteger = [decimalString intValue];
	m_iCurrentInputedDecimal = decimalLength;
	for (int i=0; i<decimalLength; i++) {
		if (decimalInteger % 10 == 0) {
			m_iCurrentInputedDecimal -=1;
		} else {
			break;
		}
		decimalInteger /= 10;
	}
	if (m_iCurrentInputedDecimal <= 0) {
		// have not change, ie the case: 12.000, 3 ==3
		m_iCurrentInputedDecimal = -1;
	}
	
	if (m_iCurrentInputedDecimal>0) {
		m_isDisplayedDecimal = YES;
		m_sTextFieldText = [[NSMutableString alloc] initWithFormat:@"%d.%s", [intString intValue], [[decimalString substringToIndex:m_iCurrentInputedDecimal] UTF8String]];
	} else {
		m_isDisplayedDecimal = NO;
		m_iCurrentInputedDecimal = -1;
		m_sTextFieldText = [[NSMutableString alloc] initWithString:intString];
	}
	
	// init and configure the keyboard
	// init MHNumberKeyboard with the delegated TextField
	[[MHNumberKeyboardView sharedMHNumberKeyboardView:aTextField] setFrame:CGRectMake(0, 0, 320, 240)];
	sharedMHNumberKeyboardView.m_oDecimalButton.hidden = !m_isEnableDecimal;
	
	// hide the 000 button
	sharedMHNumberKeyboardView.m_o00Button.hidden = !m_isEnableTribleZeroButton;
	
	// show indicator
	if (m_oIndicatorTimer) {
		[m_oIndicatorTimer invalidate];
		[m_oIndicatorTimer release];
		m_oIndicatorTimer = nil;
	}
	m_oIndicatorTimer = [[NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)0.5 target:sharedMHNumberKeyboardView selector:@selector(showIndicator) userInfo:nil repeats:YES] retain];
	m_sIndicator = @"|";
	
	
	
	// show keyboard with animation
	if (m_oWindow) {
		[m_oWindow removeFromSuperview];
		[m_oWindow release];
		m_oWindow = nil;
	}
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
	m_oWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, height, 320, 240)];
	[m_oWindow addSubview:sharedMHNumberKeyboardView];
	[m_oWindow makeKeyAndVisible];
	
	// <!---- Start Animation ----
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	//	[UIView setAnimationDelegate:sharedMHNumberKeyboardView];
	//	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	[m_oWindow setFrame:CGRectMake(m_oWindow.frame.origin.x, m_oWindow.frame.origin.y - 240,
								   m_oWindow.frame.size.width, m_oWindow.frame.size.height)];
	
	[UIView commitAnimations];
	// ---- End Animation ----!>
	
	if ([m_oTextField.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
		[m_oTextField.delegate textFieldDidBeginEditing:m_oTextField];
	}
	
	return NO;
}

/*
 - (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
 }
 */

//-----------------------------------------------------------------------------
+ (void)dismissWithoutReturn {
	if (m_isShownKeyboard == NO) { return; }
	
	m_isShownKeyboard = NO;
	
	if (m_oIndicatorTimer) {
		[m_oIndicatorTimer invalidate];
		[m_oIndicatorTimer release];
		m_oIndicatorTimer = nil;
	}
	if (m_isEnableComma) {
		if (m_isDisplayedDecimal && m_iCurrentInputedDecimal == 0 && m_sTextFieldText != nil) {
			// the last number is a decimal point
			[[MHNumberKeyboardView sharedMHNumberKeyboardView] deleteACharacter];
		}
		m_oTextField.text = [MHNumberKeyboardView formatDecimalString:m_sTextFieldText?m_sTextFieldText:@"" decPlace:m_iDecimalPlace];
	} else {
		m_oTextField.text = m_sTextFieldText?m_sTextFieldText:@"";
	}
	
	if (m_sTextFieldText) {
		[m_sTextFieldText release];
		m_sTextFieldText = nil;
	}
	m_oTextField.userInteractionEnabled = YES;
	
	//----------------------------------------
	// call back UITextField delegate function
	if ([m_oTextField.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
		[m_oTextField.delegate textFieldShouldEndEditing:m_oTextField];
	}
	
	//----------------------------------------
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	
	[m_oWindow setFrame:CGRectMake(m_oWindow.frame.origin.x, m_oWindow.frame.origin.y + 240,
								   m_oWindow.frame.size.width, m_oWindow.frame.size.height)];
	
	[UIView commitAnimations];
	
	
	// remove from super view after the keyboard has been moved down completely
	[m_oWindow performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:(NSTimeInterval)0.21];
	[m_oWindow release];
	m_oWindow = nil;
	
	// without calling back UITextField delegate return function
	// if ([m_oTextField.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
	//	[m_oTextField.delegate textFieldShouldReturn:m_oTextField];
	// }
	
	// call back UITextField delegate function
	if ([m_oTextField.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
		[m_oTextField.delegate textFieldDidEndEditing:m_oTextField];
	}
}

+ (void)dismiss {
	if (m_isShownKeyboard == NO) { return; }
	
	m_isShownKeyboard = NO;
	
	if (m_oIndicatorTimer) {
		[m_oIndicatorTimer invalidate];
		[m_oIndicatorTimer release];
		m_oIndicatorTimer = nil;
	}
	if (m_isEnableComma) {
		if (m_isDisplayedDecimal && m_iCurrentInputedDecimal == 0 && m_sTextFieldText != nil) {
			// the last number is a decimal point
			[[MHNumberKeyboardView sharedMHNumberKeyboardView] deleteACharacter];
		}
		m_oTextField.text = [MHNumberKeyboardView formatDecimalString:m_sTextFieldText?m_sTextFieldText:@"" decPlace:m_iDecimalPlace];
	} else {
		m_oTextField.text = m_sTextFieldText?m_sTextFieldText:@"";
	}
	
	if (m_sTextFieldText) {
		[m_sTextFieldText release];
		m_sTextFieldText = nil;
	}
	m_oTextField.userInteractionEnabled = YES;
	
	//----------------------------------------
	// call back UITextField delegate function
	if ([m_oTextField.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
		[m_oTextField.delegate textFieldShouldEndEditing:m_oTextField];
	}
	
	//----------------------------------------
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	
	[m_oWindow setFrame:CGRectMake(m_oWindow.frame.origin.x, m_oWindow.frame.origin.y + 240,
								   m_oWindow.frame.size.width, m_oWindow.frame.size.height)];
	
	[UIView commitAnimations];
	
	
	// remove from super view after the keyboard has been moved down completely
	[m_oWindow performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:(NSTimeInterval)0.21];
	[m_oWindow release];
	m_oWindow = nil;
	
	// call back UITextField delegate function
	if ([m_oTextField.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
		[m_oTextField.delegate textFieldShouldReturn:m_oTextField];
	}
	
	// call back UITextField delegate function
	if ([m_oTextField.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
		[m_oTextField.delegate textFieldDidEndEditing:m_oTextField];
	}
}

+ (BOOL)isShownKeyboard {
	return m_isShownKeyboard;
}


+ (void)setZeroCount:(int)aZeroCount{
	m_iZeroCount = aZeroCount;
}

+ (void)setDecimalPlace:(int)aDecimalPlace {
	m_iPrevDecimalPlace = m_iDecimalPlace;
	if (m_iPrevDecimalPlace <= 0) {
		m_isPrevEnableDecimal = NO;
	} else {
		m_isPrevEnableDecimal = YES;
	}
	
	
	m_iDecimalPlace = aDecimalPlace;
	if (m_iDecimalPlace <= 0) {
		m_isEnableDecimal = NO;
	} else {
		m_isEnableDecimal = YES;
	}
	
}

+ (int)getDecimalPlace {
	return m_iDecimalPlace;
}

+ (void)setEnableComma:(BOOL)aBoolean {
	m_isPrevEnableComma = m_isEnableComma;
	m_isEnableComma = aBoolean;
}

+ (BOOL)getEnanbleComma {
	return m_isEnableComma;
}

+ (void)setTribleZeroButton:(BOOL)aBool {
	m_isEnableTribleZeroButton = aBool;
}

+ (BOOL)getEnableTribleZeroButton {
	return m_isEnableTribleZeroButton;
}

+ (void)setEnableSound:(BOOL)aBool {
	m_isEnableSound = aBool;
}

+ (BOOL)getEnableSound {
	return m_isEnableSound;
}


@end



