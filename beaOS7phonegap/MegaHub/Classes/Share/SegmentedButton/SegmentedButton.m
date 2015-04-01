//
//  SegmentedButton.m
//  TedSegmentedControl
//
//  Created by __MyCompanyName__ on 20/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SegmentedButton.h"

#define BUTTON_DISTANCE		15

@implementation SegmentedButton

@synthesize m_iPrevSelectedIndex;
@synthesize m_iSelectedIndex;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self == nil) { return nil;  }
	
    m_oBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	[self addSubview:m_oBackgroundImageView];
	[m_oBackgroundImageView release];
    
	m_oButtonArray = [[NSMutableArray alloc] init];
	m_iButtonNumberOfLine	= 1;
	m_oButtonFont = [[UIFont systemFontOfSize:16] retain];
	m_isButtonEqualSize = YES;
	m_iSelectedIndex		= -1; //20110609
    m_iPrevSelectedIndex    = -1;
    m_isScrollable      = NO;
    
    m_oUnSelectButtonTitleColor = [[UIColor whiteColor] retain];
    m_oSelectedButtonTitleColor = [[UIColor whiteColor] retain];
	
    return self;
}

- (id)initWithFrame:(CGRect)frame scrollable:(BOOL)aScrol {
    
    self = [super initWithFrame:frame];
    if (self == nil) { return nil;  }
	
    m_isScrollable = aScrol;
    
    m_oBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	[self addSubview:m_oBackgroundImageView];
	[m_oBackgroundImageView release];
    
    // Scroll View
	m_oScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	[m_oScrollView setShowsVerticalScrollIndicator:NO];
	[m_oScrollView setShowsHorizontalScrollIndicator:NO];
	[m_oScrollView setBackgroundColor:[UIColor clearColor]];
	[self addSubview:m_oScrollView];
	[m_oScrollView release];
    
	m_oButtonArray = [[NSMutableArray alloc] init];
	m_iButtonNumberOfLine	= 1;
	m_oButtonFont = [[UIFont systemFontOfSize:16] retain];
	m_isButtonEqualSize = YES;
	m_iSelectedIndex		= -1; //20110609
    m_iPrevSelectedIndex    = -1;
	
    m_oUnSelectButtonTitleColor = [[UIColor whiteColor] retain];
    m_oSelectedButtonTitleColor = [[UIColor whiteColor] retain];
    
    
    return self;
}

// Fix same size not scrollable
- (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray {
	[aArray retain];
	self = [self initWithFrame:frame];
	
    if (self) {
        
		NSString *title = nil;
		for (int i=0; i<[aArray count]; i++) {
			title = [aArray objectAtIndex:i];
			
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			[button setFrame:CGRectMake(i*(frame.size.width/[aArray count]), 0, frame.size.width/[aArray count], frame.size.height)];
			[button setBackgroundImage:m_oUnSelectedImage forState:UIControlStateNormal];
			[button setBackgroundImage:m_oSelectedImage forState:UIControlStateSelected];
			[button setTitle:title forState:UIControlStateNormal];
			[button.titleLabel setAdjustsFontSizeToFitWidth:YES];
			[button.titleLabel setNumberOfLines:m_iButtonNumberOfLine];
			[button.titleLabel setTextAlignment:NSTextAlignmentCenter];
			[button setTag:i];
			[button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:button];
			
			[m_oButtonArray addObject:button];
		}
    }
	[aArray release];
    return self;
}

// Fix same size not scrollable
- (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray enableScroll:(BOOL)aEnableScroll buttonFrame:(CGSize)aBtnSize {
	if (aEnableScroll == NO) {
		return [self initWithFrame:frame items:aArray];
	}
	self = [self initWithFrame:frame];
	if (self == nil) {return nil;}
	
    m_isScrollable = aEnableScroll;
	
	// Scroll View
	m_oScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	[m_oScrollView setShowsVerticalScrollIndicator:NO];
	[m_oScrollView setShowsHorizontalScrollIndicator:NO];
	[m_oScrollView setBackgroundColor:[UIColor clearColor]];
	[m_oScrollView setContentSize:CGSizeMake(aBtnSize.width*[aArray count], aBtnSize.height)];
	[self addSubview:m_oScrollView];
	[m_oScrollView release];
	
	
	NSString *title = nil;
	for (int i=0; i<[aArray count]; i++) {
		title = [aArray objectAtIndex:i];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setFrame:CGRectMake(i*(aBtnSize.width), 0, aBtnSize.width, aBtnSize.height)];
		[button setBackgroundImage:m_oUnSelectedImage forState:UIControlStateNormal];
		[button setBackgroundImage:m_oSelectedImage forState:UIControlStateSelected];
		[button setTitle:title forState:UIControlStateNormal];
		[button.titleLabel setAdjustsFontSizeToFitWidth:YES];
		[button.titleLabel setNumberOfLines:m_iButtonNumberOfLine];
		[button.titleLabel setTextAlignment:NSTextAlignmentCenter];
		[button setTag:i];
		[button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[m_oScrollView addSubview:button];
		
		[m_oButtonArray addObject:button];
	}
	
	
	return self;
}

// variable size button size scrollable
- (id)initWithFrame:(CGRect)frame items:(NSArray *)aArray enableScroll:(BOOL)aEnableScroll {
    
	if (aEnableScroll == NO) {
		return [self initWithFrame:frame items:aArray];
	}
	self = [self initWithFrame:frame];
	if (self == nil) {return nil;}
	m_isButtonEqualSize = NO;
	m_isScrollable = aEnableScroll;
    
	// Scroll View
	m_oScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
	[m_oScrollView setShowsVerticalScrollIndicator:NO];
	[m_oScrollView setShowsHorizontalScrollIndicator:NO];
	[m_oScrollView setBackgroundColor:[UIColor clearColor]];
	[self addSubview:m_oScrollView];
	[m_oScrollView release];
	
	
	NSString *title = nil;
	CGFloat rightMostPosition = 0;
	CGSize lastAddedButtonSize = CGSizeZero;
	
	for (int i=0; i<[aArray count]; i++) {
		title = [aArray objectAtIndex:i];
		lastAddedButtonSize = [title sizeWithFont:m_oButtonFont];
        
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setFrame:CGRectMake(rightMostPosition, 0, lastAddedButtonSize.width+BUTTON_DISTANCE, frame.size.height)];
		[button setBackgroundImage:m_oUnSelectedImage forState:UIControlStateNormal];
		[button setBackgroundImage:m_oSelectedImage forState:UIControlStateSelected];
		[button setTitle:title forState:UIControlStateNormal];
		[button.titleLabel setNumberOfLines:m_iButtonNumberOfLine];
		[button.titleLabel setTextAlignment:NSTextAlignmentCenter];
		[button.titleLabel setFont:m_oButtonFont];
		[button setTag:i];
		[button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[m_oScrollView addSubview:button];
		
		[m_oButtonArray addObject:button];
		
		// update for next button origin.x
		rightMostPosition += lastAddedButtonSize.width+BUTTON_DISTANCE;
	}
	
	[m_oScrollView setContentSize:CGSizeMake(rightMostPosition, frame.size.height)];
	
	[self reloadButtonSize];
	
	return self;
}

- (void)reloadText {
	if (m_isButtonEqualSize == NO) {
		[self setButtonFont:m_oButtonFont];
	}
}

- (void)dealloc {
	[m_oButtonArray release];
	[m_oButtonFont  release];
	[m_oSelectedImage  release];
	[m_oUnSelectedImage  release];
	[m_oLeftSelectedImage   release];
	[m_oLeftUnSelectedImage  release];
	[m_oRightSelectedImage  release];
	[m_oRightUnSelectedImage  release];
    [super dealloc];
}

- (void)setButtonTitle:(NSArray *)aTitleArrayInAscendingOrder {
    
    [self removeAllButton];
    
    CGFloat rightMostPosition = 0;
    CGSize lastAddedButtonSize = CGSizeZero;
    
    NSString *title = nil;
    for (int i=0; i<[aTitleArrayInAscendingOrder count]; i++) {
        title = [aTitleArrayInAscendingOrder objectAtIndex:i];
        lastAddedButtonSize = [title sizeWithFont:m_oButtonFont];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:m_oUnSelectedImage forState:UIControlStateNormal];
        [button setBackgroundImage:m_oSelectedImage forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [button.titleLabel setNumberOfLines:m_iButtonNumberOfLine];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
		[button setTitleColor:m_oSelectedButtonTitleColor forState:UIControlStateSelected];
		[button setTitleColor:m_oUnSelectButtonTitleColor forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(onButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        // set background image
        if (i==0) {
            // left most
            [button setBackgroundImage:m_oLeftSelectedImage forState:UIControlStateSelected];	
            [button setBackgroundImage:m_oLeftUnSelectedImage forState:UIControlStateNormal];
        } else if (i==[aTitleArrayInAscendingOrder count]-1) {
            // right most
            [button setBackgroundImage:m_oRightSelectedImage forState:UIControlStateSelected];	            
            [button setBackgroundImage:m_oRightUnSelectedImage forState:UIControlStateNormal];            
        } else {
            [button setBackgroundImage:m_oSelectedImage forState:UIControlStateSelected];	            
            [button setBackgroundImage:m_oUnSelectedImage forState:UIControlStateNormal];            
            
        }
        
        // set the scroll size and add it
        if (m_isScrollable) {
            [button setFrame:CGRectMake(rightMostPosition, 0, lastAddedButtonSize.width+BUTTON_DISTANCE, m_oScrollView.frame.size.height)];
            [m_oScrollView addSubview:button];
            
            // update for next button origin.x
            rightMostPosition += lastAddedButtonSize.width+BUTTON_DISTANCE;
            
        } else {
            [button setFrame:CGRectMake(i*(self.frame.size.width/[aTitleArrayInAscendingOrder count]), 0, self.frame.size.width/[aTitleArrayInAscendingOrder count], self.frame.size.height)];
            [self addSubview:button];
        }
        
        [m_oButtonArray addObject:button];
    }
    if (m_isScrollable) {
        CGFloat remainWidth = m_oScrollView.frame.size.width - rightMostPosition;
        if (remainWidth > 0) {
            // if the total width of all buttons is < scroll view, ->place the buttons evenly distributed.
            CGFloat addWidth = remainWidth/[m_oButtonArray count];
            UIButton *btn = nil;
            for ( int i=0; i<[m_oButtonArray count]; i++) {
                btn = [m_oButtonArray objectAtIndex:i];
                [btn setFrame:CGRectMake(btn.frame.origin.x + addWidth*i, btn.frame.origin.y, btn.frame.size.width+addWidth, btn.frame.size.height)];
            }
            
            [m_oScrollView setContentSize:CGSizeMake(m_oScrollView.frame.size.width, m_oScrollView.frame.size.height)];
        } else {
            [m_oScrollView setContentSize:CGSizeMake(rightMostPosition, m_oScrollView.frame.size.height)];
        }
    }
    
    if (m_iSelectedIndex >= 0 && m_iSelectedIndex < [m_oButtonArray count]) {
        UIButton *btn = [m_oButtonArray objectAtIndex:m_iSelectedIndex];
        [btn setSelected:YES];
    }
    
    [self setButtonFont:m_oButtonFont];
}

- (void)onButtonPressed:(id)sender {
	if ([sender isKindOfClass:[UIButton class]]) {
		UIButton * button = sender;
        m_iPrevSelectedIndex = m_iSelectedIndex;
		m_iSelectedIndex = button.tag;
		
		for (UIButton *btn in m_oButtonArray) {
			if ([btn isEqual:button]) {
				[btn setSelected:YES];
			} else {
				[btn setSelected:NO];
			}
		}
		
		if (m_oTarget != nil && [m_oTarget respondsToSelector:m_oSelector]) {
			[m_oTarget performSelector:m_oSelector withObject:self];
		}
	}
}

// this function makes buttons' size fit the segment size
- (void)reloadButtonSizeEvenly {
	CGSize buttonSize;
	UIButton *button;
	
	// if the sum of all the button width < the segment button width
	// make all the button evenly distrubuted
	if (m_oScrollView.contentSize.width < m_oScrollView.frame.size.width) {
		buttonSize = CGSizeMake(m_oScrollView.frame.size.width/[m_oButtonArray count], m_oScrollView.frame.size.height);
		for (int i=0; i<[m_oButtonArray count]; i++) {
			button = [m_oButtonArray objectAtIndex:i];
			[button setFrame:CGRectMake(buttonSize.width*i, 0, buttonSize.width, buttonSize.height)];
		}
		
		m_oLeftArrowButton.hidden = YES;
		m_oRightArrowButton.hidden = YES;
	}
	
	m_oLeftArrowButton.hidden = NO;
	m_oRightArrowButton.hidden = NO;
}

- (void)reloadButtonSize {
	if (m_isButtonEqualSize) { return; }
    
	UIButton *button;
	CGFloat rightMostPosition = 0;
	CGSize lastAddedButtonSize = CGSizeZero;
	NSString *buttonTitle = nil;
	
	for (button in m_oButtonArray) {
		
		// re-positioning
		buttonTitle = button.titleLabel.text;
		lastAddedButtonSize = [buttonTitle sizeWithFont:m_oButtonFont];
		
		[button setFrame:CGRectMake(rightMostPosition, 0, lastAddedButtonSize.width + BUTTON_DISTANCE, self.frame.size.height)];
		rightMostPosition += lastAddedButtonSize.width + BUTTON_DISTANCE;
	}
	
	[m_oScrollView setContentSize:CGSizeMake(rightMostPosition, self.frame.size.height)];
	
    //	[self reloadButtonSizeEvenly];
}

#pragma mark Public functions
- (void)setBackgroundImage:(UIImage *)aImage {
	m_oBackgroundImageView.image =  aImage;
}

// set the center button image
- (void)setButtonSelectedImage:(UIImage *)aImage {
	if (m_oSelectedImage) {
		[m_oSelectedImage release];
		m_oSelectedImage = nil;
	}
	m_oSelectedImage = [aImage retain];
	for (UIButton *button in m_oButtonArray) {
		[button setBackgroundImage:m_oSelectedImage forState:UIControlStateSelected];
	}
}

- (void)setButtonUnSelectedImage:(UIImage *)aImage {
	if (m_oUnSelectedImage) {
		[m_oUnSelectedImage release];
		m_oUnSelectedImage = nil;
	}
	m_oUnSelectedImage = [aImage retain];
	for (UIButton *button in m_oButtonArray) {
		[button setBackgroundImage:m_oUnSelectedImage forState:UIControlStateNormal];
	}
}

#pragma mark Left Button
- (void)setLeftButtonSelectedImage:(UIImage *)aImage {
	if (m_oLeftSelectedImage) {
		[m_oLeftSelectedImage release];
		m_oLeftSelectedImage = nil;
	}
	m_oLeftSelectedImage = [aImage retain];
	
	UIButton *leftMostButton = ([m_oButtonArray count] > 0)?[m_oButtonArray objectAtIndex:0]:nil;
	[leftMostButton setBackgroundImage:m_oLeftSelectedImage forState:UIControlStateSelected];	
}

- (void)setLeftButtonUnSelectedImage:(UIImage *)aImage {
	if (m_oLeftUnSelectedImage) {
		[m_oLeftUnSelectedImage release];
		m_oLeftUnSelectedImage = nil;
	}
	m_oLeftUnSelectedImage = [aImage retain];
	
	UIButton *leftMostButton = ([m_oButtonArray count] > 0)?[m_oButtonArray objectAtIndex:0]:nil;
	[leftMostButton setBackgroundImage:m_oLeftUnSelectedImage forState:UIControlStateNormal];
}

#pragma mark Right Button
- (void)setRightButtonSelectedImage:(UIImage *)aImage {
	if (m_oRightSelectedImage) {
		[m_oRightSelectedImage release];
		m_oRightSelectedImage = nil;
	}
	m_oRightSelectedImage = [aImage retain];
	
	UIButton *rightMostButton = ([m_oButtonArray count] > [m_oButtonArray count]-1)?[m_oButtonArray objectAtIndex:[m_oButtonArray count]-1]:nil; //[m_oButtonArray objectAtIndex:[m_oButtonArray count]-1];
	[rightMostButton setBackgroundImage:m_oRightSelectedImage forState:UIControlStateSelected];	
}

- (void)setRightButtonUnSelectedImage:(UIImage *)aImage {
	if (m_oRightUnSelectedImage) {
		[m_oRightUnSelectedImage release];
		m_oRightUnSelectedImage = nil;
	}
	m_oRightUnSelectedImage = [aImage retain];
	
	UIButton *rightMostButton = ([m_oButtonArray count] > [m_oButtonArray count]-1)?[m_oButtonArray objectAtIndex:[m_oButtonArray count]-1]:nil; //[m_oButtonArray objectAtIndex:[m_oButtonArray count]-1]; 
	[rightMostButton setBackgroundImage:m_oRightUnSelectedImage forState:UIControlStateNormal];
}

#pragma mark Other
- (void)setButtonSelectedColor:(UIColor *)aSelectedColor unselectedColor:(UIColor *)aUnselectedColor {
    
	for (UIButton *btn in m_oButtonArray) {
        if ([m_oSelectedButtonTitleColor isEqual:aSelectedColor] == NO) {
            [btn setTitleColor:aSelectedColor forState:UIControlStateSelected];
        }
        if ([m_oUnSelectButtonTitleColor isEqual:aUnselectedColor] == NO) {
            [btn setTitleColor:aUnselectedColor forState:UIControlStateNormal];
        }
	}
    
    if ([m_oSelectedButtonTitleColor isEqual:aSelectedColor] == NO) {
        @synchronized(m_oSelectedButtonTitleColor) {
            if (m_oSelectedButtonTitleColor) {
                [m_oSelectedButtonTitleColor release];
                m_oSelectedButtonTitleColor = nil;
            }
            m_oSelectedButtonTitleColor = [aSelectedColor retain];
        }
    }
    if ([m_oUnSelectButtonTitleColor isEqual:aUnselectedColor] == NO) {
        @synchronized(m_oUnSelectButtonTitleColor) {
            if (m_oUnSelectButtonTitleColor) {
                [m_oUnSelectButtonTitleColor release];
                m_oUnSelectButtonTitleColor = nil;
            }
            m_oUnSelectButtonTitleColor = [aUnselectedColor retain];
        }
    }
    
}


- (void)setShowsTouchWhenHighlighted:(BOOL)aBoolean {
	for (UIButton *button in m_oButtonArray) {
		[button setShowsTouchWhenHighlighted:aBoolean];
	}
}

- (void)addTarget:(id)aTarget action:(SEL)aSelector forControlEvents:(UIControlEvents)aControlEvents {
	m_oTarget = aTarget;
	m_oSelector = aSelector;
}

- (void)setSelectedButtonIndex:(int)aIndex {
    //	if (aIndex >= [m_oButtonArray count]) { return; }
	
	m_iSelectedIndex = aIndex;
	if (aIndex >= [m_oButtonArray count]) { return; }
    
	UIButton *btn = [m_oButtonArray objectAtIndex:aIndex];
	[self onButtonPressed:btn];
	
}

- (void)setSelectedButtonIndexDisplay:(int)aIndex {
    //	if (aIndex >= [m_oButtonArray count]) { return; }
	
	m_iSelectedIndex = aIndex;
	if (aIndex >= [m_oButtonArray count]) { return; }
    
    for (UIButton *b in m_oButtonArray) {
        [b setSelected:NO];
    }
    
	UIButton *btn = [m_oButtonArray objectAtIndex:aIndex];
    [btn setSelected:YES];
	
}

- (void)setDeselectButtonIndex {
	if (m_iSelectedIndex >= [m_oButtonArray count]) { return; }
	
	UIButton *btn = [m_oButtonArray objectAtIndex:m_iSelectedIndex];
	[btn setSelected:NO];
	
	m_iSelectedIndex = -1;
    
}

- (void)setButtonFont:(UIFont *)aFont {
    
    if ([m_oButtonFont isEqual:aFont] == NO) {
        @synchronized(m_oButtonFont) {
            if (m_oButtonFont) {
                [m_oButtonFont release];
                m_oButtonFont = nil;
            }
            m_oButtonFont = [aFont retain];
        }
    }
    
    for (UIButton *button in m_oButtonArray) {
        [button.titleLabel setFont:m_oButtonFont];
    }
    
    
	[self reloadButtonSize];
	
}

- (void)setLeftArrowImage:(UIImage *)aImage {
	m_oLeftArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[m_oLeftArrowButton setFrame:CGRectMake(0, 0, aImage.size.width, m_oScrollView.frame.size.height)];
	[m_oLeftArrowButton setBackgroundImage:aImage forState:UIControlStateNormal];
	[self addSubview:m_oLeftArrowButton];
    
	
	[m_oScrollView setFrame:CGRectMake(m_oScrollView.frame.origin.x + m_oLeftArrowButton.frame.size.width,
									   m_oScrollView.frame.origin.y,
									   m_oScrollView.frame.size.width - m_oLeftArrowButton.frame.size.width,
									   m_oScrollView.frame.size.height)];
	[m_oLeftArrowButton addTarget:self action:@selector(onLeftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];	
}

- (void)setRightArrowImage:(UIImage *)aImage {
	m_oRightArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[m_oRightArrowButton setFrame:CGRectMake(m_oScrollView.frame.size.width + m_oScrollView.frame.origin.x- aImage.size.width,
											 0,
											 aImage.size.width,
											 m_oScrollView.frame.size.height)];
	[m_oRightArrowButton setBackgroundImage:aImage forState:UIControlStateNormal];
	[self addSubview:m_oRightArrowButton];
    
	
	[m_oScrollView setFrame:CGRectMake(m_oScrollView.frame.origin.x,
									   m_oScrollView.frame.origin.y,
									   m_oScrollView.frame.size.width - m_oRightArrowButton.frame.size.width,
									   m_oScrollView.frame.size.height)];
	
	[m_oRightArrowButton addTarget:self action:@selector(onRightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onLeftButtonPressed:(id)sender {
	if (m_oScrollView.contentOffset.x > 0) {
		[m_oScrollView setContentOffset:CGPointMake(m_oScrollView.contentOffset.x - self.frame.size.width/3, 
													m_oScrollView.contentOffset.y) animated:YES];
	}
}

- (void)onRightButtonPressed:(id)sender {
	if (m_oScrollView.contentOffset.x + m_oScrollView.frame.size.width < m_oScrollView.contentSize.width) {
		[m_oScrollView setContentOffset:CGPointMake(m_oScrollView.contentOffset.x + self.frame.size.width/3, 
													m_oScrollView.contentOffset.y) animated:YES];
	}
}

// 20110926
- (void)setDisplayButton:(int)aIndex animated:(BOOL)aAnimated {
	CGPoint offset = CGPointZero;
	CGPoint curOffSet = [m_oScrollView contentOffset];
	float diffx = 0;
	UIButton *btn = nil, *lastBtn = nil;
	if (aIndex <0 || aIndex >= [m_oButtonArray count]) {
		return ;
	}
	btn = [m_oButtonArray objectAtIndex:aIndex];
	
	//if already in the view
	if (btn.frame.origin.x + btn.frame.size.width < m_oScrollView.frame.size.width ) {
		return ;
	}
	
	
	offset = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
	diffx = offset.x - curOffSet.x;
	
	// if 
	lastBtn = [m_oButtonArray lastObject];
	if (lastBtn.frame.origin.x + lastBtn.frame.size.width + diffx > m_oScrollView.contentSize.width) {
		[m_oScrollView setContentOffset:CGPointMake(m_oScrollView.contentSize.width-m_oScrollView.frame.size.width,0) animated:aAnimated];
	} else	{
		[m_oScrollView setContentOffset:offset animated:aAnimated];
	}
}

- (NSString *)getButtonTitle:(int)aIndex {
    UIButton *btn = ( 0 <= aIndex && aIndex <[m_oButtonArray count] )?[m_oButtonArray objectAtIndex:aIndex]:nil;
    return (btn)?btn.titleLabel.text:@"";
}

- (UIButton *)getButtonAtIndex:(int)aIndex  {
    return ([m_oButtonArray count] > aIndex)?[m_oButtonArray objectAtIndex:aIndex]:nil;
}

- (NSArray *)getButtonArray {
    return m_oButtonArray;
}

- (void)removeAllButton {    
    for (UIButton *btn in m_oButtonArray) {
        [btn removeFromSuperview];
    }
    [m_oButtonArray removeAllObjects];
}

@end