//
//  SGGRetryViewController.m
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGGUtil.h"
#import "SGGRetryViewController.h"

@implementation SGGRetryViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([MBKUtil isLangOfChi]) {
        self = [super initWithNibName:@"SGGRetryViewController" bundle:nibBundleOrNil];
    } else {
        self = [super initWithNibName:@"SGGRetryViewController_e" bundle:nibBundleOrNil];
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

- (IBAction)startGame:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)checkLatestPromo:(id)sender {
    [[SGGUtil me]._SGGViewController checkLatestPromo:sender];
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)showIntro:(id)sender {
    [[SGGUtil me]._SGGViewController showIntro:sender];
}

- (IBAction)screenPressed{}


@end
