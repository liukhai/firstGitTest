//
//  MenuProtocol.h
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月20日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuDelegate
-(void)menuItemPressed:(int)tag;
@optional
-(void)openListWithType:(NSString *)list_type Category:(NSString *)category;
@end