//
//  PriceInputPopup.h
//  AyersGTS
//
//  Created by ChiYin on 29/06/2010.
//  Copyright 2010 Megahub. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MHPickerPopUp : UIAlertView {
	UITextField *textInput;
}

@property (nonatomic, retain) UITextField *textInput;

- (id)initWithFrame:(CGRect)frame 
	   keyboardType:(UIKeyboardType)aKeyboardType
			textTag:(NSInteger)texttag 
			  title:(NSString *)intitle 
			message:(NSString *)inmessage 
		placeholder:inPlaceholder;

- (void)setFrame:(CGRect)rect;
- (void)layoutSubviews;
- (void)drawRect:(CGRect)rect;
-(void) dealloc;
@end
