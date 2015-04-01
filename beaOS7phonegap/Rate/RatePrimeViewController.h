#import <UIKit/UIKit.h>
#import "RatePrimeCell.h"
#import "HttpRequestUtils.h"
@interface RatePrimeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,ASIHTTPRequestDelegate> {

    IBOutlet UIScrollView *scroll_view;
    IBOutlet UIView *text_view;
    IBOutlet UITableView *fund_table;
    IBOutlet UILabel *time_label,*lbTitle,*lbCurrency,*lbPrime,*lbNotice;
    IBOutlet UIButton *bt_trust,*bt_industry;
    
    
    NSMutableArray *items_data;
    NSMutableArray *items_total;
    NSString *date_stamp;
}

@property(nonatomic, retain) IBOutlet UITableView *fund_table;
@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;
@property(nonatomic, retain) IBOutlet UIView *text_view;
@property(nonatomic, retain) IBOutlet UILabel *time_label,*lbTitle,*lbCurrency,*lbPrime,*lbNotice;
@property(nonatomic, retain) IBOutlet UIButton *bt_trust, *bt_industry;
@property(nonatomic, retain) NSMutableArray *items_data, *items_total;

-(void) loadFundData;
-(void) filterDisplay;
//-(void) goHome;
//-(void) alertAndBackToMain;
@end
