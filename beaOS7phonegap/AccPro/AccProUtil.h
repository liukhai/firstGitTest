//
//  AccProUtil.h
//  BEA
//
//  Created by YAO JASEN on 10/20/10.
//  Copyright 2010 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData.h"
#import "AccProTNCViewController.h"
#import "AccProViewController.h"
#import "BasePromotion.h"
#import "AccProListViewController.h"

@class AccProViewController;
@class BasePromotion;
@class AccProListViewController;

@interface AccProUtil : NSObject <ASIHTTPRequestDelegate>{
    BasePromotion *_BasePromotion;
    AccProViewController *AccPro_view_controller;
    AccProListViewController *_AccProListViewController;
    NSString *strSend;
    NSString *requestSign;
    NSString *animate;
    NSString *inStockWatch;
}
@property (nonatomic, retain) AccProViewController *AccPro_view_controller;
@property (nonatomic, retain) BasePromotion *_BasePromotion;
@property (nonatomic, retain) AccProListViewController *_AccProListViewController;
@property (nonatomic, retain) NSString *strSend;
@property (nonatomic, retain) NSString *requestSign;
@property (nonatomic, retain) NSString *animate;
@property (nonatomic, retain) NSString *inStockWatch;

+ (AccProUtil*) me;
-(void)callToApply;
+ (BOOL) isValidUtil;
+ (BOOL) isLangOfChi;
-(NSString *) findPlistPath;

+ (BOOL) FileExists;
+ (void) copyFile;
+(void)showTNC;

-(void)showPopupPromotion;
-(NSString *) findPlistPaths;
+ (void) updateFundPriceFile:(NSData*)datas;
-(void) sendRequest:(NSString*) date_stamp
 listViewController:(AccProListViewController*)p_AccProListViewController;
-(BOOL) isSend;
-(void)updateBasePromotionPlist;
-(BOOL)needShow;
-(NSString *) findBannerPlistPaths;
-(void)updateBannerPlistAndResetCount:(NSData*)datas;
-(void)sendRequestToGetBannerPlist;

//-(void)setLatestPromoInStockWatch:(UIView*)stockWatchView frame:(CGRect)frame;

@end
