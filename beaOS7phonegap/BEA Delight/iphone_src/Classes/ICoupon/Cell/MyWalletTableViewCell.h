//
//  MyWalletTableViewCell.h
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CachedImageView.h"
@class CachedImageView;
@interface MyWalletTableViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet CachedImageView *imv_icon;
@property (retain, nonatomic) IBOutlet UILabel *lbl_title;
@property (retain, nonatomic) IBOutlet UILabel *lbl_subTitle;
@property (retain, nonatomic) IBOutlet UILabel *lbl_minTitle1;
@property (retain, nonatomic) IBOutlet UILabel *lbl_minTitle2;
@property (retain, nonatomic) IBOutlet UIButton *btn_action;


-(void)setData:(NSDictionary *)data;

@end
