//
//  OutletLisrViewDelegate.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年5月16日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OutletListViewController;

@protocol OutletListViewDelegate

-(void)OutletListUpdated:(NSArray *)items_data;

@end
