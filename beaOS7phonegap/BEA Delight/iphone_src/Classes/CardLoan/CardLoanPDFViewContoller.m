//
//  CardLoanPDFViewContoller.m
//  BEA
//
//  Created by Mtel on 11年4月7日.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardLoanPDFViewContoller.h"


@implementation CardLoanPDFViewContoller

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)dealloc {
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 20, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    webView.frame = CGRectMake(0, 44, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);

	NSString *urlAddress;
	if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
		closeButton.title = @"Close";
		urlAddress = [[NSBundle mainBundle] pathForResource:@"bea_en" ofType:@"pdf"];
	}
	else {
		closeButton.title = @"關閉";
		urlAddress = [[NSBundle mainBundle] pathForResource:@"bea_zh_TW" ofType:@"pdf"];
	}
	
	NSURL *url = [NSURL fileURLWithPath:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[webView loadRequest:requestObj];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

-(IBAction)clickCloseButton:(UIBarButtonItem*)button{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
