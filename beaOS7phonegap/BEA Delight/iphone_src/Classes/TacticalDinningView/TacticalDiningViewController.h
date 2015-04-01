//
//  TacticalDinningViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月30日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface TacticalDiningViewController : UIViewController {
	IBOutlet struct CachedImageView *cached_image_view, *coupon_image_view;
	IBOutlet UIBarButtonItem *home, *back;
	IBOutlet UIView *coupon_view, *tnc_view, *detail_view, *outlet_view;
	IBOutlet UIButton *coupon_close, *coupon, *bookmark, *share, *tnc, *detail, *outlet, *prev, *next, *tnc_close, *detail_close, *outlet_close;
	IBOutlet UILabel *title_label;
	IBOutlet UITextView *description;
	NSArray *items_data;
	int current_shop_index;

}

@property (nonatomic, retain) NSArray *items_data;

-(void)setSelectShop:(int)shop;
-(IBAction)backButtonPressed:(UIBarButtonItem *)button;
-(IBAction)homeButtonPressed:(UIBarButtonItem *)button;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)couponButtonPressed:(UIButton *)button;
-(IBAction)couponCloseButtonPressed:(UIButton *)button;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)detailButtonPressed:(UIButton *)button;
-(IBAction)outletButtonPressed:(UIButton *)button;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;

@end
