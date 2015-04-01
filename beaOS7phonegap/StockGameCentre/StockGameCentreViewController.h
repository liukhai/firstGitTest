//  Amended by yaojzy on 201309.

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface StockGameCentreViewController : UIViewController<UIWebViewDelegate> {
	IBOutlet UIWebView *webView;
    IBOutlet UILabel *lbTitle;
}

@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, retain) UILabel *lbTitle;

//-(void) btInterestRatePressed;
- (void)goHome;
@end
