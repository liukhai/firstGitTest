//
//  UIButton+Addition.m
//  LoanApproval
//
//  Created by admin on 14-8-9.
//  Copyright (c) 2014年 FormsSyntron. All rights reserved.
//

#import "UIView+Addition.h"
#import <objc/runtime.h>

@implementation UIView (Addition)
static void * orangeImageNameDictKey = &orangeImageNameDictKey;

- (NSString *)orangeImageName {
    
    return objc_getAssociatedObject(self, orangeImageNameDictKey);
    
}

- (void)setOrangeImageName:(NSString *)orangeImageName {
    
    objc_setAssociatedObject(self, orangeImageNameDictKey, orangeImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void * redImageNameDictKey = &redImageNameDictKey;
- (NSString *)redImageName {
    return objc_getAssociatedObject(self, redImageNameDictKey);
}

- (void)setRedImageName:(NSString *)redImageName {
    objc_setAssociatedObject(self, redImageNameDictKey, redImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
