//
//  NearBySearchListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Bookmark.h"
#import "CoreData.h"
#import "ATMCustomCell.h"

@interface ATMFavouriteListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
	IBOutlet UITableView *table_view;
	IBOutlet UILabel *title_label;
	IBOutlet UIButton *next, *prev;
	IBOutlet UILabel *result;
	int current_page, current_page_size, total_page, parsing_type;
//	NSMutableArray *items_data, *header_exist;
	NSMutableArray *items_data;
	NSMutableDictionary *all_items_data, *temp_record;
	NSString *current_type, *current_category, *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
	NSMutableArray *temp_merchant_list, *temp_coorganisers_list, *temp_image_list, *temp_pb_list, *temp_mgt_list, *temp_pdt_list;
	ASIHTTPRequest *asi_request_yro, *asi_request_qs, *asi_request_lp, *asi_request_sar, *asi_request_pbc, *asi_request_gpo, *asi_request_atm;
}

-(void)generateBookmark;
- (void)parseFromFile;

@end
