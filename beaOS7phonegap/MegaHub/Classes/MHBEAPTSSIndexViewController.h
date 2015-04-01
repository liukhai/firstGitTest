//
//  MHBEAPTSSIndexViewController.h
//  BEA
//
//  Created by MegaHub on 08/07/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHSubmenu.h"
#import "PTConstant.h"

@class MHBEAPTSSWorldLocalIndexViewController;
@class MHBEAFASectorRootViewController;
@class MHBEAFATopRankViewController;
@class MHBEAFAAHSharesViewController;
@class MHBEAPTFANewsViewController;
@class MHBEABottomView;
@class MHDisclaimerBarView;
@class RotateMenu2ViewController;

@interface MHBEAPTSSIndexViewController : UIViewController {
	MHBEAPTSSWorldLocalIndexViewController	*m_oMHBEAPTSSWorldLocalIndexViewController;
	MHBEAFASectorRootViewController			*m_oMHBEAFASectorRootViewController;
	MHBEAFATopRankViewController			*m_oMHBEAFATopRankViewController;
    MHBEAFAAHSharesViewController           *m_oMHBEAFAAHSharesViewController;
    MHBEAPTFANewsViewController             *m_oMHBEAPTFANewsViewController;
    
    MHBEABottomView                         *m_oMHBEABottomView;
    MHDisclaimerBarView                     *m_oMHDisclaimerBarView;
    
    RotateMenu2ViewController               *v_rmvc;
    
    NSString					*m_sLastUpdateTime;
}

@end