//
//  HotlineCallViewController.m
//  BEA
//
//  Created by yelong on 2/28/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "HotlineCallViewController.h"
#import "HotlineUtil.h"
#import "HotlineCell.h"

@implementation HotlineCallViewController

@synthesize hotlinePhoneNumbers, hotlineBarItems, hotlineImgs;
@synthesize hotlineToCall;
@synthesize table_view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.

    }
    return self;
}

- (void)viewDidLoad {
    NSLog(@"debug HotlineCallViewController:%@", self);

    [super viewDidLoad];

    self.view.frame = CGRectMake(0, 0, 320, [[MyScreenUtil me] getScreenHeight_IOS7_20]);

	lb_head.text = NSLocalizedString(@"HotlineTitle", nil);
	lb_hotline.text = NSLocalizedString(@"HotlinePickerTitle",nil);
    lb_hotline.textColor = [UIColor blackColor];
//    if ([[HotlineUtil me].mvflag2 intValue] < 1){
//		[[HotlineUtil me] increaseMvflag2];
        [self getHotlineItems];
//	}else{
//        [self getHotlineDetail];
//    }

    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[hotlinePhoneNumbers release];
	[hotlineToCall release];
    [super dealloc];
}

- (void) getHotlineItems{
	NSLog(@"getHotlineItems starts");

    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc]
                                   initWithURL:
                                   [NSURL
                                    URLWithString:
                                    [NSString
                                     stringWithFormat:@"%@gethotline.api?lang=%@",
                                     [CoreData sharedCoreData].realServerURL,
                                     [[LangUtil me] getLangID]
                                     ]]];
    NSLog(@"debug HotlineCallViewController getHotlineItems:%@",asi_request.url);

    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];

    [[CoreData sharedCoreData].mask showMask];
	NSLog(@"getHotlineItems end");
}

- (void)requestFinished:(ASIHTTPRequest *)request {

    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"debug HotlineViewController requestFinished:%@", reponsedString);

    NSString *ns_temp_file = [[HotlineUtil me] getDocHotlinePath];
	[[request responseData] writeToFile:ns_temp_file atomically:YES];

    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"HotlineViewController >> requestFailed:%@", request.error);
    
//    [self getHotlineDetail];
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void)getHotlineDetail{
    NSLog(@"getHotlineDetail starts");

    [[CoreData sharedCoreData].mask showMask];

    NSData * datas = [NSData dataWithContentsOfFile:[[HotlineUtil me] getDocHotlinePath]];

    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:datas];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];

    NSLog(@"getHotlineDetail end");

}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {

	[hotlineBarItems removeAllObjects];
    hotlineBarItems = nil;
    hotlineBarItems = [NSMutableArray new];

	[hotlinePhoneNumbers removeAllObjects];
    hotlinePhoneNumbers = nil;
    hotlinePhoneNumbers = [NSMutableArray new];

	[hotlineImgs removeAllObjects];
    hotlineImgs = nil;
    hotlineImgs = [NSMutableArray new];

	key = [NSArray arrayWithObjects:
           @"id",
           @"icon",
           @"title",
           @"tel",
           nil];
    //	NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"debug parserDidEndDocument:%d outlets",[hotlineBarItems count]);
	if ([temp_record count]==0) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert show];
//		[alert release];
	} else {
		[table_view reloadData];
	}
	NSLog(@"debug parserDidEndDocument:%@", hotlineBarItems);
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	}
    //	NSLog(@"debug didStartElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {

        NSString* title=[temp_record objectForKey:@"title"];
        NSString* tel=[temp_record objectForKey:@"tel"];
        NSString* icon=[temp_record objectForKey:@"icon"];
        title = [title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        title = [title stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        tel = [tel stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        tel = [tel stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        icon = [icon stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        icon = [icon stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        icon = [icon stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        [hotlineBarItems addObject:title];
        [hotlinePhoneNumbers addObject:tel];
        [hotlineImgs addObject:icon];
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

///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 61;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	if ([hotlineBarItems count]<1) {
		return 0;
	}
	int total_record = [hotlineBarItems count];
	return total_record;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"HotlineCallViewController cellForRowAtIndexPath:%@--%d", indexPath, [hotlinePhoneNumbers count]);

	NSUInteger index = indexPath.row;
	id obj = [hotlineBarItems objectAtIndex:index];

	NSString *identifier = @"HotlineCall";
	HotlineCell *cell = [[HotlineCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:identifier
                                                   mystyle:(index%2)
                                                      icon:[hotlineImgs objectAtIndex:index]
                         ];

//	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.title_label.text = obj;

	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
	NSLog(@"HotlineCallViewController didSelectRowAtIndexPath:%@---%d", indexPath, [hotlinePhoneNumbers count]);
    NSUInteger index = indexPath.row;
    
    hotlineToCall = [[NSString alloc] initWithString: [hotlinePhoneNumbers objectAtIndex: index]];
    NSString* hotlineToCallName = [[NSString alloc] initWithString: [hotlineBarItems objectAtIndex: index]];
    [[HotlineUtil me] call: hotlineToCall name:hotlineToCallName];
}

@end
