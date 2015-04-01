//  Amended by yaojzy on 3/7/12.

#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "WebViewController.h"
#import "CyberFundSearchUtil.h"

@interface CyberFundSearchImportantNoticeViewController : UIViewController {
	BOOL isHiddenImportantNotice;
    IBOutlet UIButton *bt_understood, *bt_cancel;
    IBOutlet UIScrollView *scroll_view;
    IBOutlet UIView *text_view;
    IBOutlet UIView *pop_view;
    NSTimer* timer1;
    IBOutlet UILabel *disclaimer_title;
    IBOutlet UIButton *start_scrollBtn;
}

@property(nonatomic, retain) IBOutlet UIScrollView *scroll_view;

@property(nonatomic, retain) IBOutlet UIView *text_view;
@property(nonatomic, retain) NSTimer* timer1;
@property (nonatomic, retain) UIButton *bt_understood, *bt_cancel;
-(IBAction)showMe;
-(IBAction)hiddenMe;
-(IBAction)hiddenMe_goHome;
-(IBAction)hiddenMe_gotoCFS;

-(void)switchMe;
-(void)setTexts;
-(IBAction)start_scrollingdown;

@end