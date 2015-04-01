#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "MPFNewsViewController.h"
#import "MPFEnquiryViewController.h"
#import "MPFFundPriceViewController.h"
#import "MPFImportantNoticeViewController.h"

@interface MPFViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate,UINavigationBarDelegate> {
//	UINavigationController *navigationController;
	UITabBar *tabBar;
    UIView *btnView;
    IBOutlet UIButton *bt_loginMBK, *bt_callMPFhotline;
    int btnViewY;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) IBOutlet UIView *btnView;
@property(nonatomic, retain) IBOutlet UIButton *bt_loginMBK, *bt_callMPFhotline;
@property (retain, nonatomic) IBOutlet UIImageView *navigationImage;
@property (retain, nonatomic) IBOutlet UIButton *backBtn;
@property (retain, nonatomic) IBOutlet UIView *backgroundView;

-(void)goHome;
-(void) selectTabBarMatchedCurrentView;
-(void) welcome;
-(void)showBtnView;
-(void) openNewsViewController:(NSURL*)url;
-(void)setTexts;
- (IBAction)backBtnClick:(id)sender;

@end
