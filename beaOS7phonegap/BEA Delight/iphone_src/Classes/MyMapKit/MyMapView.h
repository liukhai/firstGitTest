//
//  MyMapView.h
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface MyMapView : MKMapView <CLLocationManagerDelegate> {

	CLLocationManager *locmgr;
	NSMutableArray *annotation_list;
	NSArray *annotation_array;
	CLLocationDegrees heading;
	BOOL follow_user, show_nearby_annotations;
	CLLocationDistance show_nearby_distance;
	CLLocation *current_location;
	MyAnnotation *selected_annotation;
    BOOL clickable;
}

@property (nonatomic, assign) BOOL follow_user, show_nearby_annotations;
@property (nonatomic, assign) CLLocationDistance show_nearby_distance;
@property (nonatomic, assign) MyAnnotation *selected_annotation;
@property (nonatomic, assign) BOOL clickable;

-(void)reset;
-(void)loadAnnotationFromPlist:(NSString *)filename;
-(void)loadAnnotationFromArray:(NSArray *)array;
-(void)updateNearByAnnotations;
-(void)updateHeading;
-(void)setCenterCoordinate:(CLLocationCoordinate2D)theCenter Delta:(float)delta;
-(void)setSelectedAnnotation:(int)index Delta:(float)delta isNeedBox:(BOOL)isNeed;
-(void)setSelectedAnnotation:(int)index Delta:(float)delta;
-(MyAnnotation *)getAnnotationAtIndex:(int)index;
-(NSArray *)getAnnotations;
-(int)getAnnotationLength;

-(CLLocationDistance)distanceFromMe:(MyAnnotation *)annotation;
-(CLLocationDegrees)directionFromMe:(MyAnnotation *)annotation;
-(CLLocationDistance)distanceBetweenAnnotation:(MyAnnotation *)annotation1 FromAnnotation:(MyAnnotation *)annotation2;
-(CLLocationDegrees)directionFrom:(MyAnnotation *)annotation1 To:(MyAnnotation *)annotation2;

@end
