//
//  ATMMyAnnotation.h
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ATMMyAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;  
	NSString *subtitle;  
	NSString *title;
	int tag;
	
    NSString *address, *remark, *tel, *my_id, *fax;
    NSString *newtopitem;
}
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;  
@property (nonatomic,copy) NSString *subtitle;  
@property (nonatomic,copy) NSString *title;  
@property (nonatomic,assign) int tag;

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *my_id;
@property (nonatomic, retain) NSString *newtopitem;
@property (nonatomic, retain) NSString *fax;

-(id)initWithDictionary:(NSDictionary *)annotation_info;
@end
