//
//  YearRoundOffersListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月18日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "YearRoundOffersSummaryViewController.h"
//#import "YearRoundOffersMapViewController.h"
#import "CustomCell.h"

@interface YearRoundOffersListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate,UINavigationControllerDelegate> {
	
	IBOutlet UILabel *title_label;
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *prev, *next;
    IBOutlet UIImageView *lineImageView;
    IBOutlet UIImageView *borderImageView;
	
	//Define for custom table
	NSArray *category_list;
	int current_page, current_page_size, total_page;
	NSString *current_type, *current_category;
	NSMutableArray *items_data;
	NSMutableDictionary *temp_record;
	NSString *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
	ASIHTTPRequest *asi_request;
	//jeff
	NSString *tnc_string;
	//
    NSString *titleText;
    BOOL isInit;
}

-(void)setPageSize:(int)page_size;
-(void)getItemsListType:(NSString *)list_type Category:(NSString *)category;
-(void)getItemsDistrict:(int)location_id;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;

//jeff
@property (nonatomic, retain) NSString *tnc_string;
//
@end
