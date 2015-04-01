//  Created by yaojzy on 201302

#import "SideMenuUtil.h"
#import "SideMenuButton.h"

#define menu_startX 0
#define menu_width 280
#define menu_header_height 30
#define menu_item_height 70
#define menu_item_font_size 16
#define menu_item_text_x 55
#define menu_item_text_width 200

@implementation SideMenuUtil

@synthesize menu_view;
@synthesize queue;

+(SideMenuUtil*) me
{
    static SideMenuUtil* _me;

    if (!_me) {
        _me = [[SideMenuUtil alloc] init];
    }
    return _me;
}

-(id)init
{
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
		[self.queue setMaxConcurrentOperationCount:10];

        [self requestMenuDatas];
    }

    return self;
}

-(NSInteger)initMenuHeader:(UIScrollView*)menu startY:(NSInteger)startY header:(NSString*)content
{
    NSInteger pointY = startY;

    UIButton* header = [[UIButton alloc] initWithFrame:CGRectMake(menu_startX, startY, menu_width, menu_header_height)];
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, menu_width-10, menu_header_height-5)];
//    header.accessibilityLabel = [NSString stringWithFormat:@"%@",content];
    [header setAccessibilityElementsHidden:YES];
    [title setText:content];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:menu_item_font_size];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    [header addSubview:title];
	[header setBackgroundImage:[UIImage imageNamed:@"sidemenu_bg_header.png"] forState:UIControlStateNormal];
    header.userInteractionEnabled = NO;
    [menu addSubview:header];

    pointY = header.frame.origin.y + header.frame.size.height;

    return pointY;
}

-(NSInteger) initMenuItem:(UIScrollView*)menu startY:(NSInteger)startY title:(NSString*)title_text desc:(NSString*)desc_text icon:(NSString*)icon_url tag:(NSString*)tag_text
{
    NSInteger pointY = startY;

    SideMenuButton* tel =
    [[SideMenuButton alloc] initWithFrame:CGRectMake(menu_startX,
                                                     startY,
                                                     menu_width,
                                                     menu_item_height)
                                    title:title_text
                                     desc:desc_text
                                     icon:icon_url
                                      tag:tag_text];
    tel.accessibilityLabel = [NSString stringWithFormat:@"%@ \n%@",title_text,desc_text];
    BEAAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    if (delegate.openSideMenu == NO) {
        tel.accessibilityElementsHidden = YES;
    }else {
        tel.accessibilityElementsHidden = NO;
    }
    [tel addTarget:self action:@selector(sideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:tel];

    pointY = tel.frame.origin.y + tel.frame.size.height;

    return pointY;
}

-(void)initMenuViewPre:(UIScrollView*)menu
{
    self.menu_view = menu;
}

-(void)initMenuView
{
    NSInteger startY = 0;

    NSMutableArray *groups = items_data;
    NSDictionary *group;
    NSMutableArray *items;
    NSDictionary *item;
    NSString *header, *title, *desc, *icon, *tag;
    int viewsCount = [[self.menu_view subviews] count];
    for (int i=0; i<viewsCount; i++) {
        id subview = [[self.menu_view subviews] objectAtIndex:0];
//        if ([subview isKindOfClass:[SideMenuButton class]]) {
//            NSLog(@"debug initMenuView remove old item:%@", subview);
//        }
        [subview removeFromSuperview];
    }
    NSLog(@"menu_view  count %d",[[self.menu_view subviews] count]);
    
    for (int i=0; i<[groups count]; i++) {
        group = [groups objectAtIndex:i];
        header = [group objectForKey:@"header"];
        NSString *token = [group objectForKey:@"token"];
        if (![@"favourites" isEqualToString: token]) {
            continue;
        }
        startY = [self initMenuHeader:self.menu_view startY:startY header:header];
        
        items = [group objectForKey:@"items"];
        //        NSLog(@"debug init menuView group %d %@",i,header);
        for (int i=0; i<[items count]; i++) {
            item = [items objectAtIndex:i];
            title = [item objectForKey:@"name"];
            desc = [item objectForKey:@"desc"];
            icon = [item objectForKey:@"icon"];
            tag = [item objectForKey:@"token"];
            //            NSLog(@"debug initMenuView item %d :%@", i,title);
            startY = [self initMenuItem:self.menu_view startY:startY title:title desc:desc icon:icon tag:tag];
        }
        if ([@"favourites" isEqualToString: token]) {
            break;
        }
    }
    
    for (int i=0; i<[groups count]; i++) {
        group = [groups objectAtIndex:i];
        header = [group objectForKey:@"header"];
        NSString *token = [group objectForKey:@"token"];
        if ([@"favourites" isEqualToString: token]) {
            continue;
        }
        startY = [self initMenuHeader:self.menu_view startY:startY header:header];

        items = [group objectForKey:@"items"];
//        NSLog(@"debug init menuView group %d %@",i,header);
        for (int i=0; i<[items count]; i++) {
            item = [items objectAtIndex:i];
            title = [item objectForKey:@"name"];
            desc = [item objectForKey:@"desc"];
            icon = [item objectForKey:@"icon"];
            tag = [item objectForKey:@"token"];
            if ([tag isEqualToString:@"mpf"]) {//delete MPF function
                continue;
            }
//            NSLog(@"debug initMenuView item %d :%@", i,title);
            if ([tag isEqualToString: @"securitytips"]) {
                startY = [self initMenuItem:self.menu_view startY:startY title:title desc:desc icon:icon tag:tag];
                title = NSLocalizedString(@"accessibility", nil);
                desc = NSLocalizedString(@"accessibility enquiry", nil);
                icon = @"iconForAccessibility";
                tag = [NSString stringWithFormat:@"1"];
                startY = [self initMenuItem:self.menu_view startY:startY title:title desc:desc icon:icon tag:tag];
            } else {
                startY = [self initMenuItem:self.menu_view startY:startY title:title desc:desc icon:icon tag:tag];
            }
            
        }
    }
    
    CGRect frame = self.menu_view.frame;
    frame.size.width = menu_width;
    self.menu_view.frame = frame;
    self.menu_view.contentSize = CGSizeMake(menu_width, startY);

}

-(void)sideMenuButtonPressed:(UIButton*)button
{
    SideMenuButton* sideButton = (SideMenuButton*)button;
    NSLog(@"----------------token :%@", sideButton.token);
    if ([sideButton.token isEqualToString:@"sft"]) {
        button.tag = 11;
    } else if ([sideButton.token isEqualToString:@"creditcard"]) {
        
        button.tag = 0;
    } else if ([sideButton.token isEqualToString:@"mobilebanking"]) {
        button.tag = 1;
    } else if ([sideButton.token isEqualToString:@"loans"]) {
        button.tag = 6;
    } else if ([sideButton.token isEqualToString:@"hotlines"]) {
        button.tag = 8;
    } else if ([sideButton.token isEqualToString:@"privileges"]) {
        button.tag = 13;
    } else if ([sideButton.token isEqualToString:@"branchatm"]) {
        button.tag = 5;
    } else if ([sideButton.token isEqualToString:@"stocks"]) {
        button.tag = 2;
    } else if ([sideButton.token isEqualToString:@"note"]) {
        button.tag = 200;
    } else if ([sideButton.token isEqualToString:@"tt"]) {
        button.tag = 201;
    } else if ([sideButton.token isEqualToString:@"lending"]) {
        button.tag = 202;
    } else if ([sideButton.token isEqualToString:@"rates"]) {
        button.tag = 202;
    } else if ([sideButton.token isEqualToString:@"eas"]) {
        button.tag = 10;
        [CoreData sharedCoreData].bea_view_controller.fromWhere = @"EAS";
    } else if ([sideButton.token isEqualToString:@"ccp"]) {
        button.tag = 102;
        BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.isClick = YES;
    } else if ([sideButton.token isEqualToString:@"rewards"]) {
        button.tag = 103;
        BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.isClick = YES;
    } else if ([sideButton.token isEqualToString:@"ticketings"]) {
        button.tag = 104;
        BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.isClick = YES;
    } else if ([sideButton.token isEqualToString:@"easyfund"]) {
        button.tag = 101;
        BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.isClick = YES;
    } else if ([sideButton.token isEqualToString:@"dining"]) {
        button.tag = 110;
        BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.isClick = YES;
    } else if ([sideButton.token isEqualToString:@"shopping"]) {
        button.tag = 111;
        BEAAppDelegate *delegate = (BEAAppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.isClick = YES;
    }else if ([sideButton.token isEqualToString:@"facebookPages"]) {
        button.tag = 220;
    }else if ([sideButton.token isEqualToString:@"myfavourites"]) {
        button.tag = 23;
    } else if ([sideButton.token isEqualToString:@"faq"]) {
        button.tag = 24;
    } else if ([sideButton.token isEqualToString:@"securitytips"]) {
        button.tag = 25;
    } else if ([sideButton.token isEqualToString:@"mobileservices"]) {
        button.tag = 4;
    } else if ([sideButton.token isEqualToString:@"language"]) {
        button.tag = 404;
    } else if ([sideButton.token isEqualToString:@"defaultmainpage"]) {
        button.tag = 404;
    } else if ([sideButton.token isEqualToString:@"property"]) {
        button.tag = 9;
    } else if ([sideButton.token isEqualToString:@"insurance"]) {
        button.tag = 21;
    } else if ([sideButton.token isEqualToString:@"mpf"]) {
        button.tag = 12;
    }else if ([sideButton.token isEqualToString:@"funds"]) {
        button.tag = 22;
    }else if ([sideButton.token isEqualToString:@"notification"]) {
        button.tag = 404;
    } else if ([sideButton.token isEqualToString:@"game"]) {
        button.tag = 16;
    } else if ([sideButton.token isEqualToString:@"supremeGold"]) {
        button.tag = 27;
    }else if ([sideButton.token isEqualToString:@"gold"]) {
        button.tag = 203;
    }else if ([sideButton.token isEqualToString:@"1"]) {
        button.tag = 28;
    }
    NSLog(@"debug SideMenuUtil sideMenuButtonPressed: %@", sideButton.token);

//    [[CoreData sharedCoreData].bea_view_controller sideMenuButtonPressed:nil];
    [[CoreData sharedCoreData].bea_view_controller menuButtonPressed:button];
    
}

-(void)requestMenuDatas {
    NSURL* url= [NSURL URLWithString:[NSString stringWithFormat:@"%@getmenu.api?lang=%@&uptov2=true",
                                      [CoreData sharedCoreData].realServerURL,
                                      [[LangUtil me] getLangID]]];
    NSLog(@"requestMenuDatas  ： %@ ",url );
    ASIHTTPRequest* asi_request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSLog(@"debug SideMenuUtil requestMenuDatas:%@",asi_request.url);
    asi_request.delegate = self;
    [self.queue addOperation:asi_request];

	[[CoreData sharedCoreData].mask showMask];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
//	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//	NSLog(@"debug SideMenuUtil requestFinished:%@", reponsedString);

    NSXMLParser *xml_parser = [[NSXMLParser alloc] initWithData:[request responseData]];
//    NSLog(@"requestFinished  xml_parser : %@", xml_parser);
//    NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
//    NSLog(@"requestFinished  reponsedString : %@", reponsedString);
    [self writeMenuXml:[request responseData]];
    
	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];
}
- (void)writeMenuXml: (NSData *) xmlData{
    NSString *menuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [menuPath stringByAppendingPathComponent:@"menu.xml"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ( ![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    }
    [xmlData writeToFile:filePath atomically:YES];
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    [[CoreData sharedCoreData].mask hiddenMask];

	NSLog(@"debug SideMenuUtil requestFailed:%@", request.error);
   
//	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"Error downloading data",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//	[alert_view show];
//	[alert_view release];
    NSString *menuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [menuPath stringByAppendingPathComponent:@"menu.xml"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ( ![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        NSString * dataPath = [[NSBundle mainBundle] pathForResource:@"menu.xml" ofType:@""];
        
        [self writeMenuXml:[NSData dataWithContentsOfFile:dataPath]];
    }
    
    NSLog(@"filePath is %@", filePath);
    NSData *menuData = [NSData dataWithContentsOfFile:filePath];
    NSXMLParser *xmlp= [[NSXMLParser alloc] initWithData:menuData];

    NSXMLParser *xml_parser = xmlp;

	xml_parser.delegate = self;
	[xml_parser setShouldProcessNamespaces:NO];
	[xml_parser setShouldReportNamespacePrefixes:NO];
	[xml_parser setShouldResolveExternalEntities:NO];
	[xml_parser parse];
	[[CoreData sharedCoreData].mask hiddenMask];

}

-(void) parserDidStartDocument:(NSXMLParser *)parser {
	[items_data removeAllObjects];
    items_data = nil;
    items_data = [NSMutableArray new];
	key = [NSArray arrayWithObjects:
           @"token",
           @"name",
           nil];
	key_sub = [NSArray arrayWithObjects:
               @"token",
               @"icon",
               @"name",
               @"desc",
               nil];
//    NSLog(@"debug parserDidStartDocument:%@",key_sub);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
//	NSLog(@"debug parserDidEndDocument:%d outlets",[items_data count]);
	if ([items_data count]==0) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"No offer in nearby",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil];
//		[alert show];
//		[alert release];
	}
//	NSLog(@"debug parserDidEndDocument:%@",items_data);
    [self initMenuView];
    [[CoreData sharedCoreData].mask hiddenMask];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentElementName = elementName;
	if ([elementName isEqualToString:@"item"]) {
		temp_record = [NSMutableDictionary new];
        temp_groups_items = [NSMutableArray new];
        isItem = YES;
	}
	if ([elementName isEqualToString:@"subitem"]) {
		temp_record_sub = [NSMutableDictionary new];
        isSubitem = YES;
	}
    //    NSLog(@"debug didStartElement:%@",elementName);
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"parseErrorOccurred : %@", parseError);
}
-(void)fixspace:(NSMutableDictionary*)dic key:(NSString*)akey
{
    NSString* value=[dic objectForKey:akey];
//    NSLog(@"debug fixspace begin:[%@]--[%@]", akey, value);
    if (value == nil){
        value = @"";
    }
    value = [value stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    value = [value stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    if ([akey isEqualToString:@"icon"]) {
        value = [value stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
//    NSLog(@"debug fixspace end:[%@]", value);
    [dic setObject:value forKey:akey];
    return;
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:@"item"]) {
        isItem = NO;
        temp_groups_item = [NSMutableDictionary new];
        [temp_groups_item setObject:[temp_record objectForKey:@"name"] forKey:@"header"];
        [temp_groups_item setObject:[temp_record objectForKey:@"token"] forKey:@"token"];
        
        [self fixspace:temp_groups_item key:@"header"];
        [self fixspace:temp_groups_item key:@"token"];

//        NSString * oldstr = [temp_groups_item objectForKey:@"header"];
//        if (!oldstr){
//            oldstr = @"";
//        }
//        oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//
//        [temp_groups_item setObject:oldstr forKey:@"header"];
        
        [temp_groups_item setObject:temp_groups_items forKey:@"items"];
        [items_data addObject:temp_groups_item];
	}
	if ([elementName isEqualToString:@"subitem"]) {
        isSubitem = NO;
        for (int i=0; i<[key_sub count]; i++) {
            
            [self fixspace:temp_record_sub key:[key_sub objectAtIndex:i]];

//            NSString * oldstr = [temp_record_sub objectForKey:[key_sub objectAtIndex:i]];
//            if (!oldstr){
//                oldstr = @"";
//            }
//            oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//            oldstr = [oldstr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//            
//            [temp_record_sub setObject:oldstr forKey:[key_sub objectAtIndex:i]];
        }

//        NSString* icon=[temp_record_sub objectForKey:@"icon"];
//        icon = [icon stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        icon = [icon stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//        icon = [icon stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//        [temp_record_sub setObject:icon forKey:@"icon"];
        [self fixspace:temp_record_sub key:@"icon"];
       if ([@"travel" isEqualToString:[temp_record_sub objectForKey:@"token"]]) {
            return;
       }
        [temp_groups_items addObject:temp_record_sub];
	}
    //    NSLog(@"debug didEndElement:%@",elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (isSubitem) {
        for (int i=0; i<[key_sub count]; i++) {
            if ([currentElementName isEqualToString:[key_sub objectAtIndex:i]]) {
                NSString * oldstr = [temp_record_sub objectForKey:currentElementName];
                if (!oldstr){
                    oldstr = @"";
                }
                oldstr = [oldstr stringByAppendingString:string];
                [temp_record_sub setObject:oldstr forKey:currentElementName];
                //                NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
            }
        }
        //        NSLog(@"debug foundCharacters:%@",currentElementName);
    }
    else
    {
        for (int i=0; i<[key count]; i++) {
            if ([currentElementName isEqualToString:[key objectAtIndex:i]]) {
                NSString * oldstr = [temp_record objectForKey:currentElementName];
                if (!oldstr){
                    oldstr = @"";
                }
                oldstr = [oldstr stringByAppendingString:string];
                [temp_record setObject:oldstr forKey:currentElementName];
                //                NSLog(@"debug foundCharacters++++:%@ %@",currentElementName,string);
            }
        }
        //        NSLog(@"debug foundCharacters:%@",currentElementName);
    }
}

- (void) scrollToTop
{
    CGRect frame = menu_view.frame;
    frame.origin.y = 0;
    [menu_view scrollRectToVisible:frame animated:NO];
}

@end
