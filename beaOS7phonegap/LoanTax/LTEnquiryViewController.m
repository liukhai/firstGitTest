//
//  LTEnquiryViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/18/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "LTEnquiryViewController.h"


@implementation LTEnquiryViewController

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
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);

	ns_service = @"call";
	
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"LTTax Loan",nil), NSLocalizedString(@"LTTaxLoanEnquiryTitle",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	lbTag00.text = NSLocalizedString(@"LTTaxLoanEnquiryTag00",nil);
	lbTag00.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	lbTag01.text = NSLocalizedString(@"LTService hours:",nil);
	lbTag02.text = NSLocalizedString(@"LTService hours detail",nil);
	lbTag03.text = NSLocalizedString(@"LTTaxLoanEnquiryTag03",nil);
	lbTag04.text = NSLocalizedString(@"LTTaxLoanEnquiryTag04",nil);
	lbTag04.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	
	[btEmail setTitle:NSLocalizedString(@"LTTaxLoanEnquiryTagEmail", nil) forState:UIControlStateNormal];
	[btCall setTitle:NSLocalizedString(@"LTTaxLoanCallEnquiry", nil) forState:UIControlStateNormal];

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)callToEnquiry{
	ns_service = @"call";

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"LTTaxLoanCallEnquiry",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([ns_service isEqualToString:@"email"]) {
		if (buttonIndex==0) {
			MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
			if (![MFMailComposeViewController canSendMail]) {
				[mail_controller release];
				return;
			}
			mail_controller.mailComposeDelegate = self;
			NSArray* to = [NSArray arrayWithObjects:@"LTEnquiryEmail",nil];
			NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"LTTaxLoanEnquiryEmailTitle",nil)];
			[mail_controller setToRecipients:to];
			[mail_controller setSubject:subject];
			[self presentViewController:mail_controller animated:YES completion:nil];
			
			[mail_controller release];
		}
	}else if ([ns_service isEqualToString:@"call"]) {
		if (buttonIndex==1) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"LTConsumerFinanceServicesHotline",nil)]];
		}
	}
	
}

-(IBAction)email{
	ns_service = @"email";
	
//	UIAlertView* share_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Send us an email",nil) message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
//	share_alert.delegate = self;
//	[share_alert show];
//	[share_alert release];
	
	
	MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	mail_controller.mailComposeDelegate = self;
	NSArray* to = [NSArray arrayWithObjects:@"lebdcc@hkbea.com",nil];
	NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"LTTaxLoanEnquiryEmailTitle",nil)];
	[mail_controller setToRecipients:to];
	[mail_controller setSubject:subject];
	[self presentViewController:mail_controller animated:YES completion:nil];
	[CoreData sharedCoreData]._LTViewController.tabBar.hidden = YES;
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
    [[MBKUtil me].queryButton1 setHidden:NO];	
    [CoreData sharedCoreData]._LTViewController.tabBar.hidden = NO;
}

@end
