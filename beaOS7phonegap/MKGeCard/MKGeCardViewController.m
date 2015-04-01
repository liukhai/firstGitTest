//
//  MKGeCardViewController.m
//  BEA
//
//  Created by NEO on 11/07/11.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "MKGeCardViewController.h"
#import "MKGeCardUtil.h"

@implementation MKGeCardViewController

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
 
    [self.webView loadRequest:[HttpRequestUtils getPostRequest4MKGeCard]];
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;    
   	lbTitle.text = [NSString stringWithFormat:@"%@", NSLocalizedString(@"MKGeCard.title",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [[MBKUtil me].queryButton1 setHidden:YES];
}


-(void) webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"Start load MKGeCardViewController");
	[[CoreData sharedCoreData].mask showMask];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"Finish loaded MKGeCardViewController");
	[[CoreData sharedCoreData].mask hiddenMask];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[[CoreData sharedCoreData].mask hiddenMask];
	NSLog(@"fail loaded MKGeCardViewController:%@", error );
    if ([error code] != NSURLErrorCancelled) {
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Error downloading data",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
        [alert_view release];        
    }	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self goHome];
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



@end
