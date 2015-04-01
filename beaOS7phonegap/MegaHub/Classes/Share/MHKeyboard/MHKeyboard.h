//
//  MHKeyboard.h
//  MHNumberKeyboard
//
//  Created by MegaHub on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 version: 20121114
    - handle iphone 5 screen	
 
 version: 20121108
    - Handled rotation problem
    - Added String file
 
 version: 20121106
    - init version
 */

#import <UIKit/UIKit.h>

typedef enum {
//    MHKeyboardLayoutNormal = 0,
    MHKeyboardLayoutDefault = 0,
//    MHKeyboardLayoutDefaultApple = 1,
    MHKeyboardLayoutAppleNumberPad = 1
} MHKeyboardLayout;


@interface MHKeyboard : UIView <UITextFieldDelegate, UIInputViewAudioFeedback> {
    id<UITextFieldDelegate>     delegate;
    UIButton			*m_oEnterButton;	
	UIButton			*m_oDeleteButton;
	UIButton			*m_oDecimalButton;
	UIButton			*m_oClearButton;
	
	UIButton			*m_o0Button;
	UIButton			*m_o00Button;
	UIButton			*m_o1Button;
	UIButton			*m_o2Button;
	UIButton			*m_o3Button;
	UIButton			*m_o4Button;
	UIButton			*m_o5Button;
	UIButton			*m_o6Button;
	UIButton			*m_o7Button;
	UIButton			*m_o8Button;
	UIButton			*m_o9Button;
    
    UIImageView         *m_oDecimalBG;
    UIImageView         *m_o00ButtonBG;    
    
    UITextField         *m_oTextField;
    NSMutableString     *m_sTextFieldText;
    
    MHKeyboardLayout    sett_layout;
    BOOL                sett_supportHorizontal;
    BOOL                sett_showComma;
    short               sett_decimalPlace;
    short               sett_zeroCount;    
}
@property(atomic, assign) id<UITextFieldDelegate>   delegate;
@property(atomic, assign) UITextField *m_oTextField;
@property(atomic, retain) NSMutableString *m_sTextFieldText;

@property(atomic, retain) UIButton *m_oEnterButton;
@property(atomic, retain) UIButton *m_oDeleteButton;
@property(atomic, retain) UIButton *m_oDecimalButton;
@property(atomic, retain) UIButton *m_oClearButton;


@property(nonatomic, assign) MHKeyboardLayout sett_layout;
@property(nonatomic, assign) BOOL sett_supportHorizontal;
@property(nonatomic, assign) BOOL sett_showComma;
@property(nonatomic, assign) short sett_decimalPlace;
@property(nonatomic, assign) short sett_zeroCount;

+ (MHKeyboard *)keyboard:(UITextField *)textField layout:(MHKeyboardLayout)aLayout ;
+ (MHKeyboard *)keyboard:(UITextField *)textField ;

- (void)reloadText ;


@end
