//
//  InsuranceListViewController.h
//  BEA Surprise
//
//  Created by NEO on 03/01/12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "ComingSoonViewController.h"
#import "LatestPromotionsSummaryViewController.h"
#import "TermsAndConditionsViewController.h"
#import "LargeImageCell.h"
#import "AccProUtil.h"
#import "TaxLoanUtil.h"

@interface InsuranceListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate, ASIHTTPRequestDelegate> {
	IBOutlet UILabel *title_label;
    IBOutlet UIImageView *title_backImg;
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *prev, *next, *tnc;
	//Define for custom table
	NSArray *category_list;
	int current_page, current_page_size, total_page;
	NSString *current_type, *current_category;
	NSMutableArray *items_data, *temp_merchant_list, *temp_image_list;
	NSMutableDictionary *temp_record,*md_temp;
	NSString *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
	ASIHTTPRequest *asi_request;
    
	IBOutlet UIImageView *borderImageView;
}

@property(nonatomic, retain) NSMutableArray *items_data;
@property(nonatomic, retain) UITableView *table_view;
-(void)setPageSize:(int)page_size;
-(void) loadPlistData;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)homeButtonPressed:(UIBarButtonItem *)button;
//-(void) sendRequest:(NSString*)date_stamp;

@end
