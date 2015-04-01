//
//  PTAHSharesView.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadingView;

@interface PTAHSharesView : UIView {
	UIWebView					*m_oWebView;
	LoadingView					*m_oLoadingView;
	UILabel						*m_oNoPermissionLabel;
}

@property (nonatomic, retain) UIWebView					*m_oWebView;

- (id)initWithFrame:(CGRect)frame permission:(BOOL)aPermission;
- (void)dealloc;
- (void)reloadText;

// Loading Functions
- (void)startLoading;
- (void)stopLoading;

// Custom Functions
- (void)loadURLString:(NSString *)aURLString;
- (NSString *)sendJavaScriptString:(NSString *)aJavaScriptString;


@end
