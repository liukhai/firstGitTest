//
//  ViewControllerDirector.h
//  MegaHub
//
//  Created by Hong on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerDirectorParameter.h"

#define ViewControllerDirector_Notification				@"ViewControllerDirector_Notification"



@interface ViewControllerDirector : NSObject {

}

+ (ViewControllerDirector *)sharedViewControllerDirector;
- (void)release;
- (id)autorelease;
- (NSUInteger)retainCount;
- (id)retain;
- (id)copyWithZone:(NSZone *)zone;
+ (id)allocWithZone:(NSZone *)zone;

- (void)addObserver:(id)aObserver action:(SEL)aSelector;
- (void)removeObserver:(id)aObserver;

- (void)switchTo:(ViewControllerDirectorID)aID para:(ViewControllerDirectorParameter *)aPara;

@end


