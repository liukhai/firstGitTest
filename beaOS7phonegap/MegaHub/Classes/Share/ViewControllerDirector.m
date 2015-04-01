//
//  ViewControllerDirector.m
//  MegaHub
//
//  Created by Hong on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerDirector.h"


@implementation ViewControllerDirector


static ViewControllerDirector *sharedViewControllerDirector = nil;

+ (ViewControllerDirector *)sharedViewControllerDirector {
	@synchronized(self) {
		if (sharedViewControllerDirector == nil) {
			sharedViewControllerDirector	= [[self alloc] init];			
			
		}
	}
	
	return sharedViewControllerDirector;
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

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedViewControllerDirector == nil) {
			sharedViewControllerDirector = [super allocWithZone:zone];
			return sharedViewControllerDirector;
		}
	}
	
	return nil;
}

#pragma mark -
- (void)addObserver:(id)aObserver action:(SEL)aSelector {
	[[NSNotificationCenter defaultCenter] addObserver:aObserver selector:aSelector name:ViewControllerDirector_Notification object:nil];
}

- (void)removeObserver:(id)aObserver {
	[[NSNotificationCenter defaultCenter] removeObserver:aObserver name:ViewControllerDirector_Notification object:nil];
}

- (void)switchTo:(ViewControllerDirectorID)aID para:(ViewControllerDirectorParameter *)aPara {
	if (aPara == nil) {
		aPara = [[[ViewControllerDirectorParameter alloc] init] autorelease];
	}
	aPara.m_iViewControllerID = aID;
	[[NSNotificationCenter defaultCenter] postNotificationName:ViewControllerDirector_Notification object:aPara];
}


@end




