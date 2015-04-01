//
//  ShareViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ShareViewController.h"


@implementation ShareViewController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)emailButtonPressed:(UIButton *)button {
	 
	MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
	mailer.mailComposeDelegate = self;
	[mailer setMessageBody:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Main share App",nil),NSLocalizedString(@"Share App",nil)] isHTML:TRUE];
	[mailer setSubject:NSLocalizedString(@"Check Out",nil)];
	[self presentModalViewController:mailer animated:TRUE];
	[mailer release];
}

////////////////////
//Mailer delegate
////////////////////
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	UIAlertView *result_view;
	switch (result) {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSent:
			result_view = [[UIAlertView alloc] initWithTitle:@"Email sent" message:@"Thank you for apply." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
			[result_view show];
			[result_view autorelease];
			break;
		case MFMailComposeResultFailed:
			result_view = [[UIAlertView alloc] initWithTitle:@"Email send fail" message:@"Please try again later" delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil];
			[result_view show];
			[result_view autorelease];
			break;
	}
	[self dismissModalViewControllerAnimated:TRUE];
}

@end
