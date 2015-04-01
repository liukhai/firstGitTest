    //
//  MHBEAPTSSWorldLocalIndexViewController.m
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAPTSSWorldLocalIndexViewController.h"
#import "MHBEAPTSSLocalIndexViewController.h"
#import "MHBEAPTWorldIndexViewController.h"
#import "MHBEAPTSSIndexViewController.h"
#import "SegmentedButton.h"
#import "StyleConstant.h"
#import "MHUtility.h"

@implementation MHBEAPTSSWorldLocalIndexViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		m_iSelectedIndex = 0;
		
		m_oMHBEAPTSSLocalIndexViewController = [[MHBEAPTSSLocalIndexViewController alloc] init];
		
		m_oMHBEAPTWorldIndexViewController = [[MHBEAPTWorldIndexViewController alloc] init];
		
	}
	return self;
}

- (void)dealloc {
    [m_oMHBEAPTSSLocalIndexViewController release];
    m_oMHBEAPTSSLocalIndexViewController = nil;
    
    [m_oMHBEAPTWorldIndexViewController release];
    m_oMHBEAPTWorldIndexViewController = nil;
    
    [m_oPTWorldLocalIndexView release];
    m_oPTWorldLocalIndexView = nil;
    
	[super dealloc];
}

- (void)loadView {
	[super loadView]; 
	
	m_oPTWorldLocalIndexView = [[PTWorldLocalIndexView alloc] initWithFrame:CGRectMake(0, 94, 320, [MHUtility getAppHeight]-15-31-94)];
	self.view = m_oPTWorldLocalIndexView;
	
    [m_oPTWorldLocalIndexView.m_oWorldLocalSegmentButton setButtonSelectedColor:MHStockDataView_m_oStockDataSegmentedButton_selectedColor unselectedColor:MHStockDataView_m_oStockDataSegmentedButton_unselectedColor];
	[m_oPTWorldLocalIndexView.m_oWorldLocalSegmentButton addTarget:self action:@selector(onWorldLocalSegmentPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self switchTo:PTWorldLocalIndexViewNumberLocalIndex];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
    [m_oKeepCallingDataTimer invalidate];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[m_oPTWorldLocalIndexView.m_oWorldLocalSegmentButton setSelectedButtonIndex:PTWorldLocalIndexViewNumberLocalIndex];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	[m_oPTWorldLocalIndexView release];
	m_oPTWorldLocalIndexView = nil;
}

- (void)reloadText {
	[m_oPTWorldLocalIndexView reloadText];
	
	[m_oMHBEAPTSSLocalIndexViewController reloadText];
	[m_oMHBEAPTWorldIndexViewController reloadText];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return NO;
}

#pragma mark -
#pragma mark Button callback functions
- (void)onWorldLocalSegmentPressed:(id)sender {
	if ([sender isKindOfClass:[SegmentedButton class]]) {
		SegmentedButton *btn = sender;
		[self switchTo:btn.m_iSelectedIndex];
	}
}

- (void)switchTo:(PTWorldLocalIndexViewNumber)aNumber {
	
	switch (m_iSelectedIndex) {
		case PTWorldLocalIndexViewNumberLocalIndex: {		[m_oMHBEAPTSSLocalIndexViewController.view removeFromSuperview];	break;	}
		case PTWorldLocalIndexViewNumberWorldIndex: {		[m_oMHBEAPTWorldIndexViewController.view removeFromSuperview];	break;	}default: break;
	}
	
	m_iSelectedIndex = aNumber;
	UIViewController *controller = nil;
	switch (m_iSelectedIndex) {
		case PTWorldLocalIndexViewNumberLocalIndex: {		
			controller = m_oMHBEAPTSSLocalIndexViewController;
            [(MHBEAPTSSLocalIndexViewController*)controller showIndexConstituentView:NO animationTime:0];
			break;	
		}
		case PTWorldLocalIndexViewNumberWorldIndex: {
			[m_oMHBEAPTWorldIndexViewController reloadWorldIndex];
			m_oKeepCallingDataTimer	= [[NSTimer scheduledTimerWithTimeInterval:Time_WorldIndex_Interval
																		target:m_oMHBEAPTWorldIndexViewController 
																	  selector:@selector(reloadWorldIndex) 
																	  userInfo:nil 
																	   repeats:YES] retain];
			
			controller = m_oMHBEAPTWorldIndexViewController;
			break;	
		}default: break;
	}
	
	[m_oPTWorldLocalIndexView.m_oBottomView addSubview:controller.view];
}

@end