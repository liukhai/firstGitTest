//
//  MHBEAPTFANewsView.m
//  BEA
//
//  Created by hong on 10/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAPTFANewsView.h"
#import "MHPickerTextField.h"
#import "MHBEAConstant.h"
#import "LoadingView.h"
#import "MHLanguage.h"

@implementation MHBEAPTFANewsView

@synthesize m_oNewsGroupTextField;
@synthesize m_oStockSymbolTextField;
@synthesize m_oSearchButton;
@synthesize m_oWebView;
 
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		// Search Bar Image
        m_oSearchBarBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 38)];
		[m_oSearchBarBg setImage:[UIImage imageNamed:@"bea_watchlist_row.png"]];
		[self addSubview:m_oSearchBarBg];
		[m_oSearchBarBg release];
		
		m_oNewsGroupTextField = [[MHPickerTextField alloc] initWithFrame:CGRectMake(5, 3, 170, 26)];
		[m_oNewsGroupTextField setBackground:[UIImage imageNamed:@"bea_news_cat_long0.png"]];		
		[m_oNewsGroupTextField setBorderStyle:UITextBorderStyleNone];
		[m_oNewsGroupTextField setFont:[UIFont systemFontOfSize:13]];
		[m_oNewsGroupTextField setAdjustsFontSizeToFitWidth:YES];
		[m_oNewsGroupTextField set_enableDoneButton:NO];		
		[m_oNewsGroupTextField setTitleMove:5 y:4];
		[self addSubview:m_oNewsGroupTextField];
		[m_oNewsGroupTextField release];
        

		// Search button
		m_oSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[m_oSearchButton setBackgroundImage:[UIImage imageNamed:@"bea_btn_search0.png"] forState:UIControlStateNormal];
		[m_oSearchButton setTitle:MHLocalizedString(@"PTNewsView.m_oSearchButton", nil) forState:UIControlStateNormal];
		[m_oSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[m_oSearchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
		[m_oSearchButton setFrame:CGRectMake(180, 3, 130, 26)];
		[self addSubview:m_oSearchButton];
		
		// Stock Symbol input textfield
		m_oStockSymbolTextField = [[UITextField alloc] initWithFrame:CGRectMake(180, 3, 60, 26)];
		[m_oStockSymbolTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];	
		[m_oStockSymbolTextField setTextAlignment:NSTextAlignmentRight];
		[m_oStockSymbolTextField setFont:[UIFont systemFontOfSize:14]];		
		[m_oStockSymbolTextField setBorderStyle:UITextBorderStyleNone];
		[m_oStockSymbolTextField setReturnKeyType:UIReturnKeySearch];
		[m_oStockSymbolTextField setAdjustsFontSizeToFitWidth:YES];
		[m_oStockSymbolTextField setClearsOnBeginEditing:YES];
		[self addSubview:m_oStockSymbolTextField];
		[m_oStockSymbolTextField release];
		
		
		// web view, the content of news
		m_oWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 38, 320, frame.size.height-38)];
		[m_oWebView setDataDetectorTypes:UIDataDetectorTypeNone];
		[self addSubview:m_oWebView];
		[m_oWebView release];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)reloadText {
	[m_oSearchButton setTitle:MHLocalizedString(@"PTNewsView.m_oSearchButton", nil) forState:UIControlStateNormal];
}

- (void)loadURLString:(NSString *)aURLString {
	[m_oWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aURLString]]];
}

@end