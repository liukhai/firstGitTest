//
//  CalloutContentView.h
//  BEA
//
//  Created by Yilia on 15-1-4.
//  Copyright (c) 2015年 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalloutMapContentViewController.h"

@interface CalloutContentView : UIView

@property (nonatomic, retain) NSMutableArray *accessibleElements;
@property (nonatomic, retain) CalloutMapContentViewController *contentVC;
@property (nonatomic, assign) BOOL isAccess;

@end
