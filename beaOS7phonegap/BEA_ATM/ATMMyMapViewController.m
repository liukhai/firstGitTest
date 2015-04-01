//  Created by Algebra Lo on 10年1月22日.
//  Amended by jasen on 201309

#import "MyScreenUtil.h"

#import "CustomAnnotationView.h"
#import "CalloutMapAnnotation.h"

#import "ATMMyMapViewController.h"
#import "CalloutContentView.h"

#define CheckDistancePeriod	1
#define UseStandardPin		TRUE
#define HaveMoreButton		TRUE
#define ConteneViewTag      1234

@implementation ATMMyMapViewController
@synthesize map, delegate;

@synthesize calloutAnnotation = _calloutAnnotation;
@synthesize selectedAnnotationView = _selectedAnnotationView;

@synthesize cur_id;
@synthesize callerVC;

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
	NSLog(@"ATMMyMapViewController viewDidLoad");
    [super viewDidLoad];
    
    //    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.map.delegate = self;
    
	[self.map reset];
	[self.map updateHeading];
    self.map.userLocation.title = NSLocalizedString(@"userLocation_title", nil);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doClose:)];
    [self.map addGestureRecognizer:tapGesture];
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
	NSLog(@"ATMMyMapViewController dealloc");
    [super dealloc];
}

-(void)loadAnnonationsFromPlist:(NSString *)path {
	[map loadAnnotationFromPlist:path];
}

/////////////////////
//MKMapView delegate
/////////////////////

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    NSLog(@"didSelectAnnotationView view.annotation:%@", view.annotation);
	if ([view.annotation isKindOfClass:[ATMMyAnnotation class]]) {
        [view.superview bringSubviewToFront:view];
        //        self.calloutAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude
        //                                                                   andLongitude:view.annotation.coordinate.longitude];
        //        self.calloutAnnotation.title = ((ATMMyAnnotation*)view.annotation).title;
        //        self.calloutAnnotation.address = ((ATMMyAnnotation*)view.annotation).address;
        //        self.calloutAnnotation.remark = ((ATMMyAnnotation*)view.annotation).remark;
        //        self.calloutAnnotation.my_id = ((ATMMyAnnotation*)view.annotation).my_id;
        //        self.calloutAnnotation.tel = ((ATMMyAnnotation*)view.annotation).tel;
        //		[self.map addAnnotation:self.calloutAnnotation];
        self.selectedAnnotationView = view;
        //
        //        NSLog(@"didSelectAnnotationView addAnnotation:%@", self.calloutAnnotation);
        self.calloutAnnotation = view.annotation;
        self.cur_id = ((ATMMyAnnotation*)view.annotation).my_id;
        [callerVC setBookmarkButton:((ATMMyAnnotation*)view.annotation).my_id];
        self.map.clickable = NO;
//        CalloutMapContentViewController *contentVC = [[CalloutMapContentViewController alloc] initWithNibName:@"CalloutMapContentViewController" bundle:nil];
//        CalloutMapAnnotation *mapItem = (CalloutMapAnnotation *)view.annotation;
//        contentVC.strTitle = mapItem.title;
//        if ([mapItem isKindOfClass:[ATMMyAnnotation class]]) {
//            contentVC.strAddress = mapItem.address;
//            contentVC.strService = mapItem.remark;
//            contentVC.strTel = mapItem.tel;
//            [contentVC setText4ATM];
//        } else if ([mapItem isKindOfClass:[MyAnnotation class]]) {
//            [contentVC setText4CreditCard];
//        }
//        CGRect frame = contentVC.viewContent.frame;
//        frame.origin.x = view.frame.origin.x;
//        frame.origin.y = view.frame.origin.y;
//        contentVC.viewContent.frame = frame;
//        contentVC.viewContent.tag = ConteneViewTag;
//        [self.view addSubview:contentVC.viewContent];
//        [contentVC release];

        CalloutContentView *contentView = [[CalloutContentView alloc] init];
        contentView.contentVC = ((CustomAnnotationView *)view).contentVC;
        CGRect frame = view.frame;
        contentView.frame = frame;
        contentView.tag = ConteneViewTag;
        [self.view addSubview:contentView];
        [self moveContentView];
       
    }
    //    NSLog(@"didSelectAnnotationView view.annotation 2:%@", view.annotation);
    //    NSLog(@"didSelectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation);
    //    NSLog(@"didSelectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation.my_id);
    //    NSLog(@"didSelectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation.title);
    //    NSLog(@"didSelectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation.address);
    //    NSLog(@"didSelectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation.remark);
    //    NSLog(@"didSelectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation.tel);
    //    self.cur_id = self.calloutAnnotation.my_id;
    //	[self.map setCenterCoordinate:self.calloutAnnotation.coordinate Delta:0.01];
    
	[self.map setCenterCoordinate:view.annotation.coordinate Delta:0.005];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    //	if (self.calloutAnnotation){
    //		[self.map removeAnnotation: self.calloutAnnotation];//debug 20130915
    //	}
    NSLog(@"debug didDeselectAnnotationView view.annotation:%@", view.annotation);
    //    NSLog(@"didDeselectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation);
    [[callerVC btnBookmark] setHidden:YES];
//    [self removeContentView];
}

//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//    //    NSLog(@"viewForAnnotation annotation:%@", annotation);
//    //    NSLog(@"viewForAnnotation self.calloutAnnotation:%@", self.calloutAnnotation);
//	if (annotation==mapView.userLocation) {
//        MKAnnotationView *view;
//		view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"blueDot"];
//		if (view!=nil) {
//			view.annotation = annotation;
//		}
//        view.canShowCallout = NO;
//
//        return view;
//	} else {
////	} else if (annotation == self.calloutAnnotation) {
//        static NSString *CustomAnnotationViewIdentifier = @"CustomAnnotationViewIdentifier";
//
//        CustomAnnotationView *annotationView = nil;
////        annotationView = (CustomAnnotationView *) [self.map dequeueReusableAnnotationViewWithIdentifier:CustomAnnotationViewIdentifier];
//
////        if (annotationView == nil) {
//            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:CustomAnnotationViewIdentifier];
////        }
//
//        NSLog(@"viewForAnnotation annotationView:%@", annotationView);
//        [annotationView.superview bringSubviewToFront:annotationView];
//
//        annotationView.canShowCallout = NO;
//
//        return annotationView;
////	} else {
////        MKAnnotationView *view;
////
////        view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"regularPin"];
////        if (view==nil) {
////            view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"regularPin"];
////        }
////
////		view.canShowCallout = YES;
////
////        return view;
//
//    }
//
//    NSLog(@"viewForAnnotation annotation nil:%@", nil);
//
//	return nil;
//}
//

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    [self performSelector:@selector(bringSelectView) withObject:nil afterDelay:0.0];
	if (annotation==mapView.userLocation) {
        MKAnnotationView *view;
		view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"blueDot"];
		if (view!=nil) {
			view.annotation = annotation;
		}
        view.canShowCallout = NO;
        
        return view;
	} else {
        
  //      CustomAnnotationView *annView =
  //      (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier: @"pin"];
 //       if (annView == nil)
//        {
           CustomAnnotationView  *annView = [[[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                        reuseIdentifier:@"pin"] autorelease];
            annView.delegate = self;
            NSLog(@"debug mymapviewc viewForAnnotation 1:%f--%f--%f--%f",
                  annView.frame.origin.x,
                  annView.frame.origin.y,
                  annView.frame.size.width,
                  annView.frame.size.height);
            
            //jasen's note: set anno view's size for clickable, but no way to changing the position of anno view
            CGRect frame = annView.imgPin.frame;
//            frame.origin.x = 0;
//            frame.origin.y = 0;
            annView.frame = frame;
            annView.center = CGPointMake(0,0);
//            [annView setBackgroundColor:[UIColor greenColor]];
            NSLog(@"debug mymapviewc viewForAnnotation 2:%f--%f--%f--%f",
                  annView.frame.origin.x,
                  annView.frame.origin.y,
                  annView.frame.size.width,
                  annView.frame.size.height);
//            annView.canShowCallout = YES;
        
  //      }
        return annView;
    }
    
}

-(void)doClose:(id)sender{
    NSLog(@"debug mymapviewv doClose:%d--%@", self.map.clickable, self);
    self.map.clickable = YES;
	if (self.calloutAnnotation){
		[self.map removeAnnotation: self.calloutAnnotation];
        [self.map addAnnotation: self.calloutAnnotation];
	}
    [self removeContentView];
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	NSLog(@"ATMMyMapViewController calloutAccessoryControlTapped");
	[delegate  mapView:mapView annotationView:view calloutAccessoryControlTapped:control];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated");
//    [self.selectedAnnotationView.superview bringSubviewToFront:self.selectedAnnotationView];
    [self performSelector:@selector(bringSelectView) withObject:nil afterDelay:0.1];
    [self moveContentView];
}

- (void)bringSelectView {
    [self.selectedAnnotationView.superview bringSubviewToFront:self.selectedAnnotationView];
}

- (void)moveContentView {
    UIView *contentView = [self.view viewWithTag:ConteneViewTag];
    contentView.frame = self.selectedAnnotationView.frame;
//    contentView.layer.borderWidth = 1.0;
//    contentView.layer.borderColor = [UIColor redColor].CGColor;
    contentView.hidden = NO;
}

- (void)removeContentView {
    UIView *contentView = [self.view viewWithTag:ConteneViewTag];
    [contentView removeFromSuperview];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan :%@",NSStringFromCGRect(self.selectedAnnotationView.frame));
    UIView *contentView = [self.view viewWithTag:ConteneViewTag];
    contentView.hidden = YES;
}


@end
