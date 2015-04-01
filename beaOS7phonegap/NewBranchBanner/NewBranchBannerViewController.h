//
//  NewBranchBanner.h
//  BEA
//
//  Created by yaojzy on 10/24/11.
//  Copyright (c) 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreData.h"
#import "NewBranchBannerUtil.h"
#import "NewBranchListViewController.h"

@interface NewBranchBannerViewController : UIViewController {

    BOOL isHiddenImportantNotice;
    IBOutlet UILabel *promotionText;
    NSMutableArray *shown_data;
}

@property(nonatomic, retain)UILabel *promotionText;
@property(nonatomic, retain)NSMutableArray *shown_data;

-(void)showMe;
-(IBAction)hiddenMe;
-(void)saveCount;
-(IBAction)hiddenMeAndOpenAccpro;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shownData:(NSMutableArray*)data;

@end