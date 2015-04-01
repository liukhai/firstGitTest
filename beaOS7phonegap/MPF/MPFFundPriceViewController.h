#import <UIKit/UIKit.h>
#import "MPFFundCell.h"
#import "HttpRequestUtils.h"
@interface MPFFundPriceViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,ASIHTTPRequestDelegate, UIScrollViewDelegate> {

    IBOutlet UIScrollView *scroll_view;
    IBOutlet UIScrollView *scroll_view_scheme_pad;
    IBOutlet UIView *text_view;
    IBOutlet UITableView *fund_table;
    IBOutlet UILabel *time_label;
    IBOutlet UITextView *note_textview;
    
    IBOutlet UILabel *labTitle;
    IBOutlet UIImageView *labTitleBackImg;
    IBOutlet UILabel *fundname_label;
    IBOutlet UILabel *NAV_label;

    NSMutableArray *items_data;
    NSMutableArray *items_total;
    NSMutableArray *schemes_total;
    NSMutableArray *buttons_total;
    NSMutableArray *items_mt;
    NSMutableArray *items_ind;
    NSMutableArray* notes;
    NSString *date_stamp,*flag;
    
    IBOutlet UIButton *bt_mybalance;

    IBOutlet UIButton *btnPagePrev;
    IBOutlet UIButton *btnPageNext;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIImageView *backgroundImg1;
    IBOutlet UIImageView *backgroundImg2;
}

@property(nonatomic, retain) IBOutlet UITableView *fund_table;
@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;
@property(nonatomic, retain) IBOutlet UIView *text_view;
@property(nonatomic, retain) IBOutlet UILabel *time_label;
@property(nonatomic, retain) IBOutlet UIButton *bt_trust, *bt_industry;
@property(nonatomic, retain) NSMutableArray *items_data, *items_total ,*items_mt ,*items_ind;
@property(nonatomic, retain) NSMutableArray *schemes_total;
@property(nonatomic, retain) NSMutableArray *buttons_total;
@property(nonatomic, retain) NSMutableArray *notes;
@property(nonatomic, retain) NSString *date_stamp,*flag;

@property(nonatomic, retain) IBOutlet UITextView *note_textview;

@property(nonatomic, retain) IBOutlet UIButton *bt_mybalance;

@property(nonatomic, retain) IBOutlet UILabel *labTitle;
@property(nonatomic, retain) IBOutlet UILabel *fundname_label;
@property(nonatomic, retain) IBOutlet UILabel *NAV_label;

-(void) loadFundData;

-(void) schemeButtonClick:(id)sender;
-(void)updateViews;
-(void) showContents;
- (IBAction)doPrev:(id)sender;
- (IBAction)doNext:(id)sender;

-(void) parseNoteFile:(NSInteger)scheme;

- (void) showScheme:(NSInteger)scheme_id;

@end
