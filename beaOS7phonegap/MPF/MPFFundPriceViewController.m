#import "MPFFundPriceViewController.h"
#import "MPFUtil.h"

// private method define here
@interface MPFFundPriceViewController()

-(void) parseCfgFile;

@end

@implementation MPFFundPriceViewController

@synthesize scroll_view,fund_table, time_label, bt_trust, bt_industry, text_view;
@synthesize items_data, items_total,items_mt ,items_ind;;
@synthesize schemes_total;
@synthesize buttons_total;
@synthesize date_stamp;
@synthesize flag,note_textview;
@synthesize bt_mybalance;
@synthesize labTitle;
@synthesize fundname_label;
@synthesize NAV_label;
@synthesize notes;

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
    if (![MBKUtil wifiNetWorkAvailable]) {
        [[MPFUtil me] alertAndBackToMain];
        return ;
    }
    
    [super viewDidLoad];
    [self.view addSubview:self.scroll_view];
    
    btnPageNext.accessibilityLabel = NSLocalizedString(@"mpf.btnPageNext", nil);
    btnPagePrev.accessibilityLabel = NSLocalizedString(@"mpf.btnPagePrev", nil);
    scroll_view.frame = CGRectMake(0, 113, scroll_view.frame.size.width, scroll_view.frame.size.height+[[MyScreenUtil me] getScreenHeightAdjust]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [[MyScreenUtil me] adjustmentcontrolY20:scroll_view];
        [[MyScreenUtil me] adjustmentcontrolY20:scroll_view_scheme_pad];
        [[MyScreenUtil me] adjustmentcontrolY20:text_view];
        [[MyScreenUtil me] adjustmentcontrolY20:fund_table];
        [[MyScreenUtil me] adjustmentcontrolY20:time_label];
        [[MyScreenUtil me] adjustmentcontrolY20:note_textview];
        
        [[MyScreenUtil me] adjustmentcontrolY20:labTitle];
        [[MyScreenUtil me] adjustmentcontrolY20:labTitleBackImg];
        [[MyScreenUtil me] adjustmentcontrolY20:fundname_label];
        [[MyScreenUtil me] adjustmentcontrolY20:NAV_label];
        
        [[MyScreenUtil me] adjustmentcontrolY20:bt_mybalance];
        [[MyScreenUtil me] adjustmentcontrolY20:btnPagePrev];
        [[MyScreenUtil me] adjustmentcontrolY20:btnPageNext];
        [[MyScreenUtil me] adjustmentcontrolY20:pageControl];
        
        [[MyScreenUtil me] adjustmentcontrolY20:backgroundImg1];
        [[MyScreenUtil me] adjustmentcontrolY20:backgroundImg2];
    }

    CGRect mFrame;
    mFrame = time_label.frame;
    mFrame.origin.y = mFrame.origin.y + [[MyScreenUtil me] getScreenHeightAdjust];
    time_label.frame = mFrame;
    NSLog(@"%@",NSStringFromCGRect(time_label.frame));
    
    mFrame = bt_mybalance.frame;
    mFrame.origin.y = mFrame.origin.y + [[MyScreenUtil me] getScreenHeightAdjust];
    bt_mybalance.frame = mFrame;
    
    [self.scroll_view addSubview:self.fund_table];
    self.time_label.text=@"";
    
    [self.bt_industry setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [self.bt_trust setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    
    [self.labTitle setText:NSLocalizedString(@"mpf.fundprice.title",nil)];
    [self.fundname_label setText:NSLocalizedString(@"mpf.label.fundname",nil)];
    [self.NAV_label setText:NSLocalizedString(@"mpf.lable.NAV",nil)];
    
	[self.bt_mybalance setTitle:NSLocalizedString(@"MyBalance",nil) forState:UIControlStateNormal];
    [self.bt_mybalance addTarget:self action:@selector(callMBKMPFBalance:) forControlEvents:UIControlEventTouchUpInside];
    self.bt_mybalance.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.bt_mybalance.titleLabel.font=[UIFont boldSystemFontOfSize:14];
    
    [self.scroll_view addSubview:self.text_view];
    btnPagePrev.hidden=YES;
    btnPageNext.hidden=YES;
    
    self.fund_table.scrollEnabled=NO;
    note_textview.font = [UIFont systemFontOfSize:13];
    
    [self loadFundData];
}

-(void)callMBKMPFBalance:(UIButton *)button
{
    [[MPFUtil me] do_callMBKMPFBalance];
}

- (void)viewDidUnload
{
    [labTitleBackImg release];
    labTitleBackImg = nil;
    [backgroundImg1 release];
    backgroundImg1 = nil;
    [backgroundImg2 release];
    backgroundImg2 = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [labTitleBackImg release];
    [backgroundImg1 release];
    [backgroundImg2 release];
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

-(void) loadFundData
{
    // check DateStamp is expired
    NSMutableDictionary *md_temp = [NSMutableDictionary  dictionaryWithContentsOfFile:[[MPFUtil me ] findFundPricePlistPath]];
    self.date_stamp = [md_temp objectForKey:@"DateStamp"];
    if (self.date_stamp == nil) {
        [[MPFUtil me] checkingMPFServerReady:self];
        return;
    }
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *now = [NSDate date];
    now = [formatter dateFromString:[formatter stringFromDate:now] ];
    NSDate *updateDate = [formatter dateFromString:self.date_stamp];
    NSLog(@"current date:%@, update_date:%@",[formatter stringFromDate:now],self.date_stamp);
    BOOL dateExpired = ((NSOrderedDescending == [now  compare:updateDate]));
    NSLog(@"MPFFundPrice: dateExpired:%d",dateExpired);
    if (dateExpired) {
        [[MPFUtil me] checkingMPFServerReady:self];
    }else{
        [self showContents];
    }
    
}

-(void) showContents{
    [self parseCfgFile];
    
    [self showScheme:1];
    
}

-(void) parseCfgFile{
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:[[MPFUtil me ]findFundPricePlistPath]];
    self.date_stamp = [md_temp objectForKey:@"DateStamp"];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *updateDate = [formatter dateFromString:self.date_stamp];
    if ([MBKUtil isLangOfChi]){
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }else{
        [formatter setDateFormat:@"dd MMM yyyy"];
        
    }
    self.time_label.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"mpf.fundprice.time",nil), [formatter stringFromDate:updateDate]];
    self.items_total = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"FundPriceList"] copyItems:YES];
	NSLog(@"MPFFundPriceViewController: parseCfgFile count:%d", [self.items_total count]);
    self.schemes_total = [[NSMutableArray alloc] initWithArray:[md_temp objectForKey:@"SchemeList"] copyItems:YES];
    
	if ([self.items_total count] <=0 || [self.schemes_total count] <=0) {
		self.time_label.text=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"mpf.fundprice.time",nil),@"00/00/0000"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Cannot find any fund price information",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert show];
		[alert release];
        return;
	}
    
    if (!buttons_total){
        buttons_total = [NSMutableArray new];
        int index=0;
        NSLog(@"MPFFundPriceViewController: parseCfgFile schemes_total:%@", self.schemes_total);
        for (id obj in self.schemes_total) {
            NSLog(@"MPFFundPriceViewController: parseCfgFile scheme:%@", obj);
            UIButton* button=[[UIButton alloc] initWithFrame:CGRectMake(0+index*250, 0, 250, 34)];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1] forState:UIControlStateSelected];
            button.tag = [[obj objectForKey:@"sid"] integerValue];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            if ([MBKUtil isLangOfChi]){
                [button setTitle:[obj objectForKey:@"scheme_zh"] forState:UIControlStateNormal];
            }else{
                [button setTitle:[obj objectForKey:@"scheme_en"] forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(schemeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [buttons_total addObject:button];
            [scroll_view_scheme_pad addSubview:button];
            NSLog(@"MPFFundPriceViewController: parseCfgFile scheme button:%@", button);
            index++;
        }
        scroll_view_scheme_pad.contentSize = CGSizeMake(scroll_view_scheme_pad.frame.size.width * [self.schemes_total count], scroll_view_scheme_pad.frame.size.height);
        scroll_view_scheme_pad.pagingEnabled = YES;
        scroll_view_scheme_pad.showsHorizontalScrollIndicator = NO;
        scroll_view_scheme_pad.showsVerticalScrollIndicator = NO;
        scroll_view_scheme_pad.scrollsToTop = NO;
        scroll_view_scheme_pad.delegate = self;
    }
    pageControl.currentPage = 0;
    btnPageNext.hidden=NO;
    pageControl.numberOfPages = [self.schemes_total count];
    
    NSMutableDictionary *md_temp_notes = [NSMutableDictionary dictionaryWithContentsOfFile:[[MPFUtil me ]findFundPriceNotePlistPath]];
    self.notes = [[NSMutableArray alloc] initWithArray:[md_temp_notes objectForKey:@"note"] copyItems:YES];
}

-(IBAction) changePage{
    CGRect frame = scroll_view_scheme_pad.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
    [scroll_view_scheme_pad scrollRectToVisible:frame animated:YES];
    
    [self showScheme:pageControl.currentPage+1];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender{
    CGFloat pageWidth = scroll_view_scheme_pad.frame.size.width;
    pageControl.currentPage =  floor((scroll_view_scheme_pad.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (pageControl.currentPage == 0){
        btnPagePrev.hidden=YES;
    }else{
        btnPagePrev.hidden=NO;
    }
    if (pageControl.currentPage == (pageControl.numberOfPages-1)){
        btnPageNext.hidden=YES;
    }else{
        btnPageNext.hidden=NO;
    }
}

- (void) showScheme:(NSInteger)scheme_id
{
    UIButton* button=[[UIButton alloc] init];
    button.tag = scheme_id;
    [self schemeButtonClick:button];
    [button release];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self showScheme:pageControl.currentPage+1];
}

- (IBAction)doPrev:(id)sender {
    pageControl.currentPage--;
    [self changePage];
}

- (IBAction)doNext:(id)sender {
    pageControl.currentPage++;
    [self changePage];
}

#pragma mark - UITableViewDelegate

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 74;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    NSLog(@"table view row count:%d",[self.items_data count]);
    
    return [self.items_data count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   	NSUInteger index = indexPath.row;
	id obj = [self.items_data objectAtIndex:index];
	NSString *identifier = @"MPFFundCell";
    MPFFundCell *cell = [[MPFFundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	cell.accessoryType = UITableViewCellAccessoryNone;
    
    if ([MBKUtil isLangOfChi]){
        cell.scheme_label.text = [obj objectForKey:@"fund_zh"];
    }else{
        cell.scheme_label.text = [obj objectForKey:@"fund_en"];
    }
    
    NSString *nav = [obj objectForKey:@"NAV"];
    if([@"0" isEqualToString:nav]){
        cell.price_label.text = @"-";
    }else{
        cell.price_label.text = [NSString stringWithFormat:@"%0.4f",[[obj objectForKey:@"NAV"] doubleValue]];
	}
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}



#pragma mark - IBAction Listener
-(void) schemeButtonClick:(id)sender{
    UIButton* send_button = (UIButton*)sender;
    //    NSLog(@"schemeButtonClick:%@", send_button);
    
    if ([self.items_data count]>0){
        NSInteger scheme = [[[self.items_data objectAtIndex:0] objectForKey:@"sid"] integerValue];
        if (scheme == send_button.tag) {
            NSLog(@"schemeButtonClick end without changed.");
            return;
        }
    }
    
    for (id obj in self.buttons_total) {
        UIButton* opt_button = (UIButton*)obj;
        if (opt_button.tag==send_button.tag){
            [opt_button setSelected:YES];
        }else{
            [opt_button setSelected:NO];
        }
    }
    
    NSMutableArray *tempList = [NSMutableArray new];
    for (id obj in self.items_total) {
        NSInteger scheme = [[obj objectForKey:@"sid"] integerValue];
        if (scheme == send_button.tag) {
            [tempList addObject:obj];
        }
    }
    
    if (!self.items_data){
        [self.items_data release];
    }
    self.items_data = [[NSMutableArray alloc] initWithArray:tempList copyItems:YES];
    [tempList release];
    
    [self parseNoteFile:send_button.tag];
    
    [self updateViews];
}

-(void) parseNoteFile:(NSInteger)scheme
{
    
    NSLog(@"parseNoteFile, scheme:%d-------", scheme);
    
	if ([self.notes count] <=0) {
        return;
	}
    
    note_textview.text=@"";
    NSMutableDictionary *subnote;
    NSString* subnote_str;
    
    for (int i=0; i<[notes count]; i++) {
        subnote = [notes objectAtIndex:i];
        NSInteger sid = [[subnote objectForKey:@"sid"] integerValue];
        
        if(scheme==sid){
            if ([MBKUtil isLangOfChi]){
                subnote_str = [subnote objectForKey:@"subnote_zh"];
            }else{
                subnote_str = [subnote objectForKey:@"subnote_en"];
            }
            
            if (subnote_str!=NULL){
                if ([note_textview.text length]>0){
                    note_textview.text = [NSString stringWithFormat:@"%@\n\n%@", note_textview.text, subnote_str];
                }else{
                    note_textview.text = [NSString stringWithFormat:@"%@", subnote_str];
                }
            }
        }
    }
    
    note_textview.text = [note_textview.text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    
}

-(void)updateViews
{
    [self.fund_table reloadData];
    
    CGRect frame = self.fund_table.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.scroll_view.frame.size.width;
    frame.size.height = 74*[self.items_data count];
    self.fund_table.frame = frame;
    
    CGSize maxSize = CGSizeMake(note_textview.frame.size.width, 10000);
    CGSize text_area = [self.note_textview.text sizeWithFont:self.note_textview.font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    frame = self.note_textview.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = self.text_view.frame.size.width;
    frame.size.height = text_area.height*1.05+50;
    self.note_textview.frame = frame;
    
    frame = self.text_view.frame;
    frame.origin.x = 0;
    frame.origin.y = self.fund_table.frame.origin.y+self.fund_table.frame.size.height;
    frame.size.width = self.scroll_view.frame.size.width;
    frame.size.height = self.note_textview.frame.size.height;
    self.text_view.frame = frame;
    
    [self.scroll_view setContentSize:CGSizeMake(320, self.fund_table.frame.size.height+self.text_view.frame.size.height)];
    
    frame = self.scroll_view.frame;
    frame.origin.y = 0;
    [self.scroll_view scrollRectToVisible:frame animated:YES];
    
}

@end
