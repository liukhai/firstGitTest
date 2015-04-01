//
//  OutletListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "OutletLisrViewDelegate.h"
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "OutletListCell.h"
#import "OutletListCell2.h"
#import "OutletMapViewController.h"

@interface OutletListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UIAlertViewDelegate, NSXMLParserDelegate> {
	IBOutlet UILabel *title_label;
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *prev, *next, *share, *bookmark;
	IBOutlet UITableViewCell *share_bookmark_cell;
    IBOutlet UIImageView *background_imageView;
    IBOutlet UIImageView *line_imageView;
    
	id delegate;
	CLLocationManager *locmgr;
	CLLocation *current_location;
	BOOL scrollable;
	BOOL is_show_distance, show_all_in_map;
	NSString *currentAction, *currentElementName, *currentElementValue;
	NSMutableArray *items_data;
	NSMutableDictionary *temp_record;
	NSArray *key;
	NSString *current_merchant_name;
	int current_page, current_page_size, total_page;
	float show_distance;
//	ASIFormDataRequest *api_request;
    ASIHTTPRequest *api_request;
}

@property (retain, nonatomic) IBOutlet UIImageView *background_imageView;
@property (retain, nonatomic) IBOutlet UITableView *table_view;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) BOOL is_show_distance, show_all_in_map, scrollable;
@property (nonatomic, assign) float show_distance;
@property (readonly) NSArray *items_data;
@property (nonatomic, retain) NSString *fromType;
//Jeff
@property (nonatomic, retain) IBOutlet UILabel *title_label;
@property (nonatomic, retain) IBOutlet UIButton *prev, *next;
//

-(void)getMerchantOutlet:(NSString *)merchantName;
-(void)getMerchantOutlet:(NSString *)merchantName QuarterlySurprise:(BOOL)qs;
-(void)getMerchantOutlet:(NSString *)merchantName District:(NSString *)location;
-(void)getMerchantOutletWithRefId:(NSString *)refId QuarterlySurprise:(BOOL)qs;
-(void)getLatestPromotionOutlet:(NSString *)merchantName;
-(void)sortByDistance;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)shareButtonPressed:(UIButton *)button;
-(IBAction)bookmarkButtonPressed:(UIButton *)button;

@end


