//
//  PlistOperator.m
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月8日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlistOperator.h"


@implementation PlistOperator

+(id)openPlistFile:(NSString *)filename Datatype:(NSString *)datatype {
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/%@.plist",path,filename];
    NSLog(@"debug PlistOperator openPlistFile:%@", path);
	id data;
	if ([datatype isEqualToString:@"NSArray"]) {
		data = [NSArray arrayWithContentsOfFile:path];
		if (data==nil || [data count]==0) {
			path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
			data = [NSArray arrayWithContentsOfFile:path];
		}
	} else if ([datatype isEqualToString:@"NSDictionary"]) {
		data = [NSDictionary dictionaryWithContentsOfFile:path];
		if (data==nil || [data count]==0) {
			path = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
			data = [NSDictionary dictionaryWithContentsOfFile:path];
		}
	}
	return data;
}

+(void)savePlistFile:(NSString *)filename From:(id)data {
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	NSString *last_update = [NSString stringWithFormat:@"%@/%@_last_update.plist",path,filename];
	path = [NSString stringWithFormat:@"%@/%@.plist",path,filename];
	[data writeToFile:path atomically:TRUE];
	NSMutableDictionary *update = [NSMutableDictionary new];
	[update setValue:[NSDate date] forKey:@"last_update"];
	NSLog(@"debug write to %@",last_update);
	[update writeToFile:last_update atomically:TRUE];
	
}

@end
