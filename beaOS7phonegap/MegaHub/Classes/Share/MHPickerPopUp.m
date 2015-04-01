//
//  PriceInputPopup.m
//  AyersGTS
//
//  Created by ChiYin on 29/06/2010.
//  Copyright 2010 Megahub. All rights reserved.
//

#import "MHLanguage.h"
#import "MHPickerPopUp.h"

@implementation MHPickerPopUp

@synthesize textInput;

- (id)initWithFrame:(CGRect)frame keyboardType:(UIKeyboardType)aKeyboardType textTag:(NSInteger)texttag title:(NSString *)intitle message:(NSString *)inmessage placeholder:inPlaceholder {
	if (self = [super initWithFrame:frame]) {
		textInput = [[UITextField alloc] initWithFrame:CGRectZero];
		textInput.borderStyle = UITextBorderStyleRoundedRect;
		textInput.keyboardType = aKeyboardType;
		textInput.returnKeyType = UIReturnKeyDone;
		textInput.placeholder = inPlaceholder;
		textInput.autocorrectionType = UITextAutocorrectionTypeNo;
		textInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
		textInput.clearButtonMode = UITextFieldViewModeAlways;
		textInput.tag = texttag;
		
		self.title = intitle; //MHLocalizedString(@"Enter Price",@"Enter Price");
		self.message = inmessage; //MHLocalizedString(@"Input a custom price, then touch to confirm",@"Custom Price Prompt");
		
		[self addSubview:textInput];
		
		[self addButtonWithTitle:MHLocalizedString(@"alertViewCancel",nil)];
		[self addButtonWithTitle:MHLocalizedString(@"alertViewConfirm",nil)];
		
		self.cancelButtonIndex = 1;
		
	}
	return self;
}

- (void)setFrame:(CGRect)rect {         
	[super setFrame:CGRectMake(0, 0, rect.size.width, 180)];  
	self.center = CGPointMake(320/2, 110); 
}

- (void)layoutSubviews {         
	CGFloat buttonTop = 0;         
	for (UIView *view in self.subviews) {                 
		if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {                         
			view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height);                         
			buttonTop = view.frame.origin.y;                 
		}         
	}         
	
	buttonTop -= 40;
	textInput.frame = CGRectMake(35, buttonTop, 220, 30);
	[textInput becomeFirstResponder];
	
}

- (void)drawRect:(CGRect)rect {         
	[super drawRect:rect];
}

-(void) dealloc {
	[textInput release];
	[super dealloc];
}

@end
