//
//  NewBranchBannerUtil.h
//  BEA
//
//  Created by yaojzy on 10/24/11.
//  Copyright (c) 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewBranchBannerViewController.h"
#import "NewBranchCell.h"

@class NewBranchBannerViewController;
@class NewBranchCell;

@interface NewBranchBannerUtil : NSObject<ASIHTTPRequestDelegate>{
    NewBranchBannerViewController *_NewBranchBannerViewController;
    NSString* showing;
    NSString* exit;
	MaskViewController *mask;
}

@property(nonatomic, retain) NewBranchBannerViewController *_NewBranchBannerViewController;
@property(nonatomic, retain) NSString* showing;
@property(nonatomic, retain) NSString* exit;
@property (nonatomic, retain) MaskViewController *mask;

+ (NewBranchBannerUtil*) me;

+ (BOOL) FileExists;
+ (void) copyFile;
-(NSString *) findPlistPath;
- (NSString *)getDocATMplistPath;

-(NewBranchCell* )getTableViewCell:(id) obj;
+(void)tranferAnnotations:(NSArray *)annotationsDetail;
-(void)setExit;
+ (BOOL) newBranchFileExists;
-(void)requestPlist;
-(BOOL)needShow;
- (void)clearCount;
-(NSMutableArray*)selectItemsForShow:(NSMutableArray *)items_data;
-(NSMutableArray*)selectItemsForPopup:(NSMutableArray *)items_data;
-(void)showPopupPromotion:(NSMutableArray *)shown_data;

@end
