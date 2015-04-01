//
//  MapViewController.h
//  MapTest
//
//  Created by Algebra Lo on 10年1月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MyMapView.h"
#import "MyAnnotation.h"
#import "MyARViewController.h"
#import "CalloutMapAnnotation.h"
#import "OutletMapViewController.h"

//@class OutletMapViewController;

@protocol MyMapViewDelegate;

@interface MyMapViewController : UIViewController <MKMapViewDelegate> {

	IBOutlet MyMapView *map;
	MyARViewController *ar_view;
	id <MyMapViewDelegate> delegate;
	
	CalloutMapAnnotation *_calloutAnnotation;
	MKAnnotationView *_selectedAnnotationView;
    NSInteger index;
//    NSString* cur_id;
//    OutletMapViewController *callerVC;
}

@property (nonatomic, assign) IBOutlet MyMapView *map;
@property (nonatomic, assign) id <MyMapViewDelegate> delegate;
@property (nonatomic, retain) CalloutMapAnnotation *calloutAnnotation;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property (nonatomic, retain) NSArray *annotationsArr;
@property (nonatomic, retain) NSDictionary *settingDic;
//@property (nonatomic, retain) NSString* cur_id;
//@property (nonatomic, retain) OutletMapViewController *callerVC;

-(void)loadAnnonationsFromPlist:(NSString *)path;
- (void)loadAnnotationsDetailinfo:(NSArray *)annotations settingValue:(NSDictionary *)setting;

@end

@protocol MyMapViewDelegate
@optional
-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
@end