//
//  MHDisclaimerBarView.m
//  WingFung
//
//  Created by Hong on 24/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MHDisclaimerBarView.h"

#import "ViewControllerDirector.h"
#import "MHBEAConstant.h"
#import "MHLanguage.h"


@implementation MHDisclaimerBarView

@synthesize m_oTextLabel;
@synthesize m_oDelayTextLabel;
@synthesize m_oTextUPLabel;
@synthesize m_oImageLabel;
@synthesize m_oLeftButton;
@synthesize m_oRightButton;

+ (CGSize)getSize {
	return CGSizeMake(320, 15);
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[bgView setImage:[UIImage imageNamed:@"01_cover_bg_text.png"]];
		[self addSubview:bgView];
		[bgView release];
		
		// delay at least 15 mins
//		m_oDelayTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, -2, 180, 10)];
//		[m_oDelayTextLabel setBackgroundColor:[UIColor clearColor]];
//		[m_oDelayTextLabel setFont:[UIFont boldSystemFontOfSize:8]];
//		[m_oDelayTextLabel setTextAlignment:NSTextAlignmentLeft];
//		[self addSubview:m_oDelayTextLabel];
//		[m_oDelayTextLabel release];
		
		// Text
		m_oTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, -2, 320, 10)];
		[m_oTextLabel setBackgroundColor:[UIColor clearColor]];
		[m_oTextLabel setFont:[UIFont systemFontOfSize:8]];
		[m_oTextLabel setAdjustsFontSizeToFitWidth:YES];
		[self addSubview:m_oTextLabel];
		[m_oTextLabel release];
		
		// info provided by label
		m_oTextUPLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 6, 320, 10)];
		[m_oTextUPLabel setBackgroundColor:[UIColor clearColor]];
		[m_oTextUPLabel setFont:[UIFont systemFontOfSize:8]];
		[m_oTextUPLabel setTextAlignment:NSTextAlignmentLeft];
		[self addSubview:m_oTextUPLabel];
		[m_oTextUPLabel release];		

		
		
		// Image
		m_oImageLabel = [[UIImageView alloc] initWithFrame:CGRectMake(250, 0, 70, 15)];
		[m_oImageLabel setImage:[UIImage imageNamed:@"bea_megahub_banner.png"]];
		[self addSubview:m_oImageLabel];
		[m_oImageLabel release];
		
		
		// Left button
		m_oLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oLeftButton setFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height/2)];
//		[m_oLeftButton addTarget:self action:@selector(onLeftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oLeftButton];
		
		// Right Button
		m_oRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oRightButton setFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height/2)];
		[m_oRightButton addTarget:self action:@selector(onRightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:m_oRightButton];
		
		
		[self reloadText];
		
		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)reloadText {
	m_oTextLabel.text = MHLocalizedStringFile(@"MHDisclaimerBarView.m_oTextLabel", nil, MHLanguage_BEAString);
	m_oDelayTextLabel.text = MHLocalizedStringFile(@"MHDisclaimerBarView.m_oDelayTextLabel", nil, MHLanguage_BEAString);
	m_oTextUPLabel.text = MHLocalizedStringFile(@"MHDisclaimerBarView.m_oTextUPLabel", nil, MHLanguage_BEAString);
}


#pragma mark -
#pragma mark Button callback functions
- (void)onLeftButtonPressed:(id)sender {
	[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDMegaHubDisclaimer para:nil];
}

- (void)onRightButtonPressed:(id)sender {
	[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDMegaHubDisclaimer para:nil];
}

@end