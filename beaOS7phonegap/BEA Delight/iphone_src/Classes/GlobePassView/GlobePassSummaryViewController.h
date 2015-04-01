//
//  GlobePassSummaryViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"
#import "TermsAndConditionsViewController.h"

@interface GlobePassSummaryViewController : UIViewController {
	IBOutlet UIButton *ecoupon, *tnc, *share, *bookmark;
	IBOutlet UILabel *merchant, *title_label;
	IBOutlet UITextView *description;
	IBOutlet UIScrollView *scroll_view, *images_scroll_view;
	IBOutlet UIImageView *logo_arrow_l, *logo_arrow_r;
	NSDictionary *merchant_info;
	int alert_action;
    NSInteger pushType;
    BOOL isInit;
}
@property (retain, nonatomic) IBOutlet UIButton *bookButton;
@property (nonatomic, assign) NSDictionary *merchant_info;
@property (nonatomic, assign) UILabel *title_label;

//@property (nonatomic, assign) NSString *current_merchants, *current_description, *current_search_name;
-(IBAction)ecouponButtonPressed:(UIButton *)button;
-(IBAction)contactButtonPressed:(UIButton *)button;
-(IBAction)detailsButtonPressed:(UIButton *)button;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;
- (void)setViewControllerPushType:(NSInteger)type;
@end
