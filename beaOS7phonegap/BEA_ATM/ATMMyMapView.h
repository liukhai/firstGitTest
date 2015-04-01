//
//  ATMMyMapView.h
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
#import "ATMMyAnnotation.h"

@interface ATMMyMapView : MKMapView <CLLocationManagerDelegate> {

	CLLocationManager *locmgr;
	NSMutableArray *annotation_list;
	NSArray *annotation_array;
	CLLocationDegrees heading;
	BOOL follow_user, show_nearby_annotations;
	CLLocationDistance show_nearby_distance;
	CLLocation *current_location;
	MyAnnotation *selected_annotation;
    BOOL clickable;
    NSString* noItem;
}

@property (nonatomic, assign) BOOL follow_user, show_nearby_annotations;
@property (nonatomic, assign) CLLocationDistance show_nearby_distance;
@property (nonatomic, assign) MyAnnotation *selected_annotation;
@property (nonatomic, assign) BOOL clickable;
@property (nonatomic, retain) NSString* noItem;


-(void)reset;
-(void)loadAnnotationFromPlist:(NSString *)filename;
-(void)loadAnnotationFromArray:(NSArray *)array;
-(void)updateNearByAnnotations;
-(void)updateHeading;
-(void)setCenterCoordinate:(CLLocationCoordinate2D)theCenter Delta:(float)delta;
-(void)setSelectedAnnotation:(int)index Delta:(float)delta;
-(void)setSelectedAnnotation:(int)index Delta:(float)delta isNeedBox:(BOOL)isNeed;
-(ATMMyAnnotation *)getAnnotationAtIndex:(int)index;
-(NSArray *)getAnnotations;
-(int)getAnnotationLength;

-(CLLocationDistance)distanceFromMe:(ATMMyAnnotation *)annotation;
-(CLLocationDegrees)directionFromMe:(ATMMyAnnotation *)annotation;
-(CLLocationDistance)distanceBetweenAnnotation:(ATMMyAnnotation *)annotation1 FromAnnotation:(ATMMyAnnotation *)annotation2;
-(CLLocationDegrees)directionFrom:(ATMMyAnnotation *)annotation1 To:(ATMMyAnnotation *)annotation2;

@end
