//
//  PTWorldIndexView.m
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "PTWorldIndexView.h"
#import "StyleConstant.h"
#import "LoadingView.h"
#import "MHLanguage.h"
#import "MHUILabel.h"


@implementation PTWorldIndexView

@synthesize m_oTableView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		float delayLabelHeight = 20;
		
		self.backgroundColor = Default_view_background_color;
		
		m_oTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y,
																	 frame.size.width, frame.size.height-delayLabelHeight)];
		[m_oTableView setSeparatorColor:Default_table_seperator_color];
		[m_oTableView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
		[m_oTableView setBackgroundColor:[UIColor clearColor]];
		[self addSubview:m_oTableView];
		[m_oTableView release];
		
		m_oDelayLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-delayLabelHeight, 
																	frame.size.width, delayLabelHeight)];
		[m_oDelayLabel setFont:PTWorldIndexView_m_oDelayLabel_font];
		[m_oDelayLabel setTextColor:PTWorldIndexView_m_oDelayLabel_textColor];
		[m_oDelayLabel setTextAlignment:NSTextAlignmentRight];
		[self addSubview:m_oDelayLabel];
		[m_oDelayLabel release];
	
		[self reloadText];
		
		// LoadingMask
		m_oLoadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		[m_oLoadingView setCenter:self.center];
		[self addSubview:m_oLoadingView];
		[m_oLoadingView release];
    }
	
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)reloadText {
	m_oDelayLabel.text = MHLocalizedString(@"PTWorldIndexView.m_oDelayLabel", nil);
	[m_oLoadingView reloadText];
	[self reloadTable];
}


- (void)reloadTable {
	[m_oTableView reloadData];
}


#pragma mark -
#pragma mark Loading Functions
- (void)startLoading { // no spinner
}
- (void)stopLoading {
	[m_oLoadingView stopLoading];

}

- (void)startLoadingWithSpinner:(BOOL)aBoolean {
	[m_oLoadingView startLoading];
}

@end
