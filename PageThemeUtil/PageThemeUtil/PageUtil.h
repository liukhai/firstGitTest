//
//  PageUtil.h
//  BEA
//
//  Created by qwer on 15/3/24.
//  Copyright (c) 2015年 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Addition.h"

@interface PageUtil : NSObject

@property (nonatomic, retain) NSMutableArray *btnArray;

+(PageUtil *)pageUtil;
-(NSString *)getPageTheme;
- (void)setPageTheme:(NSString *)defaultname withView:(UIView *)view;
- (void)changeImageForTheme:(UIView *)view;
+ (NSString *)getDocConfigSettingFilePath;
@end
