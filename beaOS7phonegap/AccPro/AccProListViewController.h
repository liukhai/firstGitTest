//
//  AccProListViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
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
#import "LTUtil.h"
#import "ConsumerLoanUtil.h"
#import "AccProWebViewController.h"

@interface AccProListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
	IBOutlet UILabel *title_label;
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
	NSTimer *openLatesPromoItem1Timer;

    @public
    BOOL mainPagePromo;
}

@property(nonatomic, retain) IBOutlet UILabel* lb_pagetitle;
@property(nonatomic, retain) NSMutableDictionary *md_temp;
@property(nonatomic, retain) NSMutableArray *items_data;
@property(nonatomic, retain) UITableView *table_view;

//-(void)setPageSize:(int)page_size;
-(void) loadPlistData;
-(void)loadPlistDataDetail;
-(void) didSelectRowAtIndexPath:(int)index;
//-(IBAction)prevButtonPressed:(UIButton *)button;
//-(IBAction)nextButtonPressed:(UIButton *)button;
-(BOOL)isNotEmptyList;
-(void) refreshViewContent;

@end
