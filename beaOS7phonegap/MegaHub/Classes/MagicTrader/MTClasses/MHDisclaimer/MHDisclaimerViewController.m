    //
//  MHDisclaimerViewController.m
//  AyersGTS
//
//  Created by MegaHub on 04/12/2010.
//  Copyright 2010 MegaHub. All rights reserved.
//

#import "MHDisclaimerViewController.h"
#import "MHLanguage.h"
#import "MagicTraderAppDelegate.h"
#import "MHUtility.h"

@implementation MHDisclaimerViewController

@synthesize m_oOKButton;

- (void)dealloc {
	[m_oDisclaimerContentTextView release];
	[m_oOKButton release];
    [super dealloc];
}

- (void)loadView {
	[super loadView];
	self.title = MHLocalizedString(@"disclaimerViewTitle", nil);
	self.view.backgroundColor = [UIColor whiteColor];
	
    CGFloat height = [MHUtility getScreenHeight] - 56 - 20 - 55;
    
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MH_banner.png"]];
	[imageView setFrame:CGRectMake((320-305)/2, 10, 305, 56)];
	[self.view addSubview:imageView];
	[imageView release];
	
	// TextView
	m_oDisclaimerContentTextView = [[UITextView alloc] initWithFrame:CGRectMake((320-305)/2, 10+56, 300, height)];
	[m_oDisclaimerContentTextView setBackgroundColor:[UIColor clearColor]];
	[m_oDisclaimerContentTextView setFont:[UIFont systemFontOfSize:13]];
	[m_oDisclaimerContentTextView setTextColor:[UIColor blackColor]];
	[m_oDisclaimerContentTextView setScrollEnabled:YES];
	[m_oDisclaimerContentTextView setEditable:NO];
	
	[m_oDisclaimerContentTextView setText:[MT_DELEGATE loadGeneralDisclaimer]];
	[self.view addSubview:m_oDisclaimerContentTextView];
	
	m_oOKButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	if (m_idOKButtonTarget == nil) {
		[m_oOKButton addTarget:self action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
	} else {
		[m_oOKButton addTarget:m_idOKButtonTarget action:m_SELOKButtonSelector forControlEvents:UIControlEventTouchUpInside];
	}
	[m_oOKButton setFrame:CGRectMake(50, [MHUtility getScreenHeight]-55, 220, 30)];			   
	[m_oOKButton setTitle:MHLocalizedString(@"MHDisclaimerViewController_OKButton", nil) forState:UIControlStateNormal];
	[self.view addSubview:m_oOKButton];
	
}

- (void)reloadText {
	[m_oDisclaimerContentTextView setText:[MT_DELEGATE loadGeneralDisclaimer]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[m_oDisclaimerContentTextView release];
	m_oDisclaimerContentTextView = nil;
	
	[m_oOKButton release];
	m_oOKButton = nil;
}

#pragma mark -
#pragma mark Setter
- (void)setOKButtonTarget:(id)aTarget action:(SEL)aSelector {
	m_idOKButtonTarget = aTarget;
	m_SELOKButtonSelector = aSelector;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
