//
//  CalloutContentView.m
//  BEA
//
//  Created by Yilia on 15-1-4.
//  Copyright (c) 2015年 The Bank of East Asia, Limited. All rights reserved.
//

#import "CalloutContentView.h"
#import "CalloutMapContentViewController.h"

@implementation CalloutContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
//        self.accessibilityElements = [NSMutableArray array];
    }
    return self;
}

- (void)setContentVC:(CalloutMapContentViewController *)contentVC {
    for (UIView *subview in contentVC.viewContent.subviews) {
//        if ([subview class] == [UIButton class]) {
        
            if (!subview.hidden) {
                UIView *view;
                if (subview.tag == 200) {
                    view = [[UIButton alloc] initWithFrame:subview.frame];
                    if (subview.tag == 200) {
                        [(UIButton *)view addTarget:contentVC action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }else {
                    view = [[UILabel alloc] initWithFrame:subview.frame];
                }
                view.accessibilityLabel = subview.accessibilityLabel;
                view.accessibilityTraits = subview.accessibilityTraits;
                [self addSubview:view];
                view.backgroundColor = [UIColor clearColor];
            }
//        }
    }

}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isAccess) {
        return NO;
    }
    NSArray *subviews = self.subviews;
    for (UIView *subview in subviews)
    {
        if ([subview class] == [UILabel class] || [subview class] == [UIButton class])
        {
            if ([subview pointInside:[self convertPoint:point toView:subview] withEvent:event])
            {
                self.isAccess = NO;
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)isAccessibilityElement {
    self.isAccess = YES;
    return NO;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesBegan :%@",touches);
//    //    self.view addSubview:self.selectedAnnotationView
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesMoved :%@",touches);
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesCancelled :%@",touches);
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesEnded :%@",touches);
//}

//- (NSArray *)accessibleElements {
////    NSMutableArray *accessibilityArray = [NSMutableArray array];
//    if ( _accessibleElements != nil )
//    {
//        return _accessibleElements;
//    }
//    _accessibleElements = [[NSMutableArray alloc] init];
//
////    CalloutMapContentViewController *calloutVC = [[CalloutMapContentViewController alloc] initWithNibName:@"CalloutMapContentViewController" bundle:nil];
////    UIView *contentView = calloutVC.viewContent;
//    for (UIView *subview in self.subviews) {
//        if ([subview class] == [UILabel class] || [subview class] == [UIButton class]) {
//            UIAccessibilityElement *element = [[[UIAccessibilityElement alloc] initWithAccessibilityContainer:self] autorelease];
//            element.accessibilityLabel = subview.accessibilityLabel;
//            element.accessibilityFrame = subview.frame;
//            [self.accessibleElements addObject:element];
//        }
//    }
//    return self.accessibleElements;
//
//}
//
//- (BOOL)isAccessibilityElement
//{
//    return NO;
//}
//
///* The following methods are implementations of UIAccessibilityContainer protocol methods. */
//- (NSInteger)accessibilityElementCount
//{
////    NSLog(@"%@",self.accessibilityElements);
//    return [[self accessibleElements] count];
//    
//}
//
//- (id)accessibilityElementAtIndex:(NSInteger)index
//{
//    return [[self accessibleElements] objectAtIndex:index];
//}
//
//- (NSInteger)indexOfAccessibilityElement:(id)element
//{
//    return [[self accessibleElements] indexOfObject:element];
//}

@end
