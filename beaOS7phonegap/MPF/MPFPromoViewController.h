#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface MPFPromoViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
	
	IBOutlet UILabel *lbTitle;
    IBOutlet UIImageView *lbTitleBackImg;
    NSString *latestpromoUrl;
    IBOutlet UIButton *callButton;


}
@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) NSString *latestpromoUrl;

- (IBAction) call;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil latestpromoUrl:(NSString *) url;
@end
