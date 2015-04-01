//
//  OutletListCell.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年4月22日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface OutletListCell : UITableViewCell <UIAlertViewDelegate> {
	UILabel *address, *distance, *opening;
	UIImageView *bg, *house, *handset;
	UIButton *tel;
	//UIButton *call;
}

@property (nonatomic, assign) UILabel *address, *distance, *opening;
@property (nonatomic, assign) UIButton *tel;
@end
