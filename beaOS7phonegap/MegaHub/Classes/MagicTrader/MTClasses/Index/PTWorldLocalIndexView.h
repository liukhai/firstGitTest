//
//  PTWorldLocalIndexView.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentedButton;

@interface PTWorldLocalIndexView : UIView {

	SegmentedButton			*m_oWorldLocalSegmentButton;
	UIView					*m_oBottomView;
}

@property(nonatomic, retain) SegmentedButton			*m_oWorldLocalSegmentButton;
@property(nonatomic, retain) UIView						*m_oBottomView;


- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;

// Loading functions
- (void)startLoading;		// no spinner
- (void)stopLoading;
- (void)startLoadingWithSpinner:(BOOL)aBoolean;

@end
