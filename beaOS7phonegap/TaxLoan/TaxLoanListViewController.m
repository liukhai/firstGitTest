//
//  QuaterlySurpriseListViewController.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月23日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TaxLoanListViewController.h"
#import "MBKUtil.h"

#import "TaxLoanOffersViewController.h"

@implementation TaxLoanListViewController
@synthesize items_data, table_view;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		current_page = 1;
		current_page_size = 9999;
		total_page = 1;
		items_data = [NSMutableArray new];
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 00, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 64, 320, 416+[[MyScreenUtil me] getScreenHeightAdjust]);
    table_view.frame = CGRectMake(0, 45, 320, 322+[[MyScreenUtil me] getScreenHeightAdjust]);

    [self loadPlistData];
	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"TaxLoanMenu",nil)];
}

-(void) loadPlistData{
    NSString *date_stamp;
    md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[TaxLoanUtil me ] findPlistPaths]];
    date_stamp = [md_temp objectForKey:@"SN"];
	NSLog(@"loadPlistData:%@",date_stamp);
    if (date_stamp == nil && ![[TaxLoanUtil me] isSend]) {
//        [[TaxLoanUtil me] sendRequest:date_stamp listViewController:self];
    }else{
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *now = [NSDate date];
        now = [formatter dateFromString:[formatter stringFromDate:now] ];
        NSDate *updateDate = [formatter dateFromString:date_stamp];
        NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],date_stamp);
        BOOL dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
        NSLog(@"TaxLoanListViewController: dateExpired:%d",dateExpired);
        if (dateExpired && ![[TaxLoanUtil me] isSend]) {
//            [[TaxLoanUtil me] sendRequest:date_stamp listViewController:self];
        }else{
            self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"promotionList"] copyItems:YES];
            [table_view reloadData];
            table_view.contentOffset = CGPointMake(0, 0);
            
        }
    }
}

#pragma mark - UITabbarDelegate

-(void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    UIAlertView *alert_view =nil;
    switch (item.tag) {
		case 0: // Offers TabBar
            alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TaxLoanCallApply",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
            [alert_view show];
            [alert_view release];
			break;
	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"TaxLoanApplyHotline",nil)]];
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
	[items_data removeAllObjects];
	[items_data release];
    [super dealloc];

}

-(void)setPageSize:(int)page_size {
	current_page_size = page_size;
}


-(IBAction)tncButtonPressed:(UIButton *)button {
	TermsAndConditionsViewController *tnc_controller = [[TermsAndConditionsViewController alloc] initWithNibName:@"TermsAndConditionsView" bundle:nil];
    [tnc_controller setTncStr:NSLocalizedString(@"TNC Shopping",nil)];
	[self.navigationController pushViewController:tnc_controller animated:TRUE];
//	tnc_controller.tnc.text = NSLocalizedString(@"TNC Shopping",nil);
	[tnc_controller release];
}

-(IBAction)prevButtonPressed:(UIButton *)button {
	if (current_page>1) {
		current_page--;
		next.hidden = FALSE;
		if (current_page==1) {
			prev.hidden = TRUE;
		}
		[table_view reloadData];
		table_view.contentOffset = CGPointMake(0, 0);
	}
}

-(IBAction)nextButtonPressed:(UIButton *)button {
	if (current_page<total_page) {
		current_page++;
		prev.hidden = FALSE;
		if (current_page==total_page) {
			next.hidden = TRUE;
		}
		[table_view reloadData];
		table_view.contentOffset = CGPointMake(0, 0);
	}
}

-(IBAction)homeButtonPressed:(UIBarButtonItem *)button {
	[(RootViewController *)[CoreData sharedCoreData].root_view_controller setContent:-1];
}


///////////////////
//UITableDelegate
///////////////////
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 81;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSLog(@"table count :%d",[self.items_data count]);
	return [self.items_data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = @"CustomCell";
    
    //	CustomCell *cell = (CustomCell *)[table_view dequeueReusableCellWithIdentifier:identifier];
    //	if (cell==nil) {
	LargeImageCell *cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
//    if (indexPath.row%2) {
//        
//    } else {
        if (indexPath.row == [self.items_data count] -1 ) {
            if ([self.items_data count] > 5) {
                
            } else {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
                label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
                //            label.backgroundColor = [UIColor blueColor];
                [cell addSubview:label];
                
            }
//            NSLog(@"%d",indexPath.row);
        }else {
//            NSLog(@"%d",indexPath.row);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
            label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
            //            label.backgroundColor = [UIColor blueColor];
            [cell addSubview:label];
        }
//    }
    //	}
//	cell.accessoryType = UITableViewCellAccessoryNone;
//	cell.title_label.frame = CGRectMake(cell.title_label.frame.origin.x, cell.title_label.frame.origin.y, cell.title_label.frame.size.width, 60);
//	cell.title_label.numberOfLines = 3;
    
    NSString *thumbnail;
    NSString *title;
    
    if ([AccProUtil isLangOfChi]) {
        thumbnail = @"thumbnail_zh";
        title = @"title_zh";
    }else{
        thumbnail = @"thumbnail_en";
        title = @"title_en";
    }
    cell.title_label.text = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:title];
    NSString *image = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:thumbnail];
    if (image!=nil && ![image isEqualToString:@""]) {
        [cell.cached_image_view loadImageWithURL:[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:thumbnail]];
    }        
	//cell.description_label.text = [[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
    
	if ([[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
	} else {
		cell.is_new.hidden = TRUE;
	}
	
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    //	LatestPromotionsSummaryViewController *summary_controller = [[LatestPromotionsSummaryViewController alloc] initWithNibName:@"LatestPromotionsSummaryView" bundle:nil];
    //	summary_controller.merchant_info = [items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size];
    //	if ([items_data count]==1) {
    //		[self.navigationController pushViewController:summary_controller animated:TRUE];
    //	} else {
    //		[self.navigationController pushViewController:summary_controller animated:TRUE];
    //	}
    NSString  *targeturl = nil;
    NSString *hotline = nil;
    NSString *btnLabel = nil;
    //    NSString *defaultViewController = nil;
    if ([AccProUtil isLangOfChi]) {
        targeturl = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"target_url_zh"];
        btnLabel = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"call_zh"];
        //      defaultViewController = @"AccProDefaultPageViewController_zh";
    }else{
        targeturl = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"target_url_en"];
        btnLabel = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"call_en"];
        //     defaultViewController = @"AccProDefaultPageViewController_en";
    }
    hotline = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"Hotline"];
    NSString  *web = nil;//added by jasen on 20111118
    web = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"web"];
    NSLog(@"TaxLoanListViewController didSelectRowAtIndexPath:%@, %@",web, targeturl);
//    if ([web isEqualToString:@"1"]){
//        [[ConsumerLoanUtil me] showConsumerLoanViewController:@"TaxLoanListViewController"
//                                                          url:targeturl
//                                                      hotline:hotline
//                                                     btnLanel:btnLabel];
//        
//        
////    }else if([targeturl isEqualToString:@"ConsumerLoanViewController"]){
////        [[CoreData sharedCoreData].taxLoan_view_controller forwardNextView:NSClassFromString(@"TaxLoanOffersViewController") viewName:@"TaxLoanOffersViewController"];    
//
//    }else
        if([targeturl isEqualToString:@"LTViewController"]) {
        [CoreData sharedCoreData].lastScreen = @"LTViewController";
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[CoreData sharedCoreData].root_view_controller setContent:0];
        [(RootViewController*)[[CoreData sharedCoreData]._LTViewController.navigationController.viewControllers objectAtIndex:0] setContent:2];
        [CoreData sharedCoreData]._LTViewController.view.center = [[MyScreenUtil me] getmainScreenCenter:self];
        [CoreData sharedCoreData].main_view_controller.view.center = [[MyScreenUtil me] getmainScreenLeft:self];
        [UIView commitAnimations];
        
    }
    
    //    if(indexPath.row == 1){
    //        AccProOffersViewController *accProOffersViewController = [[AccProOffersViewController alloc] initWithNibName:@"AccProOffersViewController" bundle:nil];
    //        [self.navigationController pushViewController:accProOffersViewController animated:TRUE];
    //        [accProOffersViewController release];
    //    }
    //	summary_controller.title_label.text = title_label.text;
    //	[accProOffersViewController release];
}

@end
