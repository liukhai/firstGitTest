//
//  MHTableViewCellTextField.h
//  MegaHub
//
//  Created by Hong on 08/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MHTableViewCellTextField : UITableViewCell {

	UILabel			*m_oTitleLabel;
	UITextField		*m_oTextFieldTextField;
}

@property (nonatomic, retain) UILabel		*m_oTitleLabel;
@property (nonatomic, retain) UITextField	*m_oTextFieldTextField;

@end
