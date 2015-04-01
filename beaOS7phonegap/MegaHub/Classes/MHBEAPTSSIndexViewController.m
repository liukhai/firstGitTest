    //
//  MHBEAPTSSIndexViewController.m
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAPTSSWorldLocalIndexViewController.h"
#import "MHBEAFASectorRootViewController.h"
#import "MHBEAFAAHSharesViewController.h"
#import "MHBEAPTSSIndexViewController.h"
#import "MHBEAFATopRankViewController.h"
#import "MHBEAPTFANewsViewController.h"
#import "MHDisclaimerBarView.h"
#import "MHBEAPTFANewsView.h"
#import "BEAViewController.h"
#import "MHFeedConnectorX.h"
#import "PTSectorRootView.h"
#import "SegmentedButton.h"
#import "MHBEABottomView.h"
#import "PTAHSharesView.h"
#import "StyleConstant.h"
#import "MHBEAConstant.h"
#import "PTTopRankView.h"
#import "MHLanguage.h"
#import "MHUtility.h"
#import "CoreData.h"

@implementation MHBEAPTSSIndexViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		m_oMHBEAPTSSWorldLocalIndexViewController   = [[MHBEAPTSSWorldLocalIndexViewController alloc] init];
		m_oMHBEAFASectorRootViewController          = [[MHBEAFASectorRootViewController alloc] init];
		m_oMHBEAFATopRankViewController             = [[MHBEAFATopRankViewController alloc] init];
		m_oMHBEAFAAHSharesViewController			= [[MHBEAFAAHSharesViewController alloc] init];
		m_oMHBEAPTFANewsViewController              = [[MHBEAPTFANewsViewController alloc] init];
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
    
    [[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];
    
    [m_oMHBEAPTSSWorldLocalIndexViewController release];
    m_oMHBEAPTSSWorldLocalIndexViewController = nil;
    
    [m_oMHBEAFASectorRootViewController release];
    m_oMHBEAFASectorRootViewController = nil;
    
    [m_oMHBEAFATopRankViewController release];
    m_oMHBEAFATopRankViewController = nil;
    
    [m_oMHBEAFAAHSharesViewController release];
    m_oMHBEAFAAHSharesViewController = nil;
    
    [m_oMHBEAPTFANewsViewController release];
    m_oMHBEAPTFANewsViewController = nil;

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [v_rmvc.rmUtil setNav:self.navigationController];

    [self reloadText];
}

- (void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
    [[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    m_oMHBEABottomView = [[MHBEABottomView alloc] initWithFrame:CGRectMake(0, [MHUtility getAppHeight]-15-31, 320, 31)];
    [m_oMHBEABottomView setSelectedIndex:2];
    [self.view addSubview:m_oMHBEABottomView];
    [m_oMHBEABottomView release];
    
    // Discclaimer
    m_oMHDisclaimerBarView = [[MHDisclaimerBarView alloc] initWithFrame:CGRectMake(0, [MHUtility getAppHeight]-15, 320, 15)];
    [self.view addSubview:m_oMHDisclaimerBarView];
    [m_oMHDisclaimerBarView release];
    
    [self.view addSubview:m_oMHBEAPTSSWorldLocalIndexViewController.view];
    [self.view addSubview:m_oMHBEAFASectorRootViewController.view];
    [self.view addSubview:m_oMHBEAFATopRankViewController.view];
    [self.view addSubview:m_oMHBEAFAAHSharesViewController.view];
    [self.view addSubview:m_oMHBEAPTFANewsViewController.view];
    
    [m_oMHBEAPTSSWorldLocalIndexViewController.view removeFromSuperview];
    [m_oMHBEAFASectorRootViewController.view removeFromSuperview];
    [m_oMHBEAFATopRankViewController.view removeFromSuperview];
    [m_oMHBEAFAAHSharesViewController.view removeFromSuperview];
    [m_oMHBEAPTFANewsViewController.view removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:v_rmvc.contentView];
    
    NSArray *titleArray = [NSArray arrayWithObjects:
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.indices", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.sector", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.ranking", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.ah", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.news", nil, MHLanguage_BEAString),nil];

    [v_rmvc.rmUtil setTextArray:titleArray];
    
    UIView *view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSArray *a_views = [NSArray arrayWithObjects:view_temp , view_temp, view_temp, view_temp, view_temp, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
    [v_rmvc.rmUtil setShowIndex:4];
    
//    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil showMenu];
    
    [view_temp release];
    [v_rmvc release];
    
    [[MHFeedConnectorX sharedMHFeedConnectorX] addGetLiteQuoteObserver:self action:@selector(onGetLiteQuoteReceived:)];
}

- (void)reloadText {
    [m_oMHBEAPTFANewsViewController reloadText];
    [m_oMHBEAFAAHSharesViewController reloadText];
    [m_oMHBEAPTSSWorldLocalIndexViewController reloadText];
    [m_oMHBEAFASectorRootViewController reloadText];
    [m_oMHBEAFATopRankViewController reloadText];
    [m_oMHBEABottomView reloadText];
    [m_oMHDisclaimerBarView reloadText];
    
    NSArray *titleArray = [NSArray arrayWithObjects:
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.indices", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.sector", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.ranking", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.ah", nil, MHLanguage_BEAString),
                           MHLocalizedStringFile(@"MHBEAPTSSIndexViewController.news", nil, MHLanguage_BEAString),nil];
    
    [v_rmvc.rmUtil setTextArray:titleArray];
    [v_rmvc.rmUtil showMenu];
}

- (void)viewDidUnload {
	[super viewDidUnload];
    [[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLiteQuoteObserver:self];
}

- (void)showMenu:(int)show {
    for (UIView *view in self.view.subviews) {
		if ([view isKindOfClass:[PTWorldLocalIndexView class]]) {
            [m_oMHBEAPTSSWorldLocalIndexViewController.view removeFromSuperview];
        }else if ([view isKindOfClass:[PTSectorRootView class]]) {
            [m_oMHBEAFASectorRootViewController.view removeFromSuperview];
        }else if ([view isKindOfClass:[PTTopRankView class]]) {
            [m_oMHBEAFATopRankViewController.view removeFromSuperview];
        }else if ([view isKindOfClass:[PTAHSharesView class]]) {
            [m_oMHBEAFAAHSharesViewController.view removeFromSuperview];
        }else if ([view isKindOfClass:[MHBEAPTFANewsView class]]) {
            [m_oMHBEAPTFANewsViewController.view removeFromSuperview];
        }
    }
    
    m_oMHDisclaimerBarView.m_oTextLabel.text = MHLocalizedStringFile(@"MHDisclaimerBarView.m_oTextLabel", nil, MHLanguage_BEAString);
    
    switch (show) {
        case 0:
            
            m_oMHDisclaimerBarView.m_oTextLabel.text = [NSString stringWithFormat:@"%@%@",
                                                        MHLocalizedStringFile(@"MHBEAFAQuoteView.m_oLastUpdateTimeLabel", nil, MHLanguage_BEAString),
                                                        m_sLastUpdateTime?m_sLastUpdateTime:@""];
            
            [self.view addSubview:m_oMHBEAPTSSWorldLocalIndexViewController.view];
            break;
        case 1:
            [m_oMHBEAFASectorRootViewController onBackButtonPressed];
            [self.view addSubview:m_oMHBEAFASectorRootViewController.view];
            break;
        case 2:
            [self.view addSubview:m_oMHBEAFATopRankViewController.view];
            break;
        case 3:
            [self.view addSubview:m_oMHBEAFAAHSharesViewController.view];
            break;
        case 4:
            [self.view addSubview:m_oMHBEAPTFANewsViewController.view];
            break;
    }

}

- (void)onGetLiteQuoteReceived:(NSNotification *)n {
	MHFeedXMsgInGetLiteQuote *msg = [n object];
    [self performSelectorOnMainThread:@selector(handleGetLiteQuote:) withObject:msg waitUntilDone:NO];
}

- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)msg {
    // update last update time
	@synchronized(m_sLastUpdateTime) {
		if (m_sLastUpdateTime) {
			[m_sLastUpdateTime release];
		}
		m_sLastUpdateTime = [msg.m_sHKLastUpdate retain];
	}
}

@end