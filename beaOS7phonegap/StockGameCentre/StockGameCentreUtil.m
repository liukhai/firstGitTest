//  Amended by yaojzy on 201309.

#import "StockGameCentreUtil.h"

@implementation StockGameCentreUtil

@synthesize stockGameCentreViewController;

+ (StockGameCentreUtil *)me
{
	static StockGameCentreUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[StockGameCentreUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"StockGameCentreUtil init");
    self = [super init];
    if (self) {
        self.stockGameCentreViewController = nil;
    }
    
    return self;
}

+ (BOOL) isValidUtil
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyyMMdd"];
	NSDate *now_date = [NSDate date];
	
	NSDate *start_date = [df dateFromString:@"20111101"];
	NSDate *end_date = [df dateFromString:@"20111128"];

	[df release];
    
	BOOL retValue=NO;
	if ([now_date isEqualToDate:start_date] 
		|| [now_date isEqualToDate:end_date] 
		|| ( (NSOrderedDescending == [now_date compare:start_date]) && (NSOrderedAscending == [now_date compare:end_date]) )
		)
	{
		retValue=YES;
	}
	
	NSLog(@"StockGameCentreUtil isValidUtil:%@--%@--%@--%d", now_date, start_date, end_date, retValue);
	
	return retValue;
}

- (BOOL) isGameOn
{
    if ([onoff isEqualToString:@"true"]) {
        return YES;
    } else {
        return NO;
    }
}



-(void)requestAPIDatas
{
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:[NSURL
                                                URLWithString:
                                                [NSString
                                                 stringWithFormat:@"%@getgameurl.api?lang=%@",
                                                 [CoreData sharedCoreData].realServerURL,
                                                 [[LangUtil me] getLangID]]]
                                   ];
    NSLog(@"debug StockGameCentreUtil stepone:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
	[[CoreData sharedCoreData].mask showMask];
}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
//	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug StockGameCentreUtil requestFinished:%@", reponsedString);
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"debug stockGameCentreViewController requestFailed:%@", request.error);

	//	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	//	[alert_view show];
	//	[alert_view release];
	//	[[CoreData sharedCoreData].mask hiddenMask];
	//	[request release];
    
    //	[self parseFromFile];
    
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
    items_data = nil;
    items_data = [NSMutableArray new];
	key = [NSArray arrayWithObjects:
           @"onoff",
           @"url",
           nil];
    //	NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);

	if ([items_data count]==0) {
	} else {
        temp_record = [items_data objectAtIndex:0];
        [self fixspace:temp_record key:@"onoff"];
        [self fixspace:temp_record key:@"url"];
        onoff = [temp_record objectForKey:@"onoff"];
        url = [temp_record objectForKey:@"url"];
        NSLog(@"debug parserDidEndDocument game onoff:%@--%@--%@", temp_record, onoff, url);
	}
    
    [[CoreData sharedCoreData].bea_view_controller setGameButton];
    
    //	NSLog(@"debug parserDidEndDocument:%@",items_data);
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
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
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if ([akey isEqualToString:@"url"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    } else {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
//    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        [self fixspace:temp_record key:@"onoff"];
        [self fixspace:temp_record key:@"url"];
        
		[items_data addObject:temp_record];
//        NSLog(@"debug didEndElement----:%@",temp_record);
	}
    //	NSLog(@"debug didEndElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
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
- (NSString*) getGameURL
{
    [self requestAPIDatas];
    return url;
}
@end
