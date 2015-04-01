//
//  MHAdjustableTextField.h
//  QuamSec
//
//  Created by Megahub on 17/01/2011.
//  Copyright 2011 Megahub. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Composite textfield class with plus/minus button on the sides.
 *  Tapping the buttons will increment/decrement the value in the textfield
 *  by a configurable increment/decrement. Holding it down will cause the value
 *  to increment/decrement automatically, limited to a predetermined maximum.
 */

@interface MHAdjustableTextFieldView : UIView <UITextFieldDelegate> {
	
	BOOL					m_isIntegerOnly;
	BOOL					m_isIncrement;
	
	IBOutlet UIButton		*m_oIncrementButton;
	IBOutlet UIButton		*m_oDecrementButton;
	IBOutlet UITextField	*m_oTextField;
	
	NSDecimalNumber			*m_dIncrementValue;
	NSDecimalNumber			*m_dDecrementValue;
	NSDecimalNumber			*m_dMaxValue;
	NSDecimalNumber			*m_dMinValue;
	
	NSTimer					*m_oTriggerTimer;
	NSTimer					*m_oIntervalTimer;
	NSTimeInterval			m_fNextTimeInterval;
	
}

@property (nonatomic, retain) NSDecimalNumber *dIncrementValue;
@property (nonatomic, retain) NSDecimalNumber *dDecrementValue;
@property (nonatomic, retain) NSDecimalNumber *dMaxValue;
@property (nonatomic, retain) NSDecimalNumber *dMinValue;
@property (nonatomic, retain) NSString		*text;

+ (void)dummyFunction;

- (IBAction)onIncrementUp:(id)sender;
- (IBAction)onIncrementDown:(id)sender;
- (IBAction)onDecrementUp:(id)sender;
- (IBAction)onDecrementDown:(id)sender;

- (void)increment;
- (void)decrement;

@end
