//
//  ImportantNoticeContentViewController.m
//  BEA
//
//  Created by yaojzy on 19/8/13.
//  Copyright (c) 2013 The Bank of East Asia, Limited. All rights reserved.
//

#import "ImportantNoticeContentViewController.h"

@interface ImportantNoticeContentViewController ()

@end

@implementation ImportantNoticeContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_content_view release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setContent_view:nil];
    [super viewDidUnload];
}
@end
