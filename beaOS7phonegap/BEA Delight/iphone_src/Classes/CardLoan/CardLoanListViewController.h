//
//  LatestPromotionsListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "ComingSoonViewController.h"
#import "CardLoanSummaryViewController.h"
#import "TermsAndConditionsViewController.h"
#import "LargeImageCell.h"


@interface CardLoanListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate,UINavigationControllerDelegate> {
	IBOutlet UILabel *title_label;
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *prev, *next, *tnc;
    IBOutlet UIImageView *lineImageView;
    IBOutlet UIImageView *borderImageView;
    
	//Define for custom table
	NSArray *category_list;
	int current_page, current_page_size, total_page;
	NSString *current_type, *current_category;
	NSMutableArray *items_data, *temp_merchant_list, *temp_image_list;
	NSMutableDictionary *temp_record;
	NSString *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
	ASIHTTPRequest *asi_request;
	
}

-(void)setPageSize:(int)page_size;
-(void)getItemsList;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(IBAction)homeButtonPressed:(UIBarButtonItem *)button;

@end
