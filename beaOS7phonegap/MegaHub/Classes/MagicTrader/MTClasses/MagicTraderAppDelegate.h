//
//  MagicTraderAppDelegate.h
//  MagicTrader
//
//  Created by Megahub on 25/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTConstant.h"

@interface MagicTraderAppDelegate : NSObject {
}

+ (MagicTraderAppDelegate *)sharedMagicTraderAppDelegate;
- (oneway void)release;
- (id)autorelease;
- (NSUInteger)retainCount;
- (id)retain;
- (id)copyWithZone:(NSZone *)zone;
+ (id)allocWithZone:(NSZone *)zone;
- (id)init;
- (void)dealloc;
- (NSString *)loadChartDisclaimerFileName;
- (NSString *)loadChartDisclaimer;
- (NSString *)loadGeneralDisclaimer;
- (NSString *)loadDetailStyleString;
- (void)countineDetailStyleString:(NSString *)aStyleString;
- (BOOL)loadIsDetailViewInSectorView;
- (BOOL)loadIsDetailViewInTopRankView;
- (NSString *)loadFlashColor;
- (NSDictionary *)loadSubmenuReorderSetting;

@end