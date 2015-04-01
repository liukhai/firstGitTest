//
//  PTWorldLocalIndexView.m
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "PTWorldLocalIndexView.h"
#import "SegmentedButton.h"
#import "MHLanguage.h"

#import "StyleConstant.h"

@implementation PTWorldLocalIndexView

@synthesize m_oWorldLocalSegmentButton;
@synthesize m_oBottomView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		// segmented control button background
		UIImageView *bgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1.5, 320, 29)];
		[bgv setImage:PTWorldIndexView_m_oWorldLocalSegmentButton_background_image];
		[self addSubview:bgv];
		[bgv release];
		
		NSArray *titleArray = [NSArray arrayWithObjects:
							   MHLocalizedString(@"PTWorldLocalIndexView.localIndex", nil),
							   MHLocalizedString(@"PTWorldLocalIndexView.worldIndex", nil),
							   nil];
							   
		
		// World local index segment button
		m_oWorldLocalSegmentButton = [[SegmentedButton alloc] initWithFrame:CGRectMake(0, 1.5, 320, 29) items:titleArray];
		[m_oWorldLocalSegmentButton setLeftButtonSelectedImage:PTWorldIndexView_m_oWorldLocalSegmentButton_left_selectButton_image];
		[m_oWorldLocalSegmentButton setLeftButtonUnSelectedImage:PTWorldIndexView_m_oWorldLocalSegmentButton_left_unselectButton_image];
		[m_oWorldLocalSegmentButton setRightButtonSelectedImage:PTWorldIndexView_m_oWorldLocalSegmentButton_right_selectButton_image];
		[m_oWorldLocalSegmentButton setRightButtonUnSelectedImage:PTWorldIndexView_m_oWorldLocalSegmentButton_right_unselectButton_image];

		//[m_oWorldLocalSegmentButton setButtonSelectedImage:[UIImage imageNamed:@"segment_button_pressed.png"]];
		//[m_oWorldLocalSegmentButton setButtonUnSelectedImage:[UIImage imageNamed:@"segment_button_unpressed.png"]];
		
		[m_oWorldLocalSegmentButton setButtonFont:[UIFont systemFontOfSize:14]];
		[m_oWorldLocalSegmentButton setSelectedButtonIndex:0];
		[self addSubview:m_oWorldLocalSegmentButton];
		[m_oWorldLocalSegmentButton release];
		
		
		// bottom table view
		int x_m_oBottomView = bgv.frame.origin.y+bgv.frame.size.height;
		m_oBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, x_m_oBottomView, frame.size.width, frame.size.height-bgv.frame.size.height+5)];
		[self addSubview:m_oBottomView];
		[m_oBottomView release];
		
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)reloadText {
	NSArray *titleArray = [NSArray arrayWithObjects:
						   MHLocalizedString(@"PTWorldLocalIndexView.localIndex", nil),
						   MHLocalizedString(@"PTWorldLocalIndexView.worldIndex", nil),
						   nil];
	[m_oWorldLocalSegmentButton setButtonTitle:titleArray];
}



#pragma mark -
#pragma mark Loading Functions
- (void)startLoading { // no spinner
	
}
- (void)stopLoading {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)startLoadingWithSpinner:(BOOL)aBoolean {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	
	
}

@end
