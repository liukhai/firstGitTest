//
//  NewBranchBanner.m
//  BEA
//
//  Created by yaojzy on 10/24/11.
//  Copyright (c) 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "NewBranchBannerViewController.h"

@implementation NewBranchBannerViewController

@synthesize promotionText;
@synthesize shown_data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shownData:(NSMutableArray*)data
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.shown_data = data;
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

    self.view.frame = CGRectMake(0, 20, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);

    // Do any additional setup after loading the view from its nib.
    [self.view setAlpha:0.0f];
    self.view.center = CGPointMake(160, -1*[[MyScreenUtil me] getScreenHeight]/2);

    promotionText.font = [UIFont systemFontOfSize:26];
    //address_label.textColor = [UIColor colorWithRed:0.482 green:0 blue:0 alpha:1];
    promotionText.textColor = [UIColor blackColor];
    promotionText.numberOfLines = 4;
    promotionText.backgroundColor = [UIColor clearColor];
    promotionText.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSMutableArray* items_data = self.shown_data;
    if ([items_data count]>0) {
        id obj = [items_data objectAtIndex:0];
        
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *updateDate = [formatter dateFromString:[obj objectForKey:@"opening"]];
        NSLog(@"updateDate : %@",updateDate);
        
        if (![MBKUtil isLangOfChi]) {
            [formatter setDateFormat:@"dd MMM yyyy"];
            promotionText.text = [NSString stringWithFormat:@"%@\n\n%@\n%@",[obj objectForKey:@"Title_en"], NSLocalizedString(@"Open on",nil), [formatter stringFromDate:updateDate]];
            
        }else{
            [formatter setDateFormat:@"yyyy年MM月dd日"];
            promotionText.text = [NSString stringWithFormat:@"%@\n\n%@\n%@",[obj objectForKey:@"Title_zh"], NSLocalizedString(@"Open on",nil), [formatter stringFromDate:updateDate]];
            
        }
        
    }
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

-(void)showMe {
    if ([MBKUtil wifiNetWorkAvailable]) {
       
        [self saveCount];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5]; 
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [self.view setAlpha:1.0f];
        self.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        [UIView commitAnimations];
    }
}

-(void)saveCount{
    int count;
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[NewBranchBannerUtil me ]findPlistPath]];
    NSString *date_stamp = [md_temp objectForKey:@"ClickCount"];
    count = [date_stamp intValue]; 
    NSLog(@"hiddenMe beforecount:%d",count);
    
    NSString *counts = [NSString stringWithFormat:@"%d",count+1];
    [md_temp setValue:counts forKey:@"ClickCount"];
    [md_temp writeToFile:[[NewBranchBannerUtil me ] findPlistPath] atomically:YES];
}

-(IBAction)hiddenMe {
    NSLog(@"[NewBranchBanner hiddenMe]");
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [self.view setAlpha:0.0f];
    self.view.center = CGPointMake(160, -1*[[MyScreenUtil me] getScreenHeight]/2);
    
    [UIView commitAnimations];
    
}

-(IBAction)hiddenMeAndOpenAccpro{
    NSLog(@"[NewBranchBanner hiddenMeAndOpenAccpro]");
    
    [self hiddenMe];
    
	NewBranchListViewController *search_result = [[NewBranchListViewController alloc] initWithNibName:@"NewBranchListView" bundle:nil shownData:self.shown_data];
	[[CoreData sharedCoreData].atmlocation_view_controller.navigationController pushViewController:search_result animated:TRUE];
	[search_result getItemsListCuisine:@"" Location:@"Branch" Keywords:@""];
	[search_result release];
}

@end
