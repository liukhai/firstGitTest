//
//  userDefaultUtil.h
//  BEA
//
//  Created by Yilia on 14-10-23.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultUtil : NSObject

+ (void)writeToDocument;
+ (NSMutableDictionary *)readUserDefault;
//+ (void)updateUserDefault:(NSMutableDictionary *)data;
+ (void)updateNotInstalledAndFirstOpenApp;
//+ (void)updateNotification_onOroff:(BOOL)notification_onOroff;



@end
