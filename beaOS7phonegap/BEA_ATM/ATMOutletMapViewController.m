//
//  ATMOutletMapViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMOutletMapViewController.h"
#import "ATMMyAnnotation.h"
#import "Bookmark.h"
#import "ATMNearBySearchDistCMSViewController.h"

@implementation ATMOutletMapViewController

@synthesize btnBookmark;
//@synthesize calloutAnnotation;
//@synthesize selectedAnnotationView = _selectedAnnotationView;
@synthesize btnList, btnSetting, lbTitle;
@synthesize map_view_controller;
@synthesize content_view;
@synthesize sorted_items_data, toDelta, toIndex;
@synthesize menuID, titleText, annotations, favouriteIndex, isNeedBox;
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
     sorted_items_data = [[NSMutableArray alloc] init];
     annotations = [[NSMutableArray alloc] init];
 }
 return self;
 }

- (void) hideBookmark
{
    [btnBookmark setHidden:YES];
}

- (void)setViewControllerPushType:(NSInteger)type {
    pushType = type;
}

- (void) setAccessibility {
    btnBookmark.accessibilityLabel = NSLocalizedString(@"Bookmark", nil);
    btnList.accessibilityLabel = NSLocalizedString(@"tag_list", nil);
    btnSetting.accessibilityLabel = NSLocalizedString(@"tag_moremenu_settings", nil);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [lbTitle setText:titleText];
    if ([titleText isEqualToString:NSLocalizedString(@"ATM_Nearby", nil)]) {
        [btnSearch setTitle:NSLocalizedString(@"Search", nil) forState:UIControlStateNormal];
    }
    else {
        [btnSearch setTitle:NSLocalizedString(@"ATM_Nearby", nil) forState:UIControlStateNormal];
    }
    
    [self setAccessibility];
    
//    [btnSearch setTitle:NSLocalizedString(@"Nearby", nil) forState:UIControlStateNormal];
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    content_view.frame = CGRectMake(0, 63, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);
    
	map_view_controller = [[ATMMyMapViewController alloc] initWithNibName:@"ATMMapView" bundle:nil];
	map_view_controller.delegate = self;
    map_view_controller.callerVC = self;
	[content_view addSubview:map_view_controller.view];
	
    if (pushType == 1) {
        btnBookmark.hidden = YES;
        btnSetting.hidden = YES;
        btnList.hidden = YES;
        btnBookmark.superview.hidden = YES;
        self.map_view_controller.map.showsUserLocation = NO;
        [self addAnnotationsM:annotationsDetail];
        [self setSelectedAnnotation:favouriteIndex Delta:0.005 annotations:annotationsDetail];
        RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
        v_rmvc.rmUtil.caller = self;
        
        [self.view addSubview:v_rmvc.contentView];
        
        [v_rmvc.rmUtil setNav:self.navigationController];
        [self initSearch];
        CGRect frame = content_view.frame;
        frame.origin.y -= 10;
        frame.size.height += 31;
        content_view.frame = frame;
    //    [self startLocationFromFavouritetoMenuID:menuID];
    }
    else {
        if ([titleText isEqualToString:NSLocalizedString(@"Search", nil)]) {
            RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
            v_rmvc.rmUtil.caller = self;
            
            [self.view addSubview:v_rmvc.contentView];
            
            [v_rmvc.rmUtil setNav:self.navigationController];
            [self initSearch];
            CGRect frame = content_view.frame;
            frame.origin.y -= 10;
            frame.size.height += 31;
            content_view.frame = frame;
        }else{
            RotateMenu2ViewController* v_rmvc = [[[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil] autorelease];
            v_rmvc.rmUtil.caller = self;
            
            [self.view addSubview:v_rmvc.contentView];
            NSArray *a_texts = [NSLocalizedString(@"rotatemenu.atmsearch.texts",nil) componentsSeparatedByString:@","];
            NSLog(@"v_rmvc.rmUtil setTextArray:%@",a_texts);
            [v_rmvc.rmUtil setTextArray:a_texts];
            
            UIView* view_temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            NSArray* a_views = [NSArray arrayWithObjects:view_temp , view_temp, view_temp,view_temp, nil];
            [v_rmvc.rmUtil setViewArray:a_views];
            
            [v_rmvc.rmUtil setNav:self.navigationController];
            
            [v_rmvc.rmUtil showMenu:menuID];
        }
        
        NSLog(@"debug ATMOutletMapViewController viewDidLoad self.view:%@", self.view);
        NSLog(@"debug ATMOutletMapViewController viewDidLoad content_view:%@", content_view);
        [self addAnnotationsM:sorted_items_data];
        NSLog(@"ATMNearBySearchListViewController didSelectRowAtIndexPath:%@", sorted_items_data);
        [self setSelectedAnnotation:toIndex Delta:toDelta];
    }
//    if (pushType == 1) {
//        bookmark.hidden = YES;
//        [self setMenuBar1];
//        CGRect frame1 = scroll_view.frame;
//        frame1.origin.y -= 31;
//        frame1.size.height += 31;
//        scroll_view.frame = frame1;
//        CGRect frame2 = merchant.frame;
//        frame2.origin.y -= 31;
//        merchant.frame = frame2;
//    }
//    else {
//        if ([[CoreData sharedCoreData].menuType isEqualToString:@"2"]) {
//            [self setMenuBar2];
//        } else {
//            [self setMenuBar1];
//        }
//    }
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

//- (void)viewDidAppear:(BOOL)animated {
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        self.view.frame = CGRectMake(0.0, 0.0, 320, [MyScreenUtil me].getScreenHeight_IOS7_20);
//    }
//}

-(void) initSearch{
    //    btnBookmark.hidden = YES;
    CGRect newFrame = btnSetting.frame;
    btnBookmark.frame = newFrame;
    btnSetting.hidden = YES;
    btnList.hidden = YES;
    CGRect frame=self.headview.frame;
    frame.origin.y = 48;
    self.headview.frame = frame;
    
    self.greybarImg.hidden = YES;
    lbTitle.hidden = YES;
    self.blowView.hidden = YES;
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

-(void)showMenu:(int)show
{
    NSLog(@"showMenu in:%@", self);
    
    if (show%4==0) {
        [self ATMButtonPressed:nil];
    } else if (show%4==1) {
        [self SupremeGoldButtonPressed:nil];
    } else if (show%4==2) {
        [self iFinancialButtonPressed:nil];
    } else if (show%4==3) {
        [self BranchButtonPressed:nil];
    }
    onceClicked = 2;
}

- (void)startLocationFromFavouritetoMenuID:(NSInteger)menuId {
    if (self.map_view_controller) {
        NSLog(@"FFF");
        return ;
    }
    //    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    //    mapView.showsUserLocation = YES;
    //
    //    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    //    locationManager.delegate = self;
    ////    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    ////    locationManager.distanceFilter = 1000.0f;
    // //   [locationManager startUpdatingLocation];
    //
    //    MKCoordinateSpan theSpan;
    //    theSpan.latitudeDelta = 0.025;
    //    theSpan.longitudeDelta = 0.025;
    //    MKCoordinateRegion theRegion;
    //    theRegion.center = [[locationManager location] coordinate];
    //    theRegion.span = theSpan;
    //    [mapView setRegion:theRegion];
    //    [self.view addSubview:mapView];

    
    
    
    if (self.map_view_controller.map) {
        [self.map_view_controller.map removeAnnotations:self.map_view_controller.map.annotations];
        // [sorted_items_data removeAllObjects];
    }
//    ATMNearBySearchListViewController *current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
//    current_view_controller.useInMap = YES;
//    current_view_controller.outletMapVC = self;
//    current_view_controller.isFromOutletMapVC = YES;
//    [current_view_controller showMenu:menuId];
//    menuID = menuId;
//    self.map_view_controller.map addAnnotation:

}
-(IBAction)SupremeGoldButtonPressed:(UIButton *)button
{
	NSLog(@"ATMOutletMapViewController SupremeGoldButtonPressed:%@", button);
    if (onceClicked == 2) {
        if (menuID == 1) {
            [[CoreData sharedCoreData].mask showMask];
            [self performSelector:@selector(hiddenMask) withObject:nil afterDelay:0.5];
        }
        else {
            if (self.map_view_controller.map) {
                [self.map_view_controller.map removeAnnotations:self.map_view_controller.map.annotations];
               // [sorted_items_data removeAllObjects];
            }
            ATMNearBySearchListViewController *current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
            current_view_controller.useInMap = YES;
            current_view_controller.outletMapVC = self;
            current_view_controller.isFromOutletMapVC = YES;
            [current_view_controller showMenu:1];
            menuID = 1;
        }
    }
//	[self startToGetNearBy];
}

- (void)hiddenMask {
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(IBAction)ATMButtonPressed:(UIButton *)button
{
	NSLog(@"ATMOutletMapViewController ATMButtonPressed:%@", button);
    if (onceClicked == 2) {
        if (menuID == 0) {
            [[CoreData sharedCoreData].mask showMask];
            [self performSelector:@selector(hiddenMask) withObject:nil afterDelay:0.5];
        }
        else {
            if (self.map_view_controller.map) {
                [self.map_view_controller.map removeAnnotations:self.map_view_controller.map.annotations];
                [sorted_items_data removeAllObjects];
            }

            ATMNearBySearchListViewController *current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
            current_view_controller.useInMap = YES;
            current_view_controller.outletMapVC = self;
            current_view_controller.isFromOutletMapVC = YES;
            [current_view_controller showMenu:0];
            menuID = 0;
        }
    }
//	[self startToGetNearBy];
}

-(IBAction)BranchButtonPressed:(UIButton *)button
{
    
	NSLog(@"ATMOutletMapViewController BranchButtonPressed:%@", button);
    if (onceClicked == 2) {
        if (menuID == 3) {
            [[CoreData sharedCoreData].mask showMask];
            [self performSelector:@selector(hiddenMask) withObject:nil afterDelay:0.5];
        }
        else {
            if (self.map_view_controller.map) {
                [self.map_view_controller.map removeAnnotations:self.map_view_controller.map.annotations];
                [sorted_items_data removeAllObjects];
            }
            ATMNearBySearchListViewController *current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
            current_view_controller.useInMap = YES;
            current_view_controller.outletMapVC = self;
            current_view_controller.isFromOutletMapVC = YES;
            [current_view_controller showMenu:3];
            menuID = 3;
        }
    }
}

-(IBAction)iFinancialButtonPressed:(UIButton *)button
{
	NSLog(@"ATMOutletMapViewController iFinancialButtonPressed:%@", button);
    //	[supremegoldbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    //	[atmbutton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    //	[branchbutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    //	current_category = @"B";
    //	current_category = @"3";
    if (onceClicked == 2) {
        if (menuID == 2) {
            [[CoreData sharedCoreData].mask showMask];
            [self performSelector:@selector(hiddenMask) withObject:nil afterDelay:0.5];
        }
        else {
            ATMNearBySearchListViewController *current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
            current_view_controller.useInMap = YES;
            current_view_controller.outletMapVC = self;
            current_view_controller.isFromOutletMapVC = YES;
            [current_view_controller viewDidLoad];
            [current_view_controller showMenu:2];
            menuID = 2;
        }
    }
}

- (void) startToGetNearBy{
	NSLog(@"ATMOutletMapViewController startToGetNearBy");
    
//    	locmgr = nil;
//    	user_location = nil;
//    	sorted_items_data = nil;
//    	items_data = nil;
//    	if (sorted_items_data!=nil) {
//    		[sorted_items_data removeAllObjects];
//    	}
//    	if (items_data!=nil) {
//    		[items_data removeAllObjects];
//    	}
//    	locmgr = [[CLLocationManager alloc] init];
//    	locmgr.delegate = self;
//        if ([CLLocationManager locationServicesEnabled]) {
//            //	if (locmgr.locationServicesEnabled) {
//    		[locmgr startUpdatingLocation];
//    		[[CoreData sharedCoreData].mask showMask];
//    	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillDisappear:(BOOL)animated {
    NSDictionary *dataDic;
    NSString *menuIDStr = [NSString stringWithFormat:@"%d", menuID];
    if (!annotations_detail) {
        dataDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"data", menuIDStr, @"type", nil];
    }else {
        dataDic = [NSDictionary dictionaryWithObjectsAndKeys:annotations_detail,@"data", menuIDStr, @"type", nil];
    }
    if (_isNear) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"fromOuterMapToNearbyList" object:dataDic];
        [self.delegate initSortedItemsData:dataDic];
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload {
    [self setBlowView:nil];
    [self setGreybarImg:nil];
    [self setHeadview:nil];
    [self setLbTitle:nil];
    [self setBtnSetting:nil];
    [self setBtnList:nil];
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[annotations removeAllObjects];
	[annotations release];
	if (annotations_detail!=nil) {
		[annotations_detail release];
	}
    [btnList release];
    [btnSetting release];
    [lbTitle release];
    [sorted_items_data release];
    [_headview release];
    [_greybarImg release];
    [_blowView release];
    [super dealloc];
}

-(void)fixspace:(NSMutableDictionary*)dic key:(NSString*)akey
{
    NSString* value=[dic objectForKey:akey];
    //    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (value == nil){
        value = @"";
    }
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    //    if ([akey isEqualToString:@"icon"]) {
    //        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    //    }
    //    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}

-(void)addAnnotationsing{
    int i;
	if (annotations_detail!=nil) {
		[annotations_detail release];
	}
	annotations_detail = [annotationsDetail retain];
	[annotations removeAllObjects];
    NSLog(@"debug ATMOutletMapViewController addAnnotationsing annotationsDetail:%@", annotationsDetail);
    
	for (i=0; i<[annotations_detail count]; i++) {
		NSMutableDictionary *temp_record = [NSMutableDictionary new];
        //		NSArray *gps = [[[annotationsDetail objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"branch"] forKey:@"title"];
		[temp_record setValue:@"" forKey:@"subtitle"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"lat"] forKey:@"latitude"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"lon"] forKey:@"longitude"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"address"] forKey:@"address"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"tel"] forKey:@"tel"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"opeinghour"] forKey:@"remark"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
		[temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"iconshow"] forKey:@"newtopitem"];
        [temp_record setValue:[[annotationsDetail objectAtIndex:i] objectForKey:@"fax"] forKey:@"fax"];
        
        [self fixspace:temp_record key:@"title"];
        [self fixspace:temp_record key:@"latitude"];
        [self fixspace:temp_record key:@"longitude"];
        [self fixspace:temp_record key:@"address"];
        [self fixspace:temp_record key:@"tel"];
        //        [self fixspace:temp_record key:@"remark"];
        [self fixspace:temp_record key:@"id"];
        [self fixspace:temp_record key:@"newtopitem"];
        [self fixspace:temp_record key:@"fax"];
		
        [annotations addObject:temp_record];
        [temp_record release];
	}
	NSLog(@"debug ATMOutletMapViewController addAnnotationsing :%d", [annotations count]);
    NSLog(@"debug ATMOutletMapViewController addAnnotationsing end:%@", annotations);
	[map_view_controller.map loadAnnotationFromArray:annotations];
    
}

-(void)setSelectedAnnotationing{
    if ([annotations count]>index) {
		[map_view_controller.map setSelectedAnnotation:index Delta:delta];
		
	} else {
        map_view_controller.map.noItem = @"YES";
        NSLog(@"debug ATMOutletMapViewController setSelectedAnnotation:%@", map_view_controller.map.noItem);
        [map_view_controller.map updateHeading];
    }
    
    NSLog(@"ATMOutletMapViewController setSelectedAnnotationing:%d--%f--%d", index, delta, [annotations count]);
}
//-(void)setSelectedAnnotation:(NSInteger)mindex Delta:(float)mdelta {
//    index = mindex;
//    delta = mdelta;
//}
-(void)addAnnotations:(NSArray *)mannotationsDetail {
	annotationsDetail = [mannotationsDetail retain];
}

-(void)addAnnotationsM:(NSArray *)newAnnotationsDetail {
	int i;
	if (annotations_detail!=nil) {
		[annotations_detail release];
	}
    if ([newAnnotationsDetail count] == 0) {
        return ;
    }
	annotations_detail = [newAnnotationsDetail retain];
	[annotations removeAllObjects];
    NSLog(@"debug ATMOutletMapViewController addAnnotationsM begin:%@", annotationsDetail);
    
	for (i=0; i<[annotations_detail count]; i++) {
		NSMutableDictionary *temp_record = [NSMutableDictionary new];
        //		NSArray *gps = [[[annotationsDetail objectAtIndex:i] objectForKey:@"gps"] componentsSeparatedByString:@","];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"branch"] forKey:@"title"];
		[temp_record setValue:@"" forKey:@"subtitle"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"lat"] forKey:@"latitude"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"lon"] forKey:@"longitude"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"address"] forKey:@"address"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"tel"] forKey:@"tel"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"opeinghour"] forKey:@"remark"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"id"] forKey:@"id"];
		[temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"iconshow"] forKey:@"newtopitem"];
        [temp_record setValue:[[newAnnotationsDetail objectAtIndex:i] objectForKey:@"fax"] forKey:@"fax"];
        
        [self fixspace:temp_record key:@"title"];
        [self fixspace:temp_record key:@"latitude"];
        [self fixspace:temp_record key:@"longitude"];
        [self fixspace:temp_record key:@"address"];
        [self fixspace:temp_record key:@"tel"];
     //   [self fixspace:temp_record key:@"remark"];
        [self fixspace:temp_record key:@"id"];
        [self fixspace:temp_record key:@"newtopitem"];
		[self fixspace:temp_record key:@"fax"];
        
        [annotations addObject:temp_record];
        [temp_record release];
	}
	NSLog(@"debug ATMOutletMapViewController addAnnotationsM:%d", [annotations count]);
    NSLog(@"debug ATMOutletMapViewController addAnnotationsM end:%@", annotations);
	[map_view_controller.map loadAnnotationFromArray:annotations];
    [newAnnotationsDetail release];
}

//-(void)setSelectedAnnotationPush:(NSInteger)mindex Delta:(float)mdelta {
//    index = mindex;
//    delta = mdelta;
//}

-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta fromFavouriteAnnotationsArr:(NSArray *)annotationsArr {
    
	if ([annotationsArr count]>index) {
		[map_view_controller.map setSelectedAnnotation:index Delta:delta];
	} else {
        map_view_controller.map.noItem = @"YES";
        [map_view_controller.map updateHeading];
    }

}

-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta {

	if ([annotations count]>index) {
		[map_view_controller.map setSelectedAnnotation:index Delta:delta isNeedBox:self.isNeedBox];
        if (!self.isNeedBox) {
            btnBookmark.hidden = YES;
        }
		NSLog(@"ATMOutletMapViewController setSelectedAnnotation:%d--%f", index, delta);
		
	} else {
        btnBookmark.hidden = YES;
        map_view_controller.map.noItem = @"YES";
        [map_view_controller.map updateHeading];
    }
    
    NSLog(@"debug ATMOutletMapViewController setSelectedAnnotation:%@--%d", map_view_controller.map.noItem, [annotations count]);
}

-(void)setSelectedAnnotation:(NSInteger)index Delta:(float)delta annotations:(NSArray *)annotationsArr{
    annotations = [NSMutableArray arrayWithArray:annotationsArr];
	if ([annotations count]>index) {
		[map_view_controller.map setSelectedAnnotation:index Delta:delta];
		NSLog(@"ATMOutletMapViewController setSelectedAnnotation:%d--%f", index, delta);
		
	} else {
        map_view_controller.map.noItem = @"YES";
        [map_view_controller.map updateHeading];
    }

    NSLog(@"debug ATMOutletMapViewController setSelectedAnnotation:%@--%d", map_view_controller.map.noItem, [annotations count]);
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

-(void) setBookmarkButton:(NSString*)a_id
{
    //    my_id = map_view_controller.cur_id;
    a_id = [a_id stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    a_id = [a_id stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    a_id = [a_id stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	NSLog(@"debug ATMOutletMapViewController setBookmarkButton:%@--%@", self, a_id);
    [btnBookmark setHidden:NO];
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSDictionary* merchant_info = [NSDictionary dictionaryWithObjectsAndKeys:a_id, @"id", nil];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([pageTheme isEqualToString:@"1"]) {
        if ([bookmark_data isOfferExist:merchant_info InGroup:0]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
        }
    } else {
        if ([bookmark_data isOfferExist:merchant_info InGroup:0]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        } else {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
        }
    }
    [bookmark_data release];
    
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	NSLog(@"ATMOutletMapViewController calloutAccessoryControlTapped view:%@ control:%@", view, control);
	//	if (![[NSString stringWithFormat:@"%@",[[self.navigationController.viewControllers objectAtIndex:1] class]] isEqualToString:@"ATMNearBySearchListViewController"]) {
	//		[self.navigationController popViewControllerAnimated:TRUE];
	//	} else {
	//		NSLog(@"ATMOutletMapViewController calloutAccessoryControlTapped 2:%d - %@",[self.navigationController.viewControllers count], view.annotation);
	
	my_id = ((ATMMyAnnotation *)view.annotation).my_id;
	NSLog(@"ATMOutletMapViewController calloutAccessoryControlTapped my_id:%@", my_id);
	
    //	NSString * message = [NSString stringWithFormat:@"%@\n%@\n%@",
    //						  ((ATMMyAnnotation *)view.annotation).address,
    //						  ((ATMMyAnnotation *)view.annotation).remark,
    //						  ((ATMMyAnnotation *)view.annotation).tel];
	NSString * message = [NSString stringWithFormat:@"%@\n%@",
						  ((ATMMyAnnotation *)view.annotation).address,
						  ((ATMMyAnnotation *)view.annotation).remark];
	
	NSString* ls_tel = ((ATMMyAnnotation *)view.annotation).tel;
	NSLog(@"ATMOutletMapViewController calloutAccessoryControlTapped ls_tel:%@", ls_tel);
	
	if([ls_tel length]<1 || NSOrderedSame == [ls_tel compare:@"NULL"]){
	}else {
		message = [message stringByAppendingFormat:@"\n%@: %@", NSLocalizedString(@"Tel",nil), ls_tel];
	}
	
	UIAlertView *share_prompt = [[[UIAlertView alloc] init] retain];
	[share_prompt setDelegate:self];
	[share_prompt setTitle:((MyAnnotation *)view.annotation).title];
	[share_prompt setMessage:message];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"ATM - Add to Bookmark",nil)];
	//		[share_prompt addButtonWithTitle:NSLocalizedString(@"OK",nil)];
	[share_prompt addButtonWithTitle:NSLocalizedString(@"Cancel",nil)];
	[share_prompt show];
	[share_prompt release];
	
	//		if ([self.navigationController.viewControllers count]==3) {
	//			[self.navigationController popViewControllerAnimated:TRUE];
	//			[(ATMNearBySearchListViewController *)[self.navigationController.viewControllers objectAtIndex:1] selectMerchant:((MyAnnotation *)view.annotation).tag];
	//		} else {
	//			[self.navigationController popViewControllerAnimated:TRUE];
	//		}
	
	//	}
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"debug ATMOutletMapViewController clickedButtonAtIndex:%d--%@", buttonIndex, my_id);
    
	if (buttonIndex==0) {
		Bookmark *bookmark_data = [[Bookmark alloc] init];
		
		NSDictionary* merchant_info = [NSDictionary dictionaryWithObjectsAndKeys:my_id, @"id", nil];
		[bookmark_data addBookmark:merchant_info ToGroup:0];
		[bookmark_data release];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
}

- (IBAction)bookmarkButtonPress:(id)sender {
    my_id = map_view_controller.cur_id;
    my_id = [my_id stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    my_id = [my_id stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
	NSLog(@"debug ATMOutletMapViewController bookmarkButtonPress:%@--%@", sender, my_id);
    
    Bookmark *bookmark_data = [[Bookmark alloc] init];
    NSDictionary* merchant_info = [NSDictionary dictionaryWithObjectsAndKeys:my_id, @"id", nil];
    NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
    if ([bookmark_data isOfferExist:merchant_info InGroup:0]) {
        [bookmark_data removeBookmark:merchant_info InGroup:0];
        if ([pageTheme isEqualToString: @"1"]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark.png"] forState:UIControlStateNormal];
        } else {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Delete from Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    } else {
        [bookmark_data addBookmark:merchant_info ToGroup:0];
        if ([pageTheme isEqualToString:@"1"]) {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on.png"] forState:UIControlStateNormal];
        } else {
            [btnBookmark setBackgroundImage:[UIImage imageNamed:@"btn_bookmark_on_new.png"] forState:UIControlStateNormal];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Added to Favourite",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"Back",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
    [bookmark_data release];
}

- (IBAction)listButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)settingButtonPressed:(id)sender {
    
    ATMNearBySearchListViewController *current_view_controller;
	current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
    current_view_controller.menuID = menuID;
    current_view_controller.useInMap = YES;
    current_view_controller.outletMapVC = self;
    current_view_controller.isFromOutletMapVC = YES;
    [current_view_controller viewDidLoad];
    [current_view_controller settingButtonPressed:nil];
    [current_view_controller.setting_view removeFromSuperview];
    //	[current_view_controller release];
    //    CGRect frame = current_view_controller.setting_view.frame;
    [self.view addSubview:current_view_controller.setting_view];
}

-(IBAction)searchButtonPressed:(UIButton *)button
{
    if ([btnSearch.titleLabel.text isEqualToString:NSLocalizedString(@"Search", nil)]) {
        _isNear = NO;
        ATMNearBySearchDistCMSViewController* current_view_controller = [[ATMNearBySearchDistCMSViewController alloc] initWithNibName:@"ATMNearBySearchDistCMSView" bundle:nil];
        current_view_controller.menuID = menuID;

        [self.navigationController pushViewController:current_view_controller animated:TRUE];
        [current_view_controller release];
    }else{
        _isNear = YES;
        ATMNearBySearchListViewController* current_view_controller = [[ATMNearBySearchListViewController alloc] initWithNibName:@"ATMNearBySearchListView" bundle:nil];
        self.delegate = current_view_controller;
        current_view_controller.menuID = menuID;
        [self.navigationController pushViewController:current_view_controller animated:TRUE];
        [current_view_controller release];
    }
}
@end
