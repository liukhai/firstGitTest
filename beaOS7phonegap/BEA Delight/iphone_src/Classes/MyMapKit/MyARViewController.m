//
//  MyARView.m
//  MapTest
//
//  Created by Algebra Lo on 10年2月1日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyARViewController.h"
#define VIEWPORT_WIDTH_RADIANS .5
#define VIEWPORT_HEIGHT_RADIANS .7392
#define UpdateTime	0.1

@implementation MyARViewController
@synthesize info_calculator, accelerometerManager, delegate;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		vertical_angle = horizontal_angle = 0;
    }

	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/setting.plist",path];
	NSMutableDictionary *setting = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	show_distance = [[setting objectForKey:@"distance"] floatValue] * 1000;
	return self;
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	original_frame = self.view.frame;

	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeMovie]) {
		camera_controller = [[UIImagePickerController alloc] init];
		camera_controller.delegate = self;
		camera_controller.sourceType = UIImagePickerControllerSourceTypeCamera;
		camera_controller.navigationBarHidden = FALSE;
		//Avaliable for iPhone OS 3.1
/*
		camera_controller.showsCameraControls = FALSE;
		camera_controller.cameraViewTransform = CGAffineTransformMakeScale(1.0, 1.132);
*/
		overlay_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		x = [[UILabel alloc] initWithFrame:CGRectMake(0, 450, 110, 30)];
		y = [[UILabel alloc] initWithFrame:CGRectMake(110, 450, 100, 30)];
		z = [[UILabel alloc] initWithFrame:CGRectMake(210, 450, 110, 30)];
		control_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		control_toolbar.barStyle = UIBarStyleBlackOpaque;
		close = [[UIBarButtonItem alloc] initWithTitle:@"關閉" style:UIBarButtonItemStyleBordered target:self action:@selector(deactivateAR)];
		[control_toolbar setItems:[NSArray arrayWithObject:close]];
/*		[overlay_view addSubview:x];
		[overlay_view addSubview:y];
		[overlay_view addSubview:z];*/
		[overlay_view addSubview:control_toolbar];
		overlay_view.userInteractionEnabled = TRUE;
		//Avaliable for iPhone OS 3.1
/*
		[camera_controller setCameraOverlayView:overlay_view];
*/
	} else {
//		camera_controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}

	if (!self.accelerometerManager) {
		self.accelerometerManager = [UIAccelerometer sharedAccelerometer];
		self.accelerometerManager.updateInterval = 0.1;
		self.accelerometerManager.delegate = self;
	}
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

-(IBAction)activateAR {
	if (camera_controller!=nil) {
        [self presentViewController:camera_controller animated:YES completion:nil];
		[self setupAR];
		self.view.frame = CGRectMake(0, 0, 320, 44);
		refresh_timer = [NSTimer scheduledTimerWithTimeInterval:UpdateTime target:self selector:@selector(updateAR) userInfo:nil repeats:TRUE];
		[delegate openAR];
	} else {
		UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"功能未能使用" message:@"本功能需要iPhone 3GS才能運作" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[fail show];
		[fail release];
	}

}

-(void)deactivateAR {
	int i;
	[refresh_timer invalidate];
	for (i=0; i<[annotation_list count]; i++) {
		[((PlaceMarkController *)[place_mark_list objectAtIndex:i]).view removeFromSuperview];
	}
	[place_mark_list removeAllObjects];
	[place_mark_list release];
	[self dismissViewControllerAnimated:YES completion:nil];
	self.view.frame = original_frame;
	[delegate closeAR];
}

-(void)setupAR {
	PlaceMarkController *temp_place_mark;
	int i;
	place_mark_list = [NSMutableArray new];
	if (info_calculator!=nil) {
		annotation_list = [info_calculator getAnnotations];
		for (i=0; i<[annotation_list count]; i++) {
			temp_place_mark = [[PlaceMarkController alloc] initWithNibName:@"PlaceMark" bundle:nil];
//			temp_place_mark.place_text = ((MyAnnotation *)[annotation_list objectAtIndex:i]).title;
			temp_place_mark.distance_text = @"";
			[place_mark_list addObject:temp_place_mark];
#if !TARGET_IPHONE_SIMULATOR
			[overlay_view addSubview:temp_place_mark.view];
			[overlay_view sendSubviewToBack:temp_place_mark.view];
#endif
			[temp_place_mark release];
		}
	}
}

-(void)updateAR {
	int i;
	float object_direction_radian, distance;
	CGPoint label_offset;
	for (i=0; i<[annotation_list count]; i++) {
//		NSLog(@"%f meter",[info_calculator distanceFromMe:[annotation_list objectAtIndex:i]]);
//		NSLog(@"%f degree from me",[info_calculator directionFromMe:[annotation_list objectAtIndex:i]]);
		object_direction_radian = [info_calculator directionFromMe:[annotation_list objectAtIndex:i]] / 180 * M_PI; 
		if (object_direction_radian > M_PI) {
			object_direction_radian -= 2 * M_PI;
		} else if (object_direction_radian < -M_PI) {
			object_direction_radian += 2 * M_PI;
		}
		if (object_direction_radian<VIEWPORT_WIDTH_RADIANS/2 && object_direction_radian>-VIEWPORT_WIDTH_RADIANS/2) {
			distance = [info_calculator distanceFromMe:[annotation_list objectAtIndex:i]];
			if (distance < show_distance) {
				label_offset = CGPointMake(object_direction_radian / (VIEWPORT_WIDTH_RADIANS / 2) * 160,  - vertical_angle / VIEWPORT_HEIGHT_RADIANS * 240);
				[((PlaceMarkController *)[place_mark_list objectAtIndex:i]).view setHidden:FALSE];
				((PlaceMarkController *)[place_mark_list objectAtIndex:i]).view.center = CGPointMake(160 + label_offset.x, 240 + label_offset.y);
				((PlaceMarkController *)[place_mark_list objectAtIndex:i]).distance_text = [NSString stringWithFormat:@"%.2fkm",distance/1000];
				[(PlaceMarkController *)[place_mark_list objectAtIndex:i] updateLabel];
			} else {
				NSLog(@"point %f %d out of distance %fkm",distance, i, show_distance);
				[((UIViewController *)[place_mark_list objectAtIndex:i]).view setHidden:TRUE];
			}
						
		} else {
			NSLog(@"point %d out of angle",i);
			[((UIViewController *)[place_mark_list objectAtIndex:i]).view setHidden:TRUE];
		}
	}
}

-(IBAction)reloadAnnotations {
	[delegate reloadAnnotations];
}

-(IBAction)switchToSetting {
	[delegate switchToSetting];		
}

- (void)dealloc {
#if !TARGET_IPHONE_SIMULATOR
	[overlay_view removeFromSuperview];
	[overlay_view release];
#endif
	[camera_controller release];
    [super dealloc];
}

///////////////////////////
//UIImagePicker delegate
///////////////////////////
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[self dismissViewControllerAnimated:YES completion:nil];
	self.view.frame = original_frame;
	[refresh_timer invalidate];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:nil];
	self.view.frame = original_frame;
	[refresh_timer invalidate];
}

//////////////////////////////
//UIAccelerometer delegate
//////////////////////////////
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	x.text = [NSString stringWithFormat:@"%f",acceleration.x];
	y.text = [NSString stringWithFormat:@"%f",acceleration.y];
	z.text = [NSString stringWithFormat:@"%f",acceleration.z];
	vertical_angle = atan(acceleration.z / acceleration.y);
	horizontal_angle = atan(acceleration.x / acceleration.y);
}

@end
