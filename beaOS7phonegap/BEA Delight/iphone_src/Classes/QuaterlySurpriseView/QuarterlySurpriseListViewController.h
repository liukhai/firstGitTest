//
//  QuaterlySurpriseListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "QuarterlySurpriseSummaryViewController.h"
#import "CustomCell.h"


@interface QuarterlySurpriseListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate,UINavigationControllerDelegate> {
	IBOutlet UILabel *title_label;
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *prev, *next, *tnc;
	
	//Define for custom table
	NSArray *category_list;
	int current_page, current_page_size, total_page;
	NSString *current_type, *current_category;
	NSMutableArray *items_data;
	NSMutableDictionary *temp_record;
	NSString *current_element;
	NSArray *key;
	NSString *qs_tnc;
	NSString *currentAction, *currentElementName, *currentElementValue;
	ASIHTTPRequest *asi_request, *qs_tnc_request;
	
}

-(void)setPageSize:(int)page_size;
-(void)getItemsList;
-(IBAction)tncButtonPressed:(UIButton *)button;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;

@end
