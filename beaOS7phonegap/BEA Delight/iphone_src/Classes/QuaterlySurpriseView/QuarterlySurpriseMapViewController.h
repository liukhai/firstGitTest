//
//  YearRoundOffersMapViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "MyMapViewController.h"
#import "PlistOperator.h"

@class CachedImageView;
@class MyMapViewController;
@interface QuarterlySurpriseMapViewController : UIViewController <MyMapViewDelegate> {

	NSArray *items_data;
	IBOutlet UIView *content_view, *coupon_view;
	IBOutlet UIView *detail_info_view, *toc_view;
	IBOutlet CachedImageView *offer_image, *coupon_image;
	IBOutlet UILabel *offer_title, *offer_description;
	IBOutlet UITextView *offer_content, *toc_text;
	IBOutlet UIButton *coupon, *coupon_close, *share, *bookmark, *close, *map, *toc;
	IBOutlet UIBarButtonItem *back, *home;
	MyMapViewController *map_view_controller;
	int current_shop_index;
}

@property (nonatomic, retain) NSArray *items_data;

-(void)setSelectShop:(int)index;
-(IBAction)backButtonPressed:(UIBarButtonItem *)button;
-(IBAction)homeButtonPressed:(UIBarButtonItem *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;
-(IBAction)tocButtonPressed:(UIButton *)button;
-(IBAction)mapButtonPressed:(UIButton *)button;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)moreButtonPressed:(UIButton *)button;
-(IBAction)closeButtonPressed:(UIButton *)button;
-(IBAction)couponButtonPressed:(UIButton *)button;
-(IBAction)couponCloseButtonPressed:(UIButton *)button;

@end
