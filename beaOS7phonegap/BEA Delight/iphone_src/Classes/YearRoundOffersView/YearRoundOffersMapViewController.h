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

@interface YearRoundOffersMapViewController : UIViewController <MyMapViewDelegate> {

	NSArray *items_data;
	IBOutlet UIView *content_view;
	IBOutlet UIView *detail_info_view, *detail_info_bg_view, *toc_view, *coupon_view;
	IBOutlet CachedImageView *offer_image, *coupon_image;
	IBOutlet UILabel *offer_title, *offer_description, *offer_tel;
	IBOutlet UITextView *offer_content, *toc_text;
	IBOutlet UIButton *prev, *next, *share, *bookmark, *map, *toc;
	IBOutlet UIButton *tel, *more, *close;
	IBOutlet UIButton *coupon, *coupon_close;
	IBOutlet UIBarButtonItem *back, *home;
	CGRect detail_small_rect, detail_big_rect, coupon_small_rect, coupon_big_rect;
	MyMapViewController *map_view_controller;
	int current_shop_index;
	BOOL bookmark_mode_add;
	NSTimer *check_selected_annotation_timer;
}

@property (nonatomic, retain) NSArray *items_data;

-(void)createAnnotationList;
-(void)setSelectShop:(int)index;
-(void)setBookmarkModeAdd:(BOOL)add;
-(void)checkSelectedAnnotation;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;
-(IBAction)tocButtonPressed:(UIButton *)button;
-(IBAction)mapButtonPressed:(UIButton *)button;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)moreButtonPressed:(UIButton *)button;
-(IBAction)closeButtonPressed:(UIButton *)button;
-(IBAction)callButtonPressed:(UIButton *)button;
@end
