//
//  YearRoundOffersMapViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "QuarterlySurpriseMapViewController.h"


@implementation QuarterlySurpriseMapViewController
@synthesize items_data;

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
	detail_info_view.frame = CGRectMake(0, 0, 320, 160);
	map_view_controller = [[MyMapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	map_view_controller.delegate = self;
	[content_view addSubview:map_view_controller.view];
	toc_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
	toc_view.hidden = TRUE;
	[content_view addSubview:toc_view];
	toc_text= [[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 200)];
	toc_text.editable = FALSE;
	toc_text.userInteractionEnabled = FALSE;
	[toc_view addSubview:toc_text];
	
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
	if (items_data!=nil) {
		[items_data release];
	}
	[toc_text release];
    [super dealloc];
}

-(void)setSelectShop:(int)index {
	
	current_shop_index = index;
	NSMutableArray *annotation_list = [NSMutableArray new];
	int i = index;
	NSMutableDictionary *temp_record = [NSMutableDictionary new];
	[temp_record setValue:[[items_data objectAtIndex:i] objectForKey:@"title"] forKey:@"title"];
	[temp_record setValue:[[items_data objectAtIndex:i] objectForKey:@"description"] forKey:@"subtitle"];
	NSArray *gps = [[[items_data objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
	[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:0] floatValue]] forKey:@"latitude"];
	[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:1] floatValue]] forKey:@"longitude"];
	[annotation_list addObject:temp_record];
	[PlistOperator savePlistFile:@"AnnotationList" From:annotation_list];
	[map_view_controller loadAnnonationsFromPlist:@"AnnotationList"];
	offer_title.text = [[items_data objectAtIndex:index] objectForKey:@"title"];
	offer_description.text = [[items_data objectAtIndex:index] objectForKey:@"shortdescription"];
	offer_content.text = [[items_data objectAtIndex:i] objectForKey:@"description"];
	[offer_image loadImageWithURL:[[items_data objectAtIndex:i] objectForKey:@"image"]];
	[coupon_image loadImageWithURL:[[items_data objectAtIndex:i] objectForKey:@"coupon"]];
	toc_text.text = [[items_data objectAtIndex:i] objectForKey:@"remarks"];
	[map_view_controller.map setSelectedAnnotation:0 Delta:0.05];
//	NSLog(@"remarks %@",[[items_data objectAtIndex:i] objectForKey:@"remarks"]);
}

-(IBAction)backButtonPressed:(UIBarButtonItem *)button {
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[self.navigationController popViewControllerAnimated:TRUE];
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
	if ([[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:current_shop_index] InGroup:0]) {
		[[CoreData sharedCoreData].bookmark removeBookmark:[items_data objectAtIndex:current_shop_index] ToGroup:0];
		[bookmark setTitle:@"Bookmark" forState:UIControlStateNormal];
	} else {
		[[CoreData sharedCoreData].bookmark addBookmark:[items_data objectAtIndex:current_shop_index] ToGroup:0];
		[bookmark setTitle:@"Remove" forState:UIControlStateNormal];
	}
}

-(IBAction)tocButtonPressed:(UIButton *)button {
	toc_view.hidden = FALSE;
	map_view_controller.view.hidden = TRUE;
}

-(IBAction)mapButtonPressed:(UIButton *)button {
	toc_view.hidden = TRUE;
	map_view_controller.view.hidden = FALSE;
}

-(IBAction)prevButtonPressed:(UIButton *)button {
	if (current_shop_index>0) {
		current_shop_index--;
		[self setSelectShop:current_shop_index];
	}
}

-(IBAction)nextButtonPressed:(UIButton *)button {
	if (current_shop_index<[items_data count]-1) {
		current_shop_index++;
		[self setSelectShop:current_shop_index];
	}
}

-(IBAction)moreButtonPressed:(UIButton *)button {
	detail_info_view.frame = CGRectMake(0, 0, 320, 370);
}

-(IBAction)closeButtonPressed:(UIButton *)button {
	detail_info_view.frame = CGRectMake(0, 0, 320, 160);
}

-(IBAction)couponButtonPressed:(UIButton *)button {
	coupon_view.frame = CGRectMake(0, 50, 320, 300);
}

-(IBAction)couponCloseButtonPressed:(UIButton *)button {
	coupon_view.frame = CGRectMake(0, 50, 320, 30);
}


///////////////////
//MyMapViewDelegate
///////////////////
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
/*	annotation_id = ((MyAnnotation *)view.annotation).tag;
	NSLog(@"%d",annotation_id);
	float distance = [map_view_controller.map distanceFromMe:view.annotation];
	if (distance<1000) {
		offer_distance.text = [NSString stringWithFormat:@"%.0fm",distance];
	} else {
		offer_distance.text = [NSString stringWithFormat:@"%.2fkm",distance/1000];
	}
	offer_title.text = [[search_result objectAtIndex:annotation_id] objectForKey:[NSString stringWithFormat:@"%@_title",lang]];
	offer_description.text = [[search_result objectAtIndex:annotation_id] objectForKey:[NSString stringWithFormat:@"%@_description",lang]];
	[offer_image loadImageWithURL:[[search_result objectAtIndex:annotation_id] objectForKey:@"image"]];*/
}

@end
