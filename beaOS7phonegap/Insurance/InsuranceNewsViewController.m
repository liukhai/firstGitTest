// Amended by Aasen on 20120330

#import "InsuranceNewsViewController.h"
#import "MBKUtil.h"
#import "InsuranceUtil.h"
@implementation InsuranceNewsViewController
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
    
//    table_view.frame = CGRectMake(0, table_view.frame.origin.y, 320,  table_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        [[MyScreenUtil me] adjustmentcontrolY20:table_view];
//        [[MyScreenUtil me] adjustmentcontrolY20:title_label];
//        [[MyScreenUtil me] adjustmentcontrolY20:title_backImg];
//    }
    [self loadPlistData];
    [self initTableView];
	[next setTitle:NSLocalizedString(@"Next",nil) forState:UIControlStateNormal];
	[prev setTitle:NSLocalizedString(@"Prev",nil) forState:UIControlStateNormal];
	title_label.text = [NSString stringWithFormat:@"%@",NSLocalizedString(@"insurance.news.title",nil)];
}

-(void)initTableView{
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        CGRect frame1 = table_view.frame;
        frame1.origin.y = frame1.origin.y-4;
        frame1.size.height = frame1.size.height-25;
        table_view.frame = frame1;
        
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y;
        frame2.size.height = frame2.size.height-100;
        borderImageView.frame = frame2;
    }else {
        CGRect frame1 = table_view.frame;
        frame1.origin.y = frame1.origin.y-4;
        frame1.size.height = frame1.size.height-120;
        table_view.frame = frame1;
        
        CGRect frame2 = borderImageView.frame;
        frame2.origin.y = frame2.origin.y;
        frame2.size.height = frame2.size.height-120;
        borderImageView.frame = frame2;
    }
}

-(void) loadPlistData{
    NSString *date_stamp;
    md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[InsuranceUtil me ] findPlistPathsPromo]];
    date_stamp = [md_temp objectForKey:@"SN"];
	NSLog(@"loadPlistData:%@",date_stamp);
    if (date_stamp == nil && ![[InsuranceUtil me] isSendPromo]) {
        [self sendRequestPromo:date_stamp listViewController:self];
    }else{
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *now = [NSDate date];
        now = [formatter dateFromString:[formatter stringFromDate:now] ];
        NSDate *updateDate = [formatter dateFromString:date_stamp];
        NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],date_stamp);
        BOOL dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
        NSLog(@"InsuranceNewsViewController: dateExpired:%d",dateExpired);
        if (dateExpired && ![[InsuranceUtil me] isSendPromo]) {
            [[InsuranceUtil me] sendRequestPromo:date_stamp listViewController:self];
        }else{
            self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"promotionList"] copyItems:YES];
            if ([self isNotEmptyList]) [table_view reloadData];
            table_view.contentOffset = CGPointMake(0, 0);
            
        }
//                self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"promotionList"] copyItems:YES];
//                [table_view reloadData];
//                table_view.contentOffset = CGPointMake(0, 0);
    }
}

-(void) sendRequestPromo:(NSString*) date_stamp
      listViewController:(id)p_InsuranceNewsViewController
{
    NSLog(@"InsuranceUtil: sendRequest:%@", date_stamp);
    
    [InsuranceUtil me].strSendPromo = @"YES";
    
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForInsurancePlistPromo:self SN:date_stamp];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    
    [[CoreData sharedCoreData].mask showMask];
}

///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"InsuranceUtil requestFinished:%@",[request responseString]);
    [self updateFundPriceFile:[request responseData]];
    [[CoreData sharedCoreData].mask hiddenMask];
    [self loadPlistData];
}

- (void) updateFundPriceFile:(NSData*)datas{
    NSString *tempFile = [MBKUtil getDocTempFilePath];
    NSLog(@"temp file:%@",tempFile);
    [datas writeToFile:tempFile atomically:YES];
    NSMutableDictionary *newFundList = [NSMutableDictionary dictionaryWithContentsOfFile:tempFile];
    
    NSMutableArray *promolist = [newFundList objectForKey:@"promotionList"];
    NSDictionary *rsp_item;
    for (int i=0; i<[promolist count]; i++) {
        rsp_item = [promolist objectAtIndex:i];
        NSLog(@"InsuranceUtil: title_en:%@",[rsp_item objectForKey:@"title_en"]);
    }
    
    NSLog(@"InsuranceUtil: write plist to disk now.");
    NSString *prompFile =nil;
    
    prompFile= [[InsuranceUtil me ]findPlistPathsPromo];
    
    NSLog(@"InsuranceUtil: Existing plist path:%@",prompFile);
    if (prompFile == nil) {
        [[NSFileManager defaultManager] createFileAtPath:@"" contents:nil attributes:nil];
    }
   	[[NSFileManager defaultManager] removeItemAtPath:tempFile error:nil];
    [newFundList writeToFile:prompFile atomically:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"InsuranceUtil requestFailed:%@", request.error);
    [self loadPlistData];
    [[CoreData sharedCoreData].mask hiddenMask];
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
    [title_backImg release];
    title_backImg = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[items_data removeAllObjects];
	[items_data release];
    [title_backImg release];
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
    
    
	LargeImageCell *cell = [[LargeImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier mystyle:(indexPath.row%2)];
    
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
    
	if ([[[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"newitem"] isEqualToString:@"T"]) {
		cell.is_new.hidden = FALSE;
	} else {
		cell.is_new.hidden = TRUE;
	}
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 81-1.5, cell.frame.size.width, 1.5)];
    label.backgroundColor = [UIColor colorWithRed:234/255.0 green:227/255.0 blue:219/255.0 alpha:1];
    //            label.backgroundColor = [UIColor blueColor];
    [cell addSubview:label];
	
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    InsuranceOffersViewController *insuranceOffersViewController =nil;
    NSString  *targeturl = nil;
    NSString *hotline = nil;
    NSString *caption = nil;
    
    if ([AccProUtil isLangOfChi]) {
        targeturl = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"target_url_zh"];
        caption = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"call_zh"];
    }else{
        targeturl = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"target_url_en"];
        caption = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"call_en"];
        
    }
    hotline = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"Hotline"];
    
    NSString  *web = nil;
    web = [[items_data objectAtIndex:indexPath.row + (current_page-1) * current_page_size] objectForKey:@"web"];
    NSLog(@"InsuranceNewsViewController didSelectRowAtIndexPath:%@, %@",web, targeturl);
    if ([web isEqualToString:@"1"]){
        [[InsuranceUtil me] showInsuranceViewController:targeturl hotline:hotline caption:caption type:1];
    }
}

-(BOOL)isNotEmptyList
{
    BOOL isNotEmpty = ([self.items_data count]>0);
    if (!isNotEmpty)
    {
        CGRect frame = table_view.frame;
        UIImageView *bg = [[[UIImageView alloc] initWithImage:[[LangUtil me] getImage:@"coming_soon_4.png"]] autorelease];
		bg.contentMode = UIViewContentModeScaleToFill;
		bg.frame = frame;
        [self.view addSubview:bg];
    }
    return isNotEmpty;
}

@end
