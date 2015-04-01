#import "NewBranchOutletMapViewController.h"
#import "ATMMyAnnotation.h"
#import "Bookmark.h"

@implementation NewBranchOutletMapViewController

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
	NSLog(@"NewBranchOutletMapViewController viewDidLoad");
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 64, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    content_view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);

	map_view_controller = [[ATMMyMapViewController alloc] initWithNibName:@"ATMMapView" bundle:nil];
	map_view_controller.delegate = self;
	[content_view addSubview:map_view_controller.view];
	annotations = [NSMutableArray new];
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
	[annotations removeAllObjects];
	[annotations release];
	if (annotations_detail!=nil) {
		[annotations_detail release];
	}
    [super dealloc];
}

-(void)addAnnotations:(NSArray *)annotationsDetail {
	int i;
	if (annotations_detail!=nil) {
		[annotations_detail release];
	}
	annotations_detail = [annotationsDetail retain];
	[annotations removeAllObjects];
	for (i=0; i<[annotations_detail count]; i++) {
		NSMutableDictionary *temp_record = [NSMutableDictionary new];
		NSArray *gps = [[[annotationsDetail objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"title"] forKey:@"title"];
		[temp_record setValue:@"" forKey:@"subtitle"];
		[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:0] floatValue]] forKey:@"latitude"];
		[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:1] floatValue]] forKey:@"longitude"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"address"] forKey:@"address"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"tel"] forKey:@"tel"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"remark"] forKey:@"remark"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"newtopitem"] forKey:@"newtopitem"];
		[annotations addObject:temp_record];
        [temp_record release];
	}
	NSLog(@"NewBranchOutletMapViewController annotationsDetail:%d", [annotations count]);
	[map_view_controller.map loadAnnotationFromArray:annotations];
}

-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta; {
	if ([annotations count]>index) {
		[map_view_controller.map setSelectedAnnotation:index Delta:delta];
		NSLog(@"NewBranchOutletMapViewController setSelectedAnnotation done [map_view_controller.map setSelectedAnnotation:index Delta:delta]:%f", delta);
		
	}
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	NSLog(@"NewBranchOutletMapViewController calloutAccessoryControlTapped view:%@ control:%@", view, control);

	my_id = ((ATMMyAnnotation *)view.annotation).my_id;
	NSLog(@"NewBranchOutletMapViewController calloutAccessoryControlTapped my_id:%@", my_id);
	
	NSString * message = [NSString stringWithFormat:@"%@\n%@\n%@",
						  ((ATMMyAnnotation *)view.annotation).address,
						  ((ATMMyAnnotation *)view.annotation).remark,
						  ((ATMMyAnnotation *)view.annotation).tel];
	
	NSString* ls_tel = ((ATMMyAnnotation *)view.annotation).tel;
	NSLog(@"NewBranchOutletMapViewController calloutAccessoryControlTapped ls_tel:%@", ls_tel);
	
	if([ls_tel length]<1 || NSOrderedSame == [ls_tel compare:@"NULL"]){
	}else {
		message = [message stringByAppendingFormat:@"\n%@: %@", NSLocalizedString(@"Tel",nil), ls_tel];
	}
	
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:((MyAnnotation *)view.annotation).title];
	[share_prompt setMessage:message];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Cancel",nil)];
	[share_prompt show];
	[share_prompt release];

}

@end
