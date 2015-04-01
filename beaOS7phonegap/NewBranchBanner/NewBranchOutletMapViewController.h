#import <UIKit/UIKit.h>
#import "ATMMyMapViewController.h"
#import "ATMNearBySearchListViewController.h"

@interface NewBranchOutletMapViewController : UIViewController <ATMMyMapViewDelegate, UIAlertViewDelegate> {
	IBOutlet UIView *content_view;
	ATMMyMapViewController *map_view_controller;
	NSMutableArray *annotations;
	NSArray *annotations_detail;
	NSString* my_id;
}

-(void)addAnnotations:(NSArray *)annotationsDetail;
-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta;

@end
