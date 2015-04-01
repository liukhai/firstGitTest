//
//  MHBEAPTWorldIndexViewController.h
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTWorldIndexView;

@interface MHBEAPTWorldIndexViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	PTWorldIndexView						*m_oPTWorldIndexView;
	
	NSString								*m_oLastUpd;
	
	//Storing MHIndex object
	NSArray									*m_oDataSrcArray;
	
}

- (void)dealloc;
- (void)loadView;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (void)viewWillDisappear:(BOOL)animated;
- (void)didReceiveMemoryWarning;
- (void)reloadText;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadWorldIndexWithLoadingView;
- (void)reloadWorldIndex;
- (void)onWorldIndexReceived:(NSNotification *)n;

@end