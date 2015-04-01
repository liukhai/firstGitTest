//
//  PTLocalIndexView.h
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PTLocalIndexView : UIView {
	UITableView			*m_oTableView;
}

@property(nonatomic, retain) UITableView	*m_oTableView;


- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;

- (void)reloadTableAtIndexPath:(NSIndexPath *)aIndex;
- (void)reloadTable;
- (void)reloadText;

@end
