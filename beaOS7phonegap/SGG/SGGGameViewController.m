//
//  SGGGameViewController.m
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGGUtil.h"
#import "SGGGameViewController.h"

@implementation SGGGameViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([MBKUtil isLangOfChi]) {
        self = [super initWithNibName:@"SGGGameViewController" bundle:nibBundleOrNil];
    } else {
        self = [super initWithNibName:@"SGGGameViewController_e" bundle:nibBundleOrNil];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)checkLatestPromo:(id)sender {
    [[SGGUtil me]._SGGViewController checkLatestPromo:sender];
}

- (IBAction)submitAns:(id)sender {
    [self.view endEditing:TRUE];

    ASIFormDataRequest *request =[HttpRequestUtils getPostRequest4SGGANS:self answer:answer_input.text];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    [[CoreData sharedCoreData].mask showMask];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[[CoreData sharedCoreData].mask hiddenMask];
	
	NSLog(@"SGGGameViewController requestFinished:%@",[request responseString]);
	NSString * regStatus = [NSString stringWithFormat:@"%@", [request responseString]];
    
    if (NSOrderedSame == [regStatus compare:@"Y"]){
        UIViewController *current_view_controller = [[SGGPIViewController alloc] initWithNibName:@"SGGPIViewController" bundle:nil];
        
        [self.navigationController pushViewController:current_view_controller animated:TRUE];
        [current_view_controller release];
	}else {
        answer_input.text = @"";
        
        UIViewController *current_view_controller = [[SGGRetryViewController alloc] initWithNibName:@"SGGRetryViewController" bundle:nil];
        
        [self.navigationController pushViewController:current_view_controller animated:TRUE];
        [current_view_controller release];
		
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"MobileTradingUtil requestFailed req:%@", request);
	NSLog(@"MobileTradingUtil requestFailed error:%@", [request error]);
	
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	
}

- (void)dealloc {
  	[[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
    [super dealloc];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scroll_view setContentOffset:CGPointMake(0, textField.frame.origin.y-50) animated:TRUE];
    if (textField.keyboardType==UIKeyboardTypeNumberPad) {
        [[MBKUtil me].queryButton1 setHidden:NO];
    }else{
        [[MBKUtil me].queryButton1 setHidden:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 	[textField resignFirstResponder];
	return YES;
}

- (IBAction)screenPressed
{
    [answer_input resignFirstResponder];
}

-(void)queryFromKeypad:(UIButton *) btnQuery{
    [self.view endEditing:TRUE];
}

- (IBAction)showIntro:(id)sender {
    [[SGGUtil me]._SGGViewController showIntro:sender];
}
@end
