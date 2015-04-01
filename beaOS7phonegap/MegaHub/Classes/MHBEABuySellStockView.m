//
//  MHBEABuySellStockView.m
//  BEA
//
//  Created by MegaHub on 06/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEABuySellStockView.h"
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

@implementation MHBEABuySellStockView

@synthesize m_oMHBEAIndexQuoteView;
@synthesize m_oMHBEABottomView;
@synthesize m_oTableView;
@synthesize m_oStockTotalValueLabel;
@synthesize m_oStockTotalBackground;
@synthesize m_oStockTotalValueTitle;
@synthesize m_oStockTotalValueValue;
@synthesize m_oLoadingView;

- (id)initWithFrame:(CGRect)frame controller:(UIViewController *)aController{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        controller = aController;
        
        self.backgroundColor = [UIColor whiteColor];
        
        // Index bar
		m_oMHBEAIndexQuoteView = [[MHBEAIndexQuoteView alloc] initWithFrame:CGRectMake(0, 63, 320, 63) controller:aController];
//        [m_oMHBEAIndexQuoteView.m_oAddButton addTarget:controller action:@selector(onAddButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oMHBEAIndexQuoteView];
		[m_oMHBEAIndexQuoteView release];
        
        // Buysell label
        m_oBuySellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 126, 200, 34)];
        [m_oBuySellLabel setTextColor:[UIColor whiteColor]];
        [m_oBuySellLabel setBackgroundColor:[UIColor colorWithRed:168/255.0 green:180/255.0 blue:186/255.0 alpha:1]];
        [m_oBuySellLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:m_oBuySellLabel];
        
        // Buy Sell Button
        m_oBuySellButton = [[UIButton alloc] initWithFrame:CGRectMake(200,126, 120, 34)];
        [m_oBuySellButton setBackgroundColor:[UIColor orangeColor]];
        [m_oBuySellButton.titleLabel setTextColor:[UIColor whiteColor]];
        [m_oBuySellButton addTarget:aController action:@selector(onBuySellButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_oBuySellButton];
        
		// tableView
		m_oTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 160, 320, frame.size.height-64-m_oBuySellLabel.frame.size.height-m_oMHBEAIndexQuoteView.frame.size.height-31-15) style:UITableViewStylePlain];
		[m_oTableView setBackgroundColor:[UIColor clearColor]];
		[m_oTableView setSeparatorColor:[UIColor clearColor]];
		[m_oTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		[self addSubview:m_oTableView];
        [m_oTableView release];
        
        // Total Value Label
		m_oStockTotalValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-31-15-21, 320, 21)];
		[m_oStockTotalValueLabel setBackgroundColor:[UIColor grayColor]];
		[m_oStockTotalValueLabel setHidden:YES];
		[self addSubview:m_oStockTotalValueLabel];
		[m_oStockTotalValueLabel release];
		
//		m_oStockTotalBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_oStockTotalValueLabel.frame.size.width, m_oStockTotalValueLabel.frame.size.height)];
//		[m_oStockTotalBackground setImage:MHBEAWatchlistLv0View_m_oStockTotalBackground_image];
//		[m_oStockTotalValueLabel addSubview:m_oStockTotalBackground];
//		[m_oStockTotalBackground release];
		
		m_oStockTotalValueTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 110, 20)];
        [m_oStockTotalValueTitle setTextColor:[UIColor whiteColor]];
		[m_oStockTotalValueTitle setBackgroundColor:[UIColor clearColor]];
        [m_oStockTotalValueTitle setAdjustsFontSizeToFitWidth:YES];
		[m_oStockTotalValueLabel addSubview:m_oStockTotalValueTitle];
		[m_oStockTotalValueTitle release];
		
		m_oStockTotalValueValue = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 190, 20)];
        [m_oStockTotalValueValue setTextColor:[UIColor whiteColor]];
		[m_oStockTotalValueValue setBackgroundColor:[UIColor clearColor]];
		[m_oStockTotalValueValue setTextAlignment:NSTextAlignmentRight];
		[m_oStockTotalValueValue setAdjustsFontSizeToFitWidth:YES];
		[m_oStockTotalValueLabel addSubview:m_oStockTotalValueValue];
		[m_oStockTotalValueValue release];
		
		// Loading View
		m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake((frame.size.width-100)/2, (frame.size.height-100)/2, 100, 100)];
		[m_oLoadingView.m_oSpinner setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[m_oLoadingView setHaveBackground:YES];
		[m_oLoadingView stopLoading];
		[self addSubview:m_oLoadingView];
		[m_oLoadingView release];
        
        m_oMHBEABottomView = [[MHBEABottomView alloc] initWithFrame:CGRectMake(0, frame.size.height-15-31, 320, 31)];
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
    [m_oMHBEAIndexQuoteView reloadText];
    [m_oMHBEABottomView reloadText];
	[m_oLoadingView reloadText];
	m_oStockTotalValueTitle.text = MHLocalizedStringFile(@"MHBEAWatchlistLv0View.m_oStockTotalValueTitle", nil, MHLanguage_BEAString);
    [m_oBuySellButton setTitle:MHLocalizedStringFile(@"MHBEABuySellStockView.m_oBuySellButton.buy", nil, MHLanguage_BEAString) forState:UIControlStateNormal];
	m_oBuySellLabel.text = MHLocalizedStringFile(@"MHBEABuySellStockView.m_oBuySellLabel.buy", nil, MHLanguage_BEAString);
}

- (void)dealloc {
    [super dealloc];
}

- (void)clean {
	[m_oMHBEAIndexQuoteView cleanStock];
}

#pragma mark -
- (void)displayStockTotalValueView:(BOOL)show {
	if (show) {
		m_oStockTotalValueLabel.hidden = NO;
		[m_oTableView setFrame:CGRectMake(m_oTableView.frame.origin.x,
										  m_oTableView.frame.origin.y, 
										  m_oTableView.frame.size.width, self.frame.size.height-64-m_oBuySellLabel.frame.size.height-m_oMHBEAIndexQuoteView.frame.size.height-m_oMHBEABottomView.frame.size.height-m_oMHDisclaimerBarView.frame.size.height-21)];
	} else {
		m_oStockTotalValueLabel.hidden = YES;
		[m_oTableView setFrame:CGRectMake(m_oTableView.frame.origin.x, 
										  m_oTableView.frame.origin.y,
										  m_oTableView.frame.size.width, self.frame.size.height-64-m_oBuySellLabel.frame.size.height-m_oMHBEAIndexQuoteView.frame.size.height-m_oMHBEABottomView.frame.size.height-m_oMHDisclaimerBarView.frame.size.height)];
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