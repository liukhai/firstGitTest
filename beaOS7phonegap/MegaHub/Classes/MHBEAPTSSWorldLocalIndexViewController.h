//
//  MHBEAPTSSWorldLocalIndexViewController.h
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTWorldLocalIndexView.h"
#import "PTConstant.h"

typedef enum {
	PTWorldLocalIndexViewNumberNone				= -1,
	PTWorldLocalIndexViewNumberLocalIndex		= 0,
	PTWorldLocalIndexViewNumberWorldIndex		= 1
}PTWorldLocalIndexViewNumber;

@class MHBEAPTSSLocalIndexViewController;
@class MHBEAPTWorldIndexViewController;

@interface MHBEAPTSSWorldLocalIndexViewController : UIViewController {
    MHBEAPTSSLocalIndexViewController       *m_oMHBEAPTSSLocalIndexViewController;
	MHBEAPTWorldIndexViewController			*m_oMHBEAPTWorldIndexViewController;
	PTWorldLocalIndexView					*m_oPTWorldLocalIndexView;
	PTWorldLocalIndexViewNumber             m_iSelectedIndex;
	
	NSTimer                                 *m_oKeepCallingDataTimer;
}

- (id)init;
- (void)dealloc;
- (void)loadView;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (void)reloadText;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (void)onWorldLocalSegmentPressed:(id)sender;
- (void)switchTo:(PTWorldLocalIndexViewNumber)aNumber;

@end