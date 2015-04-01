//
//  MyWalletTableViewCell.m
//  BEA
//
//  Created by Keith Wong on 19/8/14.
//  Copyright (c) 2014 The Bank of East Asia, Limited. All rights reserved.
//

#import "MyWalletTableViewCell.h"

@interface MyWalletTableViewCell ()

@end

@implementation MyWalletTableViewCell



//- (void)dealloc {
//    [_lbl_title release];
//    [_lbl_subTitle release];
//    [_lbl_minTitle1 release];
//    [_lbl_minTitle2 release];
//    [_btn_action release];
//    [super dealloc];
//}

-(void)setData:(NSDictionary *)data{
    NSString* imageEncodeURL = [[data valueForKey:@"image_s"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self.imv_icon loadImageWithURL:imageEncodeURL];
    self.lbl_title.text = [NSString stringWithFormat:@"%@",[data valueForKey:@"merchant_name"]];
//    self.lbl_title.adjustsFontSizeToFitWidth = YES;
//    [self.lbl_subTitle setMinimumFontSize:10];
    self.lbl_subTitle.text = [data valueForKey:@"item_desc"];
//    self.lbl_subTitle.adjustsFontSizeToFitWidth = YES;
    self.lbl_minTitle1.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"iCoupon.fullList.bonusPoints", nil),[data valueForKey:@"required_point"]];
    if([data valueForKey:@"item_code"])
        self.lbl_minTitle2.text = [NSString stringWithFormat:@"%@: %@",NSLocalizedString(@"iCoupon.fullList.itemNo", nil),[data valueForKey:@"item_code"]];
    else{
        self.lbl_minTitle2.text = @"";
    }
}
@end
