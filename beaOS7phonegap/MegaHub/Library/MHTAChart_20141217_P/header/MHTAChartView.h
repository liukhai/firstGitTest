//
//  MegaHubChartView.h
//  MegaHubUtility
//
//  Created by Megahub on 17/08/2010.
//  Copyright 2010 Megahub Limited. All rights reserved.
//

/*
	Version: 20141217
		- 64 bit build
		- update Feed X Library
 
    Version: 20140908 Happy Mid Autumn festival
        - Added new constant for bold font in month picker in top right setting
            #define PICKERVIEW_DEFAULT_FONT_SIZE_CHINESE	19
            #define PICKERVIEW_DEFAULT_FONT_SIZE_EN			15
 
            #define PICKERVIEW_DEFAULT_BOLD_FONT_SIZE_CHINESE	15
            #define PICKERVIEW_DEFAULT_BOLD_FONT_SIZE_EN        11
 
    Version: 20140804
        - Added back support folder to the library zip file
 
    Version: 20140801
        - Fixed: remove the NSLog which print the disclaimer in console 
 
    Version: 20140731
        - Change the disclaimer view to MHTAChartDisclaimerView from Alert view
        - Added MHTAChartDisclaimerView.m and MHTAChartDisclaimerView.h
        - Updated library: MHFeedConnectorX_20140914
 
 *  Version: 20121031
 *      - Added code to restore the TA config view if the user dismissed the TA config dialog when editing TA parameters.
 *
 */


#import <Foundation/Foundation.h>
#import "MHChartTypes.h"

typedef enum {
	MHChartLanguageEnglish = 0,
	MHChartLanguageTradChinese = 1,
	MHChartLanguageSimpChinese = 2
} MHChartLanguage;

@class MHIndexSelectView;
@class MHChartUserConfiguration;
@class MHTAConfigView;


@interface MHTAChartView : UIView <UITextFieldDelegate> {
	
}

@property (nonatomic, assign) id						delegate;

@property (nonatomic, assign) int						iSymbol;	//This is for numeric symbol compatibility
@property (nonatomic, retain) NSString					*sSymbol;

@property (nonatomic, retain) NSString					*sSymbolName;

@property (nonatomic, assign) int						iWaterMark;
@property (nonatomic, assign) int						iGraphWidth;
@property (nonatomic, assign) int						iGraphHeight;

@property (nonatomic, assign) int						iFontSize;
@property (nonatomic, assign) MHChartLanguage			iLang;
@property (nonatomic, assign) MHChartTitleStyle			iTstyle;
@property (nonatomic, assign) MHChartColorScheme		iColorScheme;

@property (nonatomic, retain) UIImage					*oDisclaimerLogo;
@property (nonatomic, retain) UIImage					*oCustomLogo;

@property (nonatomic, assign) BOOL						isRealTime;
@property (nonatomic, assign) BOOL                      hasFutures;

@property (nonatomic, retain) MHChartUserConfiguration *oChartUserConfig;

- (id) initWithDefaultSettings:(CGRect)rect isRealTime:(BOOL)aisReal;
- (id) initWithDefaultSettings:(CGRect)rect isRealTime:(BOOL)aisReal hasFutures:(BOOL)hasFutures;
- (void)setImage:(UIImage *)aoImage forPeriod:(MHChartPeriods)aiPeriod;
- (void)setGraphLanguage:(MHChartLanguage)language TitleStyle:(MHChartTitleStyle)titleStyle ColorScheme:(MHChartColorScheme)colorScheme;
- (void)loadCharts;
- (void)setDisclaimerText:(NSString *)asDisclaimerStr;
+ (char)getBuildMode;
- (void)setDebugMode:(BOOL)isDebugMode;
- (void)setToolBarTint:(UIColor *)toolBarTint;
- (void)setToolBarAlpha:(float)toolBarAlpha;
- (void)setMenuBarTint:(UIColor *)menuBarTint;
- (void)setMenuBarTextColor:(UIColor *)aColor font:(UIFont *)aFont;
- (void)setMenuBarNormalBackgroundImage:(UIImage *)aImage;
- (void)setMenuBarSelectedBackgroundImage:(UIImage *)aImage;
- (void)setSSymbol:(NSString *)aSymbol;
- (void)setConfigViewButtonBorderWithWithColor:(UIColor *)aColor withBorderWidth:(CGFloat)aWidth withCornerRadius:(CGFloat)aRadius;
- (void)setButtonsTextColor:(UIColor*)aColor;
- (void)setSegmentedButtonsBackgroundImage:(UIImage*)aLeftImage selectedLeftImage:(UIImage*)aSelectedLeftImage
                               middleImage:(UIImage*)aMiddleImage selectedMiddleImage:(UIImage*)aSelectedMiddleImage
                                rightImage:(UIImage*)aRightImage selectedRightImage:(UIImage*)aSelectedRightImage;
- (void)setButtonsBackgroundImage:(UIImage*)aImage selectedImage:(UIImage*)aSelectedImage;
- (void)setDisclaimerWidth:(int)aWidth height:(int)aHeight;
- (void)setCSStyle;
@end

@protocol MHTAChartViewDelegate

- (void)clientDidRequestNewQuote:(NSString *)asNewSymbol;

@end