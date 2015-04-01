//amended by jasen on 20120817

#import "MPFPromoListViewController.h"
#import "InsuranceUtil.h"
#import "MPFPromoViewController.h"
#import "LargeImageCell3.h"

@implementation MPFPromoListViewController

@synthesize items_data, table_view, md_temp;
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
    
    table_view.frame = CGRectMake(0, table_view.frame.origin.y, table_view.frame.size.width, table_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:title_label];
        [[MyScreenUtil me] adjustmentcontrolY20:lbTitleBackImg];
        [[MyScreenUtil me] adjustmentcontrolY20:table_view];
        [[MyScreenUtil me] adjustmentcontrolY20:prev];
        [[MyScreenUtil me] adjustmentcontrolY20:next];
        [[MyScreenUtil me] adjustmentcontrolY20:tnc];
        
    }

    [self loadPlistData];
	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"mpf.promotic.title",nil)];
}

-(void) loadPlistData{
    NSString *date_stamp;
    md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MPFUtil me ]findMPFPromoPlistPath]];
    date_stamp = [md_temp objectForKey:@"SN"];
	NSLog(@"loadPlistData:%@",date_stamp);
    if (date_stamp == nil && ![[MPFUtil me] isSend]) {
        [[MPFUtil me] sendRequestMPFPromoPlist:date_stamp listViewController:self];
    }else{
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *now = [NSDate date];
        now = [formatter dateFromString:[formatter stringFromDate:now] ];
        NSDate *updateDate = [formatter dateFromString:date_stamp];
        NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],date_stamp);
        BOOL dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
        NSLog(@"MPFPromoListViewController: dateExpired:%d",dateExpired);
        if (dateExpired && ![[MPFUtil me] isSend]) {
            [[MPFUtil me] sendRequestMPFPromoPlist:date_stamp listViewController:self];
        }else{
            self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"promotionList"] copyItems:YES];
            if ([self isNotEmptyList]) [table_view reloadData];
            table_view.contentOffset = CGPointMake(0, 0);
            
        }
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
    [lbTitleBackImg release];
    lbTitleBackImg = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[items_data removeAllObjects];
	[items_data release];
    [lbTitleBackImg release];
    [super dealloc];
}

-(void)setPageSize:(int)page_size {
	current_page_size = page_size;
}

-(IBAction)prevButtonPressed:(UIButton *)button {
	if (current_page>1) {
		current_page--;
		next.hidden = FALSE;
		if (current_page==1) {
			prev.hidden = TRUE;
		}
		if ([self isNotEmptyList]) [table_view reloadData];
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
		if ([self isNotEmptyList]) [table_view reloadData];
		table_view.contentOffset = CGPointMake(0, 0);
	}
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
	LargeImageCell3 *cell = [[LargeImageCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
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
	//cell.description_label.text = [[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"description"] stringByReplacingOccurrencesOfString:@"‧" withString:@"● "];
    NSString *image = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:thumbnail];
    if (image!=nil && ![image isEqualToString:@""]) {
        [cell.cached_image_view loadImageWithURL:[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:thumbnail]];
    }
	if ([[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
	} else {
		cell.is_new.hidden = TRUE;
	}
	
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    NSString  *targeturl = nil;
    NSString *targetBtnLabel = nil;
    if ([AccProUtil isLangOfChi]) {
        targeturl = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"target_url_zh"];
        targetBtnLabel = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"call_zh"];
    }else{
        targeturl = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"target_url_en"];
        targetBtnLabel = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"call_en"];
    }
    
    NSString  *web = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"web"];
    
    NSLog(@"MPFPromoListViewController select:%@--%@", targeturl, web);
    
    MPFPromoViewController *viewController = [[MPFPromoViewController alloc]
                                              initWithNibName:@"MPFPromoViewController"
                                              bundle:nil
                                              latestpromoUrl:targeturl];
    [self.view.superview addSubview:viewController.view];
    [self.parentViewController addChildViewController:viewController];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        viewController.view.frame = CGRectMake(0, -20, 320, 475);
    }
//    [self.navigationController pushViewController:viewController animated:TRUE];
    [viewController release];
}

-(BOOL)isNotEmptyList
{
    BOOL isNotEmpty = ([self.items_data count]>0);
    if (!isNotEmpty)
    {
        CGRect frame = self.table_view.frame;
        UIImageView *bg = [[[UIImageView alloc] initWithImage:[[LangUtil me] getImage:@"coming_soon.png"]] autorelease];
        bg.contentMode = UIViewContentModeScaleToFill;
        bg.frame = frame;
        [self.view addSubview:bg];
    }
    return isNotEmpty;
}

@end
