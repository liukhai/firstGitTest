//
//  AccProEnquiryViewController.m
//  BEA
//
//  Created by NEO on 06/16/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "AccProEnquiryViewController.h"
#import "AccProUtil.h"
#import "EnquiryCellViewController.h"

@implementation AccProEnquiryViewController

//@synthesize enqWebView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //edit by chu 20150217
    [self refreshViewContent];

}

-(void)requestDatas {
    NSURL* url= [NSURL URLWithString:[NSString stringWithFormat:@"%@getenquiry.api?type=5&lang=%@",
                                      [CoreData sharedCoreData].realServerURL,
                                      [[LangUtil me] getLangID]]];
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"debug ConsumerLoanEnquiryViewController requestDatas:%@",asi_request.url);
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
	[[CoreData sharedCoreData].mask showMask];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
//	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug AccProEnquiryViewController requestFinished:%@", reponsedString);
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [[CoreData sharedCoreData].mask hiddenMask];
    
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"debug AccProEnquiryViewController requestFailed:%@", reponsedString);
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
               @"fax",
               @"email",
               @"address",
               nil];
    //    NSLog(@"debug parserDidStartDocument:%@",key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);
	if ([items_data count]==0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
    NSLog(@"debug parserDidEndDocument:%@",items_data);
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
            NSString * oldstr = [temp_record_sub objectForKey:[key_sub objectAtIndex:i]];
            if (!oldstr){
                oldstr = @"";
            }
            NSString* key1 = [key_sub objectAtIndex:i];
            if (![key1 isEqualToString:@"desc"]) {
                oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            }
            [temp_record_sub setObject:oldstr forKey:[key_sub objectAtIndex:i]];
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
        NSLog(@"%@",temp_record_sub);
        ecvc.nsTitle = [temp_record_sub objectForKey:@"title"];
        ecvc.nsService = [temp_record_sub objectForKey:@"desc"];
        ecvc.nsCall = [temp_record_sub objectForKey:@"tel"];
        ecvc.nsFax = [temp_record_sub objectForKey:@"fax"];
        ecvc.nsEmail = [temp_record_sub objectForKey:@"email"];
        ecvc.nsAddress = [temp_record_sub objectForKey:@"address"];
        ecvc.nsSubject = NSLocalizedString(@"accpro.enquires.EmailTitle",nil);
        
        ecvc.navvc = [AccProUtil me].AccPro_view_controller;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)callToEnquiry{
	ns_service = @"call";
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"accpro.enquires.tel",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
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
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"accpro.enquires.EmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
	[[AccProUtil me].AccPro_view_controller presentViewController:mail_controller animated:YES completion:nil];
    
//	[AccProUtil me].AccPro_view_controller.tabBar.hidden = YES;
//    [[MBKUtil me].queryButton1 setHidden:YES];
	[mail_controller release];
	
}

-(void)sendEmailToBEA:(NSString*) mailto{
	ns_service = @"email";
	
	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	mail_controller.mailComposeDelegate = self;
	NSArray* to = [NSArray arrayWithObjects:@"lebdcc@hkbea.com",nil];
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"accpro.enquires.EmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
	[self presentViewController:mail_controller animated:YES completion:nil];
	[AccProUtil me].AccPro_view_controller.tabBar.hidden = YES;
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
	[AccProUtil me].AccPro_view_controller.tabBar.hidden = NO;
	
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load LTOffersViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded LTOffersViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded LTOffersViewController:%@", error );
    
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	
}
- (BOOL)webView:(UIWebView *)local_webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{ 
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/SendEmailToBEA"]) { 
        NSLog(@"Send email to BEA");
        NSRange foundRange;
        foundRange = [request.mainDocumentURL.absoluteString rangeOfString:@"mailto="];
        NSLog( @"SendEmailToBEA:%u--%u--%@", foundRange.location, foundRange.length, request.mainDocumentURL.absoluteString);
        if (foundRange.location != NSNotFound) {
            NSString *mailto = [request.mainDocumentURL.absoluteString substringFromIndex:foundRange.location+foundRange.length];
            NSLog( @"SendEmailToBEA mailto:%@", mailto);
            [self sendEmailToBEA:mailto];
        }
        return false;
    } 
    
    if ( [request.mainDocumentURL.relativeString hasPrefix:@"tel:"]) { 
        NSLog(@"Make a phone call:%@", [request.mainDocumentURL.relativeString substringFromIndex:4]);
        
        [self webcallToEnquiry:[request.mainDocumentURL.relativeString substringFromIndex:4]];
        return false;
    } 
    return true; 
} 

//edit by chu
-(void) refreshViewContent{
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 00, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    enqWebView.frame = CGRectMake(0, 45, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    ns_service = @"call";
    
    //	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"accpro.common.title",nil),NSLocalizedString(@"accpro.enquires.title",nil)];
    //
    //	lbTitle.font = [UIFont boldSystemFontOfSize:17];
    //	lbTitle.textAlignment = NSTextAlignmentCenter;
    //	lbTitle.numberOfLines = 2;
    //	lbTitle.lineBreakMode = UILineBreakModeWordWrap;
    
    //lbTag00.text = NSLocalizedString(@"accpro.enquires.holine",nil);
    //lbTag00.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
    //lbTag01.text = NSLocalizedString(@"accpro.enquires.serviceHours",nil);
    //lbTag02.text = NSLocalizedString(@"accpro.enquires.serviceHoursDetail",nil);
    //lbTag03.text = NSLocalizedString(@"accpro.enquires.selectLang",nil);
    //lbTag04.text = NSLocalizedString(@"accpro.enquires.byEmail",nil);
    //lbTag04.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
    
    //[btEmail setTitle:NSLocalizedString(@"accpro.enquires.sendEmail", nil) forState:UIControlStateNormal];
    //[btCall setTitle:NSLocalizedString(@"accpro.enquires.tel", nil) forState:UIControlStateNormal];
    
    
    //	self.enqWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    //    [self.enqWebView loadRequest:[HttpRequestUtils getPostRequest4EnquiriesPage]];
    
    //remove content
    if(contentView!=nil){
        for (UIView* view in [contentView subviews]) {
            if(view){
                if([view superview]){
                    [view removeFromSuperview];
                }
            }
        }
    }
    //scroll to top
    [contentView scrollRectToVisible:CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height) animated:NO];
    
    [self requestDatas];
}
@end
