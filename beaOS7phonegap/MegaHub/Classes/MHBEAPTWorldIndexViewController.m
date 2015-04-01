    //
//  MHBEAPTWorldIndexViewController.m
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "MHBEAPTWorldIndexViewController.h"
#import "ViewControllerDirector.h"
#import "MagicTraderAppDelegate.h"
#import "PTWorldLocalIndexView.h"
#import "MHBEAPTSSWorldLocalIndexCell.h"
#import "PTWorldIndexView.h"

#import "MHFeedXMsgInGetWorldIndex.h"
#import "MHSolutionProviderView.h"
#import "MHFeedXObjWorldIndex.h"
#import "MHFeedConnectorX.h"
#import "StyleConstant.h"
#import "PTConstant.h"
#import "MHLanguage.h"
#import "MHUtility.h"
#import "MHBEAPTSSIndexViewController.h"

#define SECTION_COUNT						1

@implementation MHBEAPTWorldIndexViewController

- (void)dealloc {
    [m_oPTWorldIndexView release];
	[m_oLastUpd release];
	[m_oDataSrcArray release];
    [super dealloc];
}

- (void)loadView {
	m_oPTWorldIndexView = [[PTWorldIndexView alloc] initWithFrame:CGRectMake(0, 0, 320, [MHUtility getAppHeight]-15-31-94-33)];
    
    m_oPTWorldIndexView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
	m_oPTWorldIndexView.m_oTableView.delegate = self;
	m_oPTWorldIndexView.m_oTableView.dataSource = self;
	self.view = m_oPTWorldIndexView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[MHFeedConnectorX sharedMHFeedConnectorX] addGetWorldIndexObserver:self action:@selector(onWorldIndexReceived:)];
	[m_oPTWorldIndexView startLoading];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[[MHFeedConnectorX sharedMHFeedConnectorX] removeGetWorldIndexObserver:self];
    
    [m_oPTWorldIndexView release];
	m_oPTWorldIndexView = nil;
}


-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadText {
	[m_oPTWorldIndexView reloadText];
}

#pragma mark -
#pragma mark Table view data source
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [m_oDataSrcArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [MHBEAPTSSWorldLocalIndexCell getHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)] autorelease];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 160, 25)];
    namelabel.textColor = [UIColor orangeColor];
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.font = PTWorldLocalIndexCell_m_oLabel_Header_font;
    namelabel.text = MHLocalizedString(@"PTWorldLocalIndexView.header.nameLabel.text", nil);
    [headerView addSubview:namelabel];
    [namelabel release];
    
    UILabel *nominallabel = [[UILabel alloc] initWithFrame:CGRectMake(162, 0, 80, 25)];
    nominallabel.textColor = [UIColor orangeColor];
    nominallabel.textAlignment = NSTextAlignmentCenter;
    nominallabel.font = PTWorldLocalIndexCell_m_oLabel_Header_font;
    nominallabel.text = MHLocalizedString(@"PTWorldLocalIndexView.header.nominalLabel.text", nil);
    [headerView addSubview:nominallabel];
    [nominallabel release];
    
    UILabel *pChangelabel = [[UILabel alloc] initWithFrame:CGRectMake(242, 0, 76, 25)];
    pChangelabel.textColor = [UIColor orangeColor];
    pChangelabel.textAlignment = NSTextAlignmentRight;
    pChangelabel.font = PTWorldLocalIndexCell_m_oLabel_Header_font;
    pChangelabel.text = MHLocalizedString(@"PTWorldLocalIndexVie.header.pChangeLabel.text", nil);
    [headerView addSubview:pChangelabel];
    [pChangelabel release];
    
	return headerView;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	
    MHBEAPTSSWorldLocalIndexCell *cell = (MHBEAPTSSWorldLocalIndexCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MHBEAPTSSWorldLocalIndexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Configure the cell...
    if ([m_oDataSrcArray count] > indexPath.row) {
        MHFeedXObjWorldIndex *mhindex = [m_oDataSrcArray objectAtIndex:indexPath.row];
        
        NSString *name = nil;
        
        switch ([MHLanguage getCurrentLanguage]) {
            case LanguageEnglish:				name = mhindex.m_sDesp;			break;
            case LanguageTraditionalChinese:	name = mhindex.m_sChiDesp;		break;
            case LanguageSimpleChinese:			name = mhindex.m_sCnDesp;		break;
            case LanguageJapanese:				name = mhindex.m_sJpDesp;		break;
            default:							name = mhindex.m_sChiDesp;		break;
        }
        cell.m_oLabel_HSIName.text = name;
        
        [cell.m_oLabel_Nominal setText:[NSString stringWithFormat:@"%0.2lf",[mhindex.m_sLast doubleValue]]];
        
        if ([mhindex.m_sChange floatValue] > 0.0f) {
            cell.m_oLabel_Change.textColor	= Default_label_text_color_up;
            cell.m_oLabel_PChange.textColor	= Default_label_text_color_up;
            cell.m_oLabel_Change.text		= [MHUtility formatDecimalString:mhindex.m_sChange decPlace:2];
            NSString *changeP				= [MHUtility formatDecimalString:mhindex.m_sPctChange decPlace:2];
            cell.m_oLabel_PChange.text		= [NSString stringWithFormat:@"( %@%%)",changeP];
            
        } else if ([mhindex.m_sChange floatValue] < 0.0f) {
            cell.m_oLabel_Change.textColor	= Default_label_text_color_down;
            cell.m_oLabel_PChange.textColor	= Default_label_text_color_down;
            cell.m_oLabel_Change.text		= [MHUtility formatDecimalString:mhindex.m_sChange decPlace:2];
            NSString *changeP = [MHUtility formatDecimalString:mhindex.m_sPctChange decPlace:2];
            cell.m_oLabel_PChange.text		= [NSString stringWithFormat:@"( %@%%)",changeP];
            
        } else { // == 0
            cell.m_oLabel_Change.textColor	= Default_label_text_color_leveloff;
            cell.m_oLabel_PChange.textColor	= Default_label_text_color_leveloff;
            cell.m_oLabel_Change.text		= [MHUtility formatDecimalString:mhindex.m_sChange decPlace:2];
            NSString *changeP = [MHUtility formatDecimalString:mhindex.m_sPctChange decPlace:2];
            cell.m_oLabel_PChange.text		= [NSString stringWithFormat:@"( %@%%)",changeP];
            
        }
    }
    
    return cell;
    
}

#pragma mark -
#pragma mark Callback Functions
- (void)reloadWorldIndexWithLoadingView{
	[[MHFeedConnectorX sharedMHFeedConnectorX] getWorldIndexFreeText:nil];
	[m_oPTWorldIndexView startLoadingWithSpinner:YES];
}

- (void)reloadWorldIndex {
 	[[MHFeedConnectorX sharedMHFeedConnectorX] getWorldIndexFreeText:nil];
	[m_oPTWorldIndexView startLoadingWithSpinner:NO];
}

- (void)onWorldIndexReceived:(NSNotification *)n {
	MHFeedXMsgInGetWorldIndex *msg = [n object];
	if (m_oDataSrcArray) {
		[m_oDataSrcArray release];
		m_oDataSrcArray = nil;
	}
	m_oDataSrcArray = [msg.m_oIndexArray retain];
	[m_oLastUpd release];
	m_oLastUpd = [msg.m_sLastUpd retain];
	[m_oPTWorldIndexView performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:NO];
	[m_oPTWorldIndexView performSelectorOnMainThread:@selector(stopLoading) withObject:nil waitUntilDone:NO];
	
}

@end