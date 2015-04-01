//
//  DashBoard.m
//  Citibank Card Offer
//
//  Created by MTel on 05/02/2010.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DashBoardController.h"
#define Height		44
#define IconSpace	10

@implementation DashBoardController
@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(id)initWithFilenames:(NSArray *)filenames Labels:(NSArray *)labels SelectedFilenames:(NSArray *)selected_filenames {
	if (self = [super init]) {
		start_up_animation = FALSE;
		current_width = 0;
		icon_list = [NSMutableArray new];
		if ([filename_list count]==[label_list count]) {
			filename_list = [filenames retain];
			label_list = [labels retain];
			selected_filename_list = [selected_filenames retain];
		} else {
			filename_list = [NSMutableArray new];
			label_list = [NSMutableArray new];
			selected_filename_list = [NSMutableArray new];
		}

	}
	return self;
}

-(id)initWithFilenames:(NSArray *)filenames Labels:(NSArray *)labels SelectedFilenames:(NSArray *)selected_filenames StartUpAnimation:(BOOL)animation {
	if (self = [super init]) {
		start_up_animation = animation;
		current_width = 0;
		icon_list = [NSMutableArray new];
		if ([filename_list count]==[label_list count]) {
			filename_list = [filenames retain];
			label_list = [labels retain];
			selected_filename_list = [selected_filenames retain];
		} else {
			filename_list = [NSMutableArray new];
			label_list = [NSMutableArray new];
			selected_filename_list = [NSMutableArray new];
		}
		
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	int i;
	UIButton *temp_button;

    [super viewDidLoad];
	self.view.frame = CGRectMake(0, 0, 320, Height);
	scroll_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 72)];
	scroll_view.showsHorizontalScrollIndicator = FALSE;
	scroll_view.showsVerticalScrollIndicator = FALSE;
	scroll_view.backgroundColor = [UIColor clearColor];
	scroll_view.bounces = FALSE;
	[self.view addSubview:scroll_view];
	for (i=0; i<[filename_list count]; i++) {
		UIImage *temp_image = [UIImage imageNamed:[filename_list objectAtIndex:i]];
		temp_button = [UIButton buttonWithType:UIButtonTypeCustom];
		temp_button.frame = CGRectMake(current_width, 10, temp_image.size.width, temp_image.size.height);
		temp_button.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
		[temp_button setBackgroundImage:[[UIImage imageNamed:[filename_list objectAtIndex:i]] autorelease] forState:UIControlStateNormal];
		[temp_button setBackgroundImage:[[UIImage imageNamed:[selected_filename_list objectAtIndex:i]] autorelease] forState:UIControlStateSelected];
		temp_button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		temp_button.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
		temp_button.titleLabel.font = [UIFont systemFontOfSize:14];
		temp_button.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
		[temp_button setTitleColor:[UIColor colorWithRed:0.0 green:0.1875 blue:6 alpha:1] forState:UIControlStateNormal];
		[temp_button setTitleColor:[UIColor colorWithRed:0.8 green:0.0 blue:0.0 alpha:1] forState:UIControlStateSelected];
		[temp_button setTitle:[label_list objectAtIndex:i] forState:UIControlStateNormal];
		temp_button.tag = i;
		[temp_button addTarget:self action:@selector(iconPressed:) forControlEvents:UIControlEventTouchUpInside];
		[scroll_view addSubview:temp_button];
		[icon_list addObject:temp_button];
		current_width += temp_image.size.width + IconSpace;
		[temp_button release];
	}
	NSLog(@"%d icons",i);
	if (current_width>320) {
		scroll_view.contentSize = CGSizeMake(current_width, scroll_view.frame.size.height);
	}
	if (start_up_animation) {
		scroll_view.contentOffset = CGPointMake(scroll_view.contentSize.width - 320, 0);
	}
	[self playStartUpAnimation];
	[filename_list release];
	[selected_filename_list release];
	[label_list release];
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

-(void)playStartUpAnimation {
	if (start_up_animation && scroll_view.contentSize.width>320) {
		scroll_view.contentOffset = CGPointMake(scroll_view.contentSize.width - 320, 0);
		CGPoint offset = CGPointMake(0, 0);
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDelegate:self];
		scroll_view.contentOffset = offset;
		[UIView commitAnimations];
	}
}

-(void)setBackgroundImage:(NSString *)filename {
	NSLog(@"load %@",filename);
	if (background!=nil) {
		[background removeFromSuperview];
		[background release];
		background = nil;
	}
	background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:filename]];
	[self.view insertSubview:background atIndex:0];
}

-(void)setFontColor:(UIColor *)color {
	int i;
	for (i=0; i<[icon_list count]; i++) {
		[(UIButton *)[icon_list objectAtIndex:i] setTitleColor:color forState:UIControlStateNormal];
	}
}

-(void)setSelectedIcon:(int)index {
	for (int i=0; i<[icon_list count]; i++) {
		if (i==index) {
			[(UIButton *)[icon_list objectAtIndex:i] setSelected:TRUE];
		} else {
			[(UIButton *)[icon_list objectAtIndex:i] setSelected:FALSE];
		}

	}
	if (index<[icon_list count]) {
		((UIButton *)[icon_list objectAtIndex:index]).selected = TRUE;
		float offset = ((UIButton *)[icon_list objectAtIndex:index]).frame.origin.x + ((UIButton *)[icon_list objectAtIndex:index]).frame.size.width / 2 - 160;
		NSLog(@"%f",offset);
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDelegate:self];
		if (offset>0 & offset<scroll_view.contentSize.width-320) {
			scroll_view.contentOffset = CGPointMake(offset, 0);
		} else if (offset>scroll_view.contentSize.width-320) {
			scroll_view.contentOffset = CGPointMake(scroll_view.contentSize.width-320, 0);
		} else {
			scroll_view.contentOffset = CGPointMake(0, 0);
		}
		[UIView commitAnimations];
	}

	int i;
	for (i=0; i<[icon_list count]; i++) {
		[((UIButton *)[icon_list objectAtIndex:i]) setTitleColor:[UIColor colorWithRed:0.0 green:0.1875 blue:6 alpha:1] forState:UIControlStateNormal];
		((UIButton *)[icon_list objectAtIndex:i]).contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	}
}

-(void)iconPressed:(UIButton *)button {
	int i;
	for (i=0; i<[icon_list count]; i++) {
		((UIButton *)[icon_list objectAtIndex:i]).selected = FALSE;
	}
	((UIButton *)[icon_list objectAtIndex:button.tag]).selected = TRUE;
	[self setSelectedIcon:button.tag];
	[delegate dashBoard:self button:button];
}

@end
