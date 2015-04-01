//
//  MyARView.h
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "MyMapView.h"
#import "PlaceMarkController.h"
#import <CoreMotion/CoreMotion.h>
@protocol MyARViewDelegate;

@interface MyARViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAccelerometerDelegate> {
	
	UIImagePickerController *camera_controller;
	UIView *overlay_view;
	UILabel *x, *y, *z;
	UIBarButtonItem *close;
	UIToolbar *control_toolbar;

	CGRect original_frame;
	NSMutableArray *place_mark_list;
	NSArray *annotation_list;
	NSTimer *refresh_timer;
	UIAccelerometer *accelerometerManager;
	MyMapView *info_calculator;
	id <MyARViewDelegate> delegate;
	float horizontal_angle, vertical_angle, show_distance;
}

@property (nonatomic, retain) UIAccelerometer *accelerometerManager;
@property (nonatomic, assign) MyMapView *info_calculator;
@property (nonatomic, assign) id <MyARViewDelegate> delegate;

-(IBAction)activateAR;
-(void)deactivateAR;

-(void)setupAR;
-(void)updateAR;

-(IBAction)reloadAnnotations;
-(IBAction)switchToSetting;

@end

@protocol MyARViewDelegate
-(void)switchToSetting;
-(void)reloadAnnotations;
@optional
-(void)openAR;
-(void)closeAR;
@end
