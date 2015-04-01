//  Created by yaojzy on 21/6/12.

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface CyberFundSearchWebViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    NSString *url;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*) a_url;

@end
