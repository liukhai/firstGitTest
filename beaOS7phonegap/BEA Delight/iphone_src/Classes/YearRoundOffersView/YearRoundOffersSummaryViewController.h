//
//  YearRoundOffersSummaryViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "Bookmark.h"
#import "OutletListViewController.h"
#import "TermsAndConditionsViewController.h"

@class CachedImageView;
@interface YearRoundOffersSummaryViewController : UIViewController <UIAlertViewDelegate, OutletListViewDelegate> {
	IBOutlet UIButton *tnc, *share, *bookmark;
	IBOutlet UILabel *title_label, *offer_label;
	IBOutlet UITextView *merchant, *description;
	IBOutlet UIScrollView *scroll_view;
	IBOutlet CachedImageView *image_view;
    
    IBOutlet UIView *backView;
	NSDictionary *merchant_info;
	OutletListViewController *outlet_list_controller;
	float show_distance;
	int alert_action;
	
	NSString *tnc_string;
    NSInteger pushType;
    NSString * title_labelStr;
    IBOutlet UIImageView *boundImageView;
    BOOL isInit;
}
@property (retain, nonatomic) IBOutlet UIButton *bookButton;
@property (nonatomic, assign) NSDictionary *merchant_info;
@property (nonatomic, assign) UILabel *title_label;
@property (nonatomic, assign) float show_distance;
@property (nonatomic, retain) NSString *headingTitle;
//jeff
@property (nonatomic, retain) NSString *tnc_string;
//

//-(IBAction)outletButtonPressed:(UIButton *)button;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;
- (void)setViewControllerPushType:(NSInteger)type;
-(void)setMerchant_info:(NSDictionary *)info tnc_string:(NSString *)tnc title_label:(NSString *)title;


@end
