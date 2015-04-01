//
//  MHBEAFundamentalTableCell.h
//  BEA
//
//  Created by Samuel Ma on 16/08/2011.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHUILabel.h"

@interface MHBEAFundamentalTableCell : UITableViewCell {
    MHUILabel	*m_oLeftTitleLabel;
	MHUILabel	*m_oLeftValueLabel;
	
	MHUILabel	*m_oRightTitleLabel;
	MHUILabel	*m_oRightValueLabel;
	
	BOOL		m_isOneSetDataOnly;
	
	UIImageView		*m_oLeftImageView;
	UIImageView		*m_oRightImageView;
}

@property (assign, nonatomic) BOOL		m_isOneSetDataOnly;
@property (retain, nonatomic) UIImageView		*m_oLeftImageView;
@property (retain, nonatomic) UIImageView		*m_oRightImageView;

//Default is two set data
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

//one set or two set
-(void)setOneSetData:(NSString *)aTitleString value:(NSString *)aValueString;
-(void)setTwoSetData:(NSString *)aLeftTitleString value:(NSString *)aLeftValueString rightTitle:(NSString *)aRightTitleString value:(NSString *)aRightValueString;

-(void)setOneSetDataWithAnimation:(NSString *)aTitleString value:(NSString *)aValueString;
-(void)setTwoSetDataWithLeftStringWithAnimation:(NSString *)aLeftTitleString value:(NSString *)aLeftValueString;
-(void)setTwoSetDataWithRightStringWithAnimation:(NSString *)aRightTitleString value:(NSString *)aRightValueString;

//Internal use only, don't touch this.
-(void)setIsOneSetDataOnly:(BOOL)isOneSetData;

- (void)dealloc;

@end
