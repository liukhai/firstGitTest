/*
 *  MHChartTypes.h
 *  QuamSec
 *
 *  Created by Megahub on 13/01/2011.
 *  Copyright 2011 Megahub. All rights reserved.
 *
 */

#ifndef MHCHARTTYPES_H
#define MHCHARTTYPES_H

/** Defines chart constants in accordance to Megahub chart API v1.2 */

typedef enum {
	MHCTypeInvisible = 0,
	MHCTypeCandle = 1,
	MHCTypeOHLC = 2,
	MHCTypeHLC = 3,
	MHCTypeBar = 4,
	MHCTypeLine = 5,
	MHCTypeMountain = 6,
	MHCTypeDots = 7,
	MHCTypeDisappear = 999,
	MHCTypeThickLine = 8
} MHChartType;

typedef enum {
	MHCPeriod1Day1MinDelay = 2000101,
	MHCPeriod1Day3MinDelay = 2000103,
	MHCPeriod1Day5MinDelay = 2000105,
	MHCPeriod3Day5MinDelay = 2000305,
	MHCPeriod3Day10MinDelay = 2000310,
	MHCPeriod5Day15MinDelay = 2000515,
	MHCPeriod10Day30MinDelay = 2001030,
	MHCPeriod10Day1HrDelay = 2001060,
	MHCPeriod20Day1HrDelay = 2002060,
	MHCPeriod1Mth1DayDelay = 2010001,
	MHCPeriod3Mth1DayDelay = 2010003,
	MHCPeriod6Mth1DayDelay = 2010006,
	MHCPeriod1Yr1DayDelay = 2010100,
	MHCPeriod3Yr1DayDelay = 2010300,
	MHCPeriod6Mth1WkDelay = 2020006,
	MHCPeriod1Yr1WkDelay = 2020100,
	MHCPeriod3Yr1WkDelay = 2020300,
	MHCPeriod8Yr1WkDelay = 2020800,
	MHCPeriod3Yr1MthDelay = 2030300,
	MHCPeriod8Yr1MthDelay = 2030800,
	MHCPeriod1Day1MinReal = 1000101,
	MHCPeriod1Day3MinReal = 1000103,
	MHCPeriod1Day5MinReal = 1000105,
	MHCPeriod3Day5MinReal = 1000305,
	MHCPeriod3Day10MinReal = 1000310,
	MHCPeriod5Day15MinReal = 1000515,
	MHCPeriod10Day30MinReal = 1001030,
	MHCPeriod10Day1HrReal = 1001060,
	MHCPeriod20Day1HrReal = 1002060,
	MHCPeriod1Mth1DayReal = 1010001,
	MHCPeriod3Mth1DayReal = 1010003,
	MHCPeriod6Mth1DayReal = 1010006,
	MHCPeriod1Yr1DayReal = 1010100,
	MHCPeriod3Yr1DayReal = 1010300,
	MHCPeriod6Mth1WkReal = 1020006,
	MHCPeriod1Yr1WkReal = 1020100,
	MHCPeriod3Yr1WkReal = 1020300,
	MHCPeriod8Yr1WkReal = 1020800,
	MHCPeriod3Yr1MthReal = 1030300,
	MHCPeriod8Yr1MthReal = 1030800
} MHChartPeriods; 

typedef enum {
	MHChartTimePeriod1Day = 0,
	MHChartTimePeriod3Days = 1,
	MHChartTimePeriod5Days = 2,
	MHChartTimePeriod10Days = 3,
	MHChartTimePeriod20Days = 4,
	MHChartTimePeriod1Month = 5,
	MHChartTimePeriod3Month = 6,
	MHChartTimePeriod6Month = 7,
	MHChartTimePeriod1Year = 8,
	MHChartTimePeriod3Year = 9,
	MHChartTimePeriod8Year = 10
} MHChartTimePeriod;

typedef enum {
	MHChartTimeInterval1Min = 0,
	MHChartTimeInterval3Min = 1,
	MHChartTimeInterval5Min = 2,
	MHChartTimeInterval10Min = 3,
	MHChartTimeInterval15Min = 4,
	MHChartTimeInterval30Min = 5,
	MHChartTimeIntervalHourly = 6,
	MHChartTimeIntervalDaily = 7,
	MHChartTimeIntervalWeekly = 8,
	MHChartTimeIntervalMonthly = 9
} MHChartTimeInterval;

typedef enum {
	MHChartTitleNone = -1,
	MHChartTitleTimeSpanAtTopLeftHandCorner = 0,
	MHChartTitleStockNameAndSpanAtTopLeftCornerWithOHLC = 1,
	MHChartTitleTitleInThreeLineMode = 2,
	MHChartTitleTitleForSmallScreen = 3,
	MHChartTitleStockNameAndSpanAtTopLeftCornerWithoutOHLC = 4,
    MHChartTitleTitleWithoutName = 5,
    MHChartTitleTripleWithTABeside = 6,
    MHChartTitleTripleWithTABeside2 = 7
} MHChartTitleStyle;


typedef enum {
	MHChartColorMegahubDark = 102,
	MHChartColorMegahubLight = 101,
    MHChartColorMayfair = 103,
    MHChartColorBerich = 104,
    MHChartColorBrightSmart = 105,
    MHChartColorChief = 106,
    MHChartColorEJFQ = 107,
    MHChartColoriPhone13 = 108,
    MHChartColorFulbright = 109,
    MHChartColorWF = 110,
    MHChartColorWebsiteHKEJ = 111,
    MHChartColorSchemeWebsiteEJFQLight = 112,
    MHChartColorSchemeWebsiteBEA = 113,
    MHChartColorSchemeWebsiteDSB = 114,
    MHChartColorSchemeWebsiteDSBLight = 115
} MHChartColorScheme;

typedef enum {
	MHChartTADisplayOverlay,
	MHChartTADisplayUnderlay
} MHChartTADisplayType;

#define MH_TAPARAM_MAX_DAYS 500;
#define MH_TAPARAM_MIN_DAYS 1;

#endif