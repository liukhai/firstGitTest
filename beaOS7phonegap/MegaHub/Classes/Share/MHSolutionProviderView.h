//
//  MHSolutionProviderView.h
//  MegaHub
//
//  Created by MegaHub on 11/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHUILabel.h"

#define MHSolutionProviderView_MiniModeHeight	54

@interface MHSolutionProviderView : UIView {
	MHUILabel		*m_oDescriptionLabel;
	UIImageView		*m_oSolutionProviderLogo;
	UIButton		*m_oInvisibleButton;
	
	BOOL			isMiniMode;
	
}

@property(nonatomic, retain) UIButton *m_oInvisibleButton;
- (id)initWithFrame:(CGRect)frame setMiniMode:(BOOL)aIsMiniMode;
-(void)onInvisibleButtonIsClicked:(id)aSender;
-(void)setSnapshotMode:(BOOL)aIsSnapshotMode;
-(void)reloadText;
@end
