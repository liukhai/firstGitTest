//
//  MegaHubChartView.h
//  MegaHubUtility
//
//  Created by Megahub on 17/08/2010.
//  Copyright 2010 Megahub Limited. All rights reserved.
//

/*
 *  Version: 20121016
 *      - Initial version
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


@interface MHBigTAChartView : UIView <UITextFieldDelegate> {
	
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

@property (nonatomic, assign) BOOL                      isAutoUpdate;
@property (nonatomic, assign) NSTimeInterval            fAutoUpdateInterval;

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
- (void)setSSymbol:(NSString *)sSymbol;
- (void)setConfigViewButtonBorderWithWithColor:(UIColor *)aColor withBorderWidth:(CGFloat)aWidth withCornerRadius:(CGFloat)aRadius;
- (void)setButtonsTextColor:(UIColor*)aColor;
- (void)setSegmentedButtonsBackgroundImage:(UIImage*)aLeftImage selectedLeftImage:(UIImage*)aSelectedLeftImage
                               middleImage:(UIImage*)aMiddleImage selectedMiddleImage:(UIImage*)aSelectedMiddleImage
                                rightImage:(UIImage*)aRightImage selectedRightImage:(UIImage*)aSelectedRightImage;
- (void)setButtonsBackgroundImage:(UIImage*)aImage selectedImage:(UIImage*)aSelectedImage;

@end

@protocol MHTAChartViewDelegate

- (void)clientDidRequestNewQuote:(NSString *)asNewSymbol;

@end

