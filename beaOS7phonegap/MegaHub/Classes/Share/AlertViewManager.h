//
//  AlertViewManager.h
//  AlertViewManager
//
//  Created by Hong on 28/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlertViewManager : NSObject <UIAlertViewDelegate> {
	
	id<UIAlertViewDelegate>		m_alertViewDelegate;
	
	NSMutableArray				*m_oStuckQueue;	// Storing UIAlertView;
	
}


+ (AlertViewManager *)sharedAlertViewManager;
+ (id)allocWithZone:(NSZone *)zone;
- (void)release;
- (id)autorelease;
- (NSUInteger)retainCount;
- (id)retain;
- (id)copyWithZone:(NSZone *)zone;

// UIAlertView Delegate Functions
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

// Private Functions
- (void)clearQueue;

// Public Functions
- (void)showAlertView:(UIAlertView *)aAlertView;


@end
