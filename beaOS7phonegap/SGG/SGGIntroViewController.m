//
//  SGGIntroViewController.m
//  BEA
//
//  Created by yaojzy on 3/2/12.
//  Copyright (c) 2012 The Bank of East Asia, Limited. All rights reserved.
//

#import "SGGUtil.h"
#import "SGGIntroViewController.h"

@implementation SGGIntroViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([MBKUtil isLangOfChi]) {
        self = [super initWithNibName:@"SGGIntroViewController" bundle:nibBundleOrNil];
    } else {
        self = [super initWithNibName:@"SGGIntroViewController_e" bundle:nibBundleOrNil];
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

- (IBAction)goMainMenu:(id)sender {
    [[SGGUtil me] goHome];
}

- (IBAction)startGame:(id)sender {
    UIViewController *current_view_controller = [[SGGGameViewController alloc] initWithNibName:@"SGGGameViewController" bundle:nil];
    
    [self.navigationController pushViewController:current_view_controller animated:TRUE];
    [current_view_controller release];
}

- (IBAction)showTNC:(id)sender {
    [[SGGUtil me]._SGGViewController showTNC:sender];
}

@end
