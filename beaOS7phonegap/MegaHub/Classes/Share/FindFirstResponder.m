// 
//  FindFirstResponder.m
//  AyersGTS
//
//  Created by ChiYin on 05/01/2010.
//  Copyright 2010 Ayers GTS. All rights reserved.
//

#import "FindFirstResponder.h"


@implementation UIView (FindAndResignFirstResponder)

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;     
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}

@end
