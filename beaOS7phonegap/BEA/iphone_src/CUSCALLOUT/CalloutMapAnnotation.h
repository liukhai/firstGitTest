//  Created by jasen on 201303

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CalloutMapAnnotation : NSObject <MKAnnotation> {
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;



	NSString *subtitle;
	NSString *title;
	int tag;
	
    NSString *address, *remark, *tel, *my_id, *fax;
    NSString *newtopitem;
}

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;



@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign) int tag;

@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *my_id;
@property (nonatomic, retain) NSString *newtopitem;
@property (nonatomic, retain) NSString *fax;

-(void)setContentDictionary:(NSDictionary *)annotation_info;

@end
