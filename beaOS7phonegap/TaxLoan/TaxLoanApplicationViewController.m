//
//  TaxLoanApplicationViewController.m
//  BEA
//
//  Created by YAO JASEN on 10/15/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import "TaxLoanApplicationViewController.h"

#define MAX_LOAN_AMOUNT 1000000.00

@implementation TaxLoanApplicationViewController

@synthesize namePre_list, numberFormatter;
//@synthesize ls_loanPlan, ls_repaymentPeriod;
@synthesize ls_repaymentPeriod;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 20, 320, 411+[[MyScreenUtil me] getScreenHeightAdjust]);
    scroll_view.frame = CGRectMake(0, 44, 320, 370+[[MyScreenUtil me] getScreenHeightAdjust]);

    [scroll_view setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100)];
	numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[numberFormatter setMaximumFractionDigits:2];
	[numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
	
	self.namePre_list = [NSLocalizedString(@"Mr.,Miss,Ms.,Mrs.",nil) componentsSeparatedByString:@","];
	NSLog(@"%@", namePre_list);
	namePre_index = 0;
	
	[btNamePre setTitle:[self.namePre_list objectAtIndex:namePre_index] forState:UIControlStateNormal];
	btNamePre.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	/*	
	 [btLoanPlanGeneralCustomers setTitle:NSLocalizedString(@"General Customers", nil) forState:UIControlStateNormal];
	 btLoanPlanGeneralCustomers.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	 btLoanPlanGeneralCustomers.titleLabel.numberOfLines = 2;
	 btLoanPlanGeneralCustomers.titleLabel.textAlignment = NSTextAlignmentCenter;
	 btLoanPlanGeneralCustomers.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	 btLoanPlanGeneralCustomers.titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	 btLoanPlanGeneralCustomers.selected = YES;
	 
	 [btLoanPlanProfessionals setTitle:NSLocalizedString(@"Privileged Customers", nil) forState:UIControlStateNormal];
	 btLoanPlanProfessionals.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	 btLoanPlanProfessionals.titleLabel.numberOfLines = 2;
	 btLoanPlanProfessionals.titleLabel.textAlignment = NSTextAlignmentCenter;
	 btLoanPlanProfessionals.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	 btLoanPlanProfessionals.titleLabel.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	 btLoanPlanProfessionals.selected = NO;
	 */	
	[btRepaymentPeriod12 setTitle:NSLocalizedString(@"12 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod12.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod12.selected = YES;
	
	[btRepaymentPeriod24 setTitle:NSLocalizedString(@"24 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod24.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod24.selected = NO;
	
	[btRepaymentPeriod36 setTitle:NSLocalizedString(@"36 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod36.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod36.selected = NO;
	
	[btRepaymentPeriod48 setTitle:NSLocalizedString(@"48 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod48.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod48.selected = NO;
    
    [btRepaymentPeriod60 setTitle:NSLocalizedString(@"60 Months", nil) forState:UIControlStateNormal];
	btRepaymentPeriod60.titleLabel.font = [UIFont boldSystemFontOfSize:11];
	btRepaymentPeriod60.selected = NO;
	
	btCheck.selected = NO;
	
	[btCall setTitle:NSLocalizedString(@"Call now", nil) forState:UIControlStateNormal];
	btCall.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	
	[btClear setTitle:NSLocalizedString(@"Clear", nil) forState:UIControlStateNormal];
	btClear.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	
	[btSubmit setTitle:NSLocalizedString(@"Submit", nil) forState:UIControlStateNormal];
	btSubmit.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	
	lbTitle.text = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"Tax Loan",nil), NSLocalizedString(@"Application",nil)];
	lbTitle.font = [UIFont boldSystemFontOfSize:17];
	lbTitle.textAlignment = NSTextAlignmentCenter;
	lbTitle.numberOfLines = 2;
	lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
	
	lbTag00.text = NSLocalizedString(@"TaxLoanApplicationTag00",nil);
	lbTag00.textColor = [UIColor colorWithRed:0.91 green:0.113 blue:0.31 alpha:1];
	lbTag01.text = NSLocalizedString(@"TaxLoanApplicationTag01",nil);
	lbTag02.text = NSLocalizedString(@"Name:",nil);
	lbTag03.text = NSLocalizedString(@"Mobile no.:",nil);
	lbTag04.text = NSLocalizedString(@"Email address:",nil);
	lbTag05.text = NSLocalizedString(@"Loan amount (HK$):",nil);
	lbTag06.text = NSLocalizedString(@"Loan plan:",nil);
	lbTag07.text = NSLocalizedString(@"Repayment Period:",nil);
	lbTag08.text = NSLocalizedString(@"TaxLoanApplicationTag08",nil);
	
	if (![MBKUtil isLangOfChi]) {
		btCheck.center = CGPointMake(27, 240);
		lbTag08.center = CGPointMake(162, 240);
		btStatement = [[UIButton alloc] initWithFrame:CGRectMake(25, 250, 300, 30)];
	}else {
		btCheck.center = CGPointMake(30, 240);
		lbTag08.center = CGPointMake(162, 240);
		btStatement = [[UIButton alloc] initWithFrame:CGRectMake(125, 240, 150, 14)];
	}
	[btStatement setTitle:NSLocalizedString(@"TaxLoanApplicationPICStatement", nil) forState:UIControlStateNormal];
	btStatement.titleLabel.font = [UIFont italicSystemFontOfSize:11];
	btStatement.backgroundColor = [UIColor clearColor];
	[btStatement setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[btStatement addTarget:self action:@selector(btStatementPressed:) forControlEvents:UIControlEventTouchUpInside];
	btStatement.titleLabel.numberOfLines = 2;
	btStatement.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	
	[scroll_view addSubview:btStatement];
	
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
    
	
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
    [numberFormatter release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
  	[[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];
	if (items_data != nil){
		[items_data removeAllObjects];
		[items_data release];
	}
}

-(IBAction)screenPressed{
	[tfName resignFirstResponder];
	[tfMobileno resignFirstResponder];
	[tfEmail resignFirstResponder];
	[tfLoanAmount resignFirstResponder];
}
/*
 -(IBAction)btLoanPlanGeneralCustomersPressed{
 btLoanPlanGeneralCustomers.selected = YES;
 btLoanPlanProfessionals.selected = NO;
 }
 
 -(IBAction)btLoanPlanProfessionalsPressed{
 btLoanPlanGeneralCustomers.selected = NO;
 btLoanPlanProfessionals.selected = YES;
 }
 */
-(IBAction)btRepaymentPeriod12Pressed{
	btRepaymentPeriod12.selected = YES;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
    btRepaymentPeriod60.selected = NO;
}

-(IBAction)btRepaymentPeriod24Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = YES;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
    btRepaymentPeriod60.selected = NO;
}

-(IBAction)btRepaymentPeriod36Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = YES;
	btRepaymentPeriod48.selected = NO;
    btRepaymentPeriod60.selected = NO;
}

-(IBAction)btRepaymentPeriod48Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = YES;
    btRepaymentPeriod60.selected = NO;
}

-(IBAction)btRepaymentPeriod60Pressed{
	btRepaymentPeriod12.selected = NO;
	btRepaymentPeriod24.selected = NO;
	btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
    btRepaymentPeriod60.selected = YES;
}

-(BOOL)validateFormValue{
	
	BOOL lb_pass = NO;
	NSString *ls_alertmsg = @"";
	
	//	NSRange rMobileNo;
	//	NSString *regExMobileNo = @"[0-9]{8}";
	//	rMobileNo = [tfMobileno.text rangeOfString:regExMobileNo options:NSRegularExpressionSearch];
	//	NSLog(@"regExMobileNo:%@--r:%d--%d--%d", regExMobileNo, rMobileNo.location, rMobileNo.length, NSNotFound);
	
	//	NSRange rEmail;
	//	NSString *regExEmail = @".*@.*";
	//	rEmail = [tfEmail.text rangeOfString:regExEmail options:NSRegularExpressionSearch];
	//	NSLog(@"regExEmail:%@--r:%d--%d--%d", regExEmail, rEmail.location, rEmail.length, NSNotFound);
	
	float lf_loanamount = [[tfLoanAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
	
	if ([[tfName.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]<1) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg04", nil);
	}else if ([[tfMobileno.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]<1) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg05", nil);
	}else if ([[tfMobileno.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]!=8) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg06", nil);
		//	}else if ([[tfEmail.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]<1) {
		//		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg07",nil);
		//	}else if (rEmail.location == NSNotFound) {
		//		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg08", nil);
	}else if ([[tfLoanAmount.text stringByReplacingOccurrencesOfString:@" " withString:@""] length]<1) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg09",nil);
	}else 	if (lf_loanamount<5000) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg02", nil);
	}else if (lf_loanamount>1000000) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg03", nil);
	}else if (!btCheck.selected) {
		ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg01",nil);
	}else {
		lb_pass = YES;
	}
	
	NSLog(@"lb_pass:%d", lb_pass);
	
	if (!lb_pass) {
		UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:ls_alertmsg delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
		[alert_view show];
		[alert_view release];
		
	}
	
	return lb_pass;
}

-(IBAction)submitButtonPressed{
	
	if (![self validateFormValue]) {
		return;
	}
	//	NSLog(@"submitButtonPressed 1");
	/*	
	 if (btLoanPlanGeneralCustomers.selected) {
	 ls_loanPlan = @"gen";
	 }else {
	 ls_loanPlan = @"pro";
	 }
	 */	
	if (btRepaymentPeriod12.selected) {
		ls_repaymentPeriod = @"12";
	}else if (btRepaymentPeriod24.selected) {
		ls_repaymentPeriod = @"24";
	}else if (btRepaymentPeriod36.selected) {
		ls_repaymentPeriod = @"36";
	}else if (btRepaymentPeriod48.selected) {
		ls_repaymentPeriod = @"48";
	}else if (btRepaymentPeriod60.selected){
        ls_repaymentPeriod = @"60";
    }
    
/*    
     //	NSLog(@"submitButtonPressed 2");
     
     //	NSString *ls_url = [NSString stringWithFormat:@"%@&name=%@&mbno=%@&email=%@&amount=%@&plan=%@&period=%@&namepre=%d", [MBKUtil getURLOfTaxLoanApplication], [tfName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], tfMobileno.text, tfEmail.text, tfLoanAmount.text, ls_loanPlan, ls_repaymentPeriod, namePre_index];
     //URL For Consumer loan application
     NSString *ls_url = [NSString stringWithFormat:@"%@&name=%@&mbno=%@&email=%@&amount=%@&period=%@&namepre=%d", [MBKUtil getURLOfTaxLoanApplication], [tfName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], tfMobileno.text, tfEmail.text, tfLoanAmount.text, ls_repaymentPeriod, namePre_index];
     
     //Quick Test Cash In Hand
     //NSString *ls_url = [NSString stringWithFormat:@"%@&name=%@&mbno=%@&email=%@&amount=%@&period=%@&namepre=%d&plan=cih", [MBKUtil getURLOfTaxLoanApplication], [tfName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], tfMobileno.text, tfEmail.text, tfLoanAmount.text, ls_repaymentPeriod, namePre_index];
     NSLog(@"ls_url:%@",ls_url);
     
     NSURL *url = [NSURL URLWithString:ls_url];
     ASIHTTPRequest *asi_request = nil;
     asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
     NSLog(@"url:%@",asi_request.url);
     [asi_request setUsername:@"iphone"];
     [asi_request setPassword:@"iphone"];
     [asi_request setValidatesSecureCertificate:NO];
     asi_request.delegate = self;
     [[CoreData sharedCoreData].queue addOperation:asi_request];
*/     
    

	
    NSURL *url = [NSURL URLWithString:[MigrationSetting me].URLOfTaxLoanApplication];
    
    NSMutableDictionary* param= [HttpRequestUtils getBasicPostDatas];
    
    [param setValue:@"TLA" forKey:@"act"];
    [param setValue:tfName.text forKey:@"name"];
    [param setValue:tfMobileno.text forKey:@"mbno"];
    [param setValue:tfEmail.text forKey:@"email"];
    [param setValue:tfLoanAmount.text forKey:@"amount"];
    [param setValue:ls_repaymentPeriod forKey:@"period"];
    [param setValue:[NSNumber numberWithInt:namePre_index] forKey:@"namepre"];
    
	ASIFormDataRequest *request = [HttpRequestUtils getPostRequest:self
                                                               url:url
                                                           isHttps:true
                                                 requestParameters:param];
    
    [[CoreData sharedCoreData].queue addOperation:request];
	[[CoreData sharedCoreData].mask showMask];

}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	//	NSLog(@"rsp:%@", [request responseString]);
	
	[[CoreData sharedCoreData].mask hiddenMask];
	
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
	[request release];
	
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"debug TaxLoanApplicationViewController requestFailed:%@", request.error);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert_view show];
	[alert_view release];
	[[CoreData sharedCoreData].mask hiddenMask];
	[request release];
}


////////////////////
//XMLParserDelegate
////////////////////
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	if (items_data != nil){
		[items_data removeAllObjects];
		[items_data release];
	}
	key = [NSArray arrayWithObjects:@"Result",@"RefNo",@"ErrorCode",@"CodeDesc",@"Timestamp",@"msg",nil];
	items_data = [NSMutableArray new];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	if ([items_data count]!=0) {
		//		NSLog(@"parse end:%@", items_data);
		
		NSMutableDictionary *app_result = [NSMutableDictionary new];
		
		if ([[temp_record objectForKey:@"Result"] isEqualToString:@"SUCCESS"]) {
			[app_result setObject:[temp_record objectForKey:@"Result"] forKey:@"Result"];
			[app_result setObject:[temp_record objectForKey:@"RefNo"] forKey:@"refno"];
			[app_result setObject:[temp_record objectForKey:@"Timestamp"] forKey:@"Timestamp"];
			[app_result setObject:[temp_record objectForKey:@"msg"] forKey:@"msg"];
			[app_result setObject:tfName.text forKey:@"name"];
			[app_result setObject:tfMobileno.text forKey:@"mobileno"];
			[app_result setObject:tfEmail.text forKey:@"email"];
			//			[app_result setObject:tfLoanAmount.text forKey:@"loandetail"];
			
			NSString * ls_loanDetail;
			//			if ([ls_loanPlan isEqualToString:@"gen"]) {
			//				ls_loanPlan = NSLocalizedString(@"General Customers", nil);
			//			}else {
			//				ls_loanPlan = NSLocalizedString(@"Privileged Customers", nil);
			//			}
			
			ls_loanDetail = [NSString stringWithFormat:@"%@%@%@,\n%@%@%@",
							 NSLocalizedString(@"HK$",nil),
							 tfLoanAmount.text,
							 NSLocalizedString(@"TaxLoanDetail_part1_yuan",nil), 
							 //							 ls_loanPlan, 
							 NSLocalizedString(@"TaxLoanDetail_part2",nil), 
							 ls_repaymentPeriod,
							 NSLocalizedString(@"TaxLoanDetail_part3", nil)];
			[app_result setObject:ls_loanDetail forKey:@"loandetail"];
			
			TaxLoanApplicationResultViewController *view_controller;
			view_controller = [[TaxLoanApplicationResultViewController alloc] initWithNibName:@"TaxLoanApplicationResultViewController" bundle:nil];
			view_controller.temp_record = app_result;
			[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
			
		}else if ([[temp_record objectForKey:@"Result"] isEqualToString:@"FAIL"]) {
			[app_result setObject:[temp_record objectForKey:@"Result"] forKey:@"Result"];
			[app_result setObject:[temp_record objectForKey:@"ErrorCode"] forKey:@"ErrorCode"];
			[app_result setObject:[temp_record objectForKey:@"Timestamp"] forKey:@"Timestamp"];
			[app_result setObject:[temp_record objectForKey:@"CodeDesc"] forKey:@"CodeDesc"];
			
			TaxLoanApplicationResultFailViewController *view_controller;
			view_controller = [[TaxLoanApplicationResultFailViewController alloc] initWithNibName:@"TaxLoanApplicationResultFailViewController" bundle:nil];
			view_controller.temp_record = app_result;
			[[CoreData sharedCoreData].taxLoan_view_controller.navigationController pushViewController:view_controller animated:TRUE];
			[view_controller release];
		}
		
		NSLog(@"parse end:%@", app_result);
		
	}
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"Response"]) {
		temp_record = [NSMutableDictionary new];
	}
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"Response"]) {
		[items_data addObject:temp_record];
	}
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	for (int i=0; i<[key count]; i++) {
		if ([currentElementName isEqualToString:[key objectAtIndex:i]] && [temp_record objectForKey:currentElementName]==nil) {
			[temp_record setObject:string forKey:currentElementName];
		}
	}
}

-(IBAction)call{
	[[TaxLoanUtil new ]callToApply];
}

-(IBAction)btNamePrePressed{
	namePre_index++;
	if (namePre_index >= [self.namePre_list count]){
		namePre_index = 0;
	}
	[btNamePre setTitle:[self.namePre_list objectAtIndex:namePre_index] forState:UIControlStateNormal];
}

-(IBAction)btClearPressed{
	tfName.text = @"";
	tfMobileno.text = @"";
	tfEmail.text = @"";
	tfLoanAmount.text = @"";
	
	namePre_index = 0;
	[btNamePre setTitle:[self.namePre_list objectAtIndex:namePre_index] forState:UIControlStateNormal];
	
	//	btLoanPlanGeneralCustomers.selected = YES;
	//	btLoanPlanProfessionals.selected = NO;
	
	btRepaymentPeriod12.selected = YES;
	btRepaymentPeriod24.selected = NO;
    btRepaymentPeriod36.selected = NO;
	btRepaymentPeriod48.selected = NO;
    btRepaymentPeriod60.selected = NO;
    btCheck.selected = NO;
}

#pragma  mark -
#pragma  mark UITextFieldDelegate

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        [[MBKUtil me].queryButton1 setHidden:NO];
    }else{
        [[MBKUtil me].queryButton1 setHidden:YES];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self screenPressed];
	return TRUE;
}

-(void)queryFromKeypad:(UIButton *) btnQuery{
    [self screenPressed];
}

#pragma mark -

-(IBAction)btCheckPressed{
	if(btCheck.selected){
		btCheck.selected = NO;
	}else {
		btCheck.selected = YES;
	}
}

-(IBAction)btStatementPressed:(id)sender{
	WebViewController *webViewController;
	webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
    [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]]; //To be retested
	[self.navigationController pushViewController:webViewController animated:TRUE];
	//[webViewController.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]];
	[webViewController release];
}

-(IBAction) didBeginEditEmail:(id)sender{
    [scroll_view setContentOffset:CGPointMake(0, tfEmail.frame.origin.y-50) animated:TRUE];
}


-(IBAction)didEndEditName:(id)sender{
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
	NSLog(@"didEndEdit:%@", sender);
}

-(IBAction)didEndEditMobileNo:(id)sender{
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
	NSLog(@"didEndEdit:%@", sender);
}

-(IBAction)didEndEditEmail:(id)sender{
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
	NSLog(@"didEndEdit:%@", sender);
}

-(IBAction)didEndEditLoanAmount:(id)sender{
    [scroll_view setContentOffset:CGPointMake(0, 0) animated:TRUE];
	NSLog(@"didEndEdit:%@", sender);
    NSString *ls_alertmsg = @"";
    ls_alertmsg = NSLocalizedString(@"TaxLoanApplicationAlertMsg03", nil);
    
    if (![tfLoanAmount.text isEqualToString:@""]){
        float lfLoanAmount = [[tfLoanAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        if (lfLoanAmount>MAX_LOAN_AMOUNT){
            
            UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:ls_alertmsg delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
            [alert_view show];
            [alert_view release];

            
            
            
            lfLoanAmount=MAX_LOAN_AMOUNT;
        }
        tfLoanAmount.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:lfLoanAmount ]];
    }
}

-(IBAction)setAmount{
	tfLoanAmount.text = @"";
    [scroll_view setContentOffset:CGPointMake(0, tfLoanAmount.frame.origin.y-50) animated:TRUE];
}


@end