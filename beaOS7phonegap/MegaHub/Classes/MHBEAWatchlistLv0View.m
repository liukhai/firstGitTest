//
//  MHBEAWatchlistLv0View.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAWatchlistLv0View.h"
#import "MHDisclaimerBarView.h"
#import "MHBEAStyleConstant.h"
#import "MHBEAConstant.h"
#import "LoadingView.h"
#import "MHUtility.h"
#import "PTConstant.h"
#import "MBKUtil.h"
#import "MHBEAIndexQuoteView.h"
#import "MHBEABottomView.h"
#import "MHDisclaimerBarView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MHBEAWatchlistLv0View

@synthesize m_oBackButton;
@synthesize m_oEditButton;
@synthesize m_oReloadButton;
@synthesize m_oMHBEAIndexQuoteView;
@synthesize m_oTextField;
@synthesize m_oSearchButton;
@synthesize m_oTableView;
@synthesize m_oHideSearchKeyBoardButton;
@synthesize m_oStockTotalValueView;
@synthesize m_oStockTotalBackground;
@synthesize m_oStockTotalValueTitle;
@synthesize m_oStockTotalValueValue;
@synthesize m_oLoadingView;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)aController{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        controller = aController;
        
        UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        topBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topBgView];
        
		// Search bar
        UIView *searchBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(115+5, 7, 30, 28)];
        if(![MHUtility checkVersionGreater:@"7.0"]){
            [searchBackgroundView setFrame:CGRectMake(115+5, 5, 30, 31)];
        }
        searchBackgroundView.backgroundColor = [UIColor whiteColor];
        searchBackgroundView.layer.cornerRadius = 8;
        searchBackgroundView.layer.borderWidth = 0.5;
        searchBackgroundView.layer.borderColor = [[UIColor colorWithRed:111/255.0 green:109/255.0 blue:128/255.0 alpha:1] CGColor];
        [self addSubview:searchBackgroundView];
        [searchBackgroundView release];

        m_oSearchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(115+8, 13, 15, 15)];
        m_oSearchImageView.image = [UIImage imageNamed:@"bea_watchlist_search.png"];
        [self addSubview:m_oSearchImageView];
        [m_oSearchImageView release];
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 0)];
        m_oTextField = [[UITextField alloc] initWithFrame:CGRectMake(115+27, 7, 195-65, 28)];
        if(![MHUtility checkVersionGreater:@"7.0"]){
            [m_oTextField setFrame:CGRectMake(115+27, 5, 195-65, 31)];
        }
        m_oTextField.font = [UIFont systemFontOfSize:11];
        m_oTextField.backgroundColor = [UIColor whiteColor];
        m_oTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        m_oTextField.layer.borderWidth = 0.5;
        m_oTextField.layer.borderColor = [[UIColor colorWithRed:111/255.0 green:109/255.0 blue:128/255.0 alpha:1] CGColor];
        [m_oTextField setLeftViewMode:UITextFieldViewModeAlways];
        [m_oTextField setLeftView:spacerView];
        [self addSubview:m_oTextField];
        [m_oTextField release];
        [spacerView release];
        
        UIView *searchBackgroundView2 = [[UIView alloc] initWithFrame:CGRectMake(115+26, 7.5, 2, 27)];
        if(![MHUtility checkVersionGreater:@"7.0"]){
            [searchBackgroundView2 setFrame:CGRectMake(115+26, 5.5, 2, 30)];
        }
        searchBackgroundView2.backgroundColor = [UIColor whiteColor];
        [self addSubview:searchBackgroundView2];
        [searchBackgroundView2 release];
        
        m_oSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oSearchButton setBackgroundImage:[UIImage imageNamed:@"bea_watchlist_btn_search.png"] forState:UIControlStateNormal];
        if([MHUtility checkVersionGreater:@"7.0"]){
            [m_oSearchButton setFrame:CGRectMake(320-5-45, 7, 45, 28)];
        }else{
            [m_oSearchButton setFrame:CGRectMake(320-5-45, 5, 45, 31)];
        }
        [m_oSearchButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [m_oSearchButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:m_oSearchButton];
        
        m_oBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oBackButton setBackgroundImage:[UIImage imageNamed:@"bea_watchlist_button.png"] forState:UIControlStateNormal];
        [m_oBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [m_oBackButton addTarget:aController action:@selector(onBackButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [m_oBackButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [m_oBackButton setFrame:CGRectMake(5, 5, 40, 30)];
        [m_oBackButton setHidden:YES];
        [self addSubview:m_oBackButton];
        
        // Edit button
        m_oEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oEditButton setFrame:CGRectMake(5, 5, 40, 30)];
        [m_oEditButton setBackgroundImage:[UIImage imageNamed:@"bea_watchlist_button.png"] forState:UIControlStateNormal];
        [m_oEditButton addTarget:aController action:@selector(onEditButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [m_oEditButton setTitleColor:WFWatchlistRootViewController_m_oEditButton_text_color forState:UIControlStateNormal];
        [m_oEditButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:m_oEditButton];
        
        // reorder
        m_oReorderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oReorderButton setBackgroundImage:MHBEA_general_button_reorder_image_0 forState:UIControlStateNormal];
        [m_oReorderButton addTarget:aController action:@selector(onReorderButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [m_oReorderButton setFrame:CGRectMake(50, 5, 30, 30)];
        [m_oReorderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [m_oReorderButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [m_oReorderButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:m_oReorderButton];
        
        // reloadButton
        m_oReloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_oReloadButton setBackgroundImage:MHBEA_general_button_reload_image forState:UIControlStateNormal];
        [m_oReloadButton addTarget:aController action:@selector(onReloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [m_oReloadButton setFrame:CGRectMake(85, 5, 30, 30)];
        [self addSubview:m_oReloadButton];
        
        // Index bar
		m_oMHBEAIndexQuoteView = [[MHBEAIndexQuoteView alloc] initWithFrame:CGRectMake(0, 40, 320, 63) controller:aController];
        [m_oMHBEAIndexQuoteView.m_oAddButton addTarget:controller action:@selector(onAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oMHBEAIndexQuoteView];
		[m_oMHBEAIndexQuoteView release];
        
		// tableView
		m_oTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 103, 320, frame.size.height-m_oTextField.frame.size.height-m_oMHBEAIndexQuoteView.frame.size.height-31-15) style:UITableViewStylePlain];
		[m_oTableView setBackgroundColor:[UIColor whiteColor]];
		[m_oTableView setSeparatorColor:[UIColor clearColor]];
		[m_oTableView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
		[self addSubview:m_oTableView];
        [m_oTableView release];
		
		// Hide Search KeyBoard Button
		m_oHideSearchKeyBoardButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oHideSearchKeyBoardButton setFrame:CGRectMake(0, 40, 320, 252)];
		[m_oHideSearchKeyBoardButton setHidden:YES];
		[self addSubview:m_oHideSearchKeyBoardButton];
		[m_oHideSearchKeyBoardButton addTarget:self action:@selector(onHideSearchKeyBoardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		// Total Value Label
		m_oStockTotalValueView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-31-15-21, 320, 21)];
		[m_oStockTotalValueView setBackgroundColor:[UIColor grayColor]];
		[m_oStockTotalValueView setHidden:YES];
		[self addSubview:m_oStockTotalValueView];
		[m_oStockTotalValueView release];
		
//		m_oStockTotalBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_oStockTotalValueLabel.frame.size.width, m_oStockTotalValueLabel.frame.size.height)];
//		[m_oStockTotalBackground setImage:MHBEAWatchlistLv0View_m_oStockTotalBackground_image];
//		[m_oStockTotalValueLabel addSubview:m_oStockTotalBackground];
//		[m_oStockTotalBackground release];
		
		m_oStockTotalValueTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 110, 20)];
        [m_oStockTotalValueTitle setTextColor:[UIColor whiteColor]];
		[m_oStockTotalValueTitle setBackgroundColor:[UIColor clearColor]];
        [m_oStockTotalValueTitle setAdjustsFontSizeToFitWidth:YES];
		[m_oStockTotalValueView addSubview:m_oStockTotalValueTitle];
		[m_oStockTotalValueTitle release];
		
		m_oStockTotalValueValue = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 190, 20)];
        [m_oStockTotalValueValue setTextColor:[UIColor whiteColor]];
		[m_oStockTotalValueValue setBackgroundColor:[UIColor clearColor]];
		[m_oStockTotalValueValue setTextAlignment:NSTextAlignmentRight];
		[m_oStockTotalValueValue setAdjustsFontSizeToFitWidth:YES];
		[m_oStockTotalValueView addSubview:m_oStockTotalValueValue];
		[m_oStockTotalValueValue release];
		
		// Loading View
		m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake((frame.size.width-100)/2, (frame.size.height-100)/2, 100, 100)];
		[m_oLoadingView.m_oSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[m_oLoadingView setHaveBackground:YES];
		[m_oLoadingView stopLoading];
		[self addSubview:m_oLoadingView];
		[m_oLoadingView release];
        
        m_oMHBEABottomView = [[MHBEABottomView alloc] initWithFrame:CGRectMake(0, frame.size.height-15-31, 320, 31)];
        [m_oMHBEABottomView setShowFiveButtons:NO];
        [self addSubview:m_oMHBEABottomView];
        [m_oMHBEABottomView release];
        
        // Discclaimer
		m_oMHDisclaimerBarView = [[MHDisclaimerBarView alloc] initWithFrame:CGRectMake(0, frame.size.height-15, 320, 15)];
		[self addSubview:m_oMHDisclaimerBarView];
		[m_oMHDisclaimerBarView release];
    }
    return self;
}

- (void)reloadText {
    [m_oMHDisclaimerBarView reloadText];
    [m_oMHBEAIndexQuoteView reloadText];
    [m_oMHBEABottomView reloadText];
	[m_oTextField setPlaceholder:MHLocalizedStringFile(@"MHBEAWatchlistLv0View.m_oSearchBar.placeholder", nil, MHLanguage_BEAString)];
    [m_oSearchButton setTitle:MHLocalizedStringFile(@"MHBEAWatchlistLv0View.m_oSearchBar.searchButton", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
	[m_oLoadingView reloadText];
	m_oStockTotalValueTitle.text = MHLocalizedStringFile(@"MHBEAWatchlistLv0View.m_oStockTotalValueTitle", nil, MHLanguage_BEAString);
}

- (void)dealloc {
    [super dealloc];
}

- (void)setHiddenIndexQuoteView:(BOOL)isHidden {
    m_oMHBEAIndexQuoteView.hidden = isHidden;
    
    if(isHidden){
        m_oTableView.frame = CGRectMake(0, 40, 320, self.frame.size.height-m_oTextField.frame.size.height-10-m_oMHBEABottomView.frame.size.height-m_oMHDisclaimerBarView.frame.size.height - (m_oStockTotalValueView.hidden ? 0 : m_oStockTotalValueView.frame.size.height));
    }else{
        m_oTableView.frame = CGRectMake(0, 103, 320, self.frame.size.height-m_oTextField.frame.size.height-10-m_oMHBEAIndexQuoteView.frame.size.height-m_oMHBEABottomView.frame.size.height-m_oMHDisclaimerBarView.frame.size.height - (m_oStockTotalValueView.hidden ? 0 : m_oStockTotalValueView.frame.size.height));
    }
}

- (void)clean {
	[m_oMHBEAIndexQuoteView cleanStock];
}

#pragma mark -
- (void)displayStockTotalValueView:(BOOL)show {
	m_oStockTotalValueView.hidden = !show;
    
    if(show){
        m_oTableView.frame = CGRectMake(0, m_oMHBEAIndexQuoteView.hidden ? 40 : 103, 320, self.frame.size.height-m_oTextField.frame.size.height-10-(m_oMHBEAIndexQuoteView.hidden ? 0 : m_oMHBEAIndexQuoteView.frame.size.height)-m_oMHBEABottomView.frame.size.height-m_oMHDisclaimerBarView.frame.size.height-m_oStockTotalValueView.frame.size.height);
    }else{
        m_oTableView.frame = CGRectMake(0, m_oMHBEAIndexQuoteView.hidden ? 40 : 103, 320, self.frame.size.height-m_oTextField.frame.size.height-10-(m_oMHBEAIndexQuoteView.hidden && m_oBackButton.hidden ? 0 : m_oMHBEAIndexQuoteView.frame.size.height)-m_oMHBEABottomView.frame.size.height-m_oMHDisclaimerBarView.frame.size.height);
    }
}

- (void)displayBackButton:(BOOL)show {
    if(show) {
        m_oBackButton.hidden = NO;
        m_oEditButton.hidden = YES;
        m_oReorderButton.hidden = YES;
        m_oReloadButton.hidden = YES;
        m_oMHBEAIndexQuoteView.hidden = YES;
        
    }else{
        m_oBackButton.hidden = YES;
        m_oEditButton.hidden = NO;
        m_oReorderButton.hidden = NO;
        m_oReloadButton.hidden = NO;
        
        [self setHiddenIndexQuoteView:m_oMHBEAIndexQuoteView.hidden];
    }
}

#pragma mark -
#pragma mark UpdateFunctions
- (void)updateStockTotalValueLabel:(double)aTotalValue {
    [m_oStockTotalValueValue setText:[MHUtility doubleMoneyValueToDisplayableString:aTotalValue market:MARKET_HONGKONG]];
}

- (void)updateLastUpdateTime:(NSString *)updateTime{
    m_oMHDisclaimerBarView.m_oTextLabel.text = [NSString stringWithFormat:@"%@%@",
                                                MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oLastUpdateTimeLabel", nil, MHLanguage_BEAString),
                                                updateTime?updateTime:@""];
}

#pragma mark -
#pragma mark Button callback functions
- (void)onHideSearchKeyBoardButtonPressed:(id)sender {
	[m_oHideSearchKeyBoardButton setHidden:YES];
	[m_oTextField resignFirstResponder];
}


#pragma mark -
#pragma mark Loading Functions
- (void)startLoading {
	[self setUserInteractionEnabled:NO];
	[m_oLoadingView startLoading];
}

- (void)stopLoading {
	[self setUserInteractionEnabled:YES];
	[m_oLoadingView stopLoading];
}

@end