//
//  MHSolutionProviderView.m
//  MegaHub
//
//  Created by MegaHub on 11/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MHSolutionProviderView.h"
#import "ViewControllerDirector.h"
#import "StyleConstant.h"
#import "MHLanguage.h"

@implementation MHSolutionProviderView
@synthesize m_oInvisibleButton;

- (id)initWithFrame:(CGRect)frame setMiniMode:(BOOL)aIsMiniMode{
    
    self = [super initWithFrame:frame];
    if (self) {
		isMiniMode = aIsMiniMode;
		m_oInvisibleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:m_oInvisibleButton];
		[m_oInvisibleButton addTarget:self action:@selector(onInvisibleButtonIsClicked:) forControlEvents:UIControlEventTouchUpInside];
		[m_oInvisibleButton release];
		
		if(aIsMiniMode){
			[self setFrame:CGRectMake(frame.origin.x, frame.origin.y, 320, MHSolutionProviderView_MiniModeHeight)];
			
			m_oDescriptionLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(63, 0, 247, MHSolutionProviderView_MiniModeHeight)];
			[self addSubview:m_oDescriptionLabel];
			[m_oDescriptionLabel release];
			m_oDescriptionLabel.numberOfLines  = 2;
			m_oDescriptionLabel.font = MHSolutionProviderView_m_oDescriptionLabel_isMiniMode_font;
			
			m_oSolutionProviderLogo = [[UIImageView alloc] initWithFrame:CGRectMake(12, 7, 35, 35)];
			[self addSubview:m_oSolutionProviderLogo];
			[m_oSolutionProviderLogo release];
			[m_oSolutionProviderLogo setImage:Default_solution_provider_image_view];
			
		}else{
			m_oDescriptionLabel = [[MHUILabel alloc] initWithFrame:CGRectMake(0, 0, 115, 50)];
			[self addSubview:m_oDescriptionLabel];
			[m_oDescriptionLabel release];
			m_oDescriptionLabel.numberOfLines = 2;
			
			[m_oDescriptionLabel setBackgroundColor:[UIColor clearColor]];
			
			m_oSolutionProviderLogo = [[UIImageView alloc] initWithFrame:CGRectMake(115, 0, 205, 50)];
			[self addSubview:m_oSolutionProviderLogo];
			[m_oSolutionProviderLogo release];
			[m_oSolutionProviderLogo setBackgroundColor:[UIColor clearColor]];
		}
		
		 m_oDescriptionLabel.textColor = MHSolutionProviderView_m_oDescriptionLabel_textColor;
		[self reloadText];
	}
	return self;
}

-(void)setSnapshotMode:(BOOL)aIsSnapshotMode{
	if(aIsSnapshotMode){
		[self setFrame:CGRectMake(100, 214, 213, 35)];
		[m_oDescriptionLabel setText:MHLocalizedString(@"MHSolutionProviderView.IsSnapshotMode.m_oDescriptionLabel", nil)];
		[m_oDescriptionLabel setFrame:CGRectMake(0, 0, 86, 35)];
		[m_oDescriptionLabel setAdjustsFontSizeToFitWidth:YES];
		[m_oSolutionProviderLogo setFrame:CGRectMake(90, 6, 120, 22)];
		[m_oSolutionProviderLogo setImage:Default_snaphot_solution_provider_image_view];
	}
}

-(void)onInvisibleButtonIsClicked:(id)aSender{
	[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSolutionProviderDisclaimer para:nil];
}

-(void)reloadText{
	if(isMiniMode){
		[m_oDescriptionLabel setText:MHLocalizedString(@"MHSolutionProviderView.IsMiniMode.m_oDescriptionLabel", nil)];
	}
}

@end
