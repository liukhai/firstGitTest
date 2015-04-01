    //
//  MHBEAFASectorRootViewController.m
//  BEA
//
//  Created by MegaHub on 15/09/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAFASectorRootViewController.h"
#import "PTSectorRootView.h"
#import "PTConstant.h"

#import "MHFeedConnectorX.h"
#import "MHFeedXObjSector.h"
#import "MagicTraderAppDelegate.h"
#import "MHDetailDisclaimerButton.h"
#import "MHBEAPTSSIndexViewController.h"
#import "LoadingView.h"
#import "MHUtility.h"
#import "StyleConstant.h"
#import "ViewControllerDirector.h"

#define SECTION_COUNT				1

@implementation MHBEAFASectorRootViewController

@synthesize m_sSector;

- (id) init {
	self = [super init];
	if (self != nil) {
		@synchronized(m_oDataSourceArray) {
			m_oDataSourceArray = [[MHFeedConnectorX sharedMHFeedConnectorX] getSectorArray];
			[m_oDataSourceArray retain];
		}
	}
	return self;
}

- (void)dealloc {
    [[MHFeedConnectorX sharedMHFeedConnectorX] removeGetSectorName:self];
	[m_oDataSourceArray release];
	[m_oPTSectorRootView release];
    [super dealloc];
}

- (void)loadView {
    m_oPTSectorRootView = [[PTSectorRootView alloc] initWithFrame:CGRectMake(0, 94, 320, [MHUtility getAppHeight]-15-31-94) permission:YES];
	self.view = m_oPTSectorRootView;
    
    [m_oPTSectorRootView.m_oTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    m_oPTSectorRootView.m_oTableView.frame = CGRectMake(0, 0, 320, [MHUtility getAppHeight]-15-31-94);
    
    m_oPTSectorRootView.m_oTableView.delegate = self;
    m_oPTSectorRootView.m_oTableView.dataSource = self;
    [m_oPTSectorRootView.m_oWebView setDelegate:self];
    
    m_oPTSectorRootView.m_oTableView.hidden = NO;
	m_oPTSectorRootView.m_oWebView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[[MHFeedConnectorX sharedMHFeedConnectorX] addGetSectorName:self action:@selector(onGetSectorNameReceived:)];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	[[MHFeedConnectorX sharedMHFeedConnectorX] removeGetSectorName:self];
    
	[m_oPTSectorRootView release];
	m_oPTSectorRootView = nil;
}

- (void)reloadText {
	[[MHFeedConnectorX sharedMHFeedConnectorX] getSectorNameLanguage:[MHLanguage getCurrentLanguage] freeText:@"!!!"];
	
	[m_oPTSectorRootView reloadText];
}

- (void)onBackButtonPressed{
    UIWebView *oWebView = m_oPTSectorRootView.m_oWebView;
    [oWebView setFrame:CGRectMake(320, oWebView.frame.origin.y, oWebView.frame.size.width, oWebView.frame.size.height)];
    
    UITableView *oTableView = m_oPTSectorRootView.m_oTableView;
	[oTableView setFrame:CGRectMake(0, oTableView.frame.origin.y, oTableView.frame.size.width, oTableView.frame.size.height)];
}

#pragma mark -
#pragma mark TableView delegate functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [m_oDataSourceArray count];
}

//-----------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44;
}

//-----------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		//disable select on table
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		[cell.textLabel setTextColor:PTSectorRootViewController_cell_title_color];
        
        UIImage *btnImageUnpressed = PTWorldLocalIndexCell_m_oAccessoryButton_unpressedImage;
		UIImage *btnImagePressed = PTWorldLocalIndexCell_m_oAccessoryButton_pressedImage;
		UIButton *m_oAccessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[m_oAccessoryButton setFrame:CGRectMake(cell.frame.size.width-20-5, (cell.frame.size.height-20)/2, 19, 20)];
		[m_oAccessoryButton setImage:btnImageUnpressed forState:UIControlStateNormal];
		[m_oAccessoryButton setImage:btnImagePressed forState:UIControlStateSelected];
        [m_oAccessoryButton addTarget:self action:@selector(onAccessoryButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
		[cell addSubview:m_oAccessoryButton];
        
//		[cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
	}
	
	MHFeedXObjSector *sector = nil;
	if ([m_oDataSourceArray count] > indexPath.row) {
		sector = [m_oDataSourceArray objectAtIndex:indexPath.row];
	}
	
	if (sector) {
		cell.textLabel.text = sector.m_sDesp;
	} else {
		cell.textLabel.text = nil;
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//	if([indexPath row]%2 == 0){
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:PTSectorRootViewController_cell_background_image_dark];
//		cell.backgroundView = imgView;
//        [imgView release];
//	}else{
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:PTSectorRootViewController_cell_background_image_light];
//		cell.backgroundView = imgView;
//        [imgView release];
//	}
    
    if([indexPath row]%2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:237/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    }else {
        cell.backgroundColor = [UIColor colorWithRed:253/255.0 green:253/255.0 blue:253/255.0 alpha:1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	MHFeedXObjSector *sector = nil;
	if ([m_oDataSourceArray count] > indexPath.row) {
		sector = [m_oDataSourceArray objectAtIndex:indexPath.row];
		self.m_sSector = sector.m_sC;
		[self loadSectorWithC:sector.m_sC];
	}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	MHFeedXObjSector *sector = nil;
	if ([m_oDataSourceArray count] > indexPath.row) {
		sector = [m_oDataSourceArray objectAtIndex:indexPath.row];
		self.m_sSector = sector.m_sC;
		[self loadSectorWithC:sector.m_sC];
	}
}

- (void)onAccessoryButtonPressed:(id)sender event:(id)event {
	NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:m_oPTSectorRootView.m_oTableView];
    NSIndexPath *indexPath = [m_oPTSectorRootView.m_oTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        [self tableView:m_oPTSectorRootView.m_oTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

//-----------------------------------------------------------------------------
#pragma mark -
#pragma mark Language Translation for RelatedQutoe link
// no use can be deleted
- (NSString *)getNewsLanguageTransluation {
	NSString *lang = nil;
	switch ([MHLanguage getCurrentLanguage]) {
		case LanguageEnglish: {					lang = @"en";		break;	}
		case LanguageTraditionalChinese: {		lang = @"tc";		break;	}
		case LanguageSimpleChinese: {			lang = @"sc";		break;	}
		case LanguageJapanese: {				lang = @"jp";		break;	}
		default: {								lang = @"en";		break;	}
	}
	return lang;
}

// function overrider to get delay quote
- (void)loadSectorWithStock:(NSString *)aSymbolWithOutLeadingZero {
    
    NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlSectorWithStock:aSymbolWithOutLeadingZero
																				  style:PT_WEBVIEW_STYLE
																				 action:@"-1"
																			   realtime:@"0"
                                                                                version:URL_VERSION_1_0
                                                                                      v:nil];
    
    urlString = [NSString stringWithFormat:@"%@&showAll=1", urlString];
    
	[m_oPTSectorRootView switchWebViewWithURLString:urlString];
	
}

// function overrider to get delay quote
- (void)loadSectorWithC:(NSString *)aSector {
    
    NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlSectorWithC:aSector
																			  style:PT_WEBVIEW_STYLE
																			 action:@"-1"
																		   realtime:@"0"
                                                                            version:URL_VERSION_1_0
                                                                                  v:nil];
    
    urlString = [NSString stringWithFormat:@"%@&showAll=1", urlString];
    
	[m_oPTSectorRootView switchWebViewWithURLString:urlString];
}


#pragma mark -
#pragma mark WebView delegate functions
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	BOOL isLoad = YES;
	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:STOCK_QUOTE_LINK_PREFIX] == YES) {
		
		ViewControllerDirectorParameter *p = [[ViewControllerDirectorParameter alloc] init];
		p.m_sString1 = urlString;
		
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:p];
		
		[p release];
		isLoad = NO;
		
	} else if([[[request URL] scheme] isEqualToString:DISCLAIMER_PREFIX] == YES){
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDSolutionProviderDisclaimer para:nil];
		isLoad = NO;
	}
	
	return isLoad;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[m_oPTSectorRootView.m_oLoadingView startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[m_oPTSectorRootView.m_oLoadingView stopLoading];
	if ([webView canGoBack]) {
		//[m_oBackButton setHidden:NO];
	}
	if ([webView canGoForward]) {
		//[m_oBackButton setHidden:YES];
	}
	
	// if show detail, send showAll()
	if ([MT_DELEGATE loadIsDetailViewInSectorView]) {
		[m_oPTSectorRootView sendJavaScriptString:JAVASCRIPT_SECTOR_DETAIL];
	}	
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	
	if([error code] == NSURLErrorCancelled){
		return;
	}
	
	[m_oPTSectorRootView.m_oLoadingView stopLoading];
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
	
}


#pragma mark -
#pragma mark MHFeedConnectorX callback functions
- (void)onGetSectorNameReceived:(NSNotification *)n {
	@synchronized (m_oDataSourceArray) {
		if (m_oDataSourceArray) {
			[m_oDataSourceArray release];
			m_oDataSourceArray = nil;
		}
		m_oDataSourceArray = [[MHFeedConnectorX sharedMHFeedConnectorX] getSectorArray];
		[m_oDataSourceArray retain];
		[m_oPTSectorRootView.m_oTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
	}
}

@end