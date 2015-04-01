#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "ASIHTTPRequest.h"
#import "YearRoundOffersSummaryViewController.h"
#import "QuarterlySurpriseSummaryViewController.h"
#import "ATMCustomCell.h"

@interface NewBranchListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
	IBOutlet UITableView *table_view;
	IBOutlet UIButton *next, *prev;
	IBOutlet UILabel *title_label;
	float show_no;
	int cell_height, current_page, current_page_size, total_page;
	NSMutableArray *items_data, *distance_list;
	int default_title_font_size, default_description_font_size, default_date_font_size;
	NSString *default_image_source_type, *default_image_alignment, *searching_type;
	NSString *lang, *current_element;
	NSMutableDictionary *temp_record;
	NSString *temp_image_source_type, *temp_image_alignment;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
	ASIHTTPRequest *asi_request;
	NSString *selected_type, *selected_district;
}

@property (nonatomic, retain) NSString *selected_type, *selected_district;

-(void)defineDefaultTable;
-(void)getItemsListCuisine:(NSString *)cuisine Location:(NSString *)location Keywords:(NSString *)keywords;
-(IBAction)prevButtonPressed:(UIButton *)button;
-(IBAction)nextButtonPressed:(UIButton *)button;

//-(void) selectedItems;
-(void) selecteTypes;

-(void)sortTableItem;
- (void)parseFromFile;
- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
            shownData:(NSMutableArray*)data;

@end
