//
//  QuarterlySurpriseSummaryViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutletListViewController.h"
#import "TermsAndConditionsViewController.h"

@class CachedImageView;
@interface QuarterlySurpriseSummaryViewController : UIViewController <UIAlertViewDelegate, OutletListViewDelegate,UINavigationControllerDelegate> {
	IBOutlet UIButton *ecoupon, *outlet, *tnc, *share, *bookmark;
	IBOutlet UILabel *title_label;
	IBOutlet UITextView *merchant, *description;
	IBOutlet UIScrollView *scroll_view;
	IBOutlet CachedImageView *image_view;
	NSDictionary *merchant_info;
	OutletListViewController *outlet_list_controller;
    IBOutlet UIImageView *boundImageView;
    IBOutlet UIImageView *backImageView;
	float show_distance;
	int alert_action;
}
@property (nonatomic, assign) NSDictionary *merchant_info;
@property (nonatomic, assign) UILabel *title_label;
@property (nonatomic, assign) float show_distance;
@property (nonatomic, retain) NSString *headingTitle;
//-(IBAction)outletButtonPressed:(UIButton *)button;
-(IBAction)ecouponButtonPressed:(UIButton *)button;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;

@end
