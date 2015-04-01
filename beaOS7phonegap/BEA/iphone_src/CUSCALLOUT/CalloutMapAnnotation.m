#import "CalloutMapAnnotation.h"

//  Created by jasen on 201303

@interface CalloutMapAnnotation()


@end

@implementation CalloutMapAnnotation

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize title, subtitle, tag, address, tel, remark, my_id, fax;
@synthesize newtopitem;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude {
	if (self = [super init]) {
		self.latitude = latitude;
		self.longitude = longitude;
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
}

-(void)setContentDictionary:(NSDictionary *)annotation_info {
	
    title = [annotation_info objectForKey:@"title"];
    subtitle = [annotation_info objectForKey:@"subtitle"];
    self.latitude = [[annotation_info objectForKey:@"latitude"] doubleValue];
    self.longitude = [[annotation_info objectForKey:@"longitude"] doubleValue];
    address = [annotation_info objectForKey:@"address"];
    remark = [annotation_info objectForKey:@"remark"];
    tel = [annotation_info objectForKey:@"tel"];
    my_id = [annotation_info objectForKey:@"id"];
    newtopitem = [annotation_info objectForKey:@"newtopitem"];
    fax = [annotation_info objectForKey:@"fax"];
}

@end
