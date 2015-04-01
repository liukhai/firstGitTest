//
//  MHSubmenu.h
//  MagicTrader
//
//  Created by Megahub on 10/03/2011.
//  Copyright 2011 MegaHub Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MHReorderViewController.h"


@protocol MHSubmenuDelegate
- (void)MHSubmenuDelegateCallback:(NSNumber *)aSubmenuNumberCode;
@end

@interface MHSubmenu : UIView <UIScrollViewDelegate>{
	int							m_iModuleId;
	id<MHSubmenuDelegate>		m_idDelegate;
	
	//user for generation the submenu
	UIScrollView				*m_oScrollView;
	NSMutableArray				*m_oSubmenuItemArray; //store what information inside the submenu
	
	UIImageView					*m_oLeftArrowImageView;
	UIImageView					*m_oRightArrowImageView;
	
	UIImageView					*m_oBackgroundImageView;
}
@property (nonatomic, assign) id m_idDelegate;
@property (nonatomic, retain) NSMutableArray *m_oSubmenuItemArray;

- (id)initWithFrame:(CGRect)frame;
- (void)dealloc;
- (void)reloadText;

-(void)removeSubmenuItem:(int)aSubmenuId;
-(void)removeAllSubmenuItems;

-(void)loadReorderSequence:(int)aModuleId;
- (void)loadModule:(int)aModuleId;
- (void)updateUI;

-(void)clearAllSelected;
-(void)setDisableSubmenu:(int)aSubmenuId;
-(void)setSelectedSubmenu:(int)aSubmenuId;
-(void)onSubmenuItemIsClicked:(id)sender;
-(void)MHReorderViewControllerDelegateCallback:(id)aSender;


@end

