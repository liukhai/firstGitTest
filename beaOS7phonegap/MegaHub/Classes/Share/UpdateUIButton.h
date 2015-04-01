//
//  UpdateUIButton.h
//  MagicTraderChief
//
//  Created by Megahub on 24/08/2010.
//  Copyright 2010 Megahub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UpdateUIButton : UIButton {
//	UIColor *updateColor;
//	UIView *uiButtonView;
}
//@property (retain, nonatomic) UIColor *updateColor;
//@property (retain, nonatomic) UIColor *uiButtonView;

//-(void)setUpdateColor:(UIColor *)color;
-(void)updateLabel:(NSString *)newLabel Color:(UIColor *)color duration:(double)second;
-(void)updateLabelEvenNoChange:(NSString *)newLabel Color:(UIColor *)color duration:(double)second;

@end
