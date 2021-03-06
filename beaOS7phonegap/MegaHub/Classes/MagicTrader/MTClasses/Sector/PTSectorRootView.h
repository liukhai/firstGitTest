//
//  PTSectorRootView.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadingView;

@interface PTSectorRootView : UIView {
	
	UITableView			*m_oTableView;
	
	UIWebView			*m_oWebView;
	LoadingView			*m_oLoadingView;
	
	UILabel				*m_oNoPermissionLabel;
}


@property (nonatomic, retain) UITableView	*m_oTableView;
@property (nonatomic, retain) UIWebView		*m_oWebView;
@property (nonatomic, retain) LoadingView	*m_oLoadingView;

- (id)initWithFrame:(CGRect)frame permission:(BOOL)aPermission;
- (void)dealloc;
- (void)reloadText;

// Loading Functions
- (void)startLoading;
- (void)stopLoading;

// Custom Functions
- (void)loadURLString:(NSString *)aURLString;
- (NSString *)sendJavaScriptString:(NSString *)aJavaScriptString;

- (void)switchWebViewWithURLString:(NSString *)aURLString;
- (void)switchTableView;

@end
