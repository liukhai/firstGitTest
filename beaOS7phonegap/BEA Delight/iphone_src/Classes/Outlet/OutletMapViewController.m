//
//  OutletMapViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OutletMapViewController.h"


@implementation OutletMapViewController

@synthesize map_view_controller, settingDic, isNeedBox;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        hidden = NO;
        settingDic = [[NSDictionary alloc] init];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
//    content_view.frame = CGRectMake(0, 63, 320, [[MyScreenUtil me] getScreenHeightAdjust]);
     NSLog(@"content_view.frame  : %@",content_view);
	map_view_controller = [[MyMapViewController alloc] initWithNibName:@"MapView" bundle:nil];
	map_view_controller.delegate = self;
    NSLog(@"map_view_controller  : %@",map_view_controller.view);
	[content_view addSubview:map_view_controller.view];
	annotations = [NSMutableArray new];
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
    [self addAnnotations];
    [self setSelectedAnnotationing];
}

- (void)viewWillAppear:(BOOL)animated {
    _settingButton.hidden = hidden;
    _listButton.hidden = hidden;
    [[PageUtil pageUtil] changeImageForTheme:self.view];
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
    [settingDic release];
    [_listButton release];
    [_settingButton release];
    [super dealloc];
}

-(void)addAnnotations {
	int i;
	if (annotations_detail!=nil) {
		[annotations_detail release];
	}
	annotations_detail = [annotationsDetail retain];
	[annotations removeAllObjects];
	for (i=0; i<[annotations_detail count]; i++) {
		NSMutableDictionary *temp_record = [NSMutableDictionary new];
		NSArray *gps = [[[annotationsDetail objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"merchant"] forKey:@"title"];
		[temp_record setValue:@"" forKey:@"subtitle"];
		[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:0] floatValue]] forKey:@"latitude"];
		[temp_record setValue:[NSNumber numberWithFloat:[[gps objectAtIndex:1] floatValue]] forKey:@"longitude"];
		[annotations addObject:temp_record];
	}
	[map_view_controller.map loadAnnotationFromArray:annotations];
    [map_view_controller loadAnnotationsDetailinfo:annotations_detail settingValue:settingDic];
 
}
-(void)addAnnotations:(NSArray *)mannotationsDetail {
	annotationsDetail = [mannotationsDetail retain];
    [self addAnnotations];
    [mannotationsDetail release];
}

-(void)setSelectedAnnotationing{
	if ([annotations count]>index) {
        if (self.isNeedBox) {
            
        }
		[map_view_controller.map setSelectedAnnotation:index Delta:delta isNeedBox:self.isNeedBox];
	}
}
-(void)setSelectedAnnotation:(NSInteger)mindex Delta:(float)mdelta {
    index = mindex;
    delta = mdelta;
}

-(IBAction)shareButtonPressed:(UIButton *)button {
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:NSLocalizedString(@"Share to Friend",nil)];
	[share_prompt setMessage:NSLocalizedString(@"Share App with Friends by Email",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"OK",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Cancel",nil)];
	
	
	/*	CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 100.0);
	 [login_prompt setTransform: moveUp];*/
	[share_prompt show];
	[share_prompt release];
}

-(IBAction)bookmarkButtonPressed:(UIButton *)button {
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	//NSLog(@"tag: %d",((MyAnnotation *)view.annotation).tag);
	if (![[NSString stringWithFormat:@"%@",[[self.navigationController.viewControllers objectAtIndex:1] class]] isEqualToString:@"NearBySearchListViewController"]) {
		[self.navigationController popViewControllerAnimated:TRUE];
	} else {
		NSLog(@"%d",[self.navigationController.viewControllers count]);
		if ([self.navigationController.viewControllers count]==3) {
			[self.navigationController popViewControllerAnimated:FALSE];
			[(NearBySearchListViewController *)[self.navigationController.viewControllers objectAtIndex:1] selectMerchant:((MyAnnotation *)view.annotation).tag];
		} else {
			[self.navigationController popViewControllerAnimated:TRUE];
		}

	}

}
- (IBAction)listButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)settingButtonPressed:(id)sender {
    
    NearBySearchListViewController *current_view_controller;
	current_view_controller = [[NearBySearchListViewController alloc] initWithNibName:@"NearBySearchListView" bundle:nil];
    current_view_controller.useInMap = YES;
    current_view_controller.outletMapVC = self;
    [current_view_controller viewDidLoad];
    [current_view_controller settingButtonPressed:nil];
    [current_view_controller.setting_view removeFromSuperview];
    //	[current_view_controller release];
    //    CGRect frame = current_view_controller.setting_view.frame;
    [self.view addSubview:current_view_controller.setting_view];
    
    
}

- (void)hiddenButton:(BOOL)ishidden {
    hidden = ishidden;
}
@end
