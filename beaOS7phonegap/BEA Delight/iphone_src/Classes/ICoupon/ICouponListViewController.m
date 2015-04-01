//
//  ICouponListViewController.m
//  BEA
//
//  Created by Algebra on 13/8/14.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "ICouponListViewController.h"
#import "MyWalletTableViewCell.h"
#import "ICouponDetailViewController.h"
#import "CouponUseViewController.h"
#define WEBFUNCTION_KEY_SCHEMA @"beaapp"
#define WEBFUNCTION_KEY_BACKFULLLIST @"backToFullList"
#define WEBFUNCTION_KEY_BACKMYWALLET @"backToMyWallet"
#define WEBLINK_AASTOCKS @"product1.aastocks.com";
@interface ICouponListViewController (){
    RotateMenu4ViewController* v_rmvc;
    CouponUseViewController * v_useCoupon;
    NSArray *key;
    NSArray *searchResults;
    NSDateFormatter *apiFormatter;
    NSDateFormatter *displayFormatter;
    
    BOOL loadFinished ;//Checking the full list api if load finished.
}

@end

@implementation ICouponListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setMenuBar4];
    _status = self.toListTag;
    
    
    [self.txf_search addTarget:self
                  action:@selector(filterData)
        forControlEvents:UIControlEventEditingChanged];
    
    
    [MBKUtil me].queryButtonWillShow = @"NO";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [[PageUtil pageUtil] changeImageForTheme:self.view];
    if(_status == ICouponListStatusMyCouponList){
        [self doMenuButtonsPressed:v_rmvc.btnmenu1];
    }else if(_status == ICouponListStatusRedeemCoupon){
        NSString *pageTheme = [[PageUtil pageUtil] getPageTheme];
        if (![pageTheme isEqualToString:@"1"]) {
            [v_rmvc.btnmenu1 setTitleColor:[UIColor colorWithRed:251/255.0 green:221/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
            [v_rmvc.btnmenu0 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            UIImage *image = [UIImage imageNamed:@"my_wallet_bar.png"];
            [v_rmvc.image_bg setImage:image];
        }
    }else{
        [self getCouponList];
        [self.txf_search setText:@""];
    }
    
    
    apiFormatter = [[NSDateFormatter alloc] init];
    [apiFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [apiFormatter setDateFormat:@"yyyy-MM-dd"];
    
    displayFormatter = [[NSDateFormatter alloc] init];
    
    
    [displayFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [_txf_search setTitle:NSLocalizedString(@"Search", nil)];
    
    [displayFormatter setDateFormat:NSLocalizedString(@"iCoupon.myWallet.displayFormat", nil)];

    [self.btn_logout setTitle:NSLocalizedString(@"iCoupon.myWallet.logout", nil) forState:UIControlStateNormal];
    _txf_search.placeholder =NSLocalizedString(@"Search", nil);
    
}

-(void)setMenuBar4
{
    v_rmvc = [[RotateMenu4ViewController alloc] initWithNibName:@"RotateMenu4ViewController" bundle:nil] ;
    CGRect frame3 = v_rmvc.contentView.frame;
    frame3.origin.x =0;
    frame3.origin.y =0;
    v_rmvc.view.frame = frame3;
    v_rmvc.vc_caller = self;
    [self.view addSubview:v_rmvc.contentView];
    [v_rmvc.rmUtil setNav:self.navigationController];
    
    

    
}

- (void)dealloc {
    [table_view release];
    [web_view release];
    [table_view release];
     asi_request.delegate = nil;
    v_rmvc = nil;
    _status = nil;
    [_txf_search release];
    [_btn_logout release];
    [_view_search release];
    [super dealloc];
}

#pragma mark - RotateMenu4ViewControllerDelegate
-(void)doMenuButtonsPressed:(UIButton *)sender {
    loadFinished = NO;
    [asi_request cancel];
    if(sender == v_rmvc.btnmenu0){
        //Clear Data
        self.items_data = nil;
        searchResults = nil;
        [table_view reloadData];
        
        //Reload coupon list data
        [self getCouponList];

    }else if(sender == v_rmvc.btnmenu1){
        //Clear Data
        self.items_data = nil;
        searchResults = nil;
        [table_view reloadData];
        
        //Reload my wallet data
        [self getMyCouponList];
        
    }
    
    [self.view endEditing:YES];

}



- (IBAction)logout:(id)sender {
    NSString *urlAddress = [NSString stringWithFormat:@"%@",[CoreData sharedCoreData].iCouponServerLogoutURL];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [web_view loadRequest:requestObj];
}

- (void)goToLoginPage:(NSString *)couponId{
    table_view.hidden = YES;
    web_view.hidden = NO;
    self.view_search.hidden = YES;
    
    NSString *urlAddress = [NSString stringWithFormat:@"%@?Lang=%@&TxType=1&CpnId=%@",
                            [CoreData sharedCoreData].iCouponServerURL,
                            [[CoreData sharedCoreData] couponLang],
                            couponId];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [web_view loadRequest:requestObj];
}

#pragma UITableView DataSource & Delegate


- (void)filterData{
    if([self.txf_search.text length] > 0){
    searchResults = [[self.items_data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"merchant_name contains[cd] %@ or item_desc contains[cd] %@",self.txf_search.text,self.txf_search.text]] copy];
    }else{
        searchResults = self.items_data;
    }
//    [self.txf_search becomeFirstResponder];
    [table_view reloadData];

}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self filterData];
    [textField resignFirstResponder];
    return YES;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([searchResults count] == 0 &&_status == ICouponListStatusCouponList && loadFinished) {
        return 1; // a single cell to report no data
    }
        return [searchResults count];
    
//    return [self.items_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([searchResults count] == 0 && _status == ICouponListStatusCouponList) {
        
        UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease];
        cell.textLabel.text = NSLocalizedString(@"iCoupon.fullList.outOfStock", nil);
        
        //whatever else to configure your one cell you're going to return
        return cell;
    }
    
    static NSString *CellIdentifier = @"MyWalletTableViewCell";
	
    MyWalletTableViewCell *cell = [(MyWalletTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier] autorelease];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;	//Disable select
	
    NSDictionary *cellData = searchResults[indexPath.row];
    
	if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] ;
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        if([topLevelObjects count] >0)
            cell = [topLevelObjects objectAtIndex:0];
	}
    
    [cell setData:cellData];
    cell.btn_action.tag = indexPath.row;
    
    NSString *status = [[PageUtil pageUtil] getPageTheme];
    if ([status isEqualToString:@"1"]) {
        UIImage *image = [UIImage imageNamed:@"btn_orange_big.png"];
        [cell.btn_action setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"btn_orange_big_new.png"];
        [cell.btn_action setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    if(_status == ICouponListStatusCouponList){
        [cell.btn_action addTarget:self action:@selector(redeem_onTouch:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.btn_action addTarget:self action:@selector(useCoupon_onTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSString *description = [cellData valueForKey:@"item_desc"];
    if(!description){
        description = @"";
    }
    
    if(_status == ICouponListStatusCouponList){
        [cell.btn_action setTitle:NSLocalizedString(@"iCoupon.fullList.redeem", nil) forState:UIControlStateNormal];
        NSString *stringValue =  [NSString stringWithFormat:@"%@",description];
        cell.lbl_subTitle.text = stringValue;
        cell.lbl_subTitle.frame=CGRectMake(92, 30, 223, cell.lbl_subTitle.frame.size.height);
        [cell.lbl_subTitle sizeToFit];
        if(cell.lbl_subTitle.frame.size.height>40){
            cell.lbl_subTitle.frame=CGRectMake(92, 30, cell.lbl_subTitle.frame.size.width, 34);
        }else{
            cell.lbl_subTitle.frame=CGRectMake(92, 30, cell.lbl_subTitle.frame.size.width, cell.lbl_subTitle.frame.size.height);
        }
    }else{
        [cell.btn_action setTitle:NSLocalizedString(@"iCoupon.myWallet.useNow", nil) forState:UIControlStateNormal];
        

        
        NSString *stringValue =  [NSString stringWithFormat:@"%@ %@ %@",[cellData valueForKey:@"num_coupon"],NSLocalizedString(@"iCoupon.myWallet.unit", nil),description];
        cell.lbl_subTitle.text = stringValue;
        
        NSMutableAttributedString *text =
        [[NSMutableAttributedString alloc]
         initWithAttributedString: cell.lbl_subTitle.attributedText];
        
        [text addAttribute:NSForegroundColorAttributeName
                     value:cell.lbl_title.textColor
                     range:NSMakeRange(0, [[cellData valueForKey:@"num_coupon"] length]+ [NSLocalizedString(@"iCoupon.myWallet.unit", nil) length]+1)];

        [cell.lbl_subTitle setAttributedText: text];
        cell.lbl_subTitle.frame=CGRectMake(92, 30,223, cell.lbl_subTitle.frame.size.height);
        [cell.lbl_subTitle sizeToFit];
        if(cell.lbl_subTitle.frame.size.height>34){
            cell.lbl_subTitle.frame=CGRectMake(92, 30, cell.lbl_subTitle.frame.size.width, 34);
        }else{
            cell.lbl_subTitle.frame=CGRectMake(92, 30, cell.lbl_subTitle.frame.size.width, cell.lbl_subTitle.frame.size.height);
        }        //Format Date
        
        NSString *expireDateString = [NSString stringWithFormat:@"%@", [displayFormatter stringFromDate:[apiFormatter dateFromString:[cellData valueForKey:@"effective_end"]]]];
        cell.lbl_minTitle1.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"iCoupon.myWallet.expiryDate", nil),expireDateString];
        cell.lbl_minTitle2.text = @"";
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ICouponDetailViewController * v_detail = [[ICouponDetailViewController alloc] initWithNibName:@"ICouponDetailViewController" bundle:nil];
//    v_detail.data = [self.items_data objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:v_detail animated:YES];

    
}


- (void)redeem_onTouch :(UIButton *)sender{
//    ICouponDetailViewController * v_detail = [[ICouponDetailViewController alloc] initWithNibName:@"ICouponDetailViewController" bundle:nil];
//    [self.navigationController pushViewController:v_detail animated:YES];
    ICouponDetailViewController * v_detail = [[ICouponDetailViewController alloc] initWithNibName:@"ICouponDetailViewController" bundle:nil];
    v_detail.data = [searchResults objectAtIndex:sender.tag];
    [self.navigationController pushViewController:v_detail animated:YES];
}

- (void)useCoupon_onTouch :(UIButton *)sender{
    
    
    v_useCoupon = [[CouponUseViewController alloc] initWithNibName:@"CouponUseViewController" bundle:nil];
    v_useCoupon.data = [searchResults objectAtIndex:sender.tag];
    

    [self.navigationController pushViewController:v_useCoupon animated:YES];
    

}




#pragma UIWebViewDelegate 
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBKUtil me].queryButtonWillShow = @"NO";
    NSURLRequest *request = [web_view request];
    if([[request URL].scheme isEqualToString:@"about"]){
        return;
    }else if([[request URL].absoluteString rangeOfString:[CoreData sharedCoreData].iCouponServer options:NSCaseInsensitiveSearch].location ==  NSNotFound ){
        return;
    }
    
    
    webView.hidden = NO;
    [[CoreData sharedCoreData].mask hiddenMask];
    
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                      @"document.body.innerHTML"];
    
    
    
    NSRange isRange = [html rangeOfString:@"sessionid" options:NSCaseInsensitiveSearch];
    //Check if login
    if(isRange.location != NSNotFound) {
        
        
        //Format Data
        NSCachedURLResponse* response = [[NSURLCache sharedURLCache]
                                         cachedResponseForRequest:[webView request]];
        NSData* data = [response data];
        
        NSString *xmlString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] substringFromIndex:8];
        
        
        NSData* xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        
        
        NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xmlData];
        
        NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLParser:xml_parser];
        
        NSString *sessionid = [xmlDoc valueForKey:@"SessionID"];
        //Format End
        if(sessionid != nil){
            
            
            if(_status == ICouponListStatusMyCouponList){
                
                table_view.hidden = NO;
                self.view_search.hidden = NO;
                web_view.hidden = YES;
                
                self.items_data = [[xmlDoc arrayValueForKeyPath:@"Coupons.coupon"] mutableCopy];;
                NSLog(@"affa%@" ,self.items_data);
                
                if(!self.items_data){
                    self.items_data = [[xmlDoc arrayValueForKeyPath:@"coupons.coupon"] mutableCopy];;
                }
                searchResults = self.items_data;
                [table_view reloadData];
            }else if(_status == ICouponListStatusUseCouponList){
                table_view.hidden = NO;
                self.view_search.hidden = NO;
                web_view.hidden = YES;
                [[CoreData sharedCoreData].mask showMask];
                asi_request = [[ASIHTTPRequest alloc] initWithURL:
                               [NSURL URLWithString:
                                [NSString stringWithFormat:@"%@?Lang=%@&TxType=2&sessionid=%@",
                                 [CoreData sharedCoreData].iCouponServerURL,
                                 [[CoreData sharedCoreData] couponLang],
                                 sessionid]]];
                [asi_request setValidatesSecureCertificate:NO];
                asi_request.delegate = self;
                [[CoreData sharedCoreData].queue addOperation:asi_request];
            }

            
        }else{
            table_view.hidden = YES;
            self.view_search.hidden = YES;
            web_view.hidden = NO;
        }
        
    }else {
        //Logout
        NSRange isRange = [[[[webView request] URL] absoluteString] rangeOfString:@"MBICPLogoutShow" options:NSCaseInsensitiveSearch];
        if( isRange.location != NSNotFound){
            [self doMenuButtonsPressed:v_rmvc.btnmenu0];
        }
    }
    }

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ICouponListViewController: didFailLoadWithError error:%@", [error description] );
    [[CoreData sharedCoreData].mask hiddenMask];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if([[request URL].scheme isEqualToString:@"about"] ){
        return NO;
    }else if([[request URL].absoluteString rangeOfString:[CoreData sharedCoreData].iCouponServer options:NSCaseInsensitiveSearch].location ==  NSNotFound  && ![[request URL].scheme isEqualToString:WEBFUNCTION_KEY_SCHEMA]){
        return YES;
    }else if([[[request URL] absoluteString] rangeOfString:@"directToIcpTnc"].location != NSNotFound){

        WebViewController *webViewController;
        webViewController = [[WebViewController alloc] initWithNibName:@"WebView" bundle:nil];
        [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]]; //To be retested
        
        
        if([[[CoreData sharedCoreData] couponLang] isEqualToString:@"Eng"]){
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hkbea.com/pdf/en/i-coupon_tnc_e.pdf"]];
            [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hkbea.com/pdf/en/i-coupon_tnc_e.pdf"]]]; //To be retested
        }else{
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hkbea.com/pdf/tc/i-coupon_tnc_t.pdf"]];
            [webViewController setUrlRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.hkbea.com/pdf/tc/i-coupon_tnc_t.pdf"]]]; //To be retested
        }
        
        [webViewController setNav:self.navigationController];
        [self.navigationController pushViewController:webViewController animated:TRUE];
        //	[webViewController.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:NSLocalizedString(@"PICStatement_link",nil)]]];
        [webViewController release];
        
        
        return NO;
    }
    [[CoreData sharedCoreData].mask showMask];
    webView.hidden = YES;
    
    if( [[request URL].scheme isEqualToString:WEBFUNCTION_KEY_SCHEMA]){
        if([[request URL].host isEqualToString:WEBFUNCTION_KEY_BACKFULLLIST]){
            [self getCouponList];
        }else if([[request URL].host isEqualToString:WEBFUNCTION_KEY_BACKMYWALLET]){
            [self getMyCouponList];
        }
        return NO;
    }
    
    NSLog(@"%@ - %@ - %@ - %@", [request URL].scheme, [request URL].host, [request URL].query, [request URL].fragment);
    return YES;
}
#pragma API Part
-(void)getCouponList{
 
    NSLog(@"Get Coupon List");
    table_view.hidden = NO;
    web_view.hidden = YES;
    self.view_search.hidden = YES;
    [table_view setFrame:web_view.frame];
    v_rmvc.rightOrLeft = @"left";
    [v_rmvc changePageTheme:nil];
    _status = ICouponListStatusCouponList;
    
	[[CoreData sharedCoreData].mask showMask];
   
	asi_request = [[ASIHTTPRequest alloc] initWithURL:
                   [NSURL URLWithString:
                    [NSString stringWithFormat:@"%@?Lang=%@&TxType=0",
                     [CoreData sharedCoreData].iCouponServerURL,
                     [[CoreData sharedCoreData] couponLang]]]];
    [asi_request setValidatesSecureCertificate:NO];
	asi_request.delegate = self;
	[[CoreData sharedCoreData].queue addOperation:asi_request];

	NSLog(@"debug ICouponListViewController url:%@", asi_request.url);

}


-(void)getMyCouponList{
    
    self.view_search.hidden = YES;
    CGRect frame = web_view.frame;
    frame.origin.y = frame.origin.y+self.txf_search.frame.size.height + 8 + 35;
    frame.size.height = frame.size.height - (self.txf_search.frame.size.height + 8 + 35);
    [table_view setFrame:frame];
    v_rmvc.rightOrLeft = @"right";
    [v_rmvc changePageTheme:nil];
    _status = ICouponListStatusMyCouponList;
    NSLog(@"Get My Coupon List");
	[[CoreData sharedCoreData].mask showMask];
    
    NSString *urlAddress = [NSString stringWithFormat:@"%@?Lang=%@&TxType=2",
                            [CoreData sharedCoreData].iCouponServerURL,
                            [[CoreData sharedCoreData] couponLang]];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [web_view loadRequest:requestObj];
    

    

    
	NSLog(@"debug ICouponListViewController url:%@", asi_request.url);
}



///////////////////
//ASIHTTPRequest
///////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	
//    NSLog(@"debug PBConcertsListViewController requestFinished:%@",[request responseString]);
    //Format Data
    
    NSString *xmlString = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] substringFromIndex:8];
    if(!xmlString)
        xmlString = [[request responseString] substringFromIndex:8] ;
    
    NSData* xmlData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    
//    NSLog(@"debug PBConcertsListViewController requestFinished:%@",[request responseString]);

    //Format End
	NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLParser:xml_parser];
    self.items_data = [[xmlDoc arrayValueForKeyPath:@"Coupons.coupon"] mutableCopy];;
    searchResults = self.items_data;
    [table_view reloadData];
    
    if(_status == ICouponListStatusCouponList){
        loadFinished = YES;
    }
    

    
	[[CoreData sharedCoreData].mask hiddenMask];

}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"PBConcertsListViewController requestFailed:%@", request.error);
    if(!request.isCancelled){
        UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"iCoupon.myWallet.warning",nil) message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
        [alert_view show];
    }
//    [alert_view release];

	[[CoreData sharedCoreData].mask hiddenMask];
}
//- (void)keyboardDidShow:(NSNotification*) note {
//    return;
//}

- (void)viewDidUnload {
    [self setTxf_search:nil];
    [self setView_search:nil];
    [self setBtn_logout:nil];
    [super viewDidUnload];
}
//- (void)dealloc {
//    [_btn_logout release];
//    [_view_search release];
//    [super dealloc];
//}
@end
