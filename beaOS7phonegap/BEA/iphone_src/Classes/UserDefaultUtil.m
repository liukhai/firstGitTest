//
//  userDefaultUtil.m
//  BEA
//
//  Created by Yilia on 14-10-23.
//  Copyright (c) 2014年 The Bank of East Asia, Limited. All rights reserved.
//

#import "UserDefaultUtil.h"

@implementation UserDefaultUtil

+ (void)writeToDocument {
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"UserDefault.plist"];
    
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    BOOL isExist = [defaultManager fileExistsAtPath:filename];
    if (!isExist) {
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"UserDefault" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSLog(@"UserDefault Bundle:%@", data);
        
        //输入写入
        [data writeToFile:filename atomically:YES];

    }
    
    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"UserDefault Document%@", data1);
}

+ (NSMutableDictionary *)readUserDefault {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserDefault.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    NSLog(@"UserDefault Document %@", data);//直接打印数据。
    return data;
}

+ (void)updateUserDefault:(NSMutableDictionary *)data {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"UserDefault.plist"];
    [data writeToFile:filename atomically:YES];
}

+ (void)updateNotInstalledAndFirstOpenApp {
    NSMutableDictionary *data = [self readUserDefault];
    [data setObject:@"YES" forKey:@"NotInstalledAndFirstOpenApp"];
    [self updateUserDefault:data];
}

//+ (void)updateNotification_onOroff:(BOOL)notification_onOroff {
//    NSMutableDictionary *data = [self readUserDefault];
//    [data setObject:notification_onOroff forKey:@"Notification_onOroff"];
//    [self updateUserDefault:data];
//}
@end
