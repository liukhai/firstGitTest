//
//  MHTableViewCellTextField.m
//  MegaHub
//
//  Created by Hong on 08/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MHTableViewCellTextField.h"


@implementation MHTableViewCellTextField

@synthesize m_oTitleLabel;
@synthesize m_oTextFieldTextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.		
		m_oTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 280, 22)];
		[m_oTitleLabel setTextAlignment:NSTextAlignmentLeft];
		[m_oTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
		[self addSubview:m_oTitleLabel];
		[m_oTitleLabel release];
		
		m_oTextFieldTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 11, 280, 22)];
		[m_oTextFieldTextField setTextAlignment:NSTextAlignmentRight];
		[m_oTextFieldTextField setFont:[UIFont systemFontOfSize:16]];
		[m_oTextFieldTextField setClearsContextBeforeDrawing:YES];
		[m_oTextFieldTextField setClearsOnBeginEditing:YES];
		[m_oTextFieldTextField setSecureTextEntry:YES];
		[self addSubview:m_oTextFieldTextField];
		[m_oTextFieldTextField release];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
