//
//  MHAlertViewPanel.h
//  PhoneStream
//
//  Created by Megahub on 26/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define BUTTON_INDEX_CANCEL			0
#define BUTTON_INDEX_CONFIRM		1

@interface MHAlertViewPanel : UIAlertView {
	UITextField	*m_oMessageField;
}

@property (nonatomic, retain) UITextField *m_oMessageField;

-(NSString *)getText;
- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitleString cancel:(NSString *)aCancelString confirm:(NSString *)aConfirmString placeholder:(NSString *)aPlaceholderString keyboardType:(UIKeyboardType)aKeyboardType;
- (id)initWithFrame:(CGRect)frame title:(NSString *)aTitleString message:(NSString *)aMessageString cancel:(NSString *)aCancelString confirm:(NSString *)aConfirmString placeholder:(NSString *)aPlaceholderString keyboardType:(UIKeyboardType)aKeyboardType;

@end
