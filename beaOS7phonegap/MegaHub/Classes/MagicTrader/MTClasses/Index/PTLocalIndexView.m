//
//  PTLocalIndexView.m
//  MagicTrader
//
//  Created by Hong on 11/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import "PTLocalIndexView.h"
#import "StyleConstant.h"

@implementation PTLocalIndexView

@synthesize m_oTableView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		
		self.backgroundColor = Default_view_background_color;
		
		// TableView
		m_oTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
		m_oTableView.separatorColor = Default_table_seperator_color;
		[m_oTableView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
		m_oTableView.backgroundColor = [UIColor clearColor];
		[self addSubview:m_oTableView];
		[m_oTableView release];
	}
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)reloadTableAtIndexPath:(NSIndexPath *)aIndex {
//	[m_oTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:aIndex] withRowAnimation:UITableViewRowAnimationNone];
	[m_oTableView reloadData];
}

- (void)reloadTable {
	[m_oTableView reloadData];
}

- (void)reloadText {
	[m_oTableView reloadData];
}


@end
