//  Created by yaojzy on 201302

#import <Foundation/Foundation.h>
#import "CoreData.h"

@interface SideMenuUtil : NSObject
<ASIHTTPRequestDelegate, NSXMLParserDelegate>
{
	NSMutableArray *items_data;
	NSArray *key;
	NSArray *key_sub;
	NSString *currentAction, *currentElementName, *currentElementValue;
	NSMutableDictionary *temp_record;
	NSMutableDictionary *temp_record_sub;
    BOOL isItem;
    BOOL isSubitem;
    UIScrollView*   menu_view;

	NSMutableArray *temp_groups;
	NSMutableArray *temp_groups_items;
	NSMutableDictionary *temp_groups_item;
	NSMutableDictionary *temp_groups_item_sub;
	NSOperationQueue *queue;
}
@property (nonatomic, retain) NSOperationQueue *queue;

@property(nonatomic, retain) UIScrollView* menu_view;

+(SideMenuUtil*) me;

-(void)initMenuViewPre:(UIScrollView*)menu;
-(void)initMenuView;
-(void)requestMenuDatas;
-(void)scrollToTop;

@end
