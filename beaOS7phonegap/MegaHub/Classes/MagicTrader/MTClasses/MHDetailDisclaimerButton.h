//
//  MHDetailDisclaimerButton.h
//  MagicTrader
//
//  Created by Hong on 28/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MHDetailDisclaimerButton : UIView {
	
	UIButton		*m_oDetailButton;
	UIButton		*m_oDisclaimerButton;
	
}

@property(nonatomic, retain) UIButton	*m_oDetailButton;
@property(nonatomic, retain) UIButton	*m_oDisclaimerButton;

- (id) initWithDetailImage:(UIImage *)aDetailImage disclaimerImage:(UIImage *)aDisclaimer;
- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;

- (void)addDetailButtonTarget:(id)aTarget action:(SEL)aSelector;
- (void)addDisclaimerButtonTarget:(id)aTarget action:(SEL)aSelector;

- (void)setShowDetailButton:(BOOL)aShowDetail showDisclaimerButton:(BOOL)aShowDisclaimer;

@end
