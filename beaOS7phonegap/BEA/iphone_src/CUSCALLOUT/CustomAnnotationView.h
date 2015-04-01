//  Created by jasen on 201303

#import <MapKit/MapKit.h>
#import "CalloutMapContentViewController.h"

@interface CustomAnnotationView : MKAnnotationView
<UIGestureRecognizerDelegate>
{
    CalloutMapContentViewController* contentVC;
    UIImageView *imgPin, *imgPinClicked;
    UIButton *btnPin, *btnPinClicked;
    BOOL _preventSelectionChange;
    float adjust_x, adjust_y;
    BOOL isSelect;
}

@property(nonatomic, retain) CalloutMapContentViewController* contentVC;
@property(nonatomic, retain) UIImageView *imgPin, *imgPinClicked;
@property(nonatomic, retain) UIButton *btnPin, *btnPinClicked;
@property (nonatomic) BOOL preventSelectionChange;
@property (nonatomic, assign) id delegate;


@end