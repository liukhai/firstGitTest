//
//  ATMMyAnnotation.m
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMMyAnnotation.h"


@implementation ATMMyAnnotation
@synthesize coordinate, title, subtitle, tag, address, tel, remark, my_id, fax;
@synthesize newtopitem;

-(id)initWithDictionary:(NSDictionary *)annotation_info {
	
	self = [super init];
	if (self!=nil) {
		title = [annotation_info objectForKey:@"title"];
		subtitle = [annotation_info objectForKey:@"subtitle"];
		coordinate.latitude = [[annotation_info objectForKey:@"latitude"] doubleValue];
		coordinate.longitude = [[annotation_info objectForKey:@"longitude"] doubleValue];
		address = [annotation_info objectForKey:@"address"];
		remark = [annotation_info objectForKey:@"remark"];
		tel = [annotation_info objectForKey:@"tel"];
		my_id = [annotation_info objectForKey:@"id"];
		newtopitem = [annotation_info objectForKey:@"newtopitem"];
        fax = [annotation_info objectForKey:@"fax"];
	}
	return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
	coordinate.latitude = newCoordinate.latitude;
	coordinate.longitude = newCoordinate.longitude;
}

-(void)setCoordinateValue:(double)lat lon:(double)lon
{
    coordinate.latitude = lat;
    coordinate.longitude = lon;
}

@end
