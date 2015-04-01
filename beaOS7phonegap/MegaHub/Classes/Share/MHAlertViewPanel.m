//
//  MHAlertViewPanel.m
//  PhoneStream
//
//  Created by Megahub on 26/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MHAlertViewPanel.h"

@implementation MHAlertViewPanel

@synthesize m_oMessageField;

//- (id)initWithFrame:(CGRect)frame {
//	if (self = [super initWithFrame:frame])  {
//		m_oMessageField = [[UITextField alloc] initWithFrame:CGRectZero];
//		m_oMessageField.borderStyle = UITextBorderStyleRoundedRect;
//		m_oMessageField.returnKeyType = UIReturnKeyDone;
//		
//		m_oMessageField.placeholder = MHLocalizedString(@"watchlist_name",nil);
//		m_oMessageField.autocorrectionType = UITextAutocorrectionTypeNo;
//		m_oMessageField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//		
//		self.title = MHLocalizedString(@"watchlist_add_title",);
//		
//		[self addSubview:m_oMessageField];
//		[m_oMessageField release];
//		
//		[self addButtonWithTitle:MHLocalizedString(@"cancel_label", nil)];
//		[self dismissWithClickedButtonIndex:BUTTON_INDEX_CANCEL animated:YES];
//		[self addButtonWithTitle:MHLocalizedString(@"confirm_label", nil)];
//		[self dismissWithClickedButtonIndex:BUTTON_INDEX_CONFIRM animated:YES];
//	}
//	return self;
//}

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitleString cancel:(NSString *)aCancelString confirm:(NSString *)aConfirmString placeholder:(NSString *)aPlaceholderString keyboardType:(UIKeyboardType)aKeyboardType{
	self = [super initWithFrame:frame];
	if (self != nil)  {
		m_oMessageField					= [[UITextField alloc] initWithFrame:CGRectZero];
		m_oMessageField.borderStyle		= UITextBorderStyleRoundedRect;
		m_oMessageField.returnKeyType	= UIReturnKeyDone;
		
		m_oMessageField.placeholder				= aPlaceholderString;
		m_oMessageField.autocorrectionType		= UITextAutocorrectionTypeNo;
		m_oMessageField.autocapitalizationType	= UITextAutocapitalizationTypeNone;
		m_oMessageField.keyboardType			= aKeyboardType;
		
		self.title = aTitleString;
		
		[self addSubview:m_oMessageField];
		[m_oMessageField becomeFirstResponder];

		[self addButtonWithTitle:aCancelString];
		[self addButtonWithTitle:aConfirmString];
	}
	return self;

}

- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitleString message:(NSString *)aMessageString cancel:(NSString *)aCancelString confirm:(NSString *)aConfirmString placeholder:(NSString *)aPlaceholderString keyboardType:(UIKeyboardType)aKeyboardType{
	self = [super initWithFrame:frame];
	if (self != nil)  {
		m_oMessageField					= [[UITextField alloc] initWithFrame:CGRectZero];
		m_oMessageField.borderStyle		= UITextBorderStyleRoundedRect;
		m_oMessageField.returnKeyType	= UIReturnKeyDone;
		
		m_oMessageField.placeholder				= aPlaceholderString;
		m_oMessageField.autocorrectionType		= UITextAutocorrectionTypeNo;
		m_oMessageField.autocapitalizationType	= UITextAutocapitalizationTypeNone;
		m_oMessageField.keyboardType			= aKeyboardType;
		
		self.title = aTitleString;
		self.message	= aMessageString;
		
		[self addSubview:m_oMessageField];
		[m_oMessageField becomeFirstResponder];
		
		[self addButtonWithTitle:aCancelString];
		[self addButtonWithTitle:aConfirmString];
	}
	return self;
	
}



- (void)layoutSubviews {         
	CGFloat buttonTop = 0;   
	
	for (UIView *view in self.subviews) {                 
		if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {                         
			view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 20, view.frame.size.width, view.frame.size.height);                         
			buttonTop = view.frame.origin.y;                 
		}         
	}         
	
	buttonTop -= 35;
	m_oMessageField.frame = CGRectMake(12, buttonTop-25, self.frame.size.width - 52, 30);
}

- (void)setFrame:(CGRect)rect {         
	[super setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 180)];         
	self.center = CGPointMake(320/2, 130); 
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	return YES;
}

-(NSString *)getText{
	return m_oMessageField.text;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
	UIMenuController *menuController = [UIMenuController sharedMenuController];
	if (menuController) {
		[UIMenuController sharedMenuController].menuVisible = NO;
	}
	return NO;
}

-(void) dealloc {
	[m_oMessageField release];
	[super dealloc];
}

@end
