//
//  PlistOperator.h
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月8日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlistOperator : NSObject {

}
+(id)openPlistFile:(NSString *)filename Datatype:(NSString *)datatype;
+(void)savePlistFile:(NSString *)filename From:(id)data;
@end
