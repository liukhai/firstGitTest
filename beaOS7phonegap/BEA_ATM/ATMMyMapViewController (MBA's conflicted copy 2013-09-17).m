//
//  MapViewController.m
//  MapTest
//
//  Created by Algebra Lo on 10年1月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import "MyScreenUtil.h"

#import "CustomAnnotationView.h"
#import "CalloutMapAnnotation.h"

#import "ATMMyMapViewController.h"
#define CheckDistancePeriod	1
#define UseStandardPin		TRUE
#define HaveMoreButton		TRUE

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
        //
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
//	[self.map setCenterCoordinate:view.annotation.coordinate Delta:0.01];
//    [((UIView*)self.map) setUserInteractionEnabled:NO];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(handlePinButtonTap:)];
            tap.numberOfTapsRequired = 1;
            [self.map addGestureRecognizer:tap];
            tap.delegate = self;

            [tap release];

}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    //	if (self.calloutAnnotation){
    //		[self.map removeAnnotation: self.calloutAnnotation];//debug 20130915
    //	}
    NSLog(@"didDeselectAnnotationView view.annotation:%@", view.annotation);
    //    NSLog(@"didDeselectAnnotationView self.calloutAnnotation:%@", self.calloutAnnotation);
    [[callerVC btnBookmark] setHidden:YES];
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
	if (annotation==mapView.userLocation) {
        MKAnnotationView *view;
		view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"blueDot"];
		if (view!=nil) {
			view.annotation = annotation;
		}
        view.canShowCallout = NO;
        
        return view;
	} else {
        
        CustomAnnotationView *annView =
        (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier: @"pin"];
        if (annView == nil)
        {
            annView = [[[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                        reuseIdentifier:@"pin"] autorelease];
            
            NSLog(@"debug viewForAnnotation 1:%f--%f--%f--%f",
                  annView.frame.origin.x,
                  annView.frame.origin.y,
                  annView.frame.size.width,
                  annView.frame.size.height);
            
            //jasen's note: set anno view's size for clickable, but no way to changing the position of anno view
            CGRect frame = annView.imgPin.frame;
            //  frame.origin.x = -100;
            //  frame.origin.y = -100;
//            frame.size.width = 10;
//            frame.size.height = 10;
            annView.frame = frame;
            
            NSLog(@"debug viewForAnnotation 2:%f--%f--%f--%f",
                  annView.frame.origin.x,
                  annView.frame.origin.y,
                  annView.frame.size.width,
                  annView.frame.size.height);
            [annView setBackgroundColor:[UIColor greenColor]];
//            annView.canShowCallout = YES;
            
            
//            [annView.contentVC.btnClose addTarget:self action:@selector(doClose:) forControlEvents:UIControlEventTouchUpInside];

            
//            UIButton *pinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [pinButton setBackgroundImage:[UIImage imageNamed:@"mapview_pin.png"] forState:UIControlStateNormal];
//            pinButton.frame = CGRectMake(0, 0, 30, 44);
//
////            pinButton.frame = CGRectMake(0, 0, 30, 30);
//            pinButton.tag = 10;
//
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                           initWithTarget:self action:@selector(handlePinButtonTap:)];
//            tap.numberOfTapsRequired = 1;
//            [pinButton addGestureRecognizer:tap];
//            tap.delegate = self;
//
//            [tap release];
//
////            annView.canShowCallout = YES;
//
//            [annView addSubview:pinButton];

//            // add rightAccessoryView
//            UIButton* aButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            aButton.frame = CGRectMake(0, 0, 75, 75);
//            [aButton setBackgroundImage:[UIImage imageNamed:@"mapview_pin.png"] forState:UIControlStateNormal];
////            [aButton setTitle:@"V" forState:UIControlStateNormal];
//            annView.rightCalloutAccessoryView = aButton;
            
        }
        
//        annView.annotation = annotation;

//        UIButton *pb = (UIButton *)[annView viewWithTag:10];
//        [pb setTitle:annotation.title forState:UIControlStateNormal];
        
        return annView;
    }
}

-(void)doClose:(id)sender{
    NSLog(@"debug mymapview doClose:%@", self);
//    [self.selectedAnnotationView removeFromSuperview];
    [self.selectedAnnotationView setSelected:NO];
    [self mapView:map didDeselectAnnotationView:self.selectedAnnotationView];
}

- (void) handlePinButtonTap:(UITapGestureRecognizer *)gestureRecognizer
{
//    UIButton *btn = (UIButton *) gestureRecognizer.view;
//    MKAnnotationView *av = (MKAnnotationView *)[btn superview];
//    id<MKAnnotation> ann = av.annotation;
    NSLog(@"debug handlePinButtonTap:%@", gestureRecognizer.view);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    NSLog(@"atmmymap shouldRecognizeSimultaneouslyWithGestureRecognizer:%@", gestureRecognizer);
    return YES;
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	NSLog(@"ATMMyMapViewController calloutAccessoryControlTapped");
	[delegate  mapView:mapView annotationView:view calloutAccessoryControlTapped:control];
}

@end
