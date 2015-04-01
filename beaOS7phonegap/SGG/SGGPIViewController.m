//
//  SGGPIViewController.h
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGGUtil.h"

#import "SGGPIViewController.h"

@implementation SGGPIViewController

@synthesize webView;

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
    
    [self.webView loadRequest:[HttpRequestUtils getPostRequest4SGG]];
    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"SGG.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = UITextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = UILineBreakModeWordWrap;
    
//	tabBar.frame = CGRectMake(0, 480-49, 320, 49);
	tabBar.delegate = self;
	NSArray *tab_list = [NSLocalizedString(@"Tab",nil) componentsSeparatedByString:@","];
	
    ((UITabBarItem *)[tabBar.items objectAtIndex:0]).title = [tab_list objectAtIndex:3];
    
    [tabBar setHidden:YES];
    
//	[self.view addSubview:tabBar];
    
    [[MBKUtil me].queryButton1 setHidden:YES];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load SGGPIViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded SGGPIViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
	if ([serverFlag isEqualToString:@"succ"]) {
        [tabBar setHidden:NO];
    }
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded SGGPIViewController:%@", error );
    if ([error code] != NSURLErrorCancelled) {
        serverFlag = @"fail";
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];        
    }	
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/backToApp"] ) {    
        [[SGGUtil me] goHome];
        return false; 
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/showTNCInApp"] ) {    
        [[SGGUtil me]._SGGViewController showTNC:self];
        return false; 
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/servlet/SGGConshowTNCInApp"] ) {    
        UIViewController *current_view_controller = [[SGGTNCViewController alloc] initWithNibName:@"SGGTNCViewController" bundle:nil];
        
        [self.navigationController pushViewController:current_view_controller animated:YES];
        [current_view_controller release];
        return false; 
    }else if ( [request.mainDocumentURL.relativePath isEqualToString:@"/servlet/SGGConfirmation"] ) {    
        serverFlag = @"succ";
        return true; 
    } 
    return true; 
}

- (void)goHome{
    [[CoreData sharedCoreData].bea_view_controller.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    serverFlag = @"mail";
	UIAlertView *share_alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Share to Friends",nil) message:NSLocalizedString(@"Share App with Friends by Email",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:NSLocalizedString(@"Cancel",nil),nil];
    [share_alert show];
    [share_alert release];
  
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([serverFlag isEqualToString:@"fail"]) {
        [self goHome];
    }
    
	if (buttonIndex==0 && [serverFlag isEqualToString:@"mail"]) {
		MFMailComposeViewController* mail_controller = [[MFMailComposeViewController alloc] init];
		if (![MFMailComposeViewController canSendMail]) {
			[mail_controller release];
			return;
		}
		mail_controller.mailComposeDelegate = self;
		NSString* subject = [NSString stringWithFormat:@"%@", NSLocalizedString(@"SGG.ShareAppSubject",nil)];
		NSString* body = [NSString stringWithFormat:@"%@", NSLocalizedString(@"SGG.ShareAppBody",nil)];
		[mail_controller setSubject:subject];
		[mail_controller setMessageBody:body isHTML:FALSE];
		
		[self presentModalViewController:mail_controller animated:TRUE];
		[[MBKUtil me].queryButton1 setHidden:YES];
		[mail_controller release];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1];
        [SGGUtil me]._SGGViewController.banner.frame = CGRectMake(0, -24, 320, 44);
        [UIView commitAnimations];
	}
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
    
	[self dismissModalViewControllerAnimated:YES];
    [SGGUtil me]._SGGViewController.banner.frame = CGRectMake(0, 20, 320, 44);
}
@end
