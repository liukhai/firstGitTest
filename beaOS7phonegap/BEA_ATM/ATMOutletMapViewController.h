//
//  ATMOutletMapViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATMMyMapViewController.h"
//#import "ATMNearBySearchListViewController.h"

@protocol FreshTableDelegate <NSObject>

- (void)initSortedItemsData:(NSDictionary *)dataDic;

@end

@class ATMMyMapViewController;

@interface ATMOutletMapViewController: UIViewController
//<ATMMyMapViewDelegate,
<UIAlertViewDelegate>
{
	IBOutlet UIView *content_view;
	IBOutlet UIButton *share, *btnBookmark;
	ATMMyMapViewController *map_view_controller;
	NSMutableArray *annotations;
	NSArray *annotations_detail;
	NSString* my_id;
    NSArray  *annotationsDetail;
    NSInteger index;
    float delta;
    NSInteger pushType;
    NSInteger menuID;
    IBOutlet UIButton *btnSearch;
    NSInteger onceClicked;

    
//    CLLocationManager *locmgr;
//	CLLocation *user_location;
}
@property (nonatomic, assign) BOOL isNeedBox;
@property (nonatomic, assign) BOOL isNear;
@property (nonatomic, assign) id <FreshTableDelegate> delegate;
@property (retain, nonatomic) IBOutlet UIView *headview;
@property (retain, nonatomic) IBOutlet UIImageView *greybarImg;
@property (retain, nonatomic) IBOutlet UIView *blowView;
@property(nonatomic, retain) ATMMyMapViewController *map_view_controller;
@property(nonatomic, retain) UIButton *btnBookmark;
@property(nonatomic, retain) UIView *content_view;
-(void)addAnnotations:(NSArray *)annotationsDetail;
-(void)addAnnotationsM:(NSArray *)annotationsDetail;
-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta;
-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta annotations:(NSArray *)annotationsArr;
//-(IBAction)shareButtonPressed:(UIButton *)button;
//-(IBAction)bookmarkButtonPressed:(UIButton *)button;
-(void) setBookmarkButton:(NSString*)a_id;
- (void) hideBookmark;
@property (retain, nonatomic) IBOutlet UIButton *btnList;
@property (retain, nonatomic) IBOutlet UIButton *btnSetting;
@property (retain, nonatomic) IBOutlet UILabel *lbTitle;
- (void)setViewControllerPushType:(NSInteger)type;

-(IBAction)searchButtonPressed:(UIButton *)button;
- (void)startLocationFromFavouritetoMenuID:(NSInteger)menuId;

@property (nonatomic, assign) NSInteger menuID;
@property (nonatomic, assign) NSMutableArray *sorted_items_data;
@property (nonatomic, assign) NSInteger toIndex;
@property (nonatomic, assign) float toDelta;
@property (nonatomic, retain) NSString *titleText;
@property (nonatomic, retain) NSMutableArray *annotations;
@property (nonatomic, assign) NSInteger favouriteIndex;
//@property(nonatomic, retain) NSMutableArray *items_data, *sorted_items_data, *distance_list, *selected_items_data;

@end
