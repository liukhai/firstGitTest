//
//  ATMNearBySearchDistCMSViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreData.h"
#import "ATMDistCellCMS.h"
#import "ASIHTTPRequest.h"
#import "HttpRequestUtils.h"

@class RotateMenu2ViewController;

@interface ATMNearBySearchDistCMSViewController : UIViewController
<CLLocationManagerDelegate,
UITableViewDelegate,
UITableViewDataSource,
NSXMLParserDelegate,
ASIHTTPRequestDelegate,
NSXMLParserDelegate,
UIScrollViewDelegate,
RotateMenuDelegate>
{
	IBOutlet UILabel *title_label;
	IBOutlet UITableView *table_view;
//	IBOutlet UIButton *setting, *map;
	IBOutlet UILabel *result;
//	IBOutlet UIView *setting_view;
//	IBOutlet UILabel *setting_label, *offer_no_label, *offer_distance_label;
//	IBOutlet UISlider *offer_no_slider, *offer_distance_slider;
//	IBOutlet UIButton *setting_close, *prev, *next;
//	float show_distance, show_no;
	int cell_height, current_page, current_page_size, total_page;
	NSMutableArray *items_data, *sorted_items_data, *distance_list, *selected_items_data;
	NSMutableDictionary *temp_record;
	int default_title_font_size, default_description_font_size, default_date_font_size;
	NSString *default_image_source_type, *default_image_alignment;
	NSString *current_type, *current_category;
	//NSMutableString *temp_id, *temp_title, *temp_shortdescription, *temp_description, *temp_address, *temp_tel, *temp_date, *temp_image_source, *temp_expire, *temp_gps, *temp_remarks;
	NSString *temp_image_source_type, *temp_image_alignment;
	NSDictionary *app_setting;
//	CLLocationManager *locmgr;
//	CLLocation *user_location;
	NSString *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
//	IBOutlet UIButton *supremegoldbutton, *atmbutton, *branchbutton;
	
	NSString* request_type;

    IBOutlet UIButton *btnNearby;
    RotateMenu2ViewController* v_rmvc;
    
  //  int flag;
    int menuID;
}

@property(nonatomic, retain) RotateMenu2ViewController* v_rmvc;
@property (nonatomic, assign) int menuID;
@property (nonatomic, retain) NSString *current_category;
-(void)defineDefaultTable;
//-(void)sortTableItem;
-(void)selectMerchant:(int)merchant_id;
//-(IBAction)prevButtonPressed:(UIButton *)button;
//-(IBAction)nextButtonPressed:(UIButton *)button;
//-(IBAction)settingButtonPressed:(UIButton *)button;
//-(IBAction)settingCloseButtonPressed:(UIButton *)button;
//-(IBAction)mapButtonPressed:(UIButton *)button;
//-(IBAction)showOfferChange:(UISlider *)slider;
//-(IBAction)showDistanceChange:(UISlider *)slider;

-(IBAction)SupremeGoldButtonPressed:(UIButton *)button;
-(IBAction)ATMButtonPressed:(UIButton *)button;
-(IBAction)BranchButtonPressed:(UIButton *)button;
-(IBAction)nearbyButtonPressed:(UIButton *)button;
-(void) selecteTypes;
//-(void) calculateDistance;

@property(nonatomic, retain) UIButton *supremegoldbutton, *atmbutton, *branchbutton;
@property(nonatomic, retain) NSMutableArray *items_data, *sorted_items_data, *distance_list, *selected_items_data;

- (void) startToGetNearBy;
-(void)stepone;
//- (void) checkATMListDelta:(NSData*)datas;

@end
