//
//  MapViewController.h
//  MapTest
//
//  Created by Algebra Lo on 10年1月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ATMMyMapView.h"
#import "ATMMyAnnotation.h"
#import "MyARViewController.h"

#import "CustomAnnotationView.h"
#import "CalloutMapAnnotation.h"
#import "ATMOutletMapViewController.h"

@class ATMOutletMapViewController;

@protocol ATMMyMapViewDelegate;

@interface ATMMyMapViewController : UIViewController
<MKMapViewDelegate,
UIGestureRecognizerDelegate>
{

	IBOutlet ATMMyMapView *map;
	MyARViewController *ar_view;
	id <ATMMyMapViewDelegate> delegate;
	
	CalloutMapAnnotation *_calloutAnnotation;
	MKAnnotationView *_selectedAnnotationView;
    NSString* cur_id;
    ATMOutletMapViewController *callerVC;

}
@property (nonatomic, retain) ATMOutletMapViewController *callerVC;
@property (nonatomic, retain) CalloutMapAnnotation *calloutAnnotation;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;

@property (nonatomic, assign) IBOutlet ATMMyMapView *map;
@property (nonatomic, assign) id <ATMMyMapViewDelegate> delegate;
@property (nonatomic, retain) NSString* cur_id;


-(void)loadAnnonationsFromPlist:(NSString *)path;

@end

@protocol ATMMyMapViewDelegate
@optional
-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;
@end