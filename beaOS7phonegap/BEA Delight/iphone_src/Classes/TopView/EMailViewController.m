//
//  EMailViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月10日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EMailViewController.h"
#import "MyScreenUtil.h"
#import "CoreData.h"

@implementation EMailViewController
@synthesize mail_controller;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
	self.view.frame = CGRectMake(0, 0, 320, 0);
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(void)createComposerWithSubject:(NSString *)subject Message:(NSString *)body {
	mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	self.view.frame = CGRectMake(0, 0, 320, [[MyScreenUtil me] getScreenHeight]);
	mail_controller.mailComposeDelegate = self;
	[mail_controller setSubject:subject];
	[mail_controller setMessageBody:body isHTML:FALSE];
//    [self.view.window.rootViewController presentViewController:mail_controller animated:YES completion:nil];
    [[CoreData sharedCoreData].main_view_controller presentViewController:mail_controller animated:YES completion:nil];
    [[MBKUtil me].queryButton1 setHidden:YES];
	[mail_controller release];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame=CGRectMake(0, 0, 320,[[MyScreenUtil me] getScreenHeight]);
    }
}

-(void)createComposerWithSubject2:(NSString *)subject to:(NSArray *)addresss{
	mail_controller = [[MFMailComposeViewController alloc] init];
	if (![MFMailComposeViewController canSendMail]) {
		[mail_controller release];
		return;
	}
	self.view.frame = CGRectMake(0, 0, 320, [[MyScreenUtil me] getScreenHeight]);
	mail_controller.mailComposeDelegate = self;
    [mail_controller setToRecipients:addresss];
	[mail_controller setSubject:subject];

    [self presentViewController:mail_controller animated:YES completion:nil];
    [[MBKUtil me].queryButton1 setHidden:YES];
	[mail_controller release];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame=CGRectMake(0, 0, 320,[[MyScreenUtil me] getScreenHeight]);
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
//	[self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    [[CoreData sharedCoreData].main_view_controller dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:YES completion:nil];
	self.view.frame = CGRectMake(0, 0, 320, 0);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [CoreData sharedCoreData]._BEAAppDelegate.window.frame=CGRectMake(0, 20, 320,[[MyScreenUtil me] getScreenHeight]);
    }
}
@end
