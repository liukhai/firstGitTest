//  Created by jasen on 201303
//  Amended by jasen on 201309

#import "CustomAnnotationView.h"
#import "ATMMyAnnotation.h"
#import "MyAnnotation.h"
#import "CalloutMapContentViewController.h"
#import "CalloutMapAnnotation.h"

@interface CustomAnnotationView ()
@property (nonatomic, strong) UILabel *annotationLabel;
@property (nonatomic, strong) UIImageView *annotationImage;
@end

@implementation CustomAnnotationView

@synthesize contentVC;
@synthesize imgPin, imgPinClicked;
@synthesize btnPin, btnPinClicked;
@synthesize preventSelectionChange = _preventSelectionChange;


#define width_ContentView 300
#define height_ContenView 240

#define width_Pin 30
#define height_Pin 44

#define width_PinClicked 30
#define height_PinClicked 44

#define adjust_xy 10

// determine the MKAnnotationView based on the annotation info and reuseIdentifier
//
- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self != nil)
    {
        self.backgroundColor = [UIColor clearColor];
        isSelect = NO;
        CGRect frame;
        
        imgPinClicked = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapview_pin_clicked.png"]];
        imgPin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapview_pin.png"]];
        
        
        frame = imgPin.frame;
        //jasen's note: set pin_unclicked view to up and left of anno view;
        //        frame.origin.x = -1*(width_Pin/2) + imgPin.frame.size.width/2;
        //        frame.origin.y = -1*(height_Pin) + imgPin.frame.size.height/2;
        frame.size.width = width_Pin;
        frame.size.height = height_Pin;
        imgPin.frame = frame;
        
        contentVC = [[CalloutMapContentViewController alloc] initWithNibName:@"CalloutMapContentViewController" bundle:nil];
        CalloutMapAnnotation *mapItem = (CalloutMapAnnotation *)self.annotation;
        
        NSLog(@"debug CustomAnnotationView reuseIdentifier:%@", mapItem);
//        NSLog(@"debug CustomAnnotationView reuseIdentifier:%@", mapItem.fax);
        contentVC.strTitle = mapItem.title;
        if ([mapItem isKindOfClass:[ATMMyAnnotation class]]) {
            contentVC.strAddress = mapItem.address;
            contentVC.strService = mapItem.remark;
            contentVC.strTel = mapItem.tel;
            contentVC.strFax = mapItem.fax;
            [contentVC setText4ATM];
        } else if ([mapItem isKindOfClass:[MyAnnotation class]]) {
            [contentVC setText4CreditCard];
        }
        
        frame = contentVC.viewContent.frame;
        //        frame.origin.x = -1*width_PinClicked/2;
        frame.origin.x = 0;
        frame.origin.y = 0;
        //        frame.origin.y = imgPin.frame.size.height;
        //        frame.size.width = width_ContentView;
        //        frame.size.height = height_ContenView;
        contentVC.viewContent.frame = frame;
        
        frame = imgPinClicked.frame;
        //jasen's note: set pin_clicked view to up and left of anno view;
        frame.origin.x = contentVC.viewContent.frame.size.width/2 - width_PinClicked/2;
        frame.origin.y = -1*height_PinClicked;
        frame.size.width = width_PinClicked;
        frame.size.height = height_PinClicked;
        imgPinClicked.frame = frame;
        
        [self addSubview:imgPin];
        [self addSubview:imgPinClicked];
        [self addSubview:contentVC.viewContent];
//        [self bringSubviewToFront:contentVC.viewContent];
        [imgPin setHidden:NO];
        [imgPinClicked setHidden:YES];
        [contentVC.viewContent setHidden:YES];
        adjust_x = contentVC.viewContent.frame.size.width/2 - width_Pin/2;
        adjust_y = imgPinClicked.frame.size.height;
        
        NSLog(@"debug cusannoview init:%f--%f--%f--%f",
              self.frame.origin.x,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
        
        //        [self setSelected:NO];
        //        self.centerOffset = CGPointMake(0.0, 0.0);
        //        imgPin.frame = frame;
        
        //        btnPin = [[UIButton alloc] init];
        //        [btnPin setBackgroundImage:[UIImage imageNamed:@"btn_close.png"] forState:UIControlStateNormal];
        //        btnPin.backgroundColor = [UIColor clearColor];
        //        [btnPin addTarget:self action:@selector(doClose:) forControlEvents:UIControlEventTouchUpInside];
        //        frame = btnPin.frame;
        //        frame.origin.x = 0;
        //        frame.origin.y = 50;
        //        frame.size.width = 30;
        //        frame.size.height = 30;
        //        btnPin.frame = frame;
        
        //        [contentVC.btnClose addTarget:self action:@selector(doClose:) forControlEvents:UIControlEventTouchUpInside];
        //        [contentVC.btnTel addTarget:self action:@selector(doCall:) forControlEvents:UIControlEventTouchUpInside];
        
        //        [self addSubview:btnPin];
        
        //        [self addSubview:contentVC.view];
        
    }
    
    return self;
}

- (void)setAnnotation:(id <MKAnnotation>)annotation
{
    [super setAnnotation:annotation];

    // this annotation view has custom drawing code.  So when we reuse an annotation view
    // (through MapView's delegate "dequeueReusableAnnoationViewWithIdentifier" which returns non-nil)
    // we need to have it redraw the new annotation data.
    //
    // for any other custom annotation view which has just contains a simple image, this won't be needed
    //
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //    if (!self.preventSelectionChange) {
    //        [super setSelected:selected animated: animated];
    //    }
    isSelect = selected;
    if(selected)
    {
        self.preventSelectionChange = YES;
        
        //Add your custom view to self...
        [imgPin setHidden:YES];
        [imgPinClicked setHidden:NO];
        [contentVC.viewContent setHidden:NO];
        
        //jasen's note: move anno view to left with 1/2 content view, set anno view size with 1 content view for clickable at selected mode
        
        NSLog(@"debug cusannoview selected adjust before:%f--%f--%f--%f",
              self.frame.origin.x,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
        
        CGRect frame = self.frame;
        frame.size = contentVC.imgBG.frame.size;
        //        frame.size.height = 400;
        frame.origin.x -= adjust_x;
        frame.origin.y += adjust_y;
        self.frame = frame;
        
        //        [self setBackgroundColor:[UIColor redColor]];
        
        //        //jasen's note: move pin view to middle of anno view at selected mode
        //        frame = imgPinClicked.frame;
        //        frame.origin.x = (self.frame.size.width-frame.size.width)/2 + imgPin.frame.size.width/2;
        //        imgPinClicked.frame = frame;
        
        NSLog(@"debug cusannoview selected adjust after:%f--%f--%f--%f",
              self.frame.origin.x,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
        [self prepareOffset];
        if ([self.delegate respondsToSelector:@selector(moveContentView)]) {
            [self.delegate performSelector:@selector(moveContentView) withObject:nil];
        }
    }
    else
    {
        //Remove your custom view...
        [imgPin setHidden:NO];
        [imgPinClicked setHidden:YES];
        [contentVC.viewContent setHidden:YES];
        
        //jasen's note: move anno view back to right, set anno view size not too big at unselected mode
        NSLog(@"debug cusannoview unselected adjust before:%f--%f--%f--%f",
              self.frame.origin.x,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
        
        CGRect frame = self.frame;
        frame.size = imgPin.frame.size;
        frame.origin.x += adjust_x;
        frame.origin.y -= adjust_y;
        self.frame = frame;
        
        //        [self setBackgroundColor:[UIColor blueColor]];
        
        NSLog(@"debug cusannoview unselected adjust after:%f--%f--%f--%f",
              self.frame.origin.x,
              self.frame.origin.y,
              self.frame.size.width,
              self.frame.size.height);
       
    }
}

- (void)prepareOffset {
    self.centerOffset = CGPointMake(0, (imgPin.frame.size.height + contentVC.imgBG.frame.size.height) / 2);
}

-(BOOL)isAccessibilityElement {
//    return !isSelect;
    return NO;
}

@end
