//
//  PTWorldIndexView.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MHUILabel;
@class LoadingView;

@interface PTWorldIndexView : UIView {
	UITableView			*m_oTableView;
	
	MHUILabel			*m_oDelayLabel;
	
	LoadingView			*m_oLoadingView;
}

@property (nonatomic, retain) UITableView		*m_oTableView;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;

- (void)reloadTable;

// Loading functions
- (void)startLoading;		// no spinner
- (void)stopLoading;
- (void)startLoadingWithSpinner:(BOOL)aBoolean;

@end
