//
//  PropertyLoanEnquiryViewController.m
//  BEA
//
//  Created by YAO JASEN on 28/02/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "PropertyLoanEnquiryViewController.h"
#import "PropertyLoanUtil.h"
#import "EnquiryCellViewController.h"

@implementation PropertyLoanEnquiryViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openProperty = YES;
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    /*
    self.view.frame = CGRectMake(0, self.view.frame.origin.y, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:FirstView];
    }
	ns_service = @"call";
	
	lbTitle.text = NSLocalizedString(@"PropertyLoanEnquiryTitle",nil);
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	lbTag00.text = NSLocalizedString(@"PropertyLoanHotlineTitle",nil);
	lbTag00.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	lbTag01.text = NSLocalizedString(@"PropertyLoanServiceHours",nil);
	lbTag02.text = NSLocalizedString(@"PropertyLoanServiceDetails",nil);
	lbTag03.text = NSLocalizedString(@"PropertyLoanServiceDetails2", nil);
    lbTime01.text = NSLocalizedString(@"PropertyLoanServiceTime", nil);
    lbTime02.text = NSLocalizedString(@"PropertyLoanServiceTime2", nil);
    lbExcept.text = NSLocalizedString(@"PropertyLoanServiceExcept", nil);
	//[btEmail setTitle:NSLocalizedString(@"PropertyLoanEnquiryTagEmail", nil) forState:UIControlStateNormal];
	[btCall setTitle:NSLocalizedString(@"PropertyLoanCallEnquiry", nil) forState:UIControlStateNormal];
     */
    [self refreshViewContent];

}

-(void)requestDatas {
    NSURL* url= [NSURL URLWithString:[NSString stringWithFormat:@"%@getenquiry.api?type=2&lang=%@",
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
               @"fax",
               @"email",
               @"address",
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
    
    //edit by chu 20150216
    /*
     UILabel*_labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 21)];
     _labelTitle.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"SupremeGold",nil)];
     _labelTitle.accessibilityLabel = [NSString stringWithFormat:@"%@",NSLocalizedString(@"SupremeGold",nil)];
     [contentView addSubview:_labelTitle];
     constH=_labelTitle.frame.origin.y+_labelTitle.frame.size.height;
     */
    
    for (int i=0; i<[items_data count]; i++) {
        temp_record_sub = [items_data objectAtIndex:i];
        EnquiryCellViewController* ecvc = [[EnquiryCellViewController alloc] initWithNibName:@"EnquiryCellViewController" bundle:nil];
        ecvc.nsTitle = [temp_record_sub objectForKey:@"title"];
        ecvc.nsService = [temp_record_sub objectForKey:@"desc"];
        ecvc.nsCall = [temp_record_sub objectForKey:@"tel"];
        ecvc.nsFax = [temp_record_sub objectForKey:@"fax"];
        ecvc.nsEmail = [temp_record_sub objectForKey:@"email"];
        ecvc.nsAddress = [temp_record_sub objectForKey:@"address"];
        ecvc.nsSubject = NSLocalizedString(@"PropertyLoanEnquiryEmailTitle",nil);
        ecvc.navvc = [CoreData sharedCoreData]._PropertyLoanViewController;
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
        
        height += ecvc.view.frame.size.height + 50;
    }
    
    [contentView setContentSize:CGSizeMake(contentView.frame.size.width, height+50)];
    
    
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
//    [FirstView release];
//    FirstView = nil;
//    [lbTag03 release];
//    lbTag03 = nil;
//    [lbTime01 release];
//    lbTime01 = nil;
//    [lbTime02 release];
//    lbTime02 = nil;
//    [lbExcept release];
//    lbExcept = nil;
    [contentView release];
    contentView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
//    [FirstView release];
//    [lbTag03 release];
//    [lbTime01 release];
//    [lbTime02 release];
//    [lbExcept release];
    [contentView release];
    [super dealloc];
}

-(IBAction)callToEnquiry{
	ns_service = @"call";

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"PropertyLoanCallEnquiry",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
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
	/*if ([ns_service isEqualToString:@"email"]) {
		if (buttonIndex==0) {
			MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
			if (![MFMailComposeViewController canSendMail]) {
				[mail_controller release];
				return;
			}
			mail_controller.mailComposeDelegate = self;
			NSArray* to = [NSArray arrayWithObjects:@"PropertyLoanEnquiryEmail",nil];
			NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"PropertyLoanEnquiryEmailTitle",nil)];
			[mail_controller setToRecipients:to];
			[mail_controller setSubject:subject];
			
			[self presentModalViewController:mail_controller animated:TRUE];
			
			[mail_controller release];
		}
		return;
	}*/ // edit by @yufei at 2011.03.07
//	NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [alertView title],nil];
    
	if ([ns_service isEqualToString:@"call"]) {
		if (buttonIndex==1) {

            NSURL *telno = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[NSLocalizedString(@"PropertyLoanCallEnquiry",nil) stringByReplacingOccurrencesOfString:@" " withString:@""]]];
            NSLog(@"Enquiry Call %@",telno);
            [[UIApplication sharedApplication] openURL:telno];
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
    NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"PropertyLoanEnquiryEmailTitle",nil)];
    [mail_controller setToRecipients:to];
    [mail_controller setSubject:subject];
    [[CoreData sharedCoreData]._PropertyLoanViewController presentViewController:mail_controller animated:YES completion:nil];
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
    NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"PropertyLoanEnquiryEmailTitle",nil)];
    [mail_controller setToRecipients:to];
    [mail_controller setSubject:subject];
    [self presentViewController:mail_controller animated:YES completion:nil];
//    [SupremeGoldUtil me].SupremeGold_view_controller.tabBar.hidden = YES;
    [CoreData sharedCoreData]._PropertyLoanViewController.tabBar.hidden = YES;
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
    [CoreData sharedCoreData]._PropertyLoanViewController.tabBar.hidden = NO;
    
}
// edit by yufei @2011.03.07
/*
 -(IBAction)email{
	ns_service = @"email";
	
	UIAlertView* share_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Send us an email",nil) message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
	share_alert.delegate = self;
	[share_alert show];
	[share_alert release];
	
	
	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	mail_controller.mailComposeDelegate = self;
	NSArray* to = [NSArray arrayWithObjects:@"lebdcc@hkbea.com",nil];
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"PropertyLoanEnquiryEmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
	
	[self presentModalViewController:mail_controller animated:TRUE];
	
	[mail_controller release];
	
}
 */

/* edit by @yufei at 2011.03.07
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
	[self dismissModalViewControllerAnimated:YES];
}
*/

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