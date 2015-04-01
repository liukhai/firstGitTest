#import "RateTTViewController.h"
#import "MPFUtil.h"

// private method define here
@interface RateTTViewController() 

-(void) parseCfgFile;
-(void) sendRequest;

@end

@implementation RateTTViewController

@synthesize scroll_view,fund_table, time_label, bt_trust, bt_industry, text_view;
@synthesize items_data, items_total,lbTitle,lbCurrency,lbBuy,lbSell,lbNotice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.items_data = [NSMutableArray new];
    }
    return self;
}

#pragma mark - viewDidLoad 
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view addSubview:scroll_view];

//    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);

//    self.scroll_view.frame = CGRectMake(0, 78, 320, 317+[[MyScreenUtil me] getScreenHeightAdjust]);
//    self.lbNotice.frame = CGRectMake(0, 403+[[MyScreenUtil me] getScreenHeightAdjust], 320, 19);
//    self.time_label.frame = CGRectMake(0, 420+[[MyScreenUtil me] getScreenHeightAdjust], 320, 23);

    //    [scroll_view setContentSize:CGSizeMake(320, fund_table.frame.size.height+text_view.frame.size.height)];
//    [scroll_view setContentSize:CGSizeMake(320, fund_table.frame.size.height)];
//    [scroll_view addSubview:fund_table];
    self.time_label.text=@"";
    self.lbTitle.text = NSLocalizedString(@"Rate.TT.title",nil);
    self.lbCurrency.text = NSLocalizedString(@"Rate.NoteTT.lbCurrency",nil);
    self.lbBuy.text = NSLocalizedString(@"Rate.NoteTT.lbBuy",nil);
    self.lbSell.text = NSLocalizedString(@"Rate.NoteTT.lbSell",nil);
    self.lbNotice.text = NSLocalizedString(@"Rate.Notice",nil);
    [bt_industry setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [bt_trust setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    NSLog(@"Note viewDidLoad");

    [self loadFundData];
    //    [scroll_view addSubview:text_view];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma  mark - loadFundData

-(void) loadFundData{
    NSLog(@"loadFundData");
    
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[RateUtil me] alertAndBackToMain:self];
        return ;
    }
    
    // check DateStamp is expired
    BOOL dateExpired = [[RateUtil me] checkRateSNExpired:[[RateUtil me] findRatePlistPath:@"tt"]];
    
    if (dateExpired) {
        [self sendRequest];
    }else{
        [self parseCfgFile];
        [fund_table reloadData];
    }
    
}

-(void) sendRequest{
    ASIFormDataRequest *request = [HttpRequestUtils getRequestForRatePlist:self rate:@"rttex"];
    
    [[CoreData sharedCoreData].queue addOperation:request];
    [[CoreData sharedCoreData].mask showMask];
}

-(void) parseCfgFile{
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[RateUtil me ] findRatePlistPath:@"tt"]];
    date_stamp = [md_temp objectForKey:@"SN"];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *updateDate = [formatter dateFromString:date_stamp];
    NSLog(@"parseCfgFile updateDate : %@",updateDate);
    [formatter setDateFormat:@"dd MMM yyyy HH:mm"];
    
    self.items_data = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"tt"] copyItems:YES];
	NSLog(@"RateNoteViewController: parseCfgFile count:%d", [self.items_data count]);
    self.items_total = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"tt"] copyItems:YES];
    [self filterDisplay];
    
    if ([RateUtil isLangOfChi]){
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        self.time_label.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Rate.time",nil),[formatter stringFromDate:updateDate]];
        
    }else{
        self.time_label.text = [NSString stringWithFormat:@"%@ %@ HKG",NSLocalizedString(@"Rate.time.of",nil), [formatter stringFromDate:updateDate]];
    }
    
	if ([self.items_data count] <=0) {
        if ([RateUtil isLangOfChi]){
            self.time_label.text=[NSString stringWithFormat:@"%@ %@ %@",NSLocalizedString(@"mpf.fundprice.time",nil),@"00/00/0000 00:00", NSLocalizedString(@"mpf.fundprice.time.end",nil)];
            
        }else{
            self.time_label.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"mpf.fundprice.time",nil), @"00/00/0000 00:00"];
        }
		
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Cannot find any fund price information",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
        return;
	} 
    
}

-(void) filterDisplay{
    NSMutableArray *tempList = [NSMutableArray new];
    NSLog(@"filterDisplay itemdate size:%d",[self.items_total count]);
    for (id obj in self.items_total) {
        NSString *display = [obj objectForKey:@"display"];
        if ([@"1" isEqualToString:display]) {
            [tempList addObject:obj];
        }
    }
    NSLog(@"filterDisplay count: %d",[tempList count]);
    self.items_data = [[NSMutableArray alloc] initWithArray:tempList copyItems:YES];
    [tempList release];
}

#pragma mark - UITableViewDelegate

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"table view row count:%d",[self.items_data count]);
//    NSLog(@"table view row count:%d",[self.items_total count]);
//    NSLog(@"table view frame:%f,%f,%f,%f",fund_table.frame.origin.x,fund_table.frame.origin.y, fund_table.frame.size.width, fund_table.frame.size.height);
    //    [text_view setFrame:CGRectMake(0, fund_table.frame.size.height,text_view.frame.size.width, text_view.frame.size.height)];
    return [self.items_data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"tableView:(UITableView *)tableView cellForRowAtIndexPath");
//    NSLog(@"indexPath : %@",indexPath);
   	NSUInteger index = indexPath.row;
	id obj = [self.items_data objectAtIndex:index];
	NSString *identifier = @"RateNoteAndTTCell";
    RateNoteAndTTCell *cell = [[RateNoteAndTTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (indexPath.row%2==1) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_gray.png"]];
    } else {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"borderlist_thin_white.png"]];
    }
    if ([MBKUtil isLangOfChi]) {
        cell.lbCurrency.text = [NSString stringWithFormat:@"%@",[obj objectForKey:@"display_name_zh"]];
    }else{
        cell.lbCurrency.text = [NSString stringWithFormat:@"%@",[obj objectForKey:@"display_name_en"]];
    }
	cell.lbBankBuy.text = [NSString stringWithFormat:@"%0.5f",[[obj objectForKey:@"bankbuy"] doubleValue]];
    cell.lbBankSell.text = [NSString stringWithFormat:@"%0.5f",[[obj objectForKey:@"banksell"] doubleValue]];
	return cell;
}

//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
//}


#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request {
//    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
    NSLog(@"RateTT: request finish");
//    NSLog(@"RateTT: request finish:%@", reponsedString);
    [[CoreData sharedCoreData].mask hiddenMask];
    if(![RateUtil checkResponseData:[request responseData] rateType:@"tt"]){
        [[RateUtil me] alertAndBackToMain:self]; 
        return;
    }
    [RateUtil updateRateFile:[request responseData] rateType:@"tt"];
    [self parseCfgFile];
    [fund_table reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"RateTT: request failed.:%@", request.error);
    
    [[CoreData sharedCoreData].mask hiddenMask];
    [[RateUtil me] alertAndBackToMain:self];
}


@end
