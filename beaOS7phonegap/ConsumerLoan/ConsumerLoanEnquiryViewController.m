//  Amended by jasen on 201307

#import "ConsumerLoanEnquiryViewController.h"
#import "ConsumerLoanUtil.h"
#import "EnquiryCellViewController.h"

@implementation ConsumerLoanEnquiryViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestDatas];
}

-(void)requestDatas {
    NSURL* url= [NSURL URLWithString:[NSString stringWithFormat:@"%@getenquiry.api?type=3&lang=%@",
                                      [CoreData sharedCoreData].realServerURL,
                                      [[LangUtil me] getLangID]]];
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"debug ConsumerLoanEnquiryViewController requestDatas:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
	[[CoreData sharedCoreData].mask showMask];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
//	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug ConsumerLoanEnquiryViewController requestFinished:%@", reponsedString);
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [[CoreData sharedCoreData].mask hiddenMask];
    
	NSLog(@"debug ConsumerLoanEnquiryViewController requestFailed:%@", request.error);
}

-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
    items_data = nil;
    items_data = [NSMutableArray new];
	key = [NSArray arrayWithObjects:
           @"type",
           @"id",
           nil];
	key_sub = [NSArray arrayWithObjects:
               @"title",
               @"desc",
               @"tel",
               @"email",
               @"address",
               @"fax",
               nil];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);
	if ([items_data count]==0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
//    NSLog(@"debug parserDidEndDocument:%@",items_data);
    [self initView];
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
        temp_groups_items = [NSMutableArray new];
        isItem = YES;
	}
	if ([elementName isEqualToString:@"subitem"]) {
		temp_record_sub = [NSMutableDictionary new];
        isSubitem = YES;
	}
    //    NSLog(@"debug didStartElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        isItem = NO;
//        temp_groups_item = [NSMutableDictionary new];
//        [temp_groups_item setObject:[temp_record objectForKey:@"name"] forKey:@"header"];
//        NSString * oldstr = [temp_groups_item objectForKey:@"header"];
//        if (!oldstr){
//            oldstr = @"";
//        }
//        oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        [temp_groups_item setObject:oldstr forKey:@"header"];
//        [temp_groups_item setObject:temp_groups_items forKey:@"items"];
//        [items_data addObject:temp_groups_item];
	}
	if ([elementName isEqualToString:@"subitem"]) {
        isSubitem = NO;
        for (int i=0; i<[key_sub count]; i++) {
            NSString * akey = [key_sub objectAtIndex:i];
            NSString * oldstr = [temp_record_sub objectForKey:akey];
            if (!oldstr){
                oldstr = @"";
            }
            if (![akey isEqualToString:@"desc"]) {
                oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            }
            [temp_record_sub setObject:oldstr forKey:akey];
        }
        
        [items_data addObject:temp_record_sub];
	}
    //    NSLog(@"debug didEndElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (isSubitem) {
        for (int i=0; i<[key_sub count]; i++) {
            if ([currentElementName isEqualToString:[key_sub objectAtIndex:i]]) {
                NSString * oldstr = [temp_record_sub objectForKey:currentElementName];
                if (!oldstr){
                    oldstr = @"";
                }
                oldstr = [oldstr stringByAppendingString:string];
                [temp_record_sub setObject:oldstr forKey:currentElementName];
                //                NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
            }
        }
        //        NSLog(@"debug foundCharacters:%@",currentElementName);
    }
    else
    {
        for (int i=0; i<[key count]; i++) {
            if ([currentElementName isEqualToString:[key objectAtIndex:i]]) {
                NSString * oldstr = [temp_record objectForKey:currentElementName];
                if (!oldstr){
                    oldstr = @"";
                }
                oldstr = [oldstr stringByAppendingString:string];
                [temp_record setObject:oldstr forKey:currentElementName];
                //                NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
            }
        }
        //        NSLog(@"debug foundCharacters:%@",currentElementName);
    }
}

-(void)initView
{
    int constH=0;
    int height=0;
    for (int i=0; i<[items_data count]; i++) {
        temp_record_sub = [items_data objectAtIndex:i];
        EnquiryCellViewController* ecvc = [[EnquiryCellViewController alloc] initWithNibName:@"EnquiryCellViewController" bundle:nil];
        ecvc.nsTitle = [temp_record_sub objectForKey:@"title"];
        ecvc.nsService = [temp_record_sub objectForKey:@"desc"];
        ecvc.nsCall = [temp_record_sub objectForKey:@"tel"];
        ecvc.nsFax = [temp_record_sub objectForKey:@"fax"];
        ecvc.nsEmail = [temp_record_sub objectForKey:@"email"];
        ecvc.nsAddress = [temp_record_sub objectForKey:@"address"];
        ecvc.nsSubject = NSLocalizedString(@"consumerloan.enquires.EmailTitle",nil);
        ecvc.navvc = [CoreData sharedCoreData].taxLoan_view_controller;
//        CGRect frame = ecvc.view.frame;
//        frame.origin.x = 0;
//        frame.origin.y = 240*i;
//        frame.size.height = 240;
//        ecvc.view.frame = frame;
        CGRect frame = ecvc.view.frame;
        frame.origin.x = 0;
        frame.origin.y = constH;
        constH = constH+ecvc.v_content.frame.size.height;
        frame.size.height = ecvc.v_content.frame.size.height;
        ecvc.view.frame = frame;
        [contentView addSubview:ecvc.view];
        
        height += ecvc.view.frame.size.height + 15;
    }
    
    [contentView setContentSize:CGSizeMake(contentView.frame.size.width, height+10)];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [contentView release];
    contentView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [contentView release];
    [super dealloc];
}

-(IBAction)callToEnquiry{
	ns_service = @"call";
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:[temp_record_sub objectForKey:@"tel"] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

- (IBAction)faxToEnquiry{
    ns_service = @"fax";
    
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:[temp_record_sub objectForKey:@"fax"] message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
    [alert_view show];
    [alert_view release];
}

-(void)webcallToEnquiry:(NSString *)enq_number {
	ns_service = @"call";
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:enq_number message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//	if ([ns_service isEqualToString:@"email"]) {
//		if (buttonIndex==0) {
//			MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
//			if (![MFMailComposeViewController canSendMail]) {
//				[mail_controller release];
//				return;
//			}
//			mail_controller.mailComposeDelegate = self;
//			NSArray* to = [NSArray arrayWithObjects:@"accpro.enquires.Email",nil];
//			NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"accpro.enquires.EmailTitle",nil)];
//			[mail_controller setToRecipients:to];
//			[mail_controller setSubject:subject];
			
//			[self presentModalViewController:mail_controller animated:TRUE];
//			[[MBKUtil me].queryButton1 setHidden:YES];
//			[mail_controller release];
//		}
//	}else if ([ns_service isEqualToString:@"call"]) {
    NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [alertView title],nil];
    
	if ([ns_service isEqualToString:@"call"]) {
		if (buttonIndex==1) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:targetURL]];
		}
	}
    if ([ns_service isEqualToString:@"fax"]) {
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:targetURL]];
        }
    }
	
}

-(IBAction)email{
	ns_service = @"email";
	
	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	mail_controller.mailComposeDelegate = self;
	NSArray* to = [NSArray arrayWithObjects:[temp_record_sub objectForKey:@"email"],nil];
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"consumerloan.enquires.EmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
	[[CoreData sharedCoreData].taxLoan_view_controller presentViewController:mail_controller animated:YES completion:nil];
//	[ConsumerLoanUtil me].ConsumerLoan_view_controller.tabBar.hidden = YES;
//    [[MBKUtil me].queryButton1 setHidden:YES];
	[mail_controller release];
	
}

-(void)sendEmailToBEA{
	ns_service = @"email";
	
	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	mail_controller.mailComposeDelegate = self;
	NSArray* to = [NSArray arrayWithObjects:@"lebdcc@hkbea.com",nil];
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"consumerloan.enquires.EmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
	[self presentViewController:mail_controller animated:YES completion:nil];
	[ConsumerLoanUtil me].ConsumerLoan_view_controller.tabBar.hidden = YES;
    [[MBKUtil me].queryButton1 setHidden:YES];
	[mail_controller release];
	
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	switch (result) {
		case MFMailComposeResultCancelled:
			
			break;
		case MFMailComposeResultSaved:
			
			break;
		case MFMailComposeResultSent:
			NSLog(@"Sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Fail");
			break;
	}
	[self dismissViewControllerAnimated:YES completion:nil];
	[ConsumerLoanUtil me].ConsumerLoan_view_controller.tabBar.hidden = NO;
	
}

//-(void) webViewDidStartLoad:(UIWebView *)webView {
//	NSLog(@"Start load ConsumerLoanEnquiryViewController");
//	[[CoreData sharedCoreData].mask showMask];
//}
//
//-(void) webViewDidFinishLoad:(UIWebView *)webView {
//	NSLog(@"Finish loaded ConsumerLoanEnquiryViewController");
//	[[CoreData sharedCoreData].mask hiddenMask];
//}
//
//-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//	[[CoreData sharedCoreData].mask hiddenMask];
//	NSLog(@"fail loaded ConsumerLoanEnquiryViewController:%@", error );
//    
//	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//	[alert_view show];
//	[alert_view release];
//	
//}
//- (BOOL)webView:(UIWebView *)local_webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{ 
//    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/SendEmailToBEA"]) { 
//        NSLog(@"Send email to BEA");
//        [self sendEmailToBEA];
//        return false;
//    } 
//    
//    if ( [request.mainDocumentURL.relativeString hasPrefix:@"tel:"]) { 
//        NSLog(@"Make a phone call:%@", [request.mainDocumentURL.relativeString substringFromIndex:4]);
//        
//        [self webcallToEnquiry:[request.mainDocumentURL.relativeString substringFromIndex:4]];
//        return false;
//    } 
//    return true; 
//} 

@end
