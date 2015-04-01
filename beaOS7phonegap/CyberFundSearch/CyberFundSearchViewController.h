#import <UIKit/UIKit.h>
#import "CoreData.h"
#import "CachedImageView.h"
#import "RootViewController.h"

@class RootViewController;

@interface CyberFundSearchViewController : UIViewController <UINavigationControllerDelegate, UITabBarDelegate,UINavigationBarDelegate> {
//	UINavigationController *navigationController;
	UITabBar *tabBar;
    IBOutlet UIImageView* banner;
    NSString *showBack;
}

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) IBOutlet UIImageView* banner;
@property (nonatomic, retain) NSString *showBack;

-(void)goHome;
-(void) welcome;
-(void) openurl:(NSString*)a_url;
-(void) setTexts;
@end
