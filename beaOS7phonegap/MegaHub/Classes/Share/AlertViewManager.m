//
//  AlertViewManager.m
//  AlertViewManager
//
//  Created by Hong on 28/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertViewManager.h"



@implementation AlertViewManager

static AlertViewManager *sharedAlertViewManager = nil;

+ (AlertViewManager *)sharedAlertViewManager {
	@synchronized(self) {
		if (sharedAlertViewManager == nil) {
			sharedAlertViewManager = [[self alloc] init];
		}
	}

	return sharedAlertViewManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedAlertViewManager == nil) {
			sharedAlertViewManager = [super allocWithZone:zone];
			return sharedAlertViewManager;
		}
	}

	return nil;
}

- (id) init {
	self = [super init];
	if (self != nil) {
		m_oStuckQueue = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void)release {
	
}

- (id)autorelease { 
	return self;
}

- (NSUInteger)retainCount {
	return NSUIntegerMax;
}
- (id)retain {
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

#pragma mark -
#pragma mark UIAlertView Delegate Functions
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if ([m_alertViewDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
		[m_alertViewDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
	}
	
	if ([m_oStuckQueue count] >0 ) {
		[m_oStuckQueue removeObjectAtIndex:0];
	}
	[self clearQueue];

}

#pragma mark -
#pragma mark Private Functions
- (void)clearQueue {
	UIAlertView *alertView = nil;
	if ([m_oStuckQueue count] > 0) {
		alertView = [m_oStuckQueue objectAtIndex:0];
		if ([alertView isKindOfClass:[UIAlertView class]]) {
			m_alertViewDelegate = alertView.delegate;
			[alertView setDelegate:self];
			[alertView show];

		}
	}	
}
#pragma mark -
#pragma mark Public Functions
- (void)showAlertView:(UIAlertView *)aAlertView {

	UIAlertView *alertView = nil;
	
	if ([m_oStuckQueue count] > 0) {
		alertView = [m_oStuckQueue objectAtIndex:0];
		if (alertView.visible == NO) { // has been dimissed
			[m_oStuckQueue removeObjectAtIndex:0];
		}
	}	
	[m_oStuckQueue addObject:aAlertView];
	if ([m_oStuckQueue count] ==1) {
		[self clearQueue];
	}

}

@end
