//amended by jasen on 20120817

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "LargeImageCell.h"
#import "MPFUtil.h"

@interface MPFPromoListViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
	IBOutlet UILabel *title_label;
    IBOutlet UIImageView *lbTitleBackImg;
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
}

@property(nonatomic, retain) NSMutableDictionary *md_temp;
@property(nonatomic, retain) NSMutableArray *items_data;
@property(nonatomic, retain) UITableView *table_view;

-(void)setPageSize:(int)page_size;
-(void) loadPlistData;

-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;
-(BOOL)isNotEmptyList;


@end
