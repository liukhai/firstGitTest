//
//  CardLoanApplyFormView.m
//  BEA
//
//  Created by Jeff Cheung on 11年3月28日.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardLoanApplyFormViewController.h"
#import "subViewController.h"

@implementation CardLoanApplyFormViewController

@synthesize merchant_info;
@synthesize showBookmark;
@synthesize list_repaymentPoriod_number;
@synthesize list_repaymentPoriod_name;
@synthesize btn_repaymentPoriod;
@synthesize selected_repaymentPoriod_index;
@synthesize pickerView;// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
@synthesize selectNameArr, customView, fromType, subVC;
@synthesize selectName, repaymentBtn, callNowBtn, clear_btn, submit_btn, titleLabel, contactLabel;

- (void) syn_month_value
{
    [self.btn_repaymentPoriod setTitle:[self.list_repaymentPoriod_name objectAtIndex:[self.selected_repaymentPoriod_index intValue]] forState:UIControlStateNormal];
    month_value = [self.list_repaymentPoriod_number objectAtIndex:[self.selected_repaymentPoriod_index intValue]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		salutation_index = 0;
		up_boolean = NO;
		month_value = nil;
    }
    return self;
}


- (void)dealloc {
    [announce_btn2 release];
    [announce_label2 release];
    [loanbgView release];
    [numberbgView release];
    [namebgView release];
    [backgdView release];
    [imageView2 release];
    [imageView1 release];
    [[MBKUtil me].queryButton1 removeTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];

    
	if(tapRecognizer != nil){
		[bg_scrollview removeGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
		tapRecognizer = nil;
	}
	if(call_now_label != nil){
		[call_now_alert release];
		call_now_alert = nil;
	}
	if (items_data != nil){
		[items_data removeAllObjects];
		[items_data release];
		items_data = nil;
	}
	if(temp_record != nil){
		[temp_record release];
		temp_record = nil;
	}
   // [_selectName release];
 //   [_repaymentBtn release];
    [selectName release];
    [repaymentBtn release];
    [callNowBtn release];
    [clear_btn release];
    [submit_btn release];
    [titleLabel release];
    [contactLabel release];
    if (subVC != nil) {
        [subVC release];
    }
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *bgv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2.png"]] autorelease];
//	[self.view insertSubview:bgv atIndex:0];
//    bgv.frame = CGRectMake(0, 0, 320, 367+[[MyScreenUtil me] getScreenHeightAdjust]);
    self.view.frame = CGRectMake(0, 0, 320, 460+[[MyScreenUtil me] getScreenHeightAdjust]);
    bg_scrollview.frame = CGRectMake(0, 63, 320, 397+[[MyScreenUtil me] getScreenHeightAdjust]);

	//set words
	if(!showBookmark)
		title_label.text = NSLocalizedString(([NSString stringWithFormat:@"cih_title_%@", [merchant_info objectForKey:@"cashinhandtype"]]) , nil);
	else {
		title_label.text = NSLocalizedString(@"Bookmark",nil);
	}
	
	
	
	apply_express_label.text = NSLocalizedString(@"chi_apply_express", nil);
	//call_now_label.text = NSLocalizedString(@"chi_call_now", nil);
    [callNowBtn setTitle:NSLocalizedString(@"chi_call_now", nil) forState:UIControlStateNormal];
	office_time_label.text = NSLocalizedString(@"chi_office_time", nil);
	please_label.text = NSLocalizedString(@"chi_please", nil);

//    [titleLabel setText:NSLocalizedString(@"tag_cash_application", nil)];
    if ([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"cih"]) {
        [titleLabel setText:NSLocalizedString(@"tag_cash_application_cih", nil)];
    }
    else if ([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"btp"]) {
        [titleLabel setText:NSLocalizedString(@"tag_cash_application_btp", nil)];
    }
    else if ([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"sip"]) {
        [titleLabel setText:NSLocalizedString(@"tag_cash_application_sip", nil)];
        [self downAllSubViewOffset:20];
    }
    [selectName setTitle:[NSString stringWithFormat:@"  %@", NSLocalizedString(@"chi_Mr", nil)] forState:UIControlStateNormal];
    [contactLabel setText:NSLocalizedString(@"tag_bea_contact", nil)];
    
    
	name_label.text = NSLocalizedString(@"chi_name", nil);
	mobile_label.text = NSLocalizedString(@"chi_mobile", nil);
	email_label.text = NSLocalizedString(@"chi_email", nil);
//	loan_value_label.text = NSLocalizedString(@"chi_loan_value", nil);
    if ([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"cih"]) {
        loan_value_label.text = NSLocalizedString(@"cih_loan_value", nil);
    }
    else if ([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"btp"]) {
        loan_value_label.text = NSLocalizedString(@"btp_loan_value", nil);
    }
    else if ([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"sip"]) {
        loan_value_label.text = NSLocalizedString(@"sip_loan_value", nil);
    }

	repay_label.text = NSLocalizedString(@"chi_repay", nil);
	terms_label.text = NSLocalizedString(@"chi_terms", nil);
	announce_label.text = NSLocalizedString(@"chi_announce", nil);
	
	[clear_btn setTitle:NSLocalizedString(@"chi_clear", nil) forState:UIControlStateNormal];
	[submit_btn setTitle:NSLocalizedString(@"chi_submit", nil) forState:UIControlStateNormal];
	salutation_label.text = NSLocalizedString(@"chi_Mr", nil);
	salutation_index = 0;
	month_value = @"0";
    if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
        announce_label2.hidden=YES;
        announce_btn2.hidden=YES;
        announce_label.frame = CGRectMake(terms_label.frame.origin.x, terms_label.frame.origin.y + terms_label.frame.size.height, terms_label.frame.size.width, announce_label.frame.size.height);
	}else{
        announce_label2.hidden=NO;
        announce_btn2.hidden=NO;
        announce_label2.text = NSLocalizedString(@"chi_announce2", nil);
        announce_label.frame = CGRectMake(terms_label.frame.origin.x, terms_label.frame.origin.y +terms_label.frame.size.height-6, terms_label.frame.size.width, announce_label.frame.size.height);
    }
    
    please_label.font = [UIFont systemFontOfSize:11];
//    announce_label.frame = CGRectMake(terms_label.frame.origin.x, terms_label.frame.origin.y + terms_label.frame.size.height, terms_label.frame.size.width, announce_label.frame.size.height);
    clear_btn.frame = CGRectMake(clear_btn.frame.origin.x, announce_label.frame.origin.y + announce_label.frame.size.height + 4, clear_btn.frame.size.width, clear_btn.frame.size.height);
    submit_btn.frame = CGRectMake(submit_btn.frame.origin.x, announce_label.frame.origin.y + announce_label.frame.size.height + 4, submit_btn.frame.size.width, submit_btn.frame.size.height);
    

	//07042011
	announce_button.frame = announce_label.frame;
	[bg_scrollview bringSubviewToFront:announce_button];
	//
	bg_scrollview.contentSize = CGSizeMake(bg_scrollview.frame.size.width, submit_btn.frame.origin.y + submit_btn.frame.size.height + 5 + 200) ;
	//bg_scrollview.contentOffset = CGPointMake(0, 500);
	if(![[CoreData sharedCoreData].OS isEqualToString:@"3"]){
		tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
		//[bg_scrollview addGestureRecognizer:tapRecognizer];
	}
	
	//alert
	call_now_alert = [[UIAlertView alloc] initWithTitle:nil message:@"2211 1475" delegate:self cancelButtonTitle:NSLocalizedString(@"cancel",nil) otherButtonTitles:NSLocalizedString(@"call",nil), nil];
	
	//12042011
	email_sent_view.hidden = YES;
    
    [MBKUtil me].queryButtonWillShow= @"YES";
    [[MBKUtil me].queryButton1 addTarget:self action:@selector(queryFromKeypad:) forControlEvents:UIControlEventTouchUpInside];

    self.list_repaymentPoriod_number=[NSLocalizedString(@"list.repaymentPoriod.number",nil) componentsSeparatedByString:@","];
    self.list_repaymentPoriod_name=[NSLocalizedString(@"list.repaymentPoriod.name",nil) componentsSeparatedByString:@","];
    self.selected_repaymentPoriod_index=@"0";
    [btn_repaymentPoriod setImageEdgeInsets:UIEdgeInsetsMake(0, 120, 0, 0)];
    if ([MBKUtil isLangOfChi]) {
        [btn_repaymentPoriod setTitleEdgeInsets:UIEdgeInsetsMake(0, -106, 0, 0)];
    }else{
        [btn_repaymentPoriod setTitleEdgeInsets:UIEdgeInsetsMake(0, -84, 0, 0)];
    }

    RotateMenu3ViewController* v_rmvc = [[[RotateMenu3ViewController alloc] initWithNibName:@"RotateMenu3ViewController" bundle:nil] autorelease];
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeName:) name:@"changeName" object:nil];
    [clear_btn setFrame:CGRectMake(40, checkBox_btn.frame.origin.y + 100, 100, 30)];
    [submit_btn setFrame:CGRectMake(180, checkBox_btn.frame.origin.y + 100, 100, 30)];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        WebViewController *webViewController;
        webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]]; //To be retested
        webViewController.view.frame = CGRectMake(320, 0, 0, 0);
        [self.view addSubview:webViewController.view];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[PageUtil pageUtil] changeImageForTheme:self.view];
}

- (void)downAllSubViewOffset:(CGFloat)offset {
    CGRect frame;
    frame = imageView1.frame;
    [imageView1 setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + offset)];
    
    frame = titleLabel.frame;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    title_label.numberOfLines = 2;
    [titleLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + offset)];
    
    frame = imageView2.frame;
    [imageView2 setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = backgdView.frame;
    [backgdView setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = apply_express_label.frame;
    [apply_express_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = callNowBtn.frame;
    [callNowBtn setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = office_time_label.frame;
    [office_time_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = name_label.frame;
    [name_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = selectName.frame;
    [selectName setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = namebgView.frame;
    [namebgView setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = name_textfield.frame;
    [name_textfield setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = mobile_label.frame;
    [mobile_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = contactLabel.frame;
    [contactLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = mobile_textfield.frame;
    [mobile_textfield setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = numberbgView.frame;
    [numberbgView setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = loan_value_label.frame;
    [loan_value_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = loan_value_textfield.frame;
    [loan_value_textfield setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = loanbgView.frame;
    [loanbgView setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    
    frame = repay_label.frame;
    [repay_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = btn_repaymentPoriod.frame;
    [btn_repaymentPoriod setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = checkBox_btn.frame;
    [checkBox_btn setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = terms_label.frame;
    [terms_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = announce_label.frame;
    [announce_label setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = announce_label2.frame;
    [announce_label2 setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = announce_button.frame;
    [announce_button setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = announce_btn2.frame;
    [announce_btn2 setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = clear_btn.frame;
    [clear_btn setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
    frame = submit_btn.frame;
    [submit_btn setFrame:CGRectMake(frame.origin.x, frame.origin.y + offset, frame.size.width, frame.size.height)];
}

-(void)queryFromKeypad:(UIButton *) btnQuery{
    [self textFieldShouldReturn:nil];
    [self.view endEditing:TRUE];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {     
	if(sender.state == UIGestureRecognizerStateEnded){
		if(up_boolean){
			[bg_scrollview removeGestureRecognizer:tapRecognizer];
			[current_textfield resignFirstResponder];
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:0.3f];
			[UIView setAnimationDelegate:self];
			CGRect frame = self.view.frame;
			
			frame.origin.y = 0;
			
			self.view.frame = frame;
			[UIView commitAnimations];
			up_boolean = !up_boolean;
		}
	} 
}

#pragma mark -
#pragma  mark UITextFieldDelegate

-(void) textFieldDidBeginEditing:(UITextField *)textField{

    if (textField.keyboardType == UIKeyboardTypeNumberPad) {
        [[MBKUtil me].queryButton1 setHidden:NO];
    }else{
        [[MBKUtil me].queryButton1 setHidden:YES];
    }
}

#pragma mark -
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setSelectName:nil];
    [self setRepaymentBtn:nil];
    [self setCallNowBtn:nil];
    [self setClear_btn:nil];
    [self setSubmit_btn:nil];
    [self setTitleLabel:nil];
    [self setContactLabel:nil];
    [imageView1 release];
    imageView1 = nil;
    [imageView2 release];
    imageView2 = nil;
    [backgdView release];
    backgdView = nil;
    [namebgView release];
    namebgView = nil;
    [numberbgView release];
    numberbgView = nil;
    [loanbgView release];
    loanbgView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark -
#pragma mark touch delegate
-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {	
	if(up_boolean){
		bg_scrollview.userInteractionEnabled = YES;
		[current_textfield resignFirstResponder];
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3f];
		[UIView setAnimationDelegate:self];
		CGRect frame = self.view.frame;
		
		frame.origin.y = 0;
		
		self.view.frame = frame;
		[UIView commitAnimations];
		up_boolean = !up_boolean;
	}
}

#pragma mark -
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	if([[CoreData sharedCoreData].OS isEqualToString:@"3"]){
		bg_scrollview.userInteractionEnabled = YES;
	}
	else{
		[bg_scrollview removeGestureRecognizer:tapRecognizer];
	}
	[textField resignFirstResponder];
	if(up_boolean){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3f];
		[UIView setAnimationDelegate:self];
		CGRect frame = self.view.frame;
		
		frame.origin.y = 0;

		self.view.frame = frame;
		[UIView commitAnimations];
		up_boolean = !up_boolean;
	}
	return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"debug CardLoanApplyFormViewController textFieldShouldBeginEditing:%@", textField);
	if([[CoreData sharedCoreData].OS isEqualToString:@"3"]){
		bg_scrollview.userInteractionEnabled = NO;
	}
	else{
		[bg_scrollview removeGestureRecognizer:tapRecognizer];
		[bg_scrollview addGestureRecognizer:tapRecognizer];
	}

	current_textfield = textField;
	if(!up_boolean){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3f];
		[UIView setAnimationDelegate:self];
		CGRect frame = self.view.frame;
		
		frame.origin.y  -= 124;
		
		self.view.frame = frame;
		[UIView commitAnimations];
		up_boolean = !up_boolean;
	}
	return YES;
}

#pragma mark -
#pragma mark handle alert

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if(buttonIndex == 1) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", @"22111475"]]];
	}
}

-(void)handle_error_alert:(NSString*)message{
    NSString *str = NSLocalizedString(message, nil);
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

#pragma mark -
#pragma mark handle button events

-(IBAction)pressAnnounceButton:(UIButton*)button{
	NSLog(@"pressAnnounceButton");
    /*
	CardLoanPDFViewContoller *temp = [[CardLoanPDFViewContoller alloc] initWithNibName:@"CardLoanPDFView" bundle:nil];
	[self.navigationController presentModalViewController:temp animated:YES];
	[temp release];
	temp = nil;
    */
    WebViewController *webViewController;
	webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
    [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]]; //To be retested
    [webViewController setNav:self.navigationController];
	[self.navigationController pushViewController:webViewController animated:TRUE];
//	[webViewController.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]];
	[webViewController release];
}

-(IBAction)pressCallNowButton:(UIButton*)button{
	[call_now_alert show];
}

-(IBAction)pressClearButton:(UIButton*)button{
	name_textfield.text = mobile_textfield.text = email_textfield.text = loan_value_textfield.text = @"";
	checkBox_btn.selected = NO;
    [selectName setTitle:@"" forState:UIControlStateNormal];
    [repaymentBtn setTitle:@"" forState:UIControlStateNormal];
   // self.selected_repaymentPoriod_index = @"0";
  //  [self syn_month_value];
}

-(IBAction)pressSubmitButton:(UIButton*)button{
	//check error
	NSString *name = name_textfield.text;
	NSString *mobile  = mobile_textfield.text;
//	NSString *email = email_textfield.text;
	NSString *loan = loan_value_textfield.text;
	
//	NSRange email_range_1 = [email rangeOfString:@"@"];
//	NSRange email_range_2 = [email rangeOfString:@"."];
	
	//NSLog(@"email_range_1.location %d, email_range_2.location %d", email_range_1.location, email_range_2.location);
	
	BOOL valid_mobile = YES;
	
	for(int k = 0; k < [mobile length]; k++){
		char c =[mobile characterAtIndex:k];
		if(!(c >= '0' && c <= '9'))
		{
			valid_mobile = NO;
		}
	}
	
	if([mobile length] != 8){
		NSLog(@"mobile length != 8");
		valid_mobile = NO;
	}
	
	if([mobile length] > 0){
		char c =[mobile characterAtIndex:0];
		if(c == '0' || c == '1' || c == '4' || c == '7'){
			valid_mobile = NO;
		}
	}
	
	
	BOOL valid_loan = YES;
	for(int k = 0; k < [loan length]; k++){
		char c =[loan characterAtIndex:k];
		if(!(c >= '0' && c <= '9'))
		{
			valid_loan = NO;
		}
	}

	if([name length] == 0){
		[self handle_error_alert:@"fill_valid_name"];
		return;
	}
	if([mobile length] == 0 || !valid_mobile){
		[self handle_error_alert:@"fill_valid_mobile"];
		return;
	}
//	if([email length] == 0 || email_range_1.location == NSNotFound || email_range_2.location == NSNotFound){
//		[self handle_error_alert:@"fill_valid_email"];
//		return;
//		
//	}
 	if([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"cih"]){
		if([loan length] == 0 || [loan intValue] < 3000){
			[self handle_error_alert:@"fill_valid_loan_value_cash_3000"];
			return;
		}
	}
	if([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"btp"]){
		if([loan length] == 0 || [loan intValue] < 3000){
			[self handle_error_alert:@"fill_valid_loan_value_transfer_3000"];
			return;
		}
	}
	if([[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"sip"]){
        
		if([loan length] == 0 || [loan intValue] < 1000){
			[self handle_error_alert:@"fill_valid_loan_value_instalment_1000"];
			return;
		}
	}
    if (![[merchant_info objectForKey:@"cashinhandtype"] isEqualToString:@"sip"]) {
            if ( loan.length < 4  || ![[loan substringFromIndex:loan.length-2]  isEqualToString:@"00"] )   {
            [self handle_error_alert:@"Not_correct_loan_value_100"];
            return;
            }
    }
    
	if(!valid_loan){
		[self handle_error_alert:@"fill_valid_loan"];
		return;
	}
	/*
	else if([loan length] == 0 || [loan intValue] < 5000){
		[self handle_error_alert:@"fill_valid_loan_value"];
		return;
	}
	 */
    
    

	if([month_value intValue]<=0){
		[self handle_error_alert:@"No_repaymentPeriod"];
		return;
	}
	if(!checkBox_btn.selected){
		[self handle_error_alert:@"acceptance_valid"];
		return;
	}
	
	//send request
	
	[[CoreData sharedCoreData].mask showMask];
//	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&name=%@&mbno=%@&email=%@&amount=%@&period=%@&namepre=%d&plan=%@",[MBKUtil getURLOfCIHApplication], 
//        [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], 
//        mobile, email, loan, month_value, salutation_index,
//        [merchant_info objectForKey:@"cashinhandtype"]
//    ]]];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&name=%@&mbno=%@&amount=%@&period=%@&namepre=%d&plan=%@",[MBKUtil getURLOfCIHApplication],
                                                                                        [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                                                                        mobile, loan, month_value, salutation_index,
                                                                                        [merchant_info objectForKey:@"cashinhandtype"]
                                                                                        ]]];

	//[request setTimeOutSeconds:15];
	
	[request setUsername:@"iphone"];
	[request setPassword:@"iphone"];
	[request setValidatesSecureCertificate:NO];
   // [request setTimeOutSeconds:20.0];
   // [request setShouldAttemptPersistentConnection:YES];
	request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:request];
	 
	
	NSLog(@"%@ : %@", [self class], request.url);
	 
	 
	//Result = SUCCESS or FAIL
	/*
	MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
	mail.mailComposeDelegate = self;
	
	NSArray *toRecipients = [NSArray arrayWithObject:@"leaeobs@hkbea.com"]; 
	[mail setToRecipients:toRecipients];	 
	
	NSString *body = @"";
	if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
		[mail setSubject:[NSString stringWithFormat:@"%@ Application via BEA iPhone App", [merchant_info objectForKey:@"title"]]];
		//
		body = [body stringByAppendingString:@"Language : English\n"];
		
		//
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd MMM yyyy HH:mm:ss "];
		body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
		[formatter release];
		formatter = nil;
		body = [body stringByAppendingString:@"HKG\n\n"];
		
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Name: %@ %@\n", salutation_label.text, name_textfield.text]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Mobile no.: %@\n", mobile_textfield.text]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Email address: %@\n", email_textfield.text]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Loan details:\nHK$ %@\n%@months\n\n", loan_value_textfield.text, month_value]];
		body = [body stringByAppendingString:@"Message: Our customer service representative will contact you by the end of the day."];
		
	}
	else{
		[mail setSubject:[NSString stringWithFormat:@"%@ BEA iPhone App申請", [merchant_info objectForKey:@"title"]]];
		body = [body stringByAppendingString:@"語言 : 中文\n"];
		
		//
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
		body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
		[formatter release];
		formatter = nil;
		body = [body stringByAppendingString:@"\n\n"];
		
		body = [body stringByAppendingString:[NSString stringWithFormat:@"姓名: %@ %@\n", name_textfield.text, salutation_label.text]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"流動電話號碼: %@\n", mobile_textfield.text]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"電郵地址: %@\n", email_textfield.text]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"貸款詳情:\n港幣 %@元\n%@個月\n\n", loan_value_textfield.text, month_value]];
		body = [body stringByAppendingString:@"訊息: 我們的客戶服務員將於今天內聯絡你。"];
	}
	
	[mail setMessageBody:body isHTML:NO];
	[self presentModalViewController:mail animated:YES];
	[mail release];
	mail = nil;
	//	 
	 */
}


-(IBAction)pressSalutationButton:(UIButton*)button{
	if(salutation_index == 0){
		salutation_label.text = NSLocalizedString(@"chi_Miss", nil);
		salutation_index = 1;
	}
	else if(salutation_index == 1){
		salutation_label.text = NSLocalizedString(@"chi_Ms", nil);
		salutation_index = 2;
	}
	else if(salutation_index == 2){
		salutation_label.text = NSLocalizedString(@"chi_Mrs", nil);
		salutation_index = 3;
	}
	else if(salutation_index == 3){
		salutation_label.text = NSLocalizedString(@"chi_Mr", nil);
		salutation_index = 0;
	}
}

//-(IBAction)pressMonthButton:(UIButton*)button{
//	month12_btn.selected = month24_btn.selected = month36_btn.selected = month48_btn.selected = NO;
//	if(button == month12_btn){
//		month12_btn.selected = YES;
//		month_value = @"12";
//	}
//	else if(button == month24_btn){
//		month24_btn.selected = YES;
//		month_value = @"24";
//	}
//	else if(button == month36_btn){
//		month36_btn.selected = YES;
//		month_value = @"36";
//	}
//	else if(button == month48_btn){
//		month48_btn.selected = YES;	
//		month_value = @"48";
//	}
//}

-(IBAction)clickCheckBox:(UIButton*)button{
	checkBox_btn.selected = !checkBox_btn.selected;
}

-(IBAction)pressEmailSentOKButton:(UIButton*)button{
	email_sent_view.hidden = YES;
}

-(IBAction)pressEmailFailButton:(UIButton*)button{
	email_fail_view.hidden = YES;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSLog(@"response : %@", [request responseString]);
	
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	if(request != nil){
		[request release];
		request = nil;
	}
	[[CoreData sharedCoreData].mask hiddenMask];
    [email_sent_view setHidden:NO];
    [email_sent_view setFrame:self.view.frame];
    [self.view addSubview:email_sent_view];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"CardLoanApplyFormViewController requestFailed:%@", [request error]);

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert show];
	if(alert != nil){
		[alert release];
		alert = nil;
	}
	if(request != nil){
		[request release];
		request = nil;
	}
	[[CoreData sharedCoreData].mask hiddenMask];
    [email_fail_view setHidden:NO];
    [email_fail_view setFrame:self.view.frame];
    [self.view addSubview:email_fail_view];
}


#pragma mark -
#pragma mark XML Parse delegate
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	if (items_data != nil){
		[items_data removeAllObjects];
		[items_data release];
		items_data = nil;
	}
	key = [NSArray arrayWithObjects:@"Result",@"RefNo",@"ErrorCode",@"CodeDesc",@"Timestamp",@"msg",nil];
	items_data = [NSMutableArray new];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	if ([items_data count] > 0 ){		
		if ([[temp_record objectForKey:@"Result"] isEqualToString:@"SUCCESS"]) {
			/*
			MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
			mail.mailComposeDelegate = self;
			
			NSArray *toRecipients = [NSArray arrayWithObject:@"leaeobs@hkbea.com"]; 
			[mail setToRecipients:toRecipients];	 
			
			NSString *body = @"";
			if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
				[mail setSubject:[NSString stringWithFormat:@"%@ Application via BEA iPhone App", [merchant_info objectForKey:@"title"]]];
				//
				body = [body stringByAppendingString:@"Language : English\n"];
				
				//
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"dd MMM yyyy HH:mm:ss "];
				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
				[formatter release];
				formatter = nil;
				body = [body stringByAppendingString:@"HKG\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Name: %@ %@\n", salutation_label.text, name_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Mobile no.: %@\n", mobile_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Email address: %@\n", email_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Loan details:\nHK$ %@\n%@months\n\n", loan_value_textfield.text, month_value]];
				body = [body stringByAppendingString:@"Message: Our customer service representative will contact you by the end of the day."];
				
			}
			else{
				[mail setSubject:[NSString stringWithFormat:@"%@ BEA iPhone App申請", [merchant_info objectForKey:@"title"]]];
				body = [body stringByAppendingString:@"語言 : 中文\n"];
				
				//
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
				[formatter release];
				formatter = nil;
				body = [body stringByAppendingString:@"\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"姓名: %@ %@\n", name_textfield.text, salutation_label.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"流動電話號碼: %@\n", mobile_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"電郵地址: %@\n", email_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"貸款詳情:\n港幣 %@元\n%@個月\n\n", loan_value_textfield.text, month_value]];
				body = [body stringByAppendingString:@"訊息: 我們的客戶服務員將於今天內聯絡你。"];
			}
			
			[mail setMessageBody:body isHTML:NO];
			[self presentModalViewController:mail animated:YES];
			[mail release];
			mail = nil;
			*/
			//result-sent
			NSString *body = @"";
			if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
				//body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", [temp_record objectForKey:@"RefNo"]]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", [temp_record objectForKey:@"RefNo"]]];
//				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//				[formatter setDateFormat:@"dd MMMM yyyy HH:mm:ss "];
//				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
//                NSLog(@"%@",[NSDate date]);
//				[formatter release];
//				formatter = nil;
//				body = [body stringByAppendingString:@"HKG\n\n"];
                
                body = [body stringByAppendingString:[temp_record objectForKey:@"Timestamp"]];
                body = [body stringByAppendingString:@"\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Name: %@ %@\n", selectName.titleLabel.text, name_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Mobile no.: %@\n", mobile_textfield.text]];
			//	body = [body stringByAppendingString:[NSString stringWithFormat:@"Email address: %@\n", email_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Loan details:\tHK$ %@\n\t\t\t%@months\n\n", loan_value_textfield.text, month_value]];
				[email_sent_ok_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
				email_sent_label.text = NSLocalizedString(@"application_sent", nil);
				
				//
				BOOL contact_today = YES;
				
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"e"];
				NSString *week_day = [formatter stringFromDate:[NSDate date]];
				if([week_day isEqualToString:@"1"] || [week_day isEqualToString:@"7"]){
					contact_today = NO;
				}
				
				[formatter setDateFormat:@"yyyy-MM-dd"];
				NSString *today = [formatter stringFromDate:[NSDate date]];
				
				[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00", today]];
				NSTimeInterval ti =  [date timeIntervalSinceNow];
				if(ti < 0){
					contact_today = NO;	
				}
				
				if(contact_today){
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				else {
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				
				
				[formatter release];
				formatter = nil;
				//
				
				email_sent_textview.font = [UIFont systemFontOfSize:13];
				email_sent_textview.text = body;
				email_sent_textview.frame = CGRectMake(email_sent_textview.frame.origin.x, email_sent_textview.frame.origin.y, email_sent_textview.contentSize.width, email_sent_textview.contentSize.height);
			}
			else{
				body = [body stringByAppendingString:[NSString stringWithFormat:@"參考編號: %@\n", [temp_record objectForKey:@"RefNo"]]];
//				body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", [temp_record objectForKey:@"RefNo"]]];
				
				//
//				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//				[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
//				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
//				[formatter release];
//				formatter = nil;
                body = [body stringByAppendingString:[temp_record objectForKey:@"Timestamp"]];
				body = [body stringByAppendingString:@"\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"姓名: %@ %@\n", name_textfield.text, selectName.titleLabel.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"流動電話號碼: %@\n", mobile_textfield.text]];
			//	body = [body stringByAppendingString:[NSString stringWithFormat:@"電郵地址: %@\n", email_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"貸款詳情:\t港幣 %@元\n\t\t%@個月\n\n", loan_value_textfield.text, month_value]];
				[email_sent_ok_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
				email_sent_label.text = NSLocalizedString(@"application_sent", nil);
				
				//
				BOOL contact_today = YES;
				
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"e"];
				NSString *week_day = [formatter stringFromDate:[NSDate date]];
				if([week_day isEqualToString:@"1"] || [week_day isEqualToString:@"7"]){
					contact_today = NO;
				}
				
				[formatter setDateFormat:@"yyyy-MM-dd"];
				NSString *today = [formatter stringFromDate:[NSDate date]];
				
				[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00", today]];
				NSTimeInterval ti =  [date timeIntervalSinceNow];
				if(ti < 0){
					contact_today = NO;	
				}
				
				if(contact_today){
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				else {
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				
				
				[formatter release];
				formatter = nil;
				//
				
				email_sent_textview.font = [UIFont systemFontOfSize:13];
				email_sent_textview.text = body;
				email_sent_textview.frame = CGRectMake(email_sent_textview.frame.origin.x, email_sent_textview.frame.origin.y, email_sent_textview.contentSize.width, email_sent_textview.contentSize.height);
			}
			
			email_sent_view.hidden = NO;
			//result-sent-end			
		}else/* if ([[temp_record objectForKey:@"Result"] isEqualToString:@"FAIL"]) */{
			/*
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"applyFail", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
			[alert show];
			if(alert != nil){
				[alert release];
				alert = nil;
			}
			 */
			NSString *body = @"";
			if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", [temp_record objectForKey:@"ErrorCode"]]];
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"dd MMM yyyy HH:mm:ss "];
				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
				[formatter release];
				formatter = nil;
				body = [body stringByAppendingString:@"HKG\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Message: %@\n", [temp_record objectForKey:@"CodeDesc"]]];
				
				[email_fail_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
				email_fail_label.text = NSLocalizedString(@"application_fail", nil);
				
				
				email_fail_textview.font = [UIFont systemFontOfSize:13];
				email_fail_textview.text = body;
				email_fail_textview.frame = CGRectMake(email_fail_textview.frame.origin.x, email_fail_textview.frame.origin.y, email_fail_textview.contentSize.width, email_fail_textview.contentSize.height);
			}
			else{
				//body = [body stringByAppendingString:[NSString stringWithFormat:@"參考編號: %@\n", [temp_record objectForKey:@"RefNo"]]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", [temp_record objectForKey:@"ErrorCode"]]];
				
				//
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
				[formatter release];
				formatter = nil;
				body = [body stringByAppendingString:@"\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"訊息: %@\n", [temp_record objectForKey:@"CodeDesc"]]];
				
	
				[email_fail_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
				email_fail_label.text = NSLocalizedString(@"application_fail", nil);
				
				
				email_fail_textview.font = [UIFont systemFontOfSize:13];
				email_fail_textview.text = body;
				email_fail_textview.frame = CGRectMake(email_fail_textview.frame.origin.x, email_fail_textview.frame.origin.y, email_fail_textview.contentSize.width, email_fail_textview.contentSize.height);
			}
			
			email_fail_view.hidden = NO;
			
		}
	}
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
	[alert show];
	if(alert != nil){
		[alert release];
		alert = nil;
	}
	/*
	NSString *body = @"";
	if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", @"err code"]];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd MMM yyyy HH:mm:ss "];
		body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
		[formatter release];
		formatter = nil;
		body = [body stringByAppendingString:@"HKG\n\n"];
		
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Message: %@\n", @"err desc"]];
		
		[email_fail_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
		email_fail_label.text = NSLocalizedString(@"application_fail", nil);
		
		
		email_fail_textview.font = [UIFont systemFontOfSize:13];
		email_fail_textview.text = body;
		email_fail_textview.frame = CGRectMake(email_fail_textview.frame.origin.x, email_fail_textview.frame.origin.y, email_fail_textview.contentSize.width, email_fail_textview.contentSize.height);
	}
	else{
		//body = [body stringByAppendingString:[NSString stringWithFormat:@"參考編號: %@\n", [temp_record objectForKey:@"RefNo"]]];
		body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", @"錯"]];
		
		//
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
		body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
		[formatter release];
		formatter = nil;
		body = [body stringByAppendingString:@"\n\n"];
		
		body = [body stringByAppendingString:[NSString stringWithFormat:@"訊息: %@\n", @"又錯"]];
		
		
		[email_fail_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
		email_fail_label.text = NSLocalizedString(@"application_fail", nil);
		
		
		email_fail_textview.font = [UIFont systemFontOfSize:13];
		email_fail_textview.text = body;
		email_fail_textview.frame = CGRectMake(email_fail_textview.frame.origin.x, email_fail_textview.frame.origin.y, email_fail_textview.contentSize.width, email_fail_textview.contentSize.height);
	}
	
	email_fail_view.hidden = NO;
	*/
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

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
	
	NSString *body = @"";
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil];
	switch (result) {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
            break;			
		case MFMailComposeResultFailed:
			alert.message = @"訊息傳送失敗";
			[alert show];
			break;
		case MFMailComposeResultSent:
			//result-sent
			if([[CoreData sharedCoreData].lang isEqualToString:@"e"]){
				//body = [body stringByAppendingString:[NSString stringWithFormat:@"Reference no.: %@\n", [temp_record objectForKey:@"RefNo"]]];
				body = [body stringByAppendingString:@"Reference no.: TA829003215\n"];
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"dd MMM yyyy HH:mm:ss "];
				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
				[formatter release];
				formatter = nil;
				body = [body stringByAppendingString:@"HKG\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Name: %@ %@\n", selectName.titleLabel.text, name_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Mobile no.: %@\n", mobile_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Email address: %@\n", email_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"Loan details:\tHK$ %@\n\t\t\t%@months\n\n", loan_value_textfield.text, month_value]];
				[email_sent_ok_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
				email_sent_label.text = NSLocalizedString(@"application_sent", nil);
				
				//
				BOOL contact_today = YES;
				
				formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"e"];
				NSString *week_day = [formatter stringFromDate:[NSDate date]];
				if([week_day isEqualToString:@"1"] || [week_day isEqualToString:@"7"]){
					contact_today = NO;
				}
				
				[formatter setDateFormat:@"yyyy-MM-dd"];
				NSString *today = [formatter stringFromDate:[NSDate date]];
				
				[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00", today]];
				NSTimeInterval ti =  [date timeIntervalSinceNow];
				if(ti < 0){
					contact_today = NO;	
				}
				
				if(contact_today){
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				else {
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				
				
				[formatter release];
				formatter = nil;
				//
				
				email_sent_textview.font = [UIFont systemFontOfSize:13];
				email_sent_textview.text = body;
				email_sent_textview.frame = CGRectMake(email_sent_textview.frame.origin.x, email_sent_textview.frame.origin.y, email_sent_textview.contentSize.width, email_sent_textview.contentSize.height);
			}
			else{
				//body = [body stringByAppendingString:[NSString stringWithFormat:@"參考編號: %@\n", [temp_record objectForKey:@"RefNo"]]];
				body = [body stringByAppendingString:@"參考編號: TA829003215\n"];
				
				//
				NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
				body = [body stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
				[formatter release];
				formatter = nil;
				body = [body stringByAppendingString:@"\n\n"];
				
				body = [body stringByAppendingString:[NSString stringWithFormat:@"姓名: %@ %@\n", name_textfield.text, selectName.titleLabel.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"流動電話號碼: %@\n", mobile_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"電郵地址: %@\n", email_textfield.text]];
				body = [body stringByAppendingString:[NSString stringWithFormat:@"貸款詳情:\t港幣 %@元\n\t\t%@個月\n\n", loan_value_textfield.text, month_value]];
				[email_sent_ok_button setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
				email_sent_label.text = NSLocalizedString(@"application_sent", nil);
				
				//
				BOOL contact_today = YES;
				
				formatter = [[NSDateFormatter alloc] init];
				[formatter setDateFormat:@"e"];
				NSString *week_day = [formatter stringFromDate:[NSDate date]];
				if([week_day isEqualToString:@"1"] || [week_day isEqualToString:@"7"]){
					contact_today = NO;
				}
				
				[formatter setDateFormat:@"yyyy-MM-dd"];
				NSString *today = [formatter stringFromDate:[NSDate date]];
				
				[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
				NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ 14:00:00", today]];
				NSTimeInterval ti =  [date timeIntervalSinceNow];
				if(ti < 0){
					contact_today = NO;	
				}
				
				if(contact_today){
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				else {
					email_sent_contact_label.text = NSLocalizedString(@"contact_nextday", nil);
				}
				
				
				[formatter release];
				formatter = nil;
				//
				
				email_sent_textview.font = [UIFont systemFontOfSize:13];
				email_sent_textview.text = body;
				email_sent_textview.frame = CGRectMake(email_sent_textview.frame.origin.x, email_sent_textview.frame.origin.y, email_sent_textview.contentSize.width, email_sent_textview.contentSize.height);
			}
			
			email_sent_view.hidden = NO;
			//result-sent-end
			break;
		default:
			break;
	}

	if(alert != nil){
		[alert release];
		alert = nil;
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)pressRepaymentPoriod:(UIButton*)button
{
    [name_textfield resignFirstResponder];
    [mobile_textfield resignFirstResponder];
    [loan_value_textfield resignFirstResponder];
    if(up_boolean){
        [bg_scrollview removeGestureRecognizer:tapRecognizer];
        [current_textfield resignFirstResponder];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDelegate:self];
        CGRect frame = self.view.frame;
        
        frame.origin.y = 0;
        
        self.view.frame = frame;
        [UIView commitAnimations];
        up_boolean = !up_boolean;
    }

    customView = [[UIView alloc] init];
    customView.frame = self.view.frame;
    customView.backgroundColor = [UIColor lightGrayColor];
    customView.alpha = 0.93;
    customView.hidden = NO;
    UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFromSuperview:)];
    [customView addGestureRecognizer:dismissGesture];
    [self.view addSubview:customView];
    fromType = @"repayment";
 //   selectNameArr = [NSMutableArray arrayWithObjects:NSLocalizedString(@"chi_Miss", nil),NSLocalizedString(@"chi_Ms", nil),NSLocalizedString(@"chi_Mrs", nil),NSLocalizedString(@"chi_Mr", nil), nil];
    [self createTableViewInSuperView:customView data:self.list_repaymentPoriod_name];
//	UIActionSheet *menu;
//	menu = [[UIActionSheet alloc] initWithTitle:nil
//									   delegate:self
//							  cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
//						 destructiveButtonTitle:NSLocalizedString(@"Done",nil)
//							  otherButtonTitles:nil];
//
//	self.pickerView = [[UIPickerView alloc] init];
//	self.pickerView.showsSelectionIndicator = TRUE;
//	self.pickerView.delegate = self;
//	self.pickerView.dataSource = self;
//	[menu addSubview:self.pickerView];
////    [menu showFromTabBar:[CoreData sharedCoreData].delight_view_controller.tabBar];
//    [menu showInView:self.view];
//	[menu setBounds:CGRectMake(0, 0, 320, 480)];
//	[self.pickerView setFrame:CGRectMake(0, 140, 320, 216)];
//
//	[self.pickerView selectRow:[self.selected_repaymentPoriod_index integerValue] inComponent:0 animated:FALSE];
//
//	[menu release];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [self.list_repaymentPoriod_name count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [self.list_repaymentPoriod_name objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selected_repaymentPoriod_index = [NSString stringWithFormat:@"%d", row];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

	if (buttonIndex==0) {
        [self syn_month_value];
	}
	[self.pickerView release];

}

- (IBAction)showSelectedName:(id)sender {
    [name_textfield resignFirstResponder];
    [mobile_textfield resignFirstResponder];
    [loan_value_textfield resignFirstResponder];
    if(up_boolean){
        [bg_scrollview removeGestureRecognizer:tapRecognizer];
        [current_textfield resignFirstResponder];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationDelegate:self];
        CGRect frame = self.view.frame;
        
        frame.origin.y = 0;
        
        self.view.frame = frame;
        [UIView commitAnimations];
        up_boolean = !up_boolean;
    }
    
    customView = [[[UIView alloc] init] autorelease];
    customView.frame = self.view.frame;
    customView.backgroundColor = [UIColor lightGrayColor];
    customView.alpha = 0.93;
    customView.hidden = NO;
    UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFromSuperview:)];
    [customView addGestureRecognizer:dismissGesture];
    [self.view addSubview:customView];

    fromType = @"name";
    selectNameArr = [NSMutableArray arrayWithObjects:NSLocalizedString(@"chi_Miss", nil),NSLocalizedString(@"chi_Ms", nil),NSLocalizedString(@"chi_Mrs", nil),NSLocalizedString(@"chi_Mr", nil), nil];
    [self createTableViewInSuperView:customView data:selectNameArr];
}

- (void)dismissFromSuperview:(UITapGestureRecognizer *)tapGesture

{
    if (customView != nil) {
        for (UIView *subview in customView.subviews) {
            [subview removeFromSuperview];
        }
        [subVC.view removeFromSuperview];
        [customView removeFromSuperview];
    }
}

- (void)createTableViewInSuperView:(UIView *)view data:(NSMutableArray *)dataArr{
    subVC = [[subViewController alloc] initWithNibName:@"subViewController" bundle:nil data:dataArr];
    CGRect frame = CGRectMake(40, 140, 240, 240);
    [view addSubview:subVC.view];
    subVC.view.frame = frame;
 //   subVC.table_view.frame = frame;
 //   [view addSubview:subVC.table_view];
    
    [self.view addSubview:subVC.view];
}

-(void)changeName:(NSNotification *)notice
{
    NSArray *dataAyy = [notice object];
    NSString *nameString = [dataAyy objectAtIndex:0];
    NSInteger row = [[dataAyy objectAtIndex:1] integerValue];
    if ([fromType isEqualToString:@"repayment"]) {
        [repaymentBtn setTitle:nameString forState:UIControlStateNormal];
    //    repaymentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (row == 0) {
            month_value = @"6";
        }else if (row == 1){
            month_value = @"12";
        }else if (row == 2){
            month_value = @"18";
        }else if (row == 3){
            month_value = @"24";
        }else if (row == 4){
            month_value = @"36";
        }else if (row == 5){
            month_value = @"48";
        }
    }
    else if ([fromType isEqualToString:@"name"]){
        [selectName setTitle:[NSString stringWithFormat:@"  %@", nameString] forState:UIControlStateNormal];
     //   selectName.titleLabel.textAlignment = NSTextAlignmentCenter;
        if ([nameString isEqualToString:NSLocalizedString(@"chi_Mr", nil)]) {
            salutation_index = 0;
        }
        else if ([nameString isEqualToString:NSLocalizedString(@"chi_Miss", nil)]) {
            salutation_index = 1;
        }
        else if ([nameString isEqualToString:NSLocalizedString(@"chi_Ms", nil)]) {
            salutation_index = 2;
        }
        else if ([nameString isEqualToString:NSLocalizedString(@"chi_Mrs", nil)]) {
            salutation_index = 3;
        }
    }
    [customView setHidden:YES];
    if (subVC) {
        [subVC.view removeFromSuperview];
    }
    [customView removeFromSuperview];
}
@end
