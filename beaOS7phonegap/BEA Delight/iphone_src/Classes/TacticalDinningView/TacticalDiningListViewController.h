//
//  TacticalDinningListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月30日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CustomCell.h"
#import "TacticalDiningViewController.h"

@interface TacticalDiningListViewController : UIViewController <DataUpdaterDelegate, UITableViewDelegate, UITableViewDataSource> {

	IBOutlet UIBarButtonItem *home;
	IBOutlet UITableView *table_view;
	int cell_height, current_page, current_page_size, total_page;
	NSString *current_type, *current_category, *lang;
	int default_title_font_size, default_description_font_size, default_date_font_size;
	NSString *default_image_alignment, *default_image_source_type;
	NSMutableArray *items_data;
	NSString *current_element;
	NSMutableString *temp_id, *temp_title, *temp_shortdescription, *temp_description, *temp_date, *temp_remarks;
	NSMutableString *temp_image_source, *temp_address, *temp_tel, *temp_gps, *temp_expire, *temp_coupon;
	NSString *temp_image_source_type, *temp_image_alignment;
}

-(void)defineDefaultTable;
-(void)getItemsListType:(NSString *)list_type Category:(NSString *)category;
-(IBAction)homeButtonPressed:(UIBarButtonItem *)button;

@end
