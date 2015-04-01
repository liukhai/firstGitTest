//
//  MHDisclaimerViewController.h
//  AyersGTS
//
//  Created by MegaHub on 04/12/2010.
//  Copyright 2010 MegaHub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHDisclaimerViewController : UIViewController {
	UITextView		*m_oTextView;
	UIButton		*m_oOKButton;
	UITextView		*m_oDisclaimerContentTextView;
	id				m_idOKButtonTarget;
	SEL				m_SELOKButtonSelector;
}

@property (nonatomic, retain) UIButton *m_oOKButton;

- (void)reloadText;
- (void)setOKButtonTarget:(id)aTarget action:(SEL)aSelector;

@end