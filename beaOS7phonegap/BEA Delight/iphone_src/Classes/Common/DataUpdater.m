//
//  DataUpdater.m
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月21日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataUpdater.h"
#define Classic	0
#define XML		1
#define StatusGetChecksum	0
#define StatuscheckUpdate	1

@implementation DataUpdater
@synthesize delegate, keys, url, filename;

-(id)initWithURL:(NSString *)url_input XMLFilename:(NSString *)filename_input {
	self = [super init];
	if (self!=nil) {
		mode = XML;
		url = [url_input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		keys = [NSArray new];
		filename = [filename_input retain];
		request_page_size = 0;
		request_page = 1;
	}
	return self;
}

-(id)initWithURL:(NSString *)url_input Keys:(NSArray *)keys_input Filename:(NSString *)filename_input {
	self = [super init];
	if (self!=nil) {
		mode = Classic;
		keys = [keys_input retain];
		url = [url_input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		filename = [filename_input retain];
	}
	return self;
}

-(void)dealloc {
	[filename release];
	[keys release];
    asi_request.delegate = nil;
	[super dealloc];
}

-(void)setURL:(NSString *)url_input XMLFilename:(NSString *)filename_input {
	mode = XML;
	url = [url_input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	keys = [NSArray new];
	if (filename!=nil) {
		[filename release];
		filename = nil;
	}
	filename = [filename_input retain];
	request_page_size = 0;
	request_page = 1;
}

-(void)setURL:(NSString *)url_input Keys:(NSArray *)keys_input Filename:(NSString *)filename_input {
	mode = Classic;
	keys = [keys_input retain];
	url = [url_input stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	if (filename!=nil) {
		[filename release];
		filename = nil;
	}
	filename = [filename_input retain];
}

-(void)setRequestAction:(NSString *)action Type:(NSString *)type Category:(NSString *)category PageSize:(int)page_size Page:(int)page Lang:(NSString *)lang {
	request_action = action;
	request_type = type;
	request_category = category;
	request_page_size = page_size;
	request_page = page;
	request_lang = lang;
}

-(void)setMD5URL:(NSString *)url_md5 {
	md5url = url_md5;
}

-(void)updateInfo {
	if (md5url!=nil) {
		NSLog(@"Request for MD5: %@",md5url);
		asi_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:md5url]];
		asi_request.delegate = self;
		[asi_request startAsynchronous];
	} else if (mode==Classic && keys!=nil) {
		NSLog(@"Request for Data %@",url);
		asi_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
		asi_request.delegate = self;
		[asi_request startAsynchronous];
	} else if (mode==XML) {
		NSLog(@"Request for Data %@",url);
		checksum = @"";
		new_checksum = @"";
		NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
		path = [NSString stringWithFormat:@"%@/%@",path,filename];
		xml_data = [NSData dataWithContentsOfFile:path];
		if (xml_data!=nil) {
			status = StatusGetChecksum;
			NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xml_data];
			xml_parser.delegate = self;
			[xml_parser setShouldProcessNamespaces:NO];
			[xml_parser setShouldReportNamespacePrefixes:NO];
			[xml_parser setShouldResolveExternalEntities:NO];
			[xml_parser parse];
		} else {
			status = StatuscheckUpdate;
			checksum = @"0000000000000000";
			NSLog(@"checksum:%@",checksum);
			asi_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
			asi_request.delegate = self;
			[asi_request startAsynchronous];
		}
	}

}

- (void)requestFinished:(ASIHTTPRequest *)request {
	if (request!=asi_request) {
		NSLog(@"Response timeout");
		return;
	}
//	NSLog(@"%@",[request responseString]);
//	NSLog(@"%@",[request responseData]);
	if (md5url!=nil) {
		[md5url release];
		md5url = nil;
		md5 = [[PlistOperator openPlistFile:[NSString stringWithFormat:@"%@_md5",filename] Datatype:@"NSDictionary"] objectForKey:@"md5"];
		NSLog(@"Old MD5:%@ New MD5:%@",md5,[request responseString]);

		//For debug
/*		md5 = [[request responseString] retain];
		[self updateInfo];*/
		if (![[request responseString] isEqualToString:md5]) {
			NSLog(@"Data changed");
			md5 = [[request responseString] retain];
			[self updateInfo];
		} else {
			NSLog(@"Data unchange");
			[delegate dataUpdated:TRUE];
		}
	} else if (mode==Classic) {
		NSMutableArray *data_list = [[NSMutableArray new] autorelease];
		NSArray *string_list = [[request responseString] componentsSeparatedByString:@"||"];
		int i, j;
//		NSLog(@"%d records got for key count %d",[string_list count],[keys count]);
		for (i=0; i<[string_list count]-1; i++) {
			NSArray *temp_string_list = [[string_list objectAtIndex:i] componentsSeparatedByString:@"|"];
//			NSLog(@"number of field:%d",[temp_string_list count]);
			NSMutableDictionary *temp_record;
			if ([temp_string_list count]==[keys count]) {
				temp_record = [NSMutableDictionary new];
				for (j=0; j<[keys count]; j++) {
					[temp_record setValue:[temp_string_list objectAtIndex:j] forKey:[keys objectAtIndex:j]];
				}
				[data_list addObject:temp_record];
				[temp_record release];
			}
		}
		[PlistOperator savePlistFile:filename From:data_list];
		[delegate dataUpdated:TRUE];
		if (md5!=nil) {
			NSLog(@"md5:%@",md5);
			NSMutableDictionary *md5_file = [NSMutableDictionary new];
			[md5_file setValue:md5 forKey:@"md5"];
			[PlistOperator savePlistFile:[NSString stringWithFormat:@"%@_md5",filename] From:md5_file];
			[md5 release];
		}
	} else if (mode==XML) {
		xml_data = [request responseData];
		NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xml_data];
		xml_parser.delegate = self;
		[xml_parser setShouldProcessNamespaces:NO];
		[xml_parser setShouldReportNamespacePrefixes:NO];
		[xml_parser setShouldResolveExternalEntities:NO];
		[xml_parser parse];
	}

}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"DataUpdater requestFailed:%@", request.error);
	[delegate dataUpdated:FALSE];
}

////////////////////
//XMLParserDelegate
////////////////////
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	//	NSLog(@"found file and started parsing");
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	[delegate dataUpdated:FALSE];
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
//	NSLog(@"found this element: %@", elementName);
	current_element = [elementName copy];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	//NSLog(@"ended element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//	NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	switch (status) {
		case StatusGetChecksum:
			if ([current_element isEqualToString:@"checksum"]) {
				if ([checksum isEqualToString:@""]) {
					checksum = [string copy];
				}
			}
			break;
		case StatuscheckUpdate:
			if ([current_element isEqualToString:@"checksum"]) {
				if ([new_checksum isEqualToString:@""]) {
					new_checksum = [string copy];
				}
			}
			break;
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	switch (status) {
		case StatusGetChecksum:
			status = StatuscheckUpdate;
			NSLog(@"checksum:%@",checksum);
			asi_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
			NSString *post_string = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><request><action>%@</action><type>%@</type><category>%@</category><checksum>%@</checksum><pageSize>%d</pageSize><page>%d</page><lang>%@</lang></request>",request_action,request_type,request_category,checksum,request_page_size,request_page,request_lang];
//			NSLog(@"Post String: %@",post_string);
			new_checksum = @"";
			[asi_request appendPostData:[post_string dataUsingEncoding:NSUTF8StringEncoding]];
			asi_request.delegate = self;
			[asi_request startAsynchronous];
			break;
		case StatuscheckUpdate:
			NSLog(@"Old checksum:%@ New checksum:%@",checksum,new_checksum);
			if (![checksum isEqualToString:new_checksum]) {
				NSLog(@"Data changed");
				NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
				path = [NSString stringWithFormat:@"%@/%@",path,filename];
				NSLog(@"Save to %@",path);
				[xml_data writeToFile:path atomically:TRUE];
			}
			[delegate dataUpdated:FALSE];
			break;
	}
}

@end
