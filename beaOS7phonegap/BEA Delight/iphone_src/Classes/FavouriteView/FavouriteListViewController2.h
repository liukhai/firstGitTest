//  Created by Algebra Lo on 10年3月23日.
//  Amended by yaojzy on 201309

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Bookmark.h"
#import "CoreData.h"
#import "CustomCell.h"

@interface FavouriteListViewController2 : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate, UIAlertViewDelegate> {
	IBOutlet UITableView *table_view;
	IBOutlet UILabel *title_label;
	IBOutlet UIButton *next, *prev;
	IBOutlet UILabel *result;
//	int current_page, current_page_size, total_page, parsing_type;
    int parsing_type;
	NSMutableArray *items_data, *header_exist;
	NSMutableDictionary *all_items_data, *temp_record;
	NSString *current_type, *current_category, *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue,*groupname;
    
	NSMutableArray
    *temp_merchant_list,
    *temp_coorganisers_list,
    *temp_image_list,
    *temp_pb_list,
    *temp_mgt_list,
    *temp_pdt_list;
    
	ASIHTTPRequest
    *asi_request_yro,
    *asi_request_qs,
    *asi_request_lp,
    *asi_request_sar,
    *asi_request_pbc,
    *asi_request_gpo,
    *asi_request_atm,
    *asi_request_pri,
    *asi_request_cl,
    *asi_request_sg;
    
    NSMutableArray* header_list;
    UIViewController* caller;
}

@property (nonatomic, retain) NSMutableArray* header_list;
@property (nonatomic, retain) NSString *groupname;
@property (nonatomic, retain) UIViewController* caller;
@property (retain, nonatomic) IBOutlet UIButton *btnEdit;
@property (nonatomic, retain) NSIndexPath *deletedIndexpath;
@property (nonatomic, assign) int cellType;
@property (nonatomic, retain) NSMutableDictionary *btnToIndexpath;
@property (nonatomic, retain) NSMutableArray *temp_items_data_arr;
@property (nonatomic, retain) NSString *fromType;
@property (nonatomic, assign) BOOL isRecustomCell;
@property (nonatomic, retain) UIView *recustomCellView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL hasDeleted;
-(void)generateBookmark;

@end
