//
//  YearRoundOffersChainViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"
#import "CoreData.h"
#import "CustomCell.h"
#import "YearRoundOffersListViewController.h"

@interface YearRoundOffersChainViewController : UIViewController <DataUpdaterDelegate, UITableViewDelegate, UITableViewDataSource> {
	id <MenuDelegate> delegate;
	IBOutlet UITableView *table_view;
	int default_title_font_size, default_description_font_size, default_date_font_size;
	NSMutableArray *items_data;
	NSString *current_element;
	NSString *current_type, *current_category, *lang;
	NSMutableString *temp_id, *temp_title, *temp_shortdescription, *temp_description, *temp_date, *temp_remarks, *temp_card;
	NSMutableString *temp_image_source, *temp_address, *temp_tel, *temp_gps, *temp_expire;
}
@property (nonatomic, assign) id <MenuDelegate> delegate;

-(void)getItemsListType:(NSString *)list_type Category:(NSString *)category;
@end
