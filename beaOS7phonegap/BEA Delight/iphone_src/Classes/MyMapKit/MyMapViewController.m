//
//  MapViewController.m
//  MapTest
//
//  Created by Algebra Lo on 10年1月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyMapViewController.h"
#define CheckDistancePeriod	1
#define UseStandardPin		TRUE
#define HaveMoreButton		TRUE

#import "CustomAnnotationView.h"
#import "QuarterlySurpriseSummaryViewController.h"
#import "YearRoundOffersSummaryViewController.h"

@implementation MyMapViewController
@synthesize map, delegate;
@synthesize calloutAnnotation = _calloutAnnotation;
@synthesize selectedAnnotationView = _selectedAnnotationView;
@synthesize annotationsArr, settingDic;
//@synthesize cur_id;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		annotationsArr = [NSArray array];
        settingDic = [NSDictionary dictionary];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[map reset];
	[map updateHeading];
			
//	ar_view = [[MyARViewController alloc] initWithNibName:@"MyARView" bundle:nil];
//	[map addSubview:ar_view.view];
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
	NSLog(@"MyMapViewController dealloc");
    [super dealloc];
}

-(void)loadAnnonationsFromPlist:(NSString *)path {
	[map loadAnnotationFromPlist:path];
}

/////////////////////
//MKMapView delegate
/////////////////////
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [self performSelector:@selector(bringSelectView) withObject:nil afterDelay:0.0];
    NSLog(@"didSelectAnnotationView view.annotation:%@", view.annotation);
	if ([view.annotation isKindOfClass:[MyAnnotation class]]) {
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
//        self.cur_id = ((MyAnnotation*)view.annotation).my_id;
//        [callerVC setBookmarkButton:((ATMMyAnnotation*)view.annotation).my_id];
        self.map.clickable = NO;
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

-(void) mapViewDidFinishLoadingMap:(MKMapView *)mapView {
	NSLog(@"debug mapViewDidFinishLoadingMap:%@", self.map);
//	[self.map selectAnnotation:self.map.selected_annotation animated:TRUE];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

//	NSString *annotationIdentifier = @"CustomePin";
	MKAnnotationView *view;
	if (annotation==mapView.userLocation) {
		view = [self.map dequeueReusableAnnotationViewWithIdentifier:@"blueDot"];
		if (view!=nil) {
			view.annotation = annotation;
		} else {
		}
		
//	} else {
//		if (UseStandardPin) {
//			view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"regularPin"];
//			if (view==nil) {
//				view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
//			}
////			((MKPinAnnotationView *)view).pinColor = MKPinAnnotationColorGreen;
//		} else {
//			
//			view = [self.map dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
//			if (view==nil) {
//				view = [[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier] autorelease];
//			} else {
//				view.annotation = annotation;
//			}
//			
//			view.image = [UIImage imageNamed:@"camera.png"];
//			
//		}
//		view.canShowCallout = TRUE;
//		if (HaveMoreButton) {
//			view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//		}
//	}
	} else {
        
//        CustomAnnotationView *annView =
//        (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier: @"pin"];
//        if (annView == nil)
//        {
            CustomAnnotationView *annView = [[[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                        reuseIdentifier:@"pin"] autorelease];

        MyAnnotation *myAnnotation = (MyAnnotation *)annotation;
//        index = myAnnotation.tag;
//        NSLog(@"tag is %d  title is %@", myAnnotation.tag, myAnnotation.title);
            NSLog(@"debug MyMapViewController viewForAnnotation 1:%f--%f--%f--%f",
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
            NSLog(@"debug MyMapViewController viewForAnnotation 2:%f--%f--%f--%f",
                  annView.frame.origin.x,
                  annView.frame.origin.y,
                  annView.frame.size.width,
                  annView.frame.size.height);
            //            annView.canShowCallout = YES;
            
            [annView.contentVC.btnClose addTarget:self action:@selector(doClose:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToDetailinfoViewController:)];
        annView.contentVC.calloutTitle.tag = myAnnotation.tag;
        [annView.contentVC.calloutTitle setUserInteractionEnabled:YES];
        [annView.contentVC.calloutTitle addGestureRecognizer:tapGesture];
        [tapGesture release];
        
   //     }
        
        return annView;
    }
	
	return view;
}

-(void)doClose:(id)sender{
    NSLog(@"debug MyMapViewController doClose:%d--%@", self.map.clickable, self);
    self.map.clickable = YES;
	if (self.calloutAnnotation){
		[self.map removeAnnotation: self.calloutAnnotation];
        [self.map addAnnotation: self.calloutAnnotation];
	}
}

-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	//NSLog(@"tag: %d",((MyAnnotation *)((MKAnnotationView *)[mapView.selectedAnnotations objectAtIndex:0]).annotation).tag);
	[delegate  mapView:mapView annotationView:view calloutAccessoryControlTapped:control];
}

- (void)loadAnnotationsDetailinfo:(NSArray *)annotations settingValue:(NSDictionary *)setting {
    annotationsArr = [annotations retain];
    settingDic = [setting retain];
    
    [annotations release];
    [setting release];
}

- (void)pushToDetailinfoViewController:(UITapGestureRecognizer *)tapGesture {
    NSInteger tag = [tapGesture view].tag;
    NSString *suprise = [[annotationsArr objectAtIndex:tag] objectForKey:@"suprise"];
	if ([suprise isEqualToString:@"false"]) {
		YearRoundOffersSummaryViewController *summary_controller = [[YearRoundOffersSummaryViewController alloc] initWithNibName:@"YearRoundOffersSummaryView" bundle:nil];
        [CoreData sharedCoreData].menuType = @"1";
		summary_controller.show_distance = [[settingDic objectForKey:@"show_distance"] floatValue];
		summary_controller.merchant_info = [annotationsArr objectAtIndex:tag];
  //      summary_controller.title_label.text = title_label.text;
        summary_controller.headingTitle = NSLocalizedString(@"Year-round Offers", nil);
        [[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:summary_controller animated:YES];
		[self.navigationController pushViewController:summary_controller animated:TRUE];
		[summary_controller release];
	} else {
        //[self.navigationController popViewControllerAnimated:YES];
        [[CoreData sharedCoreData].root_view_controller.navigationController popViewControllerAnimated:YES];
        return;
        
		QuarterlySurpriseSummaryViewController *summary_controller = [[QuarterlySurpriseSummaryViewController alloc] initWithNibName:@"QuarterlySurpriseSummaryView" bundle:nil];
		summary_controller.show_distance = [[settingDic objectForKey:@"show_distance"] floatValue];
		summary_controller.merchant_info = [annotationsArr objectAtIndex:tag];
        summary_controller.headingTitle = NSLocalizedString(@"Quarterly Surprise", nil);
		[[CoreData sharedCoreData].root_view_controller.navigationController pushViewController:summary_controller animated:YES];
	//	summary_controller.title_label.text = title_label.text;
		[summary_controller release];
		
	}

}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated");
    //    [self.selectedAnnotationView.superview bringSubviewToFront:self.selectedAnnotationView];
    [self performSelector:@selector(bringSelectView) withObject:nil afterDelay:0.1];
}

- (void)bringSelectView {
    [self.selectedAnnotationView.superview bringSubviewToFront:self.selectedAnnotationView];
}

@end
