//
//  YearRoundOffersMenuViewController.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月18日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuProtocol.h"

@interface YearRoundOffersMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	id <MenuDelegate> delegate;
	BOOL dining_mode;
	IBOutlet UITableView *table_view;
}

@property (nonatomic, assign) id <MenuDelegate> delegate;

-(IBAction)menuItemPressed:(UIButton *)button;
-(void)setDiningMode:(BOOL)diningMode;
@end
