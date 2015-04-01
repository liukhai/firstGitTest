//  Created by yaojzy on 17/9/13.

#import "ATMDataHandler.h"

@implementation ATMDataHandler

@synthesize caller_view;
@synthesize user_location;
@synthesize show_distance;
@synthesize show_no;
@synthesize current_category;

-(void)request
{
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:
                                   [NSURL
                                    URLWithString:
                                    [NSString
                                     stringWithFormat:@"%@getbranch.api?lat=%f&lon=%f&dist=%0.1f&limitshow=%0.0f&lang=%@&cat=%@",
                                     [CoreData sharedCoreData].realServerURL,
                                     user_location.coordinate.latitude,
                                     user_location.coordinate.longitude,
                                     show_distance/1000,
                                     show_no,
                                     [[LangUtil me] getLangID],
                                     current_category]]];
    NSLog(@"debug ATMDataHandler request:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
	[[CoreData sharedCoreData].mask showMask];
}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"debug ATMDataHandler requestFinished:%@", reponsedString);
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"debug ATMDataHandler requestFailed:%@", reponsedString);
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser
{
	[items_data removeAllObjects];
    items_data = nil;
    items_data = [NSMutableArray new];
	key = [NSArray arrayWithObjects:
           @"id",
           @"tel",
           @"fax",
           @"district1",
           @"lat",
           @"lon",
           @"iconshow",
           @"distance",
           @"branch",
           @"address",
           @"opeinghour",
           @"contacts",
           @"services",
           @"categories",
           nil];
    //	NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser
{
	NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);
	if ([items_data count]==0) {
        [caller_view reloadData:items_data];
        
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No result found nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
        [self calculateDistance];
        
		[caller_view reloadData:items_data];
	}
    //	NSLog(@"debug parserDidEndDocument:%@",items_data);
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	}
    //	NSLog(@"debug didStartElement:%@",elementName);
}

-(void)fixspace:(NSMutableDictionary*)dic key:(NSString*)akey
{
    NSString* value=[dic objectForKey:akey];
//    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (value == nil){
        value = @"";
    }
    
    if ([akey isEqualToString:@"opeinghour"]
        ||
        [akey isEqualToString:@"branch"]
        ||
        [akey isEqualToString:@"address"]
        ) {
        //        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t\t" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\n\t" withString:@""];
    } else {
        value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:@"item"]) {
        [self fixspace:temp_record key:@"tel"];
        [self fixspace:temp_record key:@"address"];
        [self fixspace:temp_record key:@"branch"];
        [self fixspace:temp_record key:@"categories"];
        [self fixspace:temp_record key:@"contacts"];
        [self fixspace:temp_record key:@"distance"];
        [self fixspace:temp_record key:@"district1"];
        [self fixspace:temp_record key:@"fax"];
        [self fixspace:temp_record key:@"iconshow"];
        [self fixspace:temp_record key:@"id"];
        [self fixspace:temp_record key:@"lat"];
        [self fixspace:temp_record key:@"lon"];
        [self fixspace:temp_record key:@"services"];
        [self fixspace:temp_record key:@"opeinghour"];
        
		[items_data addObject:temp_record];
        //        NSLog(@"debug didEndElement----:%@",temp_record);
	}
    //	NSLog(@"debug didEndElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	for (int i=0; i<[key count]; i++) {
		if ([currentElementName isEqualToString:[key objectAtIndex:i]]) {
            NSString * oldstr = [temp_record objectForKey:currentElementName];
            if (!oldstr){
                oldstr = @"";
            }
            oldstr = [oldstr stringByAppendingString:string];
			[temp_record setObject:oldstr forKey:currentElementName];
            //            NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
		}
	}
    //	NSLog(@"debug foundCharacters:%@",currentElementName);
}

-(void) calculateDistance
{
    //	NSLog(@"calculateDistance");
	if (user_location==nil || [items_data count]<1) {
		return;
	} else {
		for (int i=0; i<[items_data count]; i++) {
            //			NSArray *gps_list = [[[items_data objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
            CLLocationDegrees latitude = [[[items_data objectAtIndex:i] objectForKey:@"lat"] doubleValue];
            CLLocationDegrees longitude = [[[items_data objectAtIndex:i] objectForKey:@"lon"] doubleValue];
			CLLocation *shop_location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
			float distance = [user_location distanceFromLocation:shop_location];
			NSString *nsdistance = [NSString stringWithFormat:@"%0.2f", distance];
			[[items_data objectAtIndex:i] setObject:nsdistance forKey:@"distance"];
		}
	}
}

@end
