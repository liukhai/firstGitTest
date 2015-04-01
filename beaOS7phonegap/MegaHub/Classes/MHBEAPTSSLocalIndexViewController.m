    //
//  MHBEAPTSSLocalIndexViewController.m
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAPTSSWorldLocalIndexViewController.h"
#import "MHBEAPTSSLocalIndexViewController.h"
#import "MHBEAPTSSIndexViewController.h"
#import "PTLocalIndexConstituentView.h"
#import "MHDetailDisclaimerButton.h"
#import "MagicTraderAppDelegate.h"
#import "MHBEAPTSSWorldLocalIndexCell.h"
#import "PTLocalIndexView.h"
#import "StyleConstant.h"
#import "MHLanguage.h"
#import "PTConstant.h"
#import "MHUtility.h"
#import "MHFeedConnectorX.h"
#import "MHFeedXMsgInGetLiteQuote.h"
#import "ViewControllerDirector.h"
#import "MHSolutionProviderView.h"

#define SECTION_COUNT		1

@implementation MHBEAPTSSLocalIndexViewController

- (id) init {
	self = [super init];
	if (self != nil) {
		m_oIndexArray = [[NSMutableArray alloc] init];
	}
	return self;
}

//-----------------------------------------------------------------------------
- (void)dealloc {
	[m_oSelectedCellIndexPath release];
	[m_oSelectedIndexImage release];
	
	[m_oIndexArray release];
    
    [m_oPTLocalIndexView release];
    [m_oPTLocalIndexConstituentView release];
	
	[super dealloc];
}

- (void)loadView {
    
	// ptlocal index view
	m_oPTLocalIndexView = [[PTLocalIndexView alloc] initWithFrame:CGRectMake(0, 0, 640, [MHUtility getAppHeight]-15-31-94-28)];
	self.view = m_oPTLocalIndexView;
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
	
	// local index constituent view
	m_oPTLocalIndexConstituentView = [[PTLocalIndexConstituentView alloc] initWithFrame:CGRectMake(320, 0, 320, [MHUtility getAppHeight]-15-31-94-28)];
	m_oPTLocalIndexConstituentView.m_oWebView.delegate = self;
	[self.view addSubview:m_oPTLocalIndexConstituentView];
	m_oPTLocalIndexConstituentView.hidden = YES;
	
	m_oPTLocalIndexView.m_oTableView.delegate = self;
	m_oPTLocalIndexView.m_oTableView.dataSource = self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    [[MHFeedConnectorX sharedMHFeedConnectorX] addGetLiteQuoteObserver:self action:@selector(onGetLiteQuoteReceived:)];
    [[MHFeedConnectorX sharedMHFeedConnectorX] addGetLocalIndexNameObserver:self action:@selector(onGetLocalIndexName:)];
	[[MHFeedConnectorX sharedMHFeedConnectorX] getLocalIndexName:nil language:[MHLanguage getCurrentLanguage]];
}

- (void)viewDidUnload {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super viewDidUnload];
	
	[m_oPTLocalIndexView release];	
	m_oPTLocalIndexView = nil;
	
	[m_oPTLocalIndexConstituentView release];
	m_oPTLocalIndexConstituentView = nil;
}

- (void)reloadText {
	[self reloadLocalIndex];
	[m_oPTLocalIndexView reloadText];
	[m_oPTLocalIndexConstituentView reloadText];
    
    NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlIndexConstituent:PT_WEBVIEW_STYLE
                                                                                language:[MHLanguage getCurrentLanguage]
                                                                             refreshRate:nil
                                                                                   index:m_sLocalIndexType
                                                                                  action:@"-1"
                                                                                realtime:@"0"
                                                                                 version:URL_VERSION_1_0
                                                                                       v:nil];
    
    urlString = [NSString stringWithFormat:@"%@&showAll=1",urlString];
	[m_oPTLocalIndexConstituentView loadURLString:urlString];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return NO;
}


#pragma mark -
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [m_oIndexArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)] autorelease];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 135, 25)];
    namelabel.textColor = [UIColor orangeColor];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.font = PTWorldLocalIndexCell_m_oLabel_Header_font;
    namelabel.text = MHLocalizedString(@"PTWorldLocalIndexView.header.nameLabel.text", nil);
    [headerView addSubview:namelabel];
    [namelabel release];
    
    UILabel *nominallabel = [[UILabel alloc] initWithFrame:CGRectMake(142, 0, 80, 25)];
    nominallabel.textColor = [UIColor orangeColor];
    nominallabel.textAlignment = NSTextAlignmentCenter;
    nominallabel.font = PTWorldLocalIndexCell_m_oLabel_Header_font;
    nominallabel.text = MHLocalizedString(@"PTWorldLocalIndexView.header.nominalLabel.text", nil);
    [headerView addSubview:nominallabel];
    [nominallabel release];
    
    UILabel *pChangelabel = [[UILabel alloc] initWithFrame:CGRectMake(222, 0, 76, 25)];
    pChangelabel.textColor = [UIColor orangeColor];
    pChangelabel.textAlignment = NSTextAlignmentRight;
    pChangelabel.font = PTWorldLocalIndexCell_m_oLabel_Header_font;
    pChangelabel.text = MHLocalizedString(@"PTWorldLocalIndexVie.header.pChangeLabel.text", nil);    
    [headerView addSubview:pChangelabel];
    [pChangelabel release];
    
	return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([m_oSelectedCellIndexPath isEqual:indexPath]) {
		return [MHBEAPTSSWorldLocalIndexCell getHeightWithGraphic];
		
	} else {
		return [MHBEAPTSSWorldLocalIndexCell getHeight];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
    MHBEAPTSSWorldLocalIndexCell *cell = (MHBEAPTSSWorldLocalIndexCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //disable select on table
        cell = [[[MHBEAPTSSWorldLocalIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        [cell.m_oAccessoryButton addTarget:self action:@selector(onAccessoryButtonPressed:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    MHFeedXObjIndexName *name = [m_oIndexArray objectAtIndex:indexPath.row];
    if([name.m_sSymbol isEqualToString:@"VHSI"]){
        cell.m_oAccessoryButton.hidden = YES;
    }else{
        cell.m_oAccessoryButton.hidden = NO;
    }
    
    MHFeedXObjQuote *quote = ([m_oIndexArray count] > indexPath.row)?[m_oIndexArray objectAtIndex:indexPath.row]:nil;
    [cell updateWithMHFeedXObjQuote:quote];
    
    if (m_oSelectedIndexImage != nil &&
        [indexPath isEqual:m_oSelectedCellIndexPath] == YES) {
        
        cell.m_oGraphView.image = m_oSelectedIndexImage;
        cell.m_oGraphView.hidden = NO;
    } else {
        cell.m_oGraphView.image = nil;
        cell.m_oGraphView.hidden = YES;
    }
    return cell;
	
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    MHFeedXObjIndexName *indexName = [self localIndexFromIndexPath:indexPath];
    
    [m_sLocalIndexType release];
	m_sLocalIndexType = [indexName.m_sSymbol retain];
    
    NSString *urlString = [[MHFeedConnectorX sharedMHFeedConnectorX] urlIndexConstituent:PT_WEBVIEW_STYLE
																	  language:[MHLanguage getCurrentLanguage]
																   refreshRate:nil
																		 index:m_sLocalIndexType
																		action:@"-1"
																	  realtime:@"0"
                                                                       version:URL_VERSION_1_0
                                                                             v:nil];
    
    urlString = [NSString stringWithFormat:@"%@&showAll=1",urlString];
    
	[m_oPTLocalIndexConstituentView loadURLString:urlString];
    
    [self showIndexConstituentView:YES animationTime:0.7];

}

- (void)onAccessoryButtonPressed:(id)sender event:(id)event {
	NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:m_oPTLocalIndexView.m_oTableView];
    NSIndexPath *indexPath = [m_oPTLocalIndexView.m_oTableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil) {
        [self tableView: m_oPTLocalIndexView.m_oTableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	UIImageView *bgv = nil;
	if (indexPath.row % 2  == 0 ) {
		bgv = [[[UIImageView alloc] initWithImage:PTWorldLocalIndexCell_background_image_dark] autorelease];
		[cell setBackgroundView:bgv];
	} else {
		bgv = [[[UIImageView alloc] initWithImage:PTWorldLocalIndexCell_background_image_light] autorelease];
		[cell setBackgroundView:bgv];
	}
}


#pragma mark -
#pragma mark  m_oPTLocalIndexConstituentView Functions
- (void)loadGraph {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *urlString = nil;
	MHFeedXObjIndexName *indexName = [self localIndexFromIndexPath:m_oSelectedCellIndexPath];
	NSString *localIndexType = indexName.m_sSymbol;
	
	// [NSString stringWithFormat:URL_INDEX_GRAPH, localIndexType, 300, 120, langString];
	urlString = [self urlLocalIndexGraph:localIndexType width:300 height:120 language:[MHLanguage getCurrentLanguage]];
	
	
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
	@synchronized(m_oSelectedIndexImage){
		if(m_oSelectedIndexImage){
			[m_oSelectedIndexImage release];
			m_oSelectedIndexImage = nil;
		}
		m_oSelectedIndexImage = [[UIImage imageWithData:imageData] retain];
	}
	
	if (m_oSelectedIndexImage != nil && m_oSelectedCellIndexPath != nil) {
		[m_oPTLocalIndexView.m_oTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:m_oSelectedCellIndexPath] withRowAnimation:UITableViewRowAnimationNone];
	}
	
	
	[pool drain];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// if tap the same cell again
	BOOL tapOnSameCell = [m_oSelectedCellIndexPath isEqual:indexPath];	
	
	if (m_oSelectedIndexImage) {
		[m_oSelectedIndexImage release];
		m_oSelectedIndexImage = nil;
	}
	
	if (tapOnSameCell) {
		// must collapse
		if (m_oSelectedCellIndexPath) {
			[m_oSelectedCellIndexPath release];
			m_oSelectedCellIndexPath = nil;
		}
		
		[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone]; 
		
	} else {
		if (m_oSelectedCellIndexPath) {
			[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:m_oSelectedCellIndexPath] withRowAnimation:UITableViewRowAnimationNone]; 
		}
		if (m_oSelectedCellIndexPath) {
			[m_oSelectedCellIndexPath release];
			m_oSelectedCellIndexPath = nil;
		}
		m_oSelectedCellIndexPath = [indexPath retain];
		[self performSelector:@selector(loadGraph) withObject:nil afterDelay:0.5];
		
		[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone]; 
	}
	
}


#pragma mark -
#pragma mark UIWebView Delegate Functions
- (void)webViewDidStartLoad:(UIWebView *)webView {
	[m_oPTLocalIndexConstituentView startLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[m_oPTLocalIndexConstituentView stopLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	[m_oPTLocalIndexConstituentView stopLoading];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
	NSString *urlString = [[request URL] absoluteString];
	
	if ([[[request URL] scheme] isEqualToString:STOCK_QUOTE_LINK_PREFIX] == YES) {
		ViewControllerDirectorParameter *p = [[ViewControllerDirectorParameter alloc] init];
		p.m_sString1 = urlString;
		
		[[ViewControllerDirector sharedViewControllerDirector] switchTo:ViewControllerDirectorIDQuote para:p];
		
		[p release];
		
	}
	return YES;
}

- (void)showIndexConstituentView:(BOOL)aShow animationTime:(float)aAnimationTime{
	if (aShow) {
		// swithc to local index constituent view
		m_oPTLocalIndexConstituentView.hidden = NO;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:aAnimationTime];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		
		// move old view to left, out of screen
		[m_oPTLocalIndexView setFrame:CGRectMake(-320, 
												 m_oPTLocalIndexView.frame.origin.y,
												 m_oPTLocalIndexView.frame.size.width, 
												 m_oPTLocalIndexView.frame.size.height)];
		
		[UIView commitAnimations];
		
	} else {
		// set new view to left
		[m_oPTLocalIndexView setFrame:CGRectMake(-320, 
												 m_oPTLocalIndexView.frame.origin.y,
												 m_oPTLocalIndexView.frame.size.width, 
												 m_oPTLocalIndexView.frame.size.height)];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:aAnimationTime];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		
		// move new view from right to left
		[m_oPTLocalIndexView setFrame:CGRectMake(0, 
												 m_oPTLocalIndexView.frame.origin.y,
												 m_oPTLocalIndexView.frame.size.width, 
												 m_oPTLocalIndexView.frame.size.height)];
		[UIView commitAnimations];
		
		[m_oPTLocalIndexConstituentView performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:aAnimationTime];
	}
	
}

- (MHFeedXObjIndexName *)localIndexFromIndexPath:(NSIndexPath *)aIndexPath {
	
	MHFeedXMsgInGetLocalIndexName *msg = [[MHFeedConnectorX sharedMHFeedConnectorX] getLocalIndexName];
	NSArray *arr = msg.m_oIndexArray;
	int cur = 0;
	MHFeedXObjIndexName *name = nil;
	
	for (name in arr) {
		if (name.m_iType == 2) { // future
			if ([[MHFeedConnectorX sharedMHFeedConnectorX] getPermission:MHFEEDX_PERMISSION_MT_INDEX_FUTURES] == NO) {
				continue;
			}
		}
		
		if (cur == aIndexPath.row) {
			return name;
		}
		cur++;
	}
	return nil;
}

- (NSString *)urlLocalIndexGraph:(NSString *)aLocalIndexType width:(int)aWdith height:(int)aHeight language:(Language)aLanguage {
	NSString *urlString = nil, *langString = nil;
	
	switch (aLanguage) {
		case LanguageEnglish: {						langString = @"0";		break; }
		case LanguageTraditionalChinese: {			langString = @"1";		break; }
		case LanguageSimpleChinese: {				langString = @"2";		break; }
		case LanguageDefault: {						langString = @"0";		break; }
		default: {									langString = @"0";		break; }
	}
	
	urlString = [NSString stringWithFormat:PTLocalIndexViewController_URL_INDEX_GRAPH, aLocalIndexType, aWdith, aHeight, langString, CHART_CR];
	return urlString;
}


#pragma mark -
#pragma mark onGetLiteQuoteReceived
- (void)reloadLocalIndex {
    NSArray *typeArray = [NSArray arrayWithObjects:
                          Parameter_Desp,
                          Parameter_Last_Update,
                          Parameter_Last,
                          Parameter_Turnover,
                          Parameter_Change,
                          Parameter_Pct_Change, nil];
    
    MHFeedXMsgInGetLocalIndexName *msg = [[MHFeedConnectorX sharedMHFeedConnectorX] getLocalIndexName];
    NSMutableArray *indexSymbolArr = [[NSMutableArray alloc] init];
    for (MHFeedXObjIndexName *name in msg.m_oIndexArray) {
        if (name.m_iType == 2) { // future
            if ([[MHFeedConnectorX sharedMHFeedConnectorX] getPermission:MHFEEDX_PERMISSION_MT_INDEX_FUTURES]) {
                [indexSymbolArr addObject:[NSString stringWithFormat:@"%@.HK", name.m_sSymbol]];
            }
        } else {
            [indexSymbolArr addObject:[NSString stringWithFormat:@"%@.HK", name.m_sSymbol]];
        }
    }
    
    m_uiFeedXMsgID = [[MHFeedConnectorX sharedMHFeedConnectorX] getLiteQuoteWithAuthen:indexSymbolArr
                                                                                  type:typeArray
                                                                              language:[MHLanguage getCurrentLanguage]
                                                                            fromObject:self
                                                                              freeText:nil
                                                                                action:@"-1"
                                                                              realtime:PT_WEBVIEW_DELAY];
    [indexSymbolArr release];
}

- (void)handleGetLiteQuote:(MHFeedXMsgInGetLiteQuote *)aMsg {
	[m_oIndexArray removeAllObjects];
	
	NSArray *stockQuoteArray = aMsg.m_oStockQuoteArray;
	NSArray *quoteArray = nil;
	for (MHFeedXObjStockQuote *stockQuote in stockQuoteArray) {
		quoteArray = stockQuote.m_oQuoteArray;
		if ([quoteArray count] > 0) {
			[m_oIndexArray addObject:[quoteArray objectAtIndex:0]];
		}
	}
	
	[m_oPTLocalIndexView.m_oTableView reloadData];
}

- (void)onGetLocalIndexName:(NSNotification *)n {
	[[MHFeedConnectorX sharedMHFeedConnectorX] removeGetLocalIndexNameObserver:self];
    [self reloadLocalIndex];
}

- (void)onGetLiteQuoteReceived:(NSNotification *)n {
	MHFeedXMsgInGetLiteQuote *msg = [n object];
	if (msg.m_uiMessageID == m_uiFeedXMsgID) {
		[self performSelectorOnMainThread:@selector(handleGetLiteQuote:) withObject:msg waitUntilDone:NO];
	}
}

@end