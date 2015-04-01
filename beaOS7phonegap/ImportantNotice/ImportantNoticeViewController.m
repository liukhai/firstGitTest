//
//  ImportantNoticeViewController.h
//  BEA
//
//  Created by YAO JASEN on 14/03/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "ImportantNoticeViewController.h"


@implementation ImportantNoticeViewController

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openImportant = YES;
    self.view.frame = CGRectMake(0, 0, 320, 480+[[MyScreenUtil me] getScreenHeightAdjust]);
    
	[bt_question setTitle:NSLocalizedString(@"Frequently Asked Questions", nil) forState:UIControlStateNormal];
    [bt_securityTip setTitle:NSLocalizedString(@"Security Tips", nil) forState:UIControlStateNormal];
    isHiddenImportantNotice=YES;
    [self.view setAlpha:0.0f];
    
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


- (void)dealloc {
    [super dealloc];
}

-(void)switchMe{
    if(isHiddenImportantNotice){
        [self showMe];
    }else{
        [self hiddenMe];
    }
}

-(void)showMe {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5]; // edit by @yufei   
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    self.view.center = CGPointMake(160, 171);
       [self.view setAlpha:1.0f];
	[UIView commitAnimations];
	isHiddenImportantNotice=NO;
}

-(IBAction)hiddenMe {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [self.view setAlpha:0.0f];
    [UIView commitAnimations];
    isHiddenImportantNotice=YES;
    [[CoreData sharedCoreData].bea_view_controller toggleNoticeButton];
}

-(IBAction)gotoWebside:(UIButton *) uiButton{
	[self hiddenMe];
    WebViewController *web_controller = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
//	[[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:web_controller animated:TRUE];
    if (uiButton.tag == 0) {
        [web_controller setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"Frequently Asked Questions - link",nil)]]]; //To be retested
    //    [web_controller.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"Frequently Asked Questions - link",nil)]]];
        [web_controller release];
        return;
    }
    if(uiButton.tag == 1){
        [web_controller setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"Security Tips - link", nil)]]]; //To be retested
     //   [web_controller.web_view loadRequest:[NSURLRequest   requestWithURL:[NSURL URLWithString:NSLocalizedString(@"Security Tips - link", nil)]]];
            [web_controller release];
        return;
    }
    [[CoreData sharedCoreData].bea_view_controller.navigationController pushViewController:web_controller animated:TRUE];
    [web_controller release];
}



@end
