//
//  MHKeyboard.m
//  MHNumberKeyboard
//
//  Created by MegaHub on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MHKeyboard.h"
#import "MHLanguage.h"

#define MHNUMBERKEYBOARD_IMAGE_PRESSED              [UIImage imageNamed:@"button_pressed.png"]
#define MHNUMBERKEYBOARD_IMAGE_UNPRESS              [UIImage imageNamed:@"button_unpress.png"]

#define MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR          [UIImage imageNamed:@"button_pressed_hor.png"]
#define MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR          [UIImage imageNamed:@"button_unpress_hor.png"]


#define MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS		[UIColor whiteColor]
#define MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED		[UIColor darkGrayColor]

#define MHLanguage_MHKeyboard                       @"MHKeyboard"

#define BUTTON_FONT_SIZE		30

@implementation MHKeyboard

@synthesize delegate;
@synthesize m_oTextField;
@synthesize m_sTextFieldText;

@synthesize m_oEnterButton;
@synthesize m_oDeleteButton;
@synthesize m_oDecimalButton;
@synthesize m_oClearButton;

@synthesize sett_layout;
@synthesize sett_supportHorizontal;
@synthesize sett_showComma;
@synthesize sett_decimalPlace;
@synthesize sett_zeroCount;

+ (MHKeyboard *)keyboard:(UITextField *)textField layout:(MHKeyboardLayout)aLayout {
    MHKeyboard *key = [[[MHKeyboard alloc] initWithFrame:CGRectMake(0, 0, 320, 240)] autorelease];
    key.sett_layout = aLayout;        
    key.delegate = textField.delegate;
    textField.delegate = key;
    key.m_oTextField = textField;
    key.m_sTextFieldText = [NSMutableString stringWithString:(textField.text)?textField.text:@""];
    key.sett_showComma = YES;
    key.sett_decimalPlace = 3;
    key.sett_zeroCount = 3;
    return key;
}


+ (MHKeyboard *)keyboard:(UITextField *)textField {
    return [MHKeyboard keyboard:textField layout:MHKeyboardLayoutDefault];
}

- (void)setSett_zeroCount:(short)aSett_zeroCount {
    sett_zeroCount = aSett_zeroCount;
    NSMutableString *zeroString = [NSMutableString string];
    for (int i=0; i<sett_zeroCount; i++) {
        [zeroString appendString:@"0"];
    }
    [m_o00Button setTitle:zeroString forState:UIControlStateNormal];  
    m_o00Button.hidden = (sett_zeroCount == 0 || sett_layout == MHKeyboardLayoutAppleNumberPad);
}

- (void)setSett_decimalPlace:(short)aSett_decimalPlace {
    sett_decimalPlace = aSett_decimalPlace;
    m_oDecimalButton.hidden = (sett_decimalPlace == 0);
}

- (void)setSett_layout:(MHKeyboardLayout)aSett_layout {
    sett_layout = aSett_layout;
    [self changeLayout:sett_layout];
}

- (void)setSett_supportHorizontal:(BOOL)aSett_supportHorizontal {
    sett_supportHorizontal = aSett_supportHorizontal;
    [self changeLayout:sett_layout];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.m_sTextFieldText = [NSMutableString string];
        sett_supportHorizontal = YES;
        
        CGFloat x=0, y = 0, h=60, w=80;
		NSInteger number=1;
		
		m_o1Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o1Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o1Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];        
		[m_o1Button setFrame:CGRectMake(x,y,w,h)];
		[m_o1Button setTag:number];
		[m_o1Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o1Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o1Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o1Button];	
		
		number++;
		x += w;
		m_o2Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o2Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o2Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o2Button setFrame:CGRectMake(x,y,w,h)];
		[m_o2Button setTag:number];
		[m_o2Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o2Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o2Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o2Button];	
		
		number++;
		x += w;
		m_o3Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];	
        [m_o3Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o3Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                        
		[m_o3Button setFrame:CGRectMake(x,y,w,h)];
		[m_o3Button setTag:number];
		[m_o3Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o3Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o3Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o3Button];	
		
		number++;
		x = 0;	y += h;
		m_o4Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o4Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o4Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o4Button setFrame:CGRectMake(x,y,w,h)];
		[m_o4Button setTag:number];
		[m_o4Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o4Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o4Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o4Button];
		
		number++;
		x += w;
		m_o5Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o5Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o5Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o5Button setFrame:CGRectMake(x,y,w,h)];
		[m_o5Button setTag:number];
		[m_o5Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o5Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o5Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o5Button];	
		
		number++;
		x += w;
		m_o6Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o6Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o6Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o6Button setFrame:CGRectMake(x,y,w,h)];
		[m_o6Button setTag:number];
		[m_o6Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o6Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o6Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o6Button];
		
		number++;
		x = 0;	y += h;
		m_o7Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o7Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o7Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o7Button setFrame:CGRectMake(x,y,w,h)];
		[m_o7Button setTag:number];
		[m_o7Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o7Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o7Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o7Button];
		
		number++;
		x += w;
		m_o8Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o8Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o8Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o8Button setFrame:CGRectMake(x,y,w,h)];
		[m_o8Button setTag:number];
		[m_o8Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o8Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o8Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o8Button];
		
		number++;
		x += w;
		m_o9Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
        [m_o9Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_UNPRESS forState:UIControlStateNormal];
        [m_o9Button setTitleColor:MHNUMBERKEYBOARD_TITLE_COLOR_PRESSED forState:UIControlStateHighlighted];                
		[m_o9Button setFrame:CGRectMake(x,y,w,h)];
		[m_o9Button setTag:number];
		[m_o9Button setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];
		[m_o9Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o9Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o9Button];
		
		x = 0;	y += h;
		// decimal button background
		m_oDecimalBG = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
		[m_oDecimalBG setImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS];
		[self addSubview:m_oDecimalBG];
		
		m_oDecimalButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oDecimalButton setFrame:CGRectMake(x,y,w,h)];
		[m_oDecimalButton setTag:10];
		[m_oDecimalButton setTitle:@"." forState:UIControlStateNormal];
		[m_oDecimalButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_oDecimalButton.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_oDecimalButton];
		
		x += w;
		m_o0Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o0Button setFrame:CGRectMake(x,y,w,h)];
		[m_o0Button setTag:11];
		[m_o0Button setTitle:[NSString stringWithFormat:@"%d",0] forState:UIControlStateNormal];
		[m_o0Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o0Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o0Button];
		
		
		x += w;
		// 000 button background
		m_o00ButtonBG = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,w,h)];
		[m_o00ButtonBG setImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS];
		[self addSubview:m_o00ButtonBG];
		
		NSMutableString *zeroString = [[[NSMutableString alloc] init] autorelease];
		for (int i=0; i<sett_zeroCount; i++) {
			[zeroString appendString:@"0"];
		}
		m_o00Button = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		[m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_o00Button setFrame:CGRectMake(x,y,w,h)];
		[m_o00Button setTag:12];
		[m_o00Button setTitle:zeroString forState:UIControlStateNormal];
        [m_o00Button.titleLabel setAdjustsFontSizeToFitWidth:YES];
		[m_o00Button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_o00Button.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];
		[self addSubview:m_o00Button];
		
		
		m_oDeleteButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_delete.png"] forState:UIControlStateNormal];
		//		[m_oDeleteButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		//		[m_oDeleteButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oDeleteButton setTag:13];
		[m_oDeleteButton setFrame:CGRectMake(240,0,w,h)];
		//		[m_oDeleteButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oDeleteButton", nil) forState:UIControlStateNormal];
		[m_oDeleteButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_oDeleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];                        
		[self addSubview:m_oDeleteButton];
		
		
		m_oEnterButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_oEnterButton setBackgroundImage:[UIImage imageNamed:@"button_enter.png"] forState:UIControlStateNormal];
		//		[m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		//		[m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oEnterButton setTag:14];
		[m_oEnterButton setFrame:CGRectMake(240,120,w,h*2)];
		//		[m_oEnterButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oEnterButton", nil) forState:UIControlStateNormal];
		[m_oEnterButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_oEnterButton.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];        
		[self addSubview:m_oEnterButton];
		
		m_oClearButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		[m_oClearButton setBackgroundImage:[UIImage imageNamed:@"button_clear.png"] forState:UIControlStateNormal];
		//		[m_oClearButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
		//		[m_oClearButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
		[m_oClearButton setTag:15];
		[m_oClearButton setFrame:CGRectMake(3*w,1*h,w,h)];
		//		[m_oClearButton setTitle:NSLocalizedString(@"MHNumberKeyboard.m_oClearButton", nil) forState:UIControlStateNormal];
		[m_oClearButton addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		m_oClearButton.titleLabel.font = [UIFont boldSystemFontOfSize:BUTTON_FONT_SIZE];                
		[self addSubview:m_oClearButton];
        
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRotate:)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
        
    }
    return self;
}

- (void)dealloc {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter 	defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    delegate = nil;
    m_oTextField = nil;
    
    [m_oEnterButton release];	
    [m_oDeleteButton release];
    [m_oDecimalButton release];
    [m_oClearButton release];
    [m_o0Button release];
    [m_o00Button release];
    [m_o1Button release];
    [m_o2Button release];
    [m_o3Button release];
    [m_o4Button release];
    [m_o5Button release];
    [m_o6Button release];
    [m_o7Button release];
    [m_o8Button release];
    [m_o9Button release];
    [m_oDecimalBG release];
    [m_o00ButtonBG release];    
    
    [m_sTextFieldText release];
    
    [super dealloc];
}

- (void)reloadText {
    switch (sett_layout) {
        case MHKeyboardLayoutDefault:
            break;
        case MHKeyboardLayoutAppleNumberPad:    
            [m_oEnterButton setTitle:MHLocalizedStringFile(@"AppleNumberPad.enter", nil, MHLanguage_MHKeyboard) forState:UIControlStateNormal];
            break;
    }
}

-(void)didRotate:(NSNotification *)notification {	
	[self changeLayout:sett_layout];
}

- (void)changeLayout:(MHKeyboardLayout)aLayout {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];    
    if ( sett_supportHorizontal && (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationFaceDown || orientation == UIDeviceOrientationFaceUp)) {
        UIInterfaceOrientation interfaceo = UIDeviceOrientationPortrait;
        if ([delegate isKindOfClass:[UIViewController class]]) {
            interfaceo = [(UIViewController *)delegate interfaceOrientation];
        } else {
            interfaceo = [UIApplication sharedApplication].statusBarOrientation;
        }
        switch (interfaceo) {
            case UIInterfaceOrientationPortrait:            orientation = UIDeviceOrientationPortrait;              break;
            case UIInterfaceOrientationPortraitUpsideDown:  orientation = UIDeviceOrientationPortraitUpsideDown;    break;
            case UIInterfaceOrientationLandscapeLeft:       orientation = UIDeviceOrientationLandscapeRight;        break;
            case UIInterfaceOrientationLandscapeRight:      orientation = UIDeviceOrientationLandscapeLeft;         break;
        }

    }
    
    switch (aLayout) {
        case MHKeyboardLayoutAppleNumberPad:    
            [m_oEnterButton setTitle:MHLocalizedStringFile(@"AppleNumberPad.enter", nil, MHLanguage_MHKeyboard) forState:UIControlStateNormal];            
            [m_oEnterButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [m_oEnterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];            
            [m_oClearButton setHidden:YES];
            [m_o00ButtonBG setHidden:YES];
            [m_o00Button setHidden:YES];
            [m_oDecimalBG setHidden:YES];
            [m_oDecimalButton setHidden:YES];
            
            if (sett_supportHorizontal &&
                (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)) {
                
                CGFloat horizontalWidth = [[UIScreen mainScreen] bounds].size.height;
                
                if (horizontalWidth == 480) {
                    [m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_del_horizontal_unpress.png"] forState:UIControlStateNormal];
                    [m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_del_horizontal_pressed.png"] forState:UIControlStateHighlighted];
                } else {
                    [m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_del_horizontal_unpress-568h.png"] forState:UIControlStateNormal];
                    [m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_del_horizontal_pressed-568h.png"] forState:UIControlStateHighlighted];
                }
                
                [m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateNormal];
                [m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateHighlighted];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                
                CGRect screen_frame = [[UIScreen mainScreen] bounds];
                self.frame = CGRectMake(0, 0, MAX(screen_frame.size.height, screen_frame.size.width), 160);
                CGFloat x=0, y = 0, h=40, w=MAX(screen_frame.size.height, screen_frame.size.width)/3.0;
                [m_o1Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o2Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o3Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o4Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o5Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o6Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o7Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o8Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o9Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                
                [m_oEnterButton setFrame:CGRectMake(x,y,w,h)];          x += w;
                [m_o0Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_oDeleteButton setFrame:CGRectMake(x,y,w,h)];		
                	
            } else {
                [m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_del_vertical_unpress.png"] forState:UIControlStateNormal];
                [m_oDeleteButton setBackgroundImage:[UIImage imageNamed:@"button_del_vertical_pressed.png"] forState:UIControlStateHighlighted];
                [m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateNormal];
                [m_oEnterButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateHighlighted];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                
                CGRect screen_frame = [[UIScreen mainScreen] bounds];                
                self.frame = CGRectMake(0, 0, screen_frame.size.width, 240);
                CGFloat x=0, y = 0, h=60, w=screen_frame.size.width/3.0;
                [m_o1Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o2Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o3Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o4Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o5Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o6Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o7Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o8Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o9Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                
                [m_oEnterButton setFrame:CGRectMake(x,y,w,h)];          x += w;
                [m_o0Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_oDeleteButton setFrame:CGRectMake(x,y,w,h)];		
            } 
            break;
        default:            
        case MHKeyboardLayoutDefault:
            if (sett_supportHorizontal &&
                (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)) {

                [m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS_HOR forState:UIControlStateNormal];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED_HOR forState:UIControlStateHighlighted];
                
                CGRect screen_frame = [[UIScreen mainScreen] bounds];                
                self.frame = CGRectMake(0, 0, screen_frame.size.height, 160);
                CGFloat x=0, y = 0, h=40, w=screen_frame.size.height/4.0;
                [m_o1Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o2Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o3Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o4Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o5Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o6Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o7Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o8Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o9Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_oDecimalBG setFrame:CGRectMake(x,y,w,h)]; 
                [m_oDecimalButton setFrame:CGRectMake(x,y,w,h)];		x += w;
                [m_o0Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o00ButtonBG setFrame:CGRectMake(x,y,w,h)];        
                [m_o00Button setFrame:CGRectMake(x,y,w,h)];             x += w;
                [m_oDeleteButton setFrame:CGRectMake(3*w,0,w,h)];		x += w;
                [m_oEnterButton setFrame:CGRectMake(3*w,2*h,w,h*2)];	x += w;
                [m_oClearButton setFrame:CGRectMake(3*w,1*h,w,h)];		x += w;
                
            } else {
                [m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_oDecimalButton setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o00Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o0Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o1Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o2Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o3Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o4Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o5Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o6Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o7Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o8Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_UNPRESS forState:UIControlStateNormal];
                [m_o9Button setBackgroundImage:MHNUMBERKEYBOARD_IMAGE_PRESSED forState:UIControlStateHighlighted];
                
                CGRect screen_frame = [[UIScreen mainScreen] bounds];                
                self.frame = CGRectMake(0, 0, screen_frame.size.width, 240);
                CGFloat x=0, y = 0, h=60, w=screen_frame.size.width/4.0;
                [m_o1Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o2Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o3Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o4Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o5Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o6Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_o7Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o8Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o9Button setFrame:CGRectMake(x,y,w,h)];              x = 0;      y += h;
                [m_oDecimalBG setFrame:CGRectMake(x,y,w,h)];
                [m_oDecimalButton setFrame:CGRectMake(x,y,w,h)];		x += w;
                [m_o0Button setFrame:CGRectMake(x,y,w,h)];              x += w;
                [m_o00ButtonBG setFrame:CGRectMake(x,y,w,h)];
                [m_o00Button setFrame:CGRectMake(x,y,w,h)];             x += w;
                [m_oDeleteButton setFrame:CGRectMake(240,0,w,h)];		x += w;
                [m_oEnterButton setFrame:CGRectMake(240,120,w,h*2)];	x += w;
                [m_oClearButton setFrame:CGRectMake(3*w,1*h,w,h)];		x += w;
            } 
            break;
    }
}

#pragma mark -
- (void)dismiss {
    if (m_oTextField) {
        [m_oTextField resignFirstResponder];
    }    
}

- (void)enter {
    [self textFieldShouldReturn:m_oTextField];
    if (m_oTextField) {
        [m_oTextField resignFirstResponder];
    }    
}

- (void)appendText:(NSString *)aText {
    if ([m_oTextField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
		NSRange range;
		range.location = (m_sTextFieldText)?[m_sTextFieldText length]:0;
		range.length = 0; //[aText length];
		
		if ([m_oTextField.delegate textField:m_oTextField shouldChangeCharactersInRange:range replacementString:aText] == NO){
			return;
		}
	}
    
    NSRange decimalRange;
    BOOL haveDecimal = NO;
    short decimalPlace = 0;    
    if (m_oTextField.text) {
        decimalRange = [m_oTextField.text rangeOfString:@"."];
        haveDecimal = (decimalRange.location != NSNotFound);
        decimalPlace = (haveDecimal)?m_oTextField.text.length - decimalRange.location:0;
    }
    
    
    @synchronized(m_oTextField.text) {
		if (haveDecimal && [aText caseInsensitiveCompare:@"."] == NSOrderedSame) {
			// not allow two decimal
			return;
		}
        // don't allow input 
		if (haveDecimal && decimalPlace > sett_decimalPlace) {
            return;
		}
        
		[m_sTextFieldText appendString:aText];
		
		NSString *string=m_sTextFieldText? m_sTextFieldText:@"";
		if (sett_showComma) {
			string = [MHKeyboard formatDecimalString:string decPlace:MIN(decimalPlace, sett_decimalPlace)];
		} 			
		m_oTextField.text = [NSString stringWithFormat:@"%@", string];
    }
}

- (void)deleteACharacter {
    if ([m_sTextFieldText length] <= 0) { return; }
	
    if ([m_oTextField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        NSRange range;
        range.location = (m_sTextFieldText)?[m_sTextFieldText length]:0;
        range.length = 1;
        
        if ([m_oTextField.delegate textField:m_oTextField shouldChangeCharactersInRange:range replacementString:@""] == NO){
            return;
        }
    }
    
    NSRange decimalRange;
    BOOL haveDecimal = NO;
    short decimalPlace = 0;    
    
	@synchronized(m_sTextFieldText) {		
        [m_sTextFieldText deleteCharactersInRange:NSMakeRange(m_sTextFieldText.length-1, 1)];
        
        if (m_sTextFieldText) {
            decimalRange = [m_sTextFieldText rangeOfString:@"."];
            haveDecimal = (decimalRange.location != NSNotFound);
            decimalPlace = haveDecimal?m_sTextFieldText.length - decimalRange.location-1 :0;
        }
        
		NSString *string=m_sTextFieldText? m_sTextFieldText:@"";
		if (sett_showComma ) {
			string = [MHKeyboard formatDecimalString:string decPlace:MIN(decimalPlace, sett_decimalPlace)];
        }
        
		m_oTextField.text = string;
	}
}

- (void)clearTextField {
    [m_sTextFieldText deleteCharactersInRange:NSMakeRange(0, m_sTextFieldText.length)];
    m_oTextField.text = @"";
}

- (NSString *)removeComma:(NSString *)aStringWithComma {
	if (aStringWithComma == nil || [aStringWithComma length] <=0 ) {
		return @"";
	}
	
	return [aStringWithComma stringByReplacingOccurrencesOfString:@"," withString:@""];
}

+ (NSString *)formatDecimalString:(NSString *)input decPlace:(NSInteger) aDecPlace {
	
	if (input == nil || [input length] <= 0) {
		return @"";
	}
	
	static NSNumberFormatter *formatter;
	
	if (formatter == nil) {
		formatter = [[NSNumberFormatter alloc] init];
	}
	
	NSLocale *locale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
	[formatter setLocale:locale];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:aDecPlace];
	[formatter setMinimumFractionDigits:aDecPlace];
	[formatter setMinimumIntegerDigits:1];
	
	NSDecimalNumber *decNum = [NSDecimalNumber decimalNumberWithString:input];
	NSString *string = [formatter stringFromNumber:decNum];
	
    
    char lastChar = [input characterAtIndex:input.length-1];
    if (lastChar == '.') {
        return [NSString stringWithFormat:@"%@.", string];
    }
	
	return string;
}

#pragma mark - Button call back functions
- (void)onButtonPressed:(UIButton *)sender {
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:@"4.2" options:NSNumericSearch] == NSOrderedAscending) {
        [[UIDevice currentDevice] playInputClick];
    }
	switch (sender.tag) {
		case 1:{		[self appendText:@"1"];		break; }
		case 2:{		[self appendText:@"2"];		break; }
		case 3:{		[self appendText:@"3"];		break; }
		case 4:{		[self appendText:@"4"];		break; }
		case 5:{		[self appendText:@"5"];		break; }
		case 6:{		[self appendText:@"6"];		break; }
		case 7:{		[self appendText:@"7"];		break; }
		case 8:{		[self appendText:@"8"];		break; }
		case 9:{		[self appendText:@"9"];		break; }
		case 10:{		[self appendText:@"."];		break; }
		case 11:{		[self appendText:@"0"];		break; }
		case 12:{		
			NSMutableString *zeroString = [[[NSMutableString alloc] init] autorelease];
			for (int i=0; i<sett_zeroCount; i++) {
				[zeroString appendString:@"0"];
			}
			[self appendText:zeroString];		
			break; 
		}
		case 13:{		[self deleteACharacter];	break; }
		case 14:{		[self enter];               break; }
		case 15:{		[self clearTextField];      break; }
		default: break;
	}
}


#pragma mark - TextField Delegate Functions
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self reloadText];
    if (textField.clearsOnBeginEditing) {
        [self clearTextField];
    }
    self.m_sTextFieldText = [NSMutableString stringWithString:(sett_showComma)?[self removeComma:m_oTextField.text]:m_oTextField.text];
    
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
	}
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidEndEditing:textField];
	}
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
	}
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
	}
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
	}
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
	}
    return YES;
}

#pragma mark - UIInputViewAudioFeedback
- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

@end
