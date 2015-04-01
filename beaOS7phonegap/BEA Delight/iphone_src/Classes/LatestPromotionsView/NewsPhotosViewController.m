//
//  NewsPhotosViewController.m
//  GZDaily
//
//  Created by Algebra Lo on 10年2月4日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsPhotosViewController.h"


@implementation NewsPhotosViewController
@synthesize items_data, news_id;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    scroll_view.frame = CGRectMake(0, 63, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);
    page_control.frame = CGRectMake(0, 424+[[MyScreenUtil me] getScreenHeightAdjust], 320, 36);

	title_label.text = NSLocalizedString(@"Details",nil);
	scroll_view_original_frame = scroll_view.frame;
	NSLog(@"%f",scroll_view.frame.size.width);

    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [self updateContent];
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

-(void)updateContent {
	int i;
	number_of_photos = [[[items_data objectAtIndex:news_id] objectForKey:@"images"] count];
	NSLog(@"number of photos: %d",number_of_photos);
	scroll_view.contentSize = CGSizeMake(320 * number_of_photos, scroll_view.frame.size.height);
	page_control.numberOfPages = number_of_photos;
	page_control.currentPage = 0;
	ZoomImageView *temp_zoom_image_view;
	if (image_list!=nil) {
		[image_list removeAllObjects];
	}
	image_list = [NSMutableArray new];
	for (i=0; i<number_of_photos; i++) {
		temp_zoom_image_view = [[ZoomImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320,  scroll_view.frame.size.height-40)];
		[temp_zoom_image_view loadImageWithURL:[[[items_data objectAtIndex:news_id] objectForKey:@"images"] objectAtIndex:i]];
        NSLog(@"imageUrl is %@", [[[items_data objectAtIndex:news_id] objectForKey:@"images"] objectAtIndex:i]);
		[scroll_view addSubview:temp_zoom_image_view];
		[image_list addObject:temp_zoom_image_view];
	}
}

- (IBAction)changePage:(id)sender {
	NSLog(@"change page");
    int page = page_control.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	/*[self loadScrollViewWithPage:page - 1];
	[self loadScrollViewWithPage:page];
	[self loadScrollViewWithPage:page + 1];*/
    // update the scroll view to the appropriate page
    CGRect frame = scroll_view.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
	scroll_view.contentSize = CGSizeMake(scroll_view_original_frame.size.width * number_of_photos, scroll_view.frame.size.height);
    [scroll_view scrollRectToVisible:frame animated:YES];
	for (int i=0; i<[image_list count]; i++) {
		((UIImageView *)[image_list objectAtIndex:i]).frame = CGRectMake(i*320, 0, 320, scroll_view.frame.size.height-40);
	}
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
}

////////////////////
//Scroll delegate
////////////////////
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
	
	CGFloat pageWidth = 320;
	if ([[CoreData sharedCoreData].OS isEqualToString:@"3"]) {
		scrollView.pagingEnabled = FALSE;
	} else {
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		//NSLog(@"offset %f, page width: %f, frame width:%f, scale: %f, page: %d",scrollView.contentOffset.x, pageWidth, scrollView.frame.size.width, scrollView.zoomScale, page);
		if (page_control.currentPage!=page) {
			page_control.currentPage = page;
			for (int i=0; i<[image_list count]; i++) {
				[[image_list objectAtIndex:i] resetSize];
			}
		}
	}
}

-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	CGFloat pageWidth = 320;
	if ([[CoreData sharedCoreData].OS isEqualToString:@"3"] && !decelerate) {
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//		NSLog(@"1 %d",page);
		[scrollView scrollRectToVisible:CGRectMake(page * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:TRUE];
		if (page_control.currentPage!=page) {
			page_control.currentPage = page;
			for (int i=0; i<[image_list count]; i++) {
				[[image_list objectAtIndex:i] resetSize];
			}
		}
	}
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	CGFloat pageWidth = 320;
	if ([[CoreData sharedCoreData].OS isEqualToString:@"3"]) {
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//		NSLog(@"2 %d",page);
		[scrollView scrollRectToVisible:CGRectMake(page * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:TRUE];
		if (page_control.currentPage!=page) {
			page_control.currentPage = page;
			for (int i=0; i<[image_list count]; i++) {
				[[image_list objectAtIndex:i] resetSize];
			}
		}
	}
}

-(void)setItems_data:(NSArray *)itemsdata setNewsid:(int)newsid{
    items_data = itemsdata;
    news_id = newsid;
}
- (void)dealloc {
    scroll_view.delegate = nil;
	if (image_list!=nil) {
		for (int i=0; i<[image_list count]; i++) {
			[[image_list objectAtIndex:i] removeFromSuperview];
		}
		[image_list removeAllObjects];
		[image_list release];
	}
    [super dealloc];
}


@end
