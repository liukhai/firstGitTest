//
//  MyAnnotation.m
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation
@synthesize coordinate, title, subtitle, tag;

-(id)initWithDictionary:(NSDictionary *)annotation_info {
	
	self = [super init];
	if (self!=nil) {
		title = [annotation_info objectForKey:@"title"];
		subtitle = [annotation_info objectForKey:@"subtitle"];
		coordinate.latitude = [[annotation_info objectForKey:@"latitude"] doubleValue];
		coordinate.longitude = [[annotation_info objectForKey:@"longitude"] doubleValue];
		
	}
	return self;
}



@end
