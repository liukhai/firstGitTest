//
//  OutletListCell2.h
//  BEA
//
//  Created by jerry on 14-4-9.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreData.h"

@interface OutletListCell2 : UITableViewCell <UIAlertViewDelegate> {
	UILabel *address, *distance, *opening;
	UIImageView *bg, *house, *handset;
	UIButton *tel;
	//UIButton *call;
}

@property (nonatomic, assign) UILabel *address, *distance, *opening;
@property (nonatomic, assign) UIButton *tel;
@property (nonatomic, assign) UIImageView *handset;

- (void)layoutViews;
@end
