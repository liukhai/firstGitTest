//
//  MHDetailDisclaimerButton.m
//  MagicTrader
//
//  Created by Hong on 28/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "MHDetailDisclaimerButton.h"
#import "StyleConstant.h"
#import "MHLanguage.h"

#define BUTTON_GAP			8

@implementation MHDetailDisclaimerButton

@synthesize m_oDetailButton;
@synthesize m_oDisclaimerButton;

- (id) initWithDetailImage:(UIImage *)aDetailImage disclaimerImage:(UIImage *)aDisclaimer {

	self = [super initWithFrame:CGRectMake(0, 0, 10, 10)];
	if (self != nil) {
		
		// detail button
		UIImage *detailImage = aDetailImage?aDetailImage:MHDetailDisclaimerButton_m_oDetailButton_background_image;
		UIImage *disclaimerImage = aDisclaimer?aDisclaimer:PT_COMPANY_ICON;
		
		self.frame = CGRectMake(0, 0,
								detailImage.size.width + BUTTON_GAP + disclaimerImage.size.width,
								MAX(detailImage.size.height, disclaimerImage.size.height));
		
		m_oDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oDetailButton setFrame:CGRectMake(0, 
											 (self.frame.size.height - detailImage.size.height)/2, 
											 detailImage.size.width, 
											 detailImage.size.height)];
		
		[m_oDetailButton setBackgroundImage:detailImage forState:UIControlStateNormal];
		[m_oDetailButton setTitle:MHLocalizedString(@"MHDetailDisclaimerButton.m_oDetailButton", nil) forState:UIControlStateNormal];
		[self addSubview:m_oDetailButton];
		
		
		// Disclaimer button
		m_oDisclaimerButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oDisclaimerButton setFrame:CGRectMake(m_oDetailButton.frame.size.width+BUTTON_GAP,
												 (self.frame.size.height-disclaimerImage.size.height)/2,
												 disclaimerImage.size.width, 
												 disclaimerImage.size.height)];
		[m_oDisclaimerButton setBackgroundImage:disclaimerImage forState:UIControlStateNormal];
		[self addSubview:m_oDisclaimerButton];
	}
	return self;
}


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		// detail button
		UIImage *detailImage = MHDetailDisclaimerButton_m_oDetailButton_background_image;
		UIImage *disclaimerImage = PT_COMPANY_ICON;

		
		self.frame = CGRectMake(frame.origin.x, frame.origin.y, 
								detailImage.size.width + BUTTON_GAP + disclaimerImage.size.width,
								MAX(detailImage.size.height, disclaimerImage.size.height));
		
		m_oDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oDetailButton setFrame:CGRectMake(0, 
											 (self.frame.size.height - detailImage.size.height)/2, 
											 detailImage.size.width, 
											 detailImage.size.height)];
								
		[m_oDetailButton setBackgroundImage:detailImage forState:UIControlStateNormal];
		[m_oDetailButton setTitle:MHLocalizedString(@"MHDetailDisclaimerButton.m_oDetailButton", nil) forState:UIControlStateNormal];
		[self addSubview:m_oDetailButton];

		
		// Disclaimer button
		m_oDisclaimerButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oDisclaimerButton setFrame:CGRectMake(m_oDetailButton.frame.size.width+BUTTON_GAP,
												 (self.frame.size.height-disclaimerImage.size.height)/2,
												 disclaimerImage.size.width, 
												 disclaimerImage.size.height)];
		[m_oDisclaimerButton setBackgroundImage:disclaimerImage forState:UIControlStateNormal];
		[self addSubview:m_oDisclaimerButton];
		
    }
    return self;
}



- (void)dealloc {
    [super dealloc];
}


- (void)reloadText {
	[m_oDetailButton setTitle:MHLocalizedString(@"MHDetailDisclaimerButton.m_oDetailButton", nil) forState:UIControlStateNormal];
	[m_oDisclaimerButton setBackgroundImage:PT_COMPANY_ICON forState:UIControlStateNormal];
}

- (void)addDetailButtonTarget:(id)aTarget action:(SEL)aSelector {
	[m_oDetailButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addDisclaimerButtonTarget:(id)aTarget action:(SEL)aSelector {
	[m_oDisclaimerButton addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
}

- (void)setShowDetailButton:(BOOL)aShowDetail showDisclaimerButton:(BOOL)aShowDisclaimer {
	m_oDetailButton.hidden = !aShowDetail;
	m_oDisclaimerButton.hidden = !aShowDisclaimer;
}

@end
