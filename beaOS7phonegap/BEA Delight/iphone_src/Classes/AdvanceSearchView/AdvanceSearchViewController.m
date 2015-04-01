//
//  AdvanceSearchViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月24日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AdvanceSearchViewController.h"


@implementation AdvanceSearchViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
        cuisine_list = [[NSLocalizedString(@"cuisine_list",nil) componentsSeparatedByString:@","] retain];
        cuisine_index_list = [[NSLocalizedString(@"cuisine_index_list",nil) componentsSeparatedByString:@","] retain];
        category_list = [[NSLocalizedString(@"search_category_list",nil) componentsSeparatedByString:@","] retain];
        category_index_list = [[NSLocalizedString(@"search_category_index_list",nil) componentsSeparatedByString:@","] retain];
        location_list = [[NSLocalizedString(@"location_search_list",nil) componentsSeparatedByString:@","] retain];
        location_index_list = [[NSLocalizedString(@"location_search_id_list",nil) componentsSeparatedByString:@","] retain];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MyScreenUtil me] adjustNavView:self.navigationController.view];
    //    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
    //	[self.view insertSubview:bgv atIndex:0];
    //    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    //    self.view.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    
    table_view.backgroundColor = [UIColor clearColor];
    dining_offers.selected = TRUE;
    NSArray *offers_list = [NSLocalizedString(@"Offer types",nil) componentsSeparatedByString:@","];
    title_label.text = NSLocalizedString(@"Advance Search",nil);
    [dining_offers setTitle:[offers_list objectAtIndex:0] forState:UIControlStateNormal];
    [shopping_offers setTitle:[offers_list objectAtIndex:1] forState:UIControlStateNormal];
    keywords.placeholder = NSLocalizedString(@"Enter your keywords",nil);
    location_label.text = NSLocalizedString(@"District",nil);
    cuisine_label.text = NSLocalizedString(@"Cuisine",nil);
    [search setTitle:NSLocalizedString(@"Search",nil) forState:UIControlStateNormal];
    [location setTitle:@"" forState:UIControlStateNormal];
    [cuisine setTitle:@"" forState:UIControlStateNormal];
    [[MBKUtil me].queryButton1 setHidden:YES];
    /*[location setTitle:[location_list objectAtIndex:selected_location] forState:UIControlStateNormal];
     [cuisine setTitle:[cuisine_list objectAtIndex:selected_cuisine] forState:UIControlStateNormal];*/
    
    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    //jerry   [v_rmvc.rmUtil setNav:self.navigationController];
    //   NSArray *navVC1 = self.navigationController.viewControllers;
    //   NSArray *navVC2 = [CoreData sharedCoreData].root_view_controller.navigationController.viewControllers;
    //    [v_rmvc.rmUtil setNav:[CoreData sharedCoreData].root_view_controller.navigationController];
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
    [[MoreMenuUtil me] setMoreMenuViews4CreditCard];
    //    self.navigationController.delegate = self;
    if ([self isMovingFromParentViewController])
    {
        if (self.navigationController.delegate == self)
        {
            self.navigationController.delegate = nil;
        }
    }
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if ([status isEqualToString:@"1"]) {
        UIImage *imageSelectedLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_left_on.png"];
        UIImage *imageNormalLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_left_off.png"];
        UIImage *imageSelectedRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_right_on.png"];
        UIImage *imageNormalRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_right_off.png"];
        [dining_offers setBackgroundImage:imageNormalLeft forState:UIControlStateNormal];
        [dining_offers setBackgroundImage:imageSelectedLeft forState:UIControlStateSelected];
        [shopping_offers setBackgroundImage:imageNormalRight forState:UIControlStateNormal];
        [shopping_offers setBackgroundImage:imageSelectedRight forState:UIControlStateSelected];
        UIImage *image0 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_off.png"];
        UIImage *image1 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_on.png"];
        UIImage *image2 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_on.png"];
        UIImage *image3 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_off.png"];
        [img0 setImage:image0];
        [img1 setImage:image1];
        [img2 setImage:image2];
        [img3 setImage:image3];
    } else {
        UIImage *imageSelectedLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_left_on_new.png"];
        UIImage *imageNormalLeft = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_left_off_mew.png"];
        UIImage *imageSelectedRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_right_on_new.png"];
        UIImage *imageNormalRight = [UIImage imageNamed:@"borderlist_thin_gray_tap_02_right_off_new.png"];
        [dining_offers setBackgroundImage:imageNormalLeft forState:UIControlStateNormal];
        [dining_offers setBackgroundImage:imageSelectedLeft forState:UIControlStateSelected];
        [shopping_offers setBackgroundImage:imageNormalRight forState:UIControlStateNormal];
        [shopping_offers setBackgroundImage:imageSelectedRight forState:UIControlStateSelected];
        UIImage *image0 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_off_new.png"];
        UIImage *image1 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_on_new.png"];
        UIImage *image2 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_dining_on_new.png"];
        UIImage *image3 = [UIImage imageNamed:@"creditcard_yearroundoffers_icon_shopping_off_new.png"];
        [img0 setImage:image0];
        [img1 setImage:image1];
        [img2 setImage:image2];
        [img3 setImage:image3];
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


- (void)dealloc {
    [cuisine_list release];
    [location_list release];
    [underLineImage release];
    [tableBackImage release];
    [img2 release];
    [img3 release];
    [img0 release];
    [img1 release];
    [super dealloc];
}

-(IBAction)diningButtonPressed:(UIButton *)button {
    current_cuisine = 0;
    current_location = 0;
    dining_offers.selected = TRUE;
    shopping_offers.selected = FALSE;
    img0.hidden = YES;
    img1.hidden = YES;
    img2.hidden = NO;
    img3.hidden = NO;
    cuisine_label.text = NSLocalizedString(@"Cuisine",nil);
    //	keywords.text = NSLocalizedString(@"Enter your keywords",nil);
    keywords.text = @"";
    [location setTitle:@"" forState:UIControlStateNormal];
    [cuisine setTitle:@"" forState:UIControlStateNormal];
    //[location setTitle:[location_list objectAtIndex:selected_location] forState:UIControlStateNormal];
    //[cuisine setTitle:[cuisine_list objectAtIndex:selected_cuisine] forState:UIControlStateNormal];
    [table_view reloadData];
}

-(IBAction)shoppingButtonPressed:(UIButton *)button {
    current_category = 0;
    dining_offers.selected = FALSE;
    shopping_offers.selected = TRUE;
    img0.hidden = NO;
    img1.hidden = NO;
    img2.hidden = YES;
    img3.hidden = YES;
    cuisine_label.text = NSLocalizedString(@"Categories",nil);
    keywords.text = @"";
    [cuisine setTitle:@"" forState:UIControlStateNormal];
    [table_view reloadData];
}

-(IBAction)cuisineButtonPressed:(UIButton *)button {
    
}

-(IBAction)searchButtonPressed:(UIButton *)button {
    
    keywords.text = [keywords.text stringByReplacingOccurrencesOfString:NSLocalizedString(@"Enter your keywords",nil) withString:@""];
    BOOL fail = TRUE;
    if ([keywords.text length]>0) {
        fail = FALSE;
    }
    if (dining_offers.selected && [[location titleForState:UIControlStateNormal] length]>0 && ![[location titleForState:UIControlStateNormal] isEqualToString:@""]/*![[location titleForState:UIControlStateNormal] isEqualToString:@"All"] && ![[location titleForState:UIControlStateNormal] isEqualToString:@"全部"]*/) {
        fail = FALSE;
    }
    if ([[cuisine titleForState:UIControlStateNormal] length]>0 && ![[cuisine titleForState:UIControlStateNormal] isEqualToString:@""] /*![[cuisine titleForState:UIControlStateNormal] isEqualToString:@"All"] && ![[cuisine titleForState:UIControlStateNormal] isEqualToString:@"全部"]*/) {
        fail = FALSE;
    }
    if (fail) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Please enter at least one search critiria",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    AdvanceSearchListViewController *search_result = [[AdvanceSearchListViewController alloc] initWithNibName:@"AdvanceSearchListView" bundle:nil];
    [self.navigationController pushViewController:search_result animated:TRUE];
    if (dining_offers.selected) {
        [search_result getItemsListCuisine:[cuisine_index_list objectAtIndex:current_cuisine] Location:[location_index_list objectAtIndex:current_location] Keywords:keywords.text ? keywords.text : @""];
    } else {
        [search_result getItemsListCategory:[category_index_list objectAtIndex:current_category] Keywords:keywords.text ? keywords.text : @""];
    }
    [search_result release];
}

/////////////////////
//UITextFieldDelegate
/////////////////////
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    textField.textColor = [UIColor blackColor];
    return TRUE;
}

/////////////////////
//Picker delegate
/////////////////////
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (dining_offers.selected) {
        return 2;
    } else {
        return 1;
    }
    
    
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (dining_offers.selected) {
        switch (component) {
            case 0:
                return [location_list count];
                break;
            case 1:
                return [cuisine_list count];
                break;
        }
    } else {
        return [category_list count];
    }
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (dining_offers.selected) {
        switch (component) {
            case 0:
                return [location_list objectAtIndex:row];
                break;
            case 1:
                return [cuisine_list objectAtIndex:row];
                break;
        }
    } else {
        return [category_list objectAtIndex:row];
    }
    
    return @"";
}

/*-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if (dining_offers.selected) {
 switch (component) {
 case 0:
 [location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
 //	selected_location = row;
 //				[location setTitle:[location_list objectAtIndex:row] forState:UIControlStateNormal];
 break;
 case 1:
 [cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
	//			selected_cuisine = row;
 //				[cuisine setTitle:[cuisine_list objectAtIndex:row] forState:UIControlStateNormal];
 break;
 }
	} else {
 [cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
	//	selected_category = row;
 //		[cuisine setTitle:[category_list objectAtIndex:row] forState:UIControlStateNormal];
	}
 }*/

/////////////////////
//Action Sheet delegate
/////////////////////
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //	self.view.frame = CGRectMake(0, 0, 320, 411);
    ((RootViewController *)[CoreData sharedCoreData].root_view_controller).content_view.frame = CGRectMake(0, 0, 320, 411);
    if (buttonIndex==0) {
        NSLog(@"OK");
        if (dining_offers.selected) {
            current_location = [pickerView selectedRowInComponent:0];
            current_cuisine = [pickerView selectedRowInComponent:1];
            [location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
            [cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
        } else {
            current_category = [pickerView selectedRowInComponent:0];
            [cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
        }
        
    } else {
        NSLog(@"Cancel");
        if (dining_offers.selected) {
            [location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
            [cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
        } else {
            [cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
        }
    }
//    [pickerView release];
    
}

/////////////////////
//ASIHTTPRequest delegate
/////////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSString *responseString = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    cuisine_list = [[[NSString stringWithFormat:@"All,%@",responseString] componentsSeparatedByString:@","] retain];
    [cuisine setTitle:[cuisine_list objectAtIndex:0] forState:UIControlStateNormal];
    [location setTitle:[location_list objectAtIndex:0] forState:UIControlStateNormal];
    [[CoreData sharedCoreData].mask hiddenMask];
    [responseString release];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"AdvanceSearchViewController requestFailed:%@", [request responseString]);
    [[CoreData sharedCoreData].mask hiddenMask];
}

///////////////////
//UITableView delegate
///////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if (dining_offers.selected) {
        underLineImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"borderlist_thin_gray_bottom.png"]];
        CGRect frame = underLineImage.frame;
        frame.origin.y = 194 + 3 * 44;
        frame.size.width = 299;
        frame.origin.x = 10.5;
        underLineImage.frame = frame;
        frame = tableBackImage.frame;
        frame.size.height = 3 * 44;
        tableBackImage.frame = frame;
        return 3;
    } else {
        underLineImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"borderlist_thin_white_bottom.png"]];
        CGRect frame = underLineImage.frame;
        frame.origin.y = 194 + 2 * 44;
        underLineImage.frame = frame;
        frame = tableBackImage.frame;
        frame.size.height = 2 * 44;
        tableBackImage.frame = frame;
        return 2;
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dining_offers.selected) {
        switch (indexPath.row) {
            case 0:
                return keywords_cell;
                break;
            case 1:
                return district_cell;
                break;
            case 2:
                return cuisine_cell;
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:
                return keywords_cell;
                break;
            case 1:
                return cuisine_cell;
                break;
        }
        
    }
    
    return nil;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor clearColor];
    }else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    if (indexPath.row>0) {
        UIActionSheet *menu;
        ((RootViewController *)[CoreData sharedCoreData].root_view_controller).content_view.frame = CGRectMake(0, 0, 320, 550);
        self.view.frame = CGRectMake(0, 0, 320, 550);
        menu = [[UIActionSheet alloc] initWithTitle:nil
                                           delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                             destructiveButtonTitle:NSLocalizedString(@"Done",nil)
                                  otherButtonTitles:nil];
        [menu setUserInteractionEnabled:YES];
        
        // Add the picker
        pickerView = [[UIPickerView alloc] init];
        pickerView.showsSelectionIndicator = TRUE;
        pickerView.delegate = self;
        pickerView.dataSource = self;
//        [menu addSubview:pickerView];
//        [menu showInView:self.view];
//        [menu setBounds:CGRectMake(0, 0, 320, 480)];
        //		[pickerView setFrame:CGRectMake(0, 140, 320, 216)];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [pickerView setFrame:CGRectMake(8, 90, 305, 216)];
        }
        else {
            [pickerView setFrame:CGRectMake(0, 140, 320, 216)];
        }
        pickerView.backgroundColor = [UIColor whiteColor];
        
        //[pickerView setFrame:CGRectMake(0, 80, 320, 216)];
        //	UIButton *done_button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 50, 30)];
        //	[menu addSubview:done_button];
        if (dining_offers.selected) {
            [pickerView selectRow:current_location inComponent:0 animated:FALSE];
            [pickerView selectRow:current_cuisine inComponent:1 animated:FALSE];
            [cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
            [location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
        } else {
            // current_category
            [pickerView selectRow:current_category inComponent:0 animated:YES];
            [cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
        }
        if([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            UIWindow *window = nil;
            for (UIWindow *win in [UIApplication sharedApplication].windows) {
                if (win.tag == 2000) {
                    window = win;
                    [window makeKeyAndVisible];
                }
            }
            if (!window) {
                window = [[UIWindow alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, [MyScreenUtil me].getScreenHeight)];
                window.tag = 2000;
                [window makeKeyAndVisible];
                UIViewController *VC = [[UIViewController alloc] init];
                window.rootViewController = VC;
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                           message:@"\n\n\n\n\n\n\n\n\n"// change UIAlertController height
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Done",nil)
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        window.hidden = YES;
                                                        if (dining_offers.selected) {
                                                            current_location = [pickerView selectedRowInComponent:0];
                                                            current_cuisine = [pickerView selectedRowInComponent:1];
                                                            [location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
                                                            [cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
                                                        } else {
                                                            current_category = [pickerView selectedRowInComponent:0];
                                                            [cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
                                                        }
                                                        NSLog(@"Action 1 Handler Called");
                                                    }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil)
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        window.hidden = YES;
                                                        if (dining_offers.selected) {
                                                            [location setTitle:[location_list objectAtIndex:current_location] forState:UIControlStateNormal];
                                                            [cuisine setTitle:[cuisine_list objectAtIndex:current_cuisine] forState:UIControlStateNormal];
                                                        } else {
                                                            [cuisine setTitle:[category_list objectAtIndex:current_category] forState:UIControlStateNormal];
                                                        }
                                                        NSLog(@"Action 2 Handler Called");
                                                    }]];
            [pickerView setFrame:CGRectMake(0, 0, 304, 215)];
            pickerView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
            [alert.view addSubview:pickerView];
            
            [window.rootViewController presentViewController:alert animated:NO completion:nil];
        }else {
            [menu addSubview:pickerView];
            [menu showInView:self.view];
            [menu setBounds:CGRectMake(0, 0, 320, 480)];
            
        }
        [pickerView release];
        [menu release];
    }
}

@end
