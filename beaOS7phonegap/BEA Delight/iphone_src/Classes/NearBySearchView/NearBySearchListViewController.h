//
//  NearBySearchListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreData.h"
#import "CustomCell2.h"
#import "ASIHTTPRequest.h"
#import "OutletMapViewController.h"

@class OutletMapViewController;

@interface NearBySearchListViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
	IBOutlet UILabel *title_label;
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *setting, *map;
	IBOutlet UILabel *result;
	IBOutlet UIView *setting_view;
	IBOutlet UILabel *setting_label, *offer_distance_label;
    IBOutlet UILabel  *offer_no_label;
	IBOutlet UISlider *offer_no_slider;
	IBOutlet UISlider *offer_distance_slider;
	IBOutlet UIButton *setting_close, *prev, *next;
    IBOutlet UILabel *offer_distance_label_num;
    IBOutlet UILabel *offer_no_label_num;
	float show_distance, show_no;
	int cell_height, current_page, current_page_size, total_page;
	NSMutableArray *items_data, *sorted_items_data, *distance_list;
	NSMutableDictionary *temp_record;
	int default_title_font_size, default_description_font_size, default_date_font_size;
	NSString *default_image_source_type, *default_image_alignment;
	NSString *current_type, *current_category;
	//NSMutableString *temp_id, *temp_title, *temp_shortdescription, *temp_description, *temp_address, *temp_tel, *temp_date, *temp_image_source, *temp_expire, *temp_gps, *temp_remarks;
	NSString *temp_image_source_type, *temp_image_alignment;
	NSDictionary *app_setting;
	CLLocationManager *locmgr;
	CLLocation *user_location;
	NSString *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
	ASIHTTPRequest *asi_request;
}

@property (nonatomic, assign) BOOL useInMap;
@property (nonatomic, retain) OutletMapViewController *outletMapVC;
@property (retain, nonatomic) UIView *setting_view;
-(void)defineDefaultTable;
//-(void)sortTableItem;
-(void)selectMerchant:(int)merchant_id;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)settingButtonPressed:(UIButton *)button;
-(IBAction)settingCloseButtonPressed:(UIButton *)button;
-(IBAction)mapButtonPressed:(UIButton *)button;
-(IBAction)homeButtonPressed:(UIBarButtonItem *)button;
-(IBAction)showOfferChange:(UISlider *)slider;
-(IBAction)showDistanceChange:(UISlider *)slider;

@end
