//
//  MHFeedXUtil.h
//  MHFeedConnectorX
//
//  Created by MegaHub on 11/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHLanguage.h"


@interface MHFeedXUtil : NSObject {

}

+ (NSString*)getMD5:(NSString*)input ;
+ (NSString *)getSHA256:(NSString *)input;

//+ (NSString *)getCurrentTime ; // should be replaced by getCurrentTimeWithTimeout:timeout
//+ (NSString *)getCurrentTimeWithTimeout:(NSTimeInterval)timeout ;
//+ (NSString *)getCurrentTimeFrom1970 ;

+ (NSData *)hexStringToData:(NSString *) hexString ;
+ (NSString *)dataToHexString:(NSData *) data ;
+ (NSString *)tranlateMHLangaugeToXMLLang:(Language)aLangauge;

@end
