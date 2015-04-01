//
//  YearRoundOffersViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月18日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "CoreData.h"
#import "TermsAndConditionsViewController.h"
#import "YearRoundOffersMenuViewController.h"
#import "YearRoundOffersListViewController.h"

@interface YearRoundOffersViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, NSXMLParserDelegate,UINavigationControllerDelegate> {

    IBOutlet UIImageView *cached_image_bg;
    IBOutlet UIImageView *cached_image_bg2;
    IBOutlet UIImageView *cached_image_bg3;
    IBOutlet UIImageView *cached_image_bg4;
    IBOutlet UIImageView *cached_image_bg5;
    IBOutlet UIImageView *cached_image_bg6;
    IBOutlet UIImageView *cached_image_bg7;
    IBOutlet UIImageView *cached_image_bg8;
	IBOutlet UILabel *title_label;
	IBOutlet UIButton *dining_offers, *shopping_offers, *tnc;
	IBOutlet UIButton *button0, *button1, *button2, *button3, *button4, *button5, *button6, *button7;
	IBOutlet UIBarButtonItem *home;
	IBOutlet UIView *content_view;
	IBOutlet UIViewController *current_view_controller;
	IBOutlet UIButton *dining1, *dining2, *dining3, *dining4;
	IBOutlet UIButton *shopping1, *shopping2, *shopping3, *shopping4;
	IBOutlet UIImageView *new0, *new1, *new2, *new3, *new4, *new5, *new6, *new7;
	IBOutlet UIImageView *img0, *img1, *img2, *img3, *img4;
	int list_mode;
	int current_location_index;
	NSArray *category_list, *location_list, *location_id_list;
	NSString *dining_tnc, *shopping_tnc;
	ASIHTTPRequest *dining_tnc_request, *shopping_tnc_request;
	NSString *currentAction, *currentElementName;
	NSMutableDictionary *record_number_data;
    Boolean isShowShopping;
}

@property (nonatomic, assign) NSMutableDictionary *record_number_data;
@property (nonatomic, assign) NSInteger alertShowCount;
-(void)setContent:(int)index;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)diningButtonPressed:(UIButton *)button;
-(IBAction)shoppingButtonPressed:(UIButton *)button;
-(IBAction)tabButtonPressed:(UIButton *)button;
- (void) setShowShopping :(Boolean) isShow;

@end
