//
//  MyMapView.m
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyMapView.h"
#define DefaultNearbyDistance	5000

@implementation MyMapView
@synthesize follow_user, show_nearby_annotations, show_nearby_distance, selected_annotation;
@synthesize clickable;

-(void)reset {
	follow_user = FALSE;
	show_nearby_annotations = FALSE;
	show_nearby_distance = DefaultNearbyDistance;
    clickable = YES;
}

-(void)loadAnnotationFromPlist:(NSString *)filename {
	NSLog(@"Loading Annotation");
	int i;
	MyAnnotation *temp_annotation;
	
	heading = 0;
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/%@.plist",path,filename];
	NSArray *annotation_from_plist = [[NSArray arrayWithContentsOfFile:path] retain];
	if (annotation_from_plist==nil || [annotation_from_plist count]==0) {
		path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
		annotation_from_plist = [[NSArray arrayWithContentsOfFile:path] retain];
	}
	if (annotation_list!=nil) {
		[self removeAnnotations:annotation_list];
		[annotation_list removeAllObjects];
		[annotation_list release];
		annotation_list = nil;
	}
	annotation_list = [NSMutableArray new];
	for (i=0; i<[annotation_from_plist count]; i++) {
		temp_annotation = [[MyAnnotation alloc] initWithDictionary:(NSDictionary *)[annotation_from_plist objectAtIndex:i]];
		temp_annotation.tag = i;
		[annotation_list addObject:temp_annotation];
		[self addAnnotation:temp_annotation];
		[temp_annotation release];
	}
	[self updateNearByAnnotations];
	
}

-(void)loadAnnotationFromArray:(NSArray *)array {
	NSLog(@"Loading Annotation from Array");
	int i;
	MyAnnotation *temp_annotation;
	annotation_array = array;
	if (annotation_list!=nil) {
		[self removeAnnotations:annotation_list];
		[annotation_list removeAllObjects];
		[annotation_list release];
		annotation_list = nil;
	}
	annotation_list = [NSMutableArray new];
	for (i=0; i<[annotation_array count]; i++) {
     //   NSLog(@"title is %@", [[annotation_array objectAtIndex:i] objectForKey:@"title"]);
		temp_annotation = [[MyAnnotation alloc] initWithDictionary:(NSDictionary *)[annotation_array objectAtIndex:i]];
		temp_annotation.tag = i;
		[annotation_list addObject:temp_annotation];
		[self addAnnotation:temp_annotation];
		//		[[self viewForAnnotation:temp_annotation] setHidden:TRUE];
		[temp_annotation release];
	}
	NSLog(@"Load completed");
}

-(void)updateNearByAnnotations {
	if (show_nearby_annotations) {
		for (int i=0; i<[annotation_list count]; i++) {
			if ([self distanceFromMe:[annotation_list objectAtIndex:i]]<show_nearby_distance) {
				[[self viewForAnnotation:[annotation_list objectAtIndex:i]] setHidden:FALSE];
			} else {
				[[self viewForAnnotation:[annotation_list objectAtIndex:i]] setHidden:TRUE];
			}
			
		}
	}
}

-(void)setCenterCoordinate:(CLLocationCoordinate2D)theCenter Delta:(float)delta {
	MKCoordinateRegion myRegion;
	
	myRegion.center = theCenter;
	MKCoordinateSpan theSpan;
	theSpan.latitudeDelta = delta;
	theSpan.longitudeDelta = delta;
	
	myRegion.span = theSpan;
	[self setRegion:myRegion animated:TRUE];
	[self regionThatFits:myRegion];
	[self updateNearByAnnotations];
}

-(void)setSelectedAnnotation:(int)index Delta:(float)delta {
	[self setSelectedAnnotation:index Delta:delta isNeedBox:YES];
}

-(void)setSelectedAnnotation:(int)index Delta:(float)delta isNeedBox:(BOOL)isNeed {
	selected_annotation = [[self getAnnotations] objectAtIndex:index];
	
	[self setCenterCoordinate:selected_annotation.coordinate Delta:delta];
    if (isNeed) {
        [self selectAnnotation:selected_annotation animated:TRUE];
    }
}

-(void)updateHeading {
	locmgr = [[CLLocationManager alloc] init];
	locmgr.delegate = self;
	[locmgr startUpdatingLocation];
//	if (locmgr.headingAvailable) {
    if ([CLLocationManager headingAvailable]) {
		NSLog(@"Start updating heading");
		[locmgr startUpdatingHeading];
	}
	
}

-(MyAnnotation *)getAnnotationAtIndex:(int)index {
	if (index<[annotation_list count]) {
		return [annotation_list objectAtIndex:index];
	} else {
		return nil;
	}

}

-(NSArray *)getAnnotations {
	return (NSArray *)annotation_list;
}

-(int)getAnnotationLength {
	return [annotation_list count];
}

-(CLLocationDistance)distanceFromMe:(MyAnnotation *)annotation {
	NSDictionary *me_dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"",@"",[NSNumber numberWithFloat:self.userLocation.location.coordinate.latitude],[NSNumber numberWithFloat:self.userLocation.location.coordinate.longitude],nil] forKeys:[NSArray arrayWithObjects:@"title",@"subtitle",@"latitude",@"longitude",nil]];
	MyAnnotation *me = [[[MyAnnotation alloc] initWithDictionary:me_dictionary] autorelease];
	return [self distanceBetweenAnnotation:me FromAnnotation:annotation];
}

-(CLLocationDegrees)directionFromMe:(MyAnnotation *)annotation {
	NSLog(@"My heading is %f",heading);
	NSDictionary *me_dictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"",@"",[NSNumber numberWithFloat:self.userLocation.location.coordinate.latitude],[NSNumber numberWithFloat:self.userLocation.location.coordinate.longitude],nil] forKeys:[NSArray arrayWithObjects:@"title",@"subtitle",@"latitude",@"longitude",nil]];
	MyAnnotation *me = [[[MyAnnotation alloc] initWithDictionary:me_dictionary] autorelease];
//	NSLog(@"%f degree from me at north",[self directionFrom:me To:annotation]);
	return [self directionFrom:me To:annotation] - heading;
}

-(CLLocationDistance)distanceBetweenAnnotation:(MyAnnotation *)annotation1 FromAnnotation:(MyAnnotation *)annotation2 {
	CLLocation *point1 = [[[CLLocation alloc] initWithLatitude:annotation1.coordinate.latitude longitude:annotation1.coordinate.longitude] autorelease];
	CLLocation *point2 = [[[CLLocation alloc] initWithLatitude:annotation2.coordinate.latitude longitude:annotation2.coordinate.longitude] autorelease];
//	return [point1 getDistanceFrom:point2];
	return [point1 distanceFromLocation:point2];
}

-(CLLocationDegrees)directionFrom:(MyAnnotation *)annotation1 To:(MyAnnotation *)annotation2 {
	
	float x1 = annotation1.coordinate.latitude;					//Our position.
	float y1 = annotation1.coordinate.longitude;
	float x2 = annotation2.coordinate.latitude;		//The other thing's position.
	float y2 = annotation2.coordinate.longitude;
	float result;						//The resulting bearing.
	
	
	// First You calculate Delta distances.
	float dx = (x2-x1);
	float dy = (y2-y1);
	
	// If x part is 0 we could get into division by zero problems, but in that case result can only be 90 or 270:
	if (dx==0){
		if (dy > 0){
			result = 90;
		}else {
			result = 270;
		}
	}else {
		result = (atan(dy/dx)) * 180 / M_PI;
	}
	
	// the (*180/ M_PI) part is because results are usually in Radians, but we want it in degrees.
	// This is only valid for two quadrants (for right side of the coordinate system) so modify result if necessary...
	if (dx < 0) {
		result = result + 180;
	}
	
	// looks better if all numbers are positive (0 to 360 range)
	if (result < 0) {
		result = result + 360;
	}
	
	//Return our result.
	return result;
}

///////////////////////////
//Location manager delegate
///////////////////////////

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
	if (follow_user) {
		NSLog(@"trace user New");
		MKCoordinateRegion myRegion;
		CLLocationCoordinate2D theCenter;
        CLLocation *newLocation = [locations lastObject];
		theCenter.latitude = newLocation.coordinate.latitude;
		theCenter.longitude = newLocation.coordinate.longitude;
		
		myRegion.center = theCenter;
		MKCoordinateSpan theSpan;
		theSpan.latitudeDelta = 0.1;
		theSpan.longitudeDelta = 0.1;
		
		myRegion.span = theSpan;
		
		[self setRegion:myRegion];
		[self regionThatFits:myRegion];
		[self updateNearByAnnotations];
        
	}
}

//Deprecated in iOS 6.0
//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	if (follow_user) {
//		NSLog(@"trace user Old");
//		MKCoordinateRegion myRegion;
//		CLLocationCoordinate2D theCenter;
//		theCenter.latitude = newLocation.coordinate.latitude;
//		theCenter.longitude = newLocation.coordinate.longitude;
//		
//		myRegion.center = theCenter;
//		MKCoordinateSpan theSpan;
//		theSpan.latitudeDelta = 0.1;
//		theSpan.longitudeDelta = 0.1;
//		
//		myRegion.span = theSpan;
//		
//		[self setRegion:myRegion];
//		[self regionThatFits:myRegion];
//		[self updateNearByAnnotations];
//
//	}
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	heading = newHeading.magneticHeading;
//	NSLog(@"I am heading to %f",newHeading.magneticHeading);
}

-(BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
	return FALSE;
}

-(void)dealloc {
	NSLog(@"MyMapView dealloc");
	if (locmgr!=nil) {
		[locmgr stopUpdatingLocation];
        if ([CLLocationManager headingAvailable]) {
//		if (locmgr.headingAvailable) {
			[locmgr stopUpdatingHeading];
		}
		[locmgr release];
	}
	if (annotation_list!=nil) {
		[self removeAnnotations:annotation_list];
		[annotation_list removeAllObjects];
		[annotation_list release];
	}
	[super dealloc];
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    if ( ! self.clickable &&
//        [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
//        return NO;
//    return YES;
//}

@end
