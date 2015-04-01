//  Created by yaojzy on 17/9/13.

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "HttpRequestUtils.h"

@protocol ATMDataHandlerDelegate <NSObject>
@optional
-(void)reloadData:(NSMutableArray*)datas;
@end

@interface ATMDataHandler : NSObject
<NSXMLParserDelegate>
{
	CLLocation *user_location;
	float show_distance, show_no;
	NSString *current_category;
	NSMutableArray *items_data;
	NSArray *key;
	NSString *currentElementName;
	NSMutableDictionary *temp_record;
	id <ATMDataHandlerDelegate> caller_view;
}

@property (retain, nonatomic) id <ATMDataHandlerDelegate> caller_view;
@property (retain, nonatomic) CLLocation *user_location;
@property (assign, nonatomic) float show_distance, show_no;
@property (retain, nonatomic) NSString *current_category;

-(void)request;

@end
