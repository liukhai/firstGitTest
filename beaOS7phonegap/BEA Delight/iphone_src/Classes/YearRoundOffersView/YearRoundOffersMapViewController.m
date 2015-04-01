//
//  YearRoundOffersMapViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "YearRoundOffersMapViewController.h"


@implementation YearRoundOffersMapViewController
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
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bea_logo.png"]];
	self.navigationItem.title = NSLocalizedString(@"Back",nil);
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Home",nil) style:UIBarButtonItemStyleBordered target:[CoreData sharedCoreData].root_view_controller action:@selector(goHome)];
	check_selected_annotation_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkSelectedAnnotation) userInfo:nil repeats:TRUE];
	[self release];
	bookmark_mode_add = TRUE;
	detail_small_rect = CGRectMake(0, 27, 320, 82);
	detail_big_rect = CGRectMake(0, 27, 320, 260);
	detail_info_view.frame = detail_small_rect;
	coupon_view.frame = CGRectMake(0, 67, 320, 0);
	map_view_controller = [[MyMapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	map_view_controller.delegate = self;
	map.selected = TRUE;
	[content_view addSubview:map_view_controller.view];
	toc_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 205)];
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
	NSLog(@"YearRoundOffersMapViewController dealloc");
	[self retain];
	[check_selected_annotation_timer invalidate];
	if (items_data!=nil) {
		[items_data release];
	}
	[toc_text release];
    [super dealloc];
}

-(void)createAnnotationList {
	NSLog(@"createAnnotationList");
	NSMutableArray *annotation_list = [NSMutableArray new];
	for (int i=0; i<[items_data count]; i++) {
		NSMutableDictionary *temp_record = [NSMutableDictionary new];
		[temp_record setValue:[[items_data objectAtIndex:i] objectForKey:@"title"] forKey:@"title"];
		[temp_record setValue:@"" forKey:@"subtitle"];
		NSArray *gps = [[[items_data objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
		[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:0] floatValue]] forKey:@"latitude"];
		[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:1] floatValue]] forKey:@"longitude"];
		[annotation_list addObject:temp_record];
	}
	[PlistOperator savePlistFile:@"AnnotationList" From:annotation_list];
	[map_view_controller loadAnnonationsFromPlist:@"AnnotationList"];
}

-(void)setSelectShop:(int)index {
	[map_view_controller.map setSelectedAnnotation:index Delta:0.05];
/*	current_shop_index = index;
	offer_title.text = [[items_data objectAtIndex:index] objectForKey:@"title"];
	offer_description.text = [[items_data objectAtIndex:index] objectForKey:@"shortdescription"];
	offer_content.text = [[items_data objectAtIndex:index] objectForKey:@"description"];
	[offer_image loadImageWithURL:[[items_data objectAtIndex:index] objectForKey:@"image"]];
	toc_text.text = [[items_data objectAtIndex:index] objectForKey:@"remarks"];
	if (bookmark_mode_add) {
		[bookmark setTitle:@"Bookmark" forState:UIControlStateNormal];
		if ([[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:index] InGroup:0]) {
			bookmark.enabled = FALSE;
		} else {
			bookmark.enabled = TRUE;
		}

	} else {
		[bookmark setTitle:@"Remove" forState:UIControlStateNormal];
		if ([[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:index] InGroup:0]) {
			bookmark.enabled = TRUE;
		} else {
			bookmark.enabled = FALSE;
		}
	}

	if (current_shop_index==0) {
		prev.enabled = FALSE;
	} else {
		prev.enabled = TRUE;
	}
	if (current_shop_index==[items_data count]-1) {
		next.enabled = FALSE;
	} else {
		next.enabled = TRUE;
	}
	map_view_controller.map.follow_user = FALSE;*/
}

-(void)setBookmarkModeAdd:(BOOL)add {
	bookmark_mode_add = add;
}

-(void)checkSelectedAnnotation {
	if ([map_view_controller.map.selectedAnnotations count]>0) {
		NSArray *annotation_list = [map_view_controller.map getAnnotations];
		for (int i=0; i<[annotation_list count]; i++) {
			if ([annotation_list objectAtIndex:i]==((MKPinAnnotationView *)[map_view_controller.map.selectedAnnotations objectAtIndex:0]).annotation) {
/*				if ( && (current_shop_index!=i || ![offer_title.text isEqualToString:@""])) {
				}*/
				current_shop_index = i;
				NSLog(@"%@ %@",[[items_data objectAtIndex:i] objectForKey:@"title"],[[items_data objectAtIndex:i] objectForKey:@"description"]);
				offer_title.text = [[items_data objectAtIndex:i] objectForKey:@"title"];
				offer_description.text = [[items_data objectAtIndex:i] objectForKey:@"shortdescription"];
				offer_tel.text = [[items_data objectAtIndex:i] objectForKey:@"tel"];
				offer_content.text = [[items_data objectAtIndex:i] objectForKey:@"description"];
				[offer_image loadImageWithURL:[[items_data objectAtIndex:i] objectForKey:@"image"]];
				toc_text.text = [[items_data objectAtIndex:i] objectForKey:@"remarks"];
//				NSLog(@"coupon %@",[[items_data objectAtIndex:i] objectForKey:@"coupon"]);
				if ([[items_data objectAtIndex:i] objectForKey:@"coupon"]==nil || [[[items_data objectAtIndex:i] objectForKey:@"coupon"] isEqualToString:@""]) {
//					NSLog(@"no coupon");
					coupon_view.frame = CGRectMake(0, 44, 320, 0);
				} else {
					coupon_view.frame = CGRectMake(0, 44, 320, 30);
					[coupon_image loadImageWithURL:[[items_data objectAtIndex:i] objectForKey:@"coupon"]];
				}

				if (bookmark_mode_add) {
//					[bookmark setTitle:@"Add Favourite" forState:UIControlStateNormal];
					if ([[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:i] InGroup:0]) {
//						bookmark.enabled = FALSE;
						bookmark.selected = TRUE;
					} else {
//						bookmark.enabled = TRUE;
						bookmark.selected = FALSE;
					}
					
				} else {
//					[bookmark setTitle:@"Remove" forState:UIControlStateNormal];
					if ([[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:i] InGroup:0]) {
//						bookmark.enabled = TRUE;
						bookmark.selected = TRUE;
					} else {
//						bookmark.enabled = FALSE;
						bookmark.selected = FALSE;
					}
				}
				
				if (current_shop_index==0) {
					prev.enabled = FALSE;
				} else {
					prev.enabled = TRUE;
				}
				if (current_shop_index==[items_data count]-1) {
					next.enabled = FALSE;
				} else {
					next.enabled = TRUE;
				}
			}
		}
	} else {
		current_shop_index = -1;
		offer_title.text = @"";
		offer_description.text = @"Please choose a shop";
		offer_tel.text = @"";
		offer_content.text = @"";
		offer_image.image = nil;
		toc_text.text = @"";
	}
	
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
	if (bookmark_mode_add) {
		if (![[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:current_shop_index] InGroup:0]) {
			[[CoreData sharedCoreData].bookmark addBookmark:[items_data objectAtIndex:current_shop_index] ToGroup:0];
			bookmark.selected = TRUE;
//			[bookmark setEnabled:FALSE];
		}
	} else {
		if ([[CoreData sharedCoreData].bookmark isOfferExist:[items_data objectAtIndex:current_shop_index] InGroup:0]) {
			[[CoreData sharedCoreData].bookmark removeBookmark:[items_data objectAtIndex:current_shop_index] ToGroup:0];
			bookmark.selected = FALSE;
//			[bookmark setEnabled:FALSE];
		}
	}

}

-(IBAction)tocButtonPressed:(UIButton *)button {
	toc_view.hidden = FALSE;
	toc.selected = TRUE;
	map.selected = FALSE;
	map_view_controller.view.hidden = TRUE;
}

-(IBAction)mapButtonPressed:(UIButton *)button {
	toc_view.hidden = TRUE;
	toc.selected = FALSE;
	map.selected = TRUE;
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
	NSLog(@"Show more");
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	detail_info_view.frame = detail_big_rect;
	detail_info_bg_view.alpha = 0.8;
	[UIView commitAnimations];
	more.hidden = TRUE;
}

-(IBAction)closeButtonPressed:(UIButton *)button {
	NSLog(@"Close more");
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	detail_info_view.frame = detail_small_rect;
	detail_info_bg_view.alpha = 0;
	[UIView commitAnimations];
	more.hidden = FALSE;
}

-(IBAction)callButtonPressed:(UIButton *)button {
	if (current_shop_index>=0) {
		NSLog(@"call %@",[[items_data objectAtIndex:current_shop_index] objectForKey:@"tel"]);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[[[items_data objectAtIndex:current_shop_index] objectForKey:@"tel"] stringByReplacingOccurrencesOfString:@" " withString:@""]]]];
	}
}

///////////////////
//MyMapViewDelegate
///////////////////
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	int annotation_id = ((MyAnnotation *)view.annotation).tag;
	NSLog(@"%d",annotation_id);
	offer_title.text = [[items_data objectAtIndex:annotation_id] objectForKey:@"title"];
	offer_description.text = [[items_data objectAtIndex:annotation_id] objectForKey:@"description"];
	[offer_image loadImageWithURL:[[items_data objectAtIndex:annotation_id] objectForKey:@"image"]];
}

@end
