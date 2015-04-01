//  Created by Algebra Lo on 10年3月23日.
//  Amended by yaojzy on 201309

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Bookmark.h"
#import "CoreData.h"
#import "CustomCell.h"

@interface FavouriteListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate,UINavigationControllerDelegate> {
	IBOutlet UITableView *table_view;
	IBOutlet UILabel *title_label;
	IBOutlet UIButton *next, *prev;
	IBOutlet UILabel *result;
    IBOutlet UIScrollView *scrollView;
	int current_page, current_page_size, total_page, parsing_type;
	NSMutableArray *items_data, *header_exist;
	NSMutableDictionary *all_items_data, *temp_record;
	NSString *current_type, *current_category, *current_element;
	NSArray *key;
	NSString *currentAction, *currentElementName, *currentElementValue;
    
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
    NSMutableArray* groupname_list;
    NSMutableArray* itemname_listATM;
    NSMutableArray* itemname_listCreditCard;
    NSMutableArray* itemname_listprivileges;
    NSMutableArray* itemname_listLoans;
    NSMutableArray* itemname_listGold;
    int request_type_count;
    BOOL isCreditCardBookmark;
}

@property (nonatomic, retain) NSMutableArray* header_list;
@property (nonatomic, retain) NSMutableArray* groupname_list;
@property (nonatomic, retain) NSMutableArray* itemname_listATM;
@property (nonatomic, retain) NSMutableArray* itemname_listCreditCard;
@property (nonatomic, retain) NSMutableArray* itemname_listprivileges;
@property (nonatomic, retain) NSMutableArray* itemname_listLoans;
@property (nonatomic, retain) NSMutableArray* itemname_listGold;
@property (nonatomic, assign) BOOL isCreditCardBookmark;
-(void)generateBookmark;
-(void)removeItemsByItemsName;
@end
