
#import "MHBEAConstant.h"
#import "MHBEAStyleConstant.h"
#import "MagicTraderAppDelegate.h"

#define PT_COMPANY_ICON													[UIImage imageNamed:@"disclaimer_logo.png"]
#define	MHStockDataView_aBackgroundImageView_image						nil
#define CHART_CR														@"113"
#define Default_MHIndexBarView_label_animate_second						Default_label_animation_second
#define Default_MHIndexBarView_label_background_color					[UIColor clearColor]
#define Default_MHIndexBarView_label_font								[UIFont boldSystemFontOfSize:12]
#define Default_MHIndexBarView_label_text_color							[UIColor whiteColor]
#define Default_button_title_background_color							[UIColor colorWithRed:112/255.0 green:113/255.0 blue:123/255.0 alpha:1]
#define Default_chart_disclaimer_image_view								[UIImage imageNamed:@"disclaimer_logo.png"]
#define Default_label_animation_second									0.3
#define Default_label_flash_color										@"0x0000FF"
#define Default_label_text_color										[UIColor whiteColor]
#define Default_label_text_color_down									[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define Default_label_text_color_leveloff								MHBEA_color_bea_black//[UIColor whiteColor]
#define Default_label_text_color_up										[UIColor colorWithRed:26/255.0 green:157/255.0 blue:0/255.0 alpha:1]
#define Default_snaphot_solution_provider_image_view					[UIImage imageNamed:@"disclaimer_logo2.png"]
#define Default_solution_provider_image_view							[UIImage imageNamed:@"disclaimer_logo.png"]
#define Default_table_cell_height										35
#define Default_table_seperator_color									[UIColor whiteColor]
#define Default_textfield_background_color								[UIColor whiteColor]
#define Default_view_background_color									[UIColor whiteColor]
#define MHBidAskTableCell_label_animate_second							Default_label_animation_second
#define MHBidAskTableCell_m_oAskLabel_font								[UIFont systemFontOfSize:16]
#define MHBidAskTableCell_m_oAskLabel_text_color						[UIColor colorWithRed:220/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define MHBidAskTableCell_m_oBidLabel_font								[UIFont systemFontOfSize:16]
#define MHBidAskTableCell_m_oBidLabel_text_color						[UIColor colorWithRed:0/255.0 green:161/255.0 blue:255/255.0 alpha:1]
#define MHBidAskView_logo_image											[UIImage imageNamed:@"dc_MHBidAskView_logo.png"]
#define MHBidAskView_m_oAskQueueView_image								[UIImage imageNamed:@"bg_bid2.png"]
#define MHBidAskView_m_oAskTitleLabel_font								[UIFont boldSystemFontOfSize:16]
#define MHBidAskView_m_oAskTitleLabel_textColor							[UIColor whiteColor]
#define MHBidAskView_m_oAskValueLabel_font								[UIFont boldSystemFontOfSize:19]
#define MHBidAskView_m_oAskValueLabel_textColor							[UIColor whiteColor]
#define MHBidAskView_m_oAskView_background_image						[UIImage imageNamed:@"Heading_red.png"]
#define MHBidAskView_m_oBidQueueView_image								[UIImage imageNamed:@"bg_bid2.png"]
#define MHBidAskView_m_oBidTitleLabel_font								[UIFont boldSystemFontOfSize:16]
#define MHBidAskView_m_oBidTitleLabel_textColor							[UIColor whiteColor]
#define MHBidAskView_m_oBidValueLabel_font								[UIFont boldSystemFontOfSize:19]
#define MHBidAskView_m_oBidValueLabel_textColor							[UIColor whiteColor]
#define MHBidAskView_m_oBidView_background_image						[UIImage imageNamed:@"Heading_blue.png"]
#define MHBidAskView_view_background_color								Default_view_background_color
#define MHDetailDisclaimerButton_m_oDetailButton_background_image		[UIImage imageNamed:@"bea_btn_full1.png"]
#define MHFundamentalTableCell_m_oLeftTitleLabel_font					[UIFont systemFontOfSize:15]
#define MHFundamentalTableCell_m_oLeftTitleLabel_textColor				[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define MHFundamentalTableCell_m_oLeftValueLabel_font					[UIFont boldSystemFontOfSize:15]
#define MHFundamentalTableCell_m_oLeftValueLabel_textColor				[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define MHFundamentalTableCell_m_oRightTitleLabel_font					[UIFont systemFontOfSize:15]
#define MHFundamentalTableCell_m_oRightTitleLabel_textColor				[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define MHFundamentalTableCell_m_oRightValueLabel_font					[UIFont boldSystemFontOfSize:15]
#define MHFundamentalTableCell_m_oRightValueLabel_textColor				[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define MHIndexBarView_m_oChangeLabel_text_color_down					[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1]
#define MHIndexBarView_m_oChangeLabel_text_color_leveloff				[UIColor blackColor]
#define MHIndexBarView_m_oChangeLabel_text_color_up						[UIColor colorWithRed:26/255.0 green:157/255.0 blue:0/255.0 alpha:1]
#define MHIndexBarView_m_oIndexChangeLabel_animate_second				Default_MHIndexBarView_label_animate_second
#define MHIndexBarView_m_oIndexChangeLabel_text_color					Default_MHIndexBarView_label_text_color
#define MHIndexBarView_m_oIndexDescriptionLabel_text_color				Default_MHIndexBarView_label_text_color
#define MHIndexBarView_m_oIndexValueLabel_animate_second				Default_MHIndexBarView_label_animate_second
#define MHIndexBarView_m_oIndexValueLabel_text_color					Default_MHIndexBarView_label_text_color
#define MHIndexBarView_m_oIndexVolumeLabel_animate_second				Default_MHIndexBarView_label_animate_second
#define MHIndexBarView_view_background_image							[UIImage imageNamed:@"bg_index.png"]
#define MHSolutionProviderView_m_oDescriptionLabel_isMiniMode_font		[UIFont systemFontOfSize:12]
#define MHSolutionProviderView_m_oDescriptionLabel_textColor			[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define MHStockDataView_m_notOneSetData_even_image							[UIImage imageNamed:@"bea_quote_bg_cell_dark.png"]
#define MHStockDataView_m_notOneSetData_odd_image							[UIImage imageNamed:@"bea_quote_bg_cell_light.png"]
#define MHStockDataView_m_oLastUpdateBackgroundImageView_image				nil
#define MHStockDataView_m_oLastUpdateLabel_font								[UIFont systemFontOfSize:13]
#define MHStockDataView_m_oLastUpdateLabel_font								[UIFont systemFontOfSize:13]
#define MHStockDataView_m_oLastUpdateLabel_text_color						[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]//[MHUtility uicolorWithHexValueString:@"0x4D6984"]
#define MHStockDataView_m_oStockDataSegmentedButton_background_image		[UIImage imageNamed:@"ZC03wf_Stock_data_01_bg_button.png"]
#define MHStockDataView_m_oStockDataSegmentedButton_left_selectedImage		[UIImage imageNamed:@"bea_quote_btn_01a.png"]//[UIImage imageNamed:@"z03_btn_01b.png"]
#define MHStockDataView_m_oStockDataSegmentedButton_left_unselectedImage	[UIImage imageNamed:@"bea_quote_btn_01b.png"] //[UIImage imageNamed:@"z03_btn_01a.png"]
#define MHStockDataView_m_oStockDataSegmentedButton_right_selectedImage		[UIImage imageNamed:@"bea_quote_btn_03a.png"]//[UIImage imageNamed:@"z03_btn_03b.png"]
#define MHStockDataView_m_oStockDataSegmentedButton_right_unselectedImage	[UIImage imageNamed:@"bea_quote_btn_03b.png"]
#define MHStockDataView_m_oStockDataSegmentedButton_selectedColor			[UIColor whiteColor]
#define MHStockDataView_m_oStockDataSegmentedButton_selectedImage			[UIImage imageNamed:@"bea_quote_btn_02a.png"]//[UIImage imageNamed:@"z03_btn_02b.png"]
#define MHStockDataView_m_oStockDataSegmentedButton_unselectedColor			[UIColor orangeColor]
#define MHStockDataView_m_oStockDataSegmentedButton_unselectedImage			[UIImage imageNamed:@"bea_quote_btn_02b.png"]//[UIImage imageNamed:@"z03_btn_02a.png"]
#define MHStockDataView_m_oStockDataTableView_seperator_color				[UIColor whiteColor]
#define MHStockDataView_m_oneSetData_even_image								[UIImage imageNamed:@"bea_quote_bg_cell_dark02.png"]
#define MHStockDataView_m_oneSetData_odd_image								[UIImage imageNamed:@"bea_quote_bg_cell_light02.png"]
#define MHStockQuoteBarView_m_oChangeLabel_animate_second					Default_label_animation_second
#define MHStockQuoteBarView_m_oChangeLabel_font								[UIFont systemFontOfSize:16]
#define MHStockQuoteBarView_m_oChangeLabel_text_color_down					Default_label_text_color_down
#define MHStockQuoteBarView_m_oChangeLabel_text_color_leveloff				Default_label_text_color_leveloff
#define MHStockQuoteBarView_m_oChangeLabel_text_color_up					Default_label_text_color_up
#define MHStockQuoteBarView_m_oChangePercentageLabel_animate_second			Default_label_animation_second
#define MHStockQuoteBarView_m_oChangePercentageLabel_font					[UIFont systemFontOfSize:16]
#define MHStockQuoteBarView_m_oChangePercentageLabel_text_color_down		Default_label_text_color_down
#define MHStockQuoteBarView_m_oChangePercentageLabel_text_color_leveloff	Default_label_text_color_leveloff
#define MHStockQuoteBarView_m_oChangePercentageLabel_text_color_up			Default_label_text_color_up
#define MHStockQuoteBarView_m_oPriceLabel_animate_second					Default_label_animation_second
#define MHStockQuoteBarView_m_oPriceLabel_font								[UIFont boldSystemFontOfSize:18]
#define MHStockQuoteBarView_m_oPriceLabel_text_color						[UIColor blackColor]
#define MHStockQuoteBarView_m_oQuoteButton_font								[UIFont boldSystemFontOfSize:13]
#define MHStockQuoteBarView_m_oQuoteButton_image							[UIImage imageNamed:@"bea_general_btn_quote.png"]
#define MHStockQuoteBarView_m_oSuspendImage_image							[UIImage imageNamed:@"suspend.png"]
#define MHStockQuoteBarView_m_oSymbolTextField_font							[UIFont systemFontOfSize:13]
#define MHStockQuoteBarView_view_background_color							[UIColor colorWithPatternImage:[UIImage imageNamed:@"bea_quote_bg_quote.png"]]
#define MHStockView_m_oAskPriceLabel_font									[UIFont boldSystemFontOfSize:16]
#define MHStockView_m_oAskTitleLabel_font									[UIFont boldSystemFontOfSize:16]
#define MHStockView_m_oBidPriceLabel_font									[UIFont boldSystemFontOfSize:16]
#define MHStockView_m_oBidTitleLabel_font									[UIFont boldSystemFontOfSize:16]
#define MHStockView_m_oChangeLabel_font										[UIFont systemFontOfSize:16]
#define MHStockView_m_oChangePctLabel_font									[UIFont systemFontOfSize:16]
#define MHStockView_m_oCopyAskPriceButton_image								[UIImage imageNamed:@"Heading_red.png"]
#define MHStockView_m_oCopyBidPriceButton_image								[UIImage imageNamed:@"Heading_blue.png"]
#define MHStockView_m_oNorminalPriceLabel									[UIFont boldSystemFontOfSize:18]
#define MHStockView_m_oNorminalPriceLabel_font								[UIFont boldSystemFontOfSize:26]
#define MHSubmenuItem_background_image										[UIImage imageNamed:@"bea_index_bg_submenu.png"]
#define MHSubmenuItem_label_font											[UIFont systemFontOfSize:15]
#define MHSubmenuItem_label_textColor										[UIColor blackColor]
#define MHSubmenuItem_m_oLeftArrowImageView_image							[UIImage imageNamed:@"arrow_left0.png"]
#define MHSubmenuItem_m_oRightArrowImageView_image							[UIImage imageNamed:@"arrow_right0.png"]
#define MHSubmenuItem_selected_color										[UIColor orangeColor]
#define MHSubmenuItem_width													90
#define MHTableCell_detailView_backgroundImage								[UIImage imageNamed:@"z10_bg_header_big.png"]
#define MHTableCell_label_font												[UIFont systemFontOfSize:15]
#define MHTableCell_label_textColor											Default_label_text_color
#define MHTableCell_m_oBidAskLabel_textColor								[UIColor whiteColor]
#define MHTableCell_m_oDescriptionLabel_textColor							[UIColor whiteColor]
#define MHTableCell_m_oSymbolLabel_textColor								[UIColor whiteColor]
#define MHTableCell_m_oTurnoverLabel_textColor								[UIColor whiteColor]
#define MHTableCell_m_oVolumeLabel_textColor								[UIColor whiteColor]
#define MHTableCell_normalView_backgroundImage								[UIImage imageNamed:@"z10_bg_header.png"]
#define MTableCell_m_oPriceLabel_color													[UIColor colorWithRed:146/255.0 green:206/255.0 blue:243/255.0 alpha:1]
#define PTSectorRootViewController_cell_background_image_dark							MHBEAWatchlistLv0ViewStockCell_background_image
#define PTSectorRootViewController_cell_background_image_light							MHBEAWatchlistLv0ViewStockCell_background_image
#define PTSectorRootViewController_cell_title_color										[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1]
#define PTStockQuotePageView_animationDuration									1.5
#define PTStockQuotePageView_m_o52WeekTitleLabel_font							[UIFont systemFontOfSize:13]
#define PTStockQuotePageView_m_oFreeTextLabel_font								[UIFont systemFontOfSize:13]
#define PTStockQuotePageView_m_oFreeTextLabel_image								[UIImage imageNamed:@"07_quote_bg_gradient.png"]
#define PTStockQuotePageView_m_oFreeTextLabel_text_color						[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1]
#define PTStockQuotePageView_m_oLowHighHighValueLabel_font						[UIFont systemFontOfSize:13]
#define PTStockQuotePageView_m_oLowHighLowValueLabel_font						[UIFont systemFontOfSize:13]
#define PTStockQuotePageView_m_oLowHighTitleLabel_font							[UIFont systemFontOfSize:13]
#define PTStockQuotePageView_m_oRangeImageView									[UIImage imageNamed:@"07_quote_bg_range.png"]
#define PTStockQuotePageView_m_oRangeImageView_background_color					[UIColor clearColor]//[UIColor colorWithRed:20/255.0 green:27/255.0 blue:39/255.0 alpha:1]
#define PTStockQuotePageView_m_oUndelyingPriceLabel_font						[UIFont systemFontOfSize:13]
#define PTStockQuotePageView_m_oUndelyingTitleLabel_font						[UIFont systemFontOfSize:13]
#define PTTopRankViewController_m_oBackBarButton_background_image				[UIImage imageNamed:@"bea_general_btn_back.png"]
#define PTTopRankViewController_m_oBackBarButton_title_color					[UIColor whiteColor]
#define PTWorldIndexView_m_oDelayLabel_font										[UIFont systemFontOfSize:13]
#define PTWorldIndexView_m_oDelayLabel_textColor								[UIColor grayColor]
#define PTWorldIndexView_m_oWorldLocalSegmentButton_background_image			[UIImage imageNamed:@"bea_general_bg.png"]
#define PTWorldIndexView_m_oWorldLocalSegmentButton_left_selectButton_image		[UIImage imageNamed:@"bea_quote_btn_01a.png"]
#define PTWorldIndexView_m_oWorldLocalSegmentButton_left_unselectButton_image	[UIImage imageNamed:@"bea_quote_btn_01b.png"]
#define PTWorldIndexView_m_oWorldLocalSegmentButton_right_selectButton_image	[UIImage imageNamed:@"bea_quote_btn_03a.png"]
#define PTWorldIndexView_m_oWorldLocalSegmentButton_right_unselectButton_image	[UIImage imageNamed:@"bea_quote_btn_03b.png"]
#define PTWorldLocalIndexCell_background_image_dark								[UIImage imageNamed:@"bea_quote_bg_cell_dark02.png"]
#define PTWorldLocalIndexCell_background_image_light							[UIImage imageNamed:@"bea_quote_bg_cell_light02.png"]
#define PTWorldLocalIndexCell_m_oAccessoryButton_pressedImage					[UIImage imageNamed:@"btn_arrow_right.png"]
#define PTWorldLocalIndexCell_m_oAccessoryButton_unpressedImage					[UIImage imageNamed:@"btn_arrow_right.png"]
#define PTWorldLocalIndexCell_m_oLabel_Header_font								[UIFont boldSystemFontOfSize:14]
#define PTWorldLocalIndexCell_m_oLabel_Change_font								[UIFont systemFontOfSize:14]
#define PTWorldLocalIndexCell_m_oLabel_Change_textColor							MHBEA_color_bea_black
#define PTWorldLocalIndexCell_m_oLabel_HSIName_font								[UIFont systemFontOfSize:14]
#define PTWorldLocalIndexCell_m_oLabel_HSIName_textColor						[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define PTWorldLocalIndexCell_m_oLabel_MrkTOver_font							[UIFont systemFontOfSize:14]
#define PTWorldLocalIndexCell_m_oLabel_MrkTOver_textColor						[UIColor colorWithRed:153.0/255.0 green:217.0/255.0 blue:255/255.0 alpha:1]
#define PTWorldLocalIndexCell_m_oLabel_Nominal_font								[UIFont systemFontOfSize:14]
#define PTWorldLocalIndexCell_m_oLabel_Nominal_textColor						[UIColor colorWithRed:051.0/255.0 green:051.0/255.0 blue:051.0/255.0 alpha:1]
#define PTWorldLocalIndexCell_m_oLabel_PChange_font								[UIFont systemFontOfSize:14]
#define PTWorldLocalIndexCell_m_oLabel_PChange_textColor						MHBEA_color_bea_black
#define STYLE_ChinaStyle														@"BEACN"
#define STYLE_DEFAULT															@"BEAHK"
#define NoPermissionLabel_text_color                                            [UIColor whiteColor]
#define MHIndexBarView_m_oLastUpdateLabel_font                                  [UIFont systemFontOfSize:8]
#define MHIndexBarView_indexBackgroundView_background_color                     [UIColor colorWithRed:197/255.0 green:197/255.0 blue:202/255.0 alpha:1]
#define MHIndexBarView_stockBackgroundView_background_color                     [UIColor colorWithRed:241/255.0 green:238/255.0 blue:239/255.0 alpha:1]

#define Default_MHStaticDataView_view_background_color			[UIColor colorWithRed:237/255.0 green:236/255.0 blue:236/255.0 alpha:1]
#define MHStaticDataView_background_image						[UIImage imageNamed:@"bg_info.png"]
#define MHStaticDataView_label_background_color_even            [UIColor colorWithRed:237/255.0 green:236/255.0 blue:236/255.0 alpha:1]
#define MHStaticDataView_label_background_color_odd             [UIColor whiteColor]

#define Default_MHStaticDataView_title_label_text_color			[UIColor blackColor]
#define Default_MHStaticDataView_title_label_font				[UIFont systemFontOfSize:11]
#define Default_MHStaticDataView_value_label_text_color			[UIColor blackColor]
#define Default_MHStaticDataView_value_label_font				[UIFont systemFontOfSize:11]