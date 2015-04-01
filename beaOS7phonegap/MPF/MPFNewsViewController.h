#import <UIKit/UIKit.h>
#import "MBKUtil.h"
#import "HttpRequestUtils.h"
#import "MPFUtil.h"

@interface MPFNewsViewController : UIViewController
<UIWebViewDelegate>
{
    IBOutlet UILabel *labTitle;
    IBOutlet UIWebView *webView;
    IBOutlet UIImageView *lbTitleBackImg;
    int level_count;
    NSURL* url;
}

@property (nonatomic, retain) IBOutlet UILabel *labTitle;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL* url;

-(void) sendRequest;
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSURL*)aurl;

@end
