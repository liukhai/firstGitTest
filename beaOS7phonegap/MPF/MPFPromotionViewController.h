#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "MPFUtil.h"

@interface MPFPromotionViewController : UIViewController {
    IBOutlet UIWebView* webView;
	
	IBOutlet UILabel *lbTitle;
	
	IBOutlet UIButton  *bt_mastertrustscheme,*bt_contribitionaccount,*bt_promotiondetails;
    
    IBOutlet UIButton *bt_detail_mastertrustscheme, *bt_detail_contribitionaccount;

    NSString* promotion_type;

}

@property(nonatomic, retain)  IBOutlet UIButton *bt_detail_mastertrustscheme, *bt_detail_contribitionaccount,*bt_mastertrustscheme,*bt_contribitionaccount,*bt_promotiondetails;

@property(nonatomic, retain) IBOutlet UIWebView* webView;

@property(nonatomic, retain) NSString* promotion_type;

-(void) sendRequest;

-(IBAction) bt_schemePressed:(UIButton*) button;
-(IBAction) bt_promotiondetailsPressed;

@end
