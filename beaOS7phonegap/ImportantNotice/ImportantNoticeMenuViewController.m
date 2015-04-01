//  Created by Jasen on 201308

#import "ImportantNoticeMenuViewController.h"
#import "SideMenuUtil.h"

@implementation ImportantNoticeMenuViewController
{
    UIButton *_callBtn;
}

@synthesize
mv_content,
m_nvc,
items_data;

@synthesize urlcurrent, urlfaq, urlsecurity, step, urlacc;
@synthesize key;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil nav:(UINavigationController *)a_nvc
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_nvc = a_nvc;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.openImportant = YES;
    UIView *mmenuv0;
    UIView *mmenuv1;
    UIView *mmenuv2;
//    UIView *mmenuv3;
    
    content_faq = [[ImportantNoticeContentViewController alloc] initWithNibName:@"ImportantNoticeContentViewController" bundle:nil];
    content_security = [[ImportantNoticeContentViewController alloc] initWithNibName:@"ImportantNoticeContentViewController" bundle:nil];
    contect_accessibility = [[ImportantNoticeContentViewController alloc] initWithNibName:@"ImportantNoticeContentViewController" bundle:nil];

    mmenuv0 = content_faq.view;
    mmenuv1 = content_security.view;
    mmenuv2 = contect_accessibility.view;
//    mmenuv3 = nil;
    NSLog(@"debug AccProMenuViewController viewDidLoad:%@", self);
    NSLog(@"debug AccProMenuViewController viewDidLoad 0:%@", mmenuv0);
    NSLog(@"debug AccProMenuViewController viewDidLoad 1:%@", mmenuv1);
    NSLog(@"debug AccProMenuViewController viewDidLoad 2:%@", mmenuv2);
    
    CGRect frame = self.mv_content.frame;
   frame.origin.x = 0;
    frame.origin.y = 0;
    
    [self.mv_content addSubview:mmenuv0];
    mmenuv0.frame = frame;
    [self.mv_content addSubview:mmenuv1];
    mmenuv1.frame = frame;
    [self.mv_content addSubview:mmenuv2];
    mmenuv2.frame = frame;

    RotateMenu2ViewController* v_rmvc = [[RotateMenu2ViewController alloc] initWithNibName:@"RotateMenu2ViewController" bundle:nil];
    v_rmvc.rmUtil.caller = self;
    
    [self.view addSubview:v_rmvc.contentView];
    
    NSArray* a_texts = [NSArray arrayWithObjects:NSLocalizedString(@"Frequently Asked Questions", nil),
                        NSLocalizedString(@"Security Tips", nil),
                        NSLocalizedString(@"accessibility", nil),
                        nil];
    [v_rmvc.rmUtil setTextArray:a_texts];
    
    NSArray* a_views = [NSArray arrayWithObjects:mmenuv0,mmenuv1,mmenuv2, nil];
    [v_rmvc.rmUtil setViewArray:a_views];
    
//    [v_rmvc.rmUtil setNav:self.m_nvc];
    [v_rmvc.rmUtil setNav:self.navigationController];
    [v_rmvc.rmUtil setShowIndex:mTag];
    [v_rmvc.rmUtil showMenu];
    
    mv_rmvc=v_rmvc;
    
    self.urlfaq = [NSString stringWithFormat:@"%@getinfo.api?type=12&lang=%@",
              [CoreData sharedCoreData].realServerURL,
              [[LangUtil me] getLangID]];
    self.urlsecurity = [NSString stringWithFormat:@"%@getinfo.api?type=13&lang=%@",
                   [CoreData sharedCoreData].realServerURL,
                   [[LangUtil me] getLangID]];
//    self.urlacc = NSLocalizedString(@"accessibility desc", nil);
    self.step = @"1";
    [self.items_data removeAllObjects];
    self.items_data = nil;
    self.items_data = [NSMutableArray new];
    
	self.key = [NSArray arrayWithObjects:
           @"id",
           @"title",
           @"desc",
           nil];

    [self loadPlistData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMenu:(int)show
{
    NSLog(@"debug AccProMenuViewController showMenu in:%d", show);
}

//-(void) welcome
//{
//    [mv_rmvc.rmUtil setShowIndex:0];
//    [mv_rmvc.rmUtil showMenu];
//
//}

-(void) welcome:(int)tag
{
    if (tag<0 || tag>2) {
        tag = 0;
    }
    mTag = tag;
//    [mv_rmvc.rmUtil setShowIndex:tag];
    [mv_rmvc.rmUtil showMenu];
    
}

- (void)dealloc {
    [mv_content release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMv_content:nil];
    [super viewDidUnload];
}

- (void) loadPlistData2{
    urlcurrent = urlsecurity;
    [self loadPlistData];
}

- (void) loadPlistData{
	NSLog(@"debug ImportantNoticeMenuViewController loadPlistData starts");
    
    ASIHTTPRequest* asi_request;
    
    if ([step isEqualToString:@"1"]) {
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:self.urlfaq]];
        
    } else if ([step isEqualToString:@"2"]) {
        asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:self.urlsecurity]];
    }

    NSLog(@"debug url:%@",asi_request.url);
    
    asi_request.delegate = self;
    [[CoreData sharedCoreData].queue addOperation:asi_request];
    
    [[CoreData sharedCoreData].mask showMask];
	NSLog(@"debug ImportantNoticeMenuViewController loadPlistData end");
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"debug ImportantNoticeMenuViewController requestFinished:%@", [reponsedString substringToIndex:[reponsedString length]/100]);
    
    NSString *ns_temp_file = [[TaxLoanUtil me ] findPlistPaths];
	[[request responseData] writeToFile:ns_temp_file atomically:YES];
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"ImportantNoticeMenuViewController >> requestFailed req:%@", request);
    
//    [self loadPlistDataDetail];
	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
    
}

-(void)loadPlistDataDetail{
    NSLog(@"loadPlistDataDetail starts");
    
    [[CoreData sharedCoreData].mask showMask];
    
    NSData * datas = [NSData dataWithContentsOfFile:[[TaxLoanUtil me ] findPlistPaths]];
    
    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:datas];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
    
    NSLog(@"loadPlistDataDetail end");
    
}

////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
    
    NSLog(@"debug parserDidStartDocument:%@", self.key);
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"debug parserDidEndDocument:%d outlets",[self.items_data count]);
	if ([temp_record count]==0) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert show];
//		[alert release];
	} else {
        if ([step isEqualToString:@"1"]) {
            step = @"2";
            [self loadPlistData];
        } else if ([step isEqualToString:@"2"]) {
            [self fillContents];
        }
	}
	NSLog(@"debug parserDidEndDocument:%@", self.items_data);
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
	}
    //	NSLog(@"debug didStartElement:%@",elementName);
}

-(void)fixspace:(NSString*)akey
{
    NSString* value=[temp_record objectForKey:akey];
//    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if ([akey isEqualToString:@"thumb"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
//    NSLog(@"debug fixspace end:[%@]", value);
    [temp_record setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        
//        [self fixspace:@"id"];
//        [self fixspace:@"image"];
//        [self fixspace:@"title"];
//        [self fixspace:@"tel"];
//        [self fixspace:@"tel_label"];
//        [self fixspace:@"thumb"];
        
        [self.items_data addObject:temp_record];
        //        NSLog(@"debug didEndElement----:%@",temp_record);
	}
    //	NSLog(@"debug didEndElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	for (int i=0; i<[self.key count]; i++) {
		if ([currentElementName isEqualToString:[self.key objectAtIndex:i]]) {
            NSString * oldstr = [temp_record objectForKey:currentElementName];
            if (!oldstr){
                oldstr = @"";
            }
            oldstr = [oldstr stringByAppendingString:string];
			[temp_record setObject:oldstr forKey:currentElementName];
            //            NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
		}
	}
    //	NSLog(@"debug foundCharacters:%@",currentElementName);
}

-(void) fillContents
{
    NSLog(@"debug fillContents:%@", self.items_data);
    
    [SideMenuUtil me].menu_view.accessibilityElementsHidden = YES;
    
    NSMutableDictionary* faq_dic = [self.items_data objectAtIndex:0];
    NSString* faq_txt = [faq_dic objectForKey:@"desc"];
    [content_faq.content_view setText:faq_txt];
    
    NSMutableDictionary* sec_dic = [self.items_data objectAtIndex:1];
    NSString* sec_txt = [sec_dic objectForKey:@"desc"];
    [content_security.content_view setText:sec_txt];
    
    [contect_accessibility.content_view removeFromSuperview];
    NSString *acc_txt = NSLocalizedString(@"accessibility desc", nil);
    UILabel *accLabel = [[UILabel alloc] init];
    accLabel.accessibilityLabel = NSLocalizedString(@"accessibility desc", nil);
    accLabel.font = [UIFont fontWithName:@".HelveticaNeueInterface-M3" size:14.00];
    [accLabel setText:acc_txt];
    accLabel.numberOfLines = 0;
    CGSize accLabelMaximumSize =CGSizeMake(300,9999);
    CGSize accLabelStringSize =[acc_txt sizeWithFont:accLabel.font
                               constrainedToSize:accLabelMaximumSize
                                   lineBreakMode:accLabel.lineBreakMode];
    CGRect accLabelFrame =CGRectMake(10,10,300, accLabelStringSize.height);
    accLabel.frame = accLabelFrame;
    [contect_accessibility.view addSubview:accLabel];
    contect_accessibility.view.userInteractionEnabled = YES;
//    contect_accessibility.content_view.accessibilityElementsHidden = YES;
    
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.text = NSLocalizedString(@"accessibility tel", nil);
    telLabel.font = [UIFont fontWithName:@".HelveticaNeueInterface-M3" size:14.00];
    CGSize telLabelMaximumSize =CGSizeMake(300,9999);
    CGSize telLabelStringSize =[telLabel.text sizeWithFont:telLabel.font
                               constrainedToSize:telLabelMaximumSize
                                       lineBreakMode:telLabel.lineBreakMode];
    CGRect telLabelFrame =CGRectMake(accLabel.frame.origin.x, accLabel.frame.size.height+30,telLabelStringSize.width, 20);
    telLabel.frame = telLabelFrame;
    [contect_accessibility.view addSubview:telLabel];
    
    _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _callBtn.frame = CGRectMake(telLabel.frame.size.width + telLabel.frame.origin.x, telLabel.frame.origin.y, 125, 20);
    [_callBtn setTitle:NSLocalizedString(@"accessibility telNumber", nil) forState:UIControlStateNormal];
    [_callBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _callBtn.titleLabel.font = [UIFont fontWithName:@".HelveticaNeueInterface-M3" size:14.00];
    [_callBtn addTarget:self action:@selector(btnCall:) forControlEvents:UIControlEventTouchUpInside];
    [contect_accessibility.view addSubview:_callBtn];
    
}

- (void)btnCall:(UIButton *)sender {
    UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:_callBtn.titleLabel.text message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
    [alert_view show];
    [alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *targetURL = [NSString stringWithFormat:@"tel:%@", [[alertView title] stringByReplacingOccurrencesOfString:@" " withString:@""],nil];
    NSLog(@"targetURL is %@", targetURL);
    if ([_callBtn.titleLabel.text isEqualToString:NSLocalizedString(@"accessibility telNumber", nil)]) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:targetURL]];
        }
    }
    
}

@end

