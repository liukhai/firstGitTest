//
//  ATMUtil.m
//  BEA
//
//  Created by yaojzy on 7/26/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "ATMUtil.h"


@implementation ATMUtil

static NSLocale *gbLocale;
static NSRange gbrange;

+ (ATMUtil *)me
{
	static ATMUtil *me;
	
	@synchronized(self)
	{
		if (!me)
			me = [[ATMUtil alloc] init];
		
		return me;
	}
}

- (id)init
{
	NSLog(@"ATMUtil init");
    self = [super init];
    if (self) {
//        gbLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease];
        gbLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hant"] autorelease];
        gbrange.location = 0;
        gbrange.length = 256;
    }
    return self;
}

#pragma mark - move Main Branch to the top
+(void)moveForwardItemsByKey:(NSMutableArray *)items_data
{
    NSLog(@"moveItemsByKey begin:%d", [items_data count]);

    NSMutableArray* top_items_data = [NSMutableArray new];
    for (int i=0; i<[items_data count]; i++) {
        NSString* newtopitem = [[items_data objectAtIndex:i] objectForKey:@"newtopitem"];
        if (newtopitem!=nil && [newtopitem isEqualToString:@"1"]){
//            NSLog(@"moveItemsByKey newtopitem:%@--%@", [[items_data objectAtIndex:i] objectForKey:@"id"], [[items_data objectAtIndex:i] objectForKey:@"title"]);
            
            [top_items_data insertObject:[items_data objectAtIndex:i] atIndex:0];
            [items_data removeObjectAtIndex:i--];
        }
    }
    
    if ([top_items_data count]>0) {
        for (int i=0; i<[top_items_data count]; i++) {
            [items_data insertObject:[top_items_data objectAtIndex:i] atIndex:0];
        }
    }

    [top_items_data release];

    NSLog(@"moveItemsByKey end:%d", [items_data count]);
}

NSInteger doATMSort(id obj1, id obj2, void *context)
{
    return [[obj1 objectForKey:@"title"] compare:[obj2 objectForKey:@"title"] options:NSLiteralSearch range:gbrange locale:gbLocale];
}

-(void)sortItemsAlphabetically:(NSMutableArray *)items_data
{
//    NSLog(@"sortItemsAlphabetically begin::%d--%@", [items_data count], [[NSLocale currentLocale] localeIdentifier]);
    
    NSArray *sortedArray = [items_data sortedArrayUsingFunction:doATMSort context:NULL];

    [items_data removeAllObjects];
    [items_data addObjectsFromArray:sortedArray];	

    NSLog(@"sortItemsAlphabetically end::%d", [items_data count]);
}

-(void)stepone{
    NSLog(@"ATMUtil.stepone begin");
	request_type = @"stepone";
    ASIFormDataRequest *request = [HttpRequestUtils getPostRequest4stepone:self];
    
    [[CoreData sharedCoreData].queue addOperation:request];
}

//////////////////
//DataUpdaterDelegate
//////////////////
- (void)requestFinished:(ASIHTTPRequest *)request {
	// Use when fetching text data
	NSString* reponsedString = [NSString stringWithFormat:@"%@", [request responseString]];
	NSLog(@"ATMUtil.requestFinished rsp:%d", [reponsedString length]);
//	NSLog(@"ATMUtil.requestFinished rsp:%@", reponsedString);
	if ([request_type isEqualToString:@"stepone"]) {
		request_type = @"steptwo";
		[self checkATMListDelta:[request responseData]];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSLog(@"ATMUtil.requestFailed:%@", [request error]);
	
}

- (void) checkATMListDelta:(NSData*)datas{
	NSString *ns_temp_file = [MBKUtil getDocTempFilePath];
//	NSLog(@"ATMUtil.checkATMListDelta:<rsp>%@</rsp>", datas);
	[datas writeToFile:ns_temp_file atomically:YES];
	
    NSMutableDictionary *md_temp = [NSMutableDictionary dictionaryWithContentsOfFile:ns_temp_file];
//	NSLog(@"ATMUtil.dict:%d", [md_temp count]);
	NSString * atmlist_sn = [md_temp objectForKey:@"SN"];
	NSLog(@"ATMUtil.checkATMListDelta:<new>%@</new>--<old>%@</old>", atmlist_sn, [[MBKUtil me] getATMListSNFromLocal]);
	if (atmlist_sn==nil || [atmlist_sn isEqualToString:@""] || [atmlist_sn isEqualToString:[[MBKUtil me] getATMListSNFromLocal]]){
	}else {
		NSArray *rsp_atmlist = [md_temp objectForKey:@"atmlist"];
		NSDictionary *rsp_item;
		NSString *expire;
		NSString *item_id;
		NSString *item_id_old;
		if (atmlist_sn!=nil && ![atmlist_sn isEqualToString:@""]){
			NSMutableDictionary *old_atmplist = [NSMutableDictionary dictionaryWithContentsOfFile:[[MBKUtil me] getDocATMplistPath]];
			NSMutableArray *old_atmlist = [old_atmplist objectForKey:@"atmlist"];
			if (old_atmlist==nil || [old_atmlist count]<=0) {
				old_atmlist = [NSMutableArray new];
			}
//			NSLog(@"delta all:%@--<rsp>%d---<old>%d", [[MBKUtil me] getDocATMplistPath], [rsp_atmlist count], [old_atmlist count]);
			
			NSDictionary *old_item;
			BOOL isExistRecord = FALSE;
			int index_process = 0;
			
			for (int i=0; i<[rsp_atmlist count]; i++) {
				rsp_item = [rsp_atmlist objectAtIndex:i];
				expire = [rsp_item objectForKey:@"expire"];
				item_id = [rsp_item objectForKey:@"id"];
				isExistRecord = FALSE;
				//index_process = 0;
				old_item = nil;
				item_id_old = nil;
				
//				NSLog(@"ATMUtil.searching...:%@--%@", [rsp_item objectForKey:@"id"], [rsp_item objectForKey:@"title"]);
				
				for (index_process=0; index_process<[old_atmlist count]; index_process++) {
					old_item = [old_atmlist objectAtIndex:index_process];
					item_id_old = [old_item objectForKey:@"id"];
					if ([item_id isEqualToString:item_id_old]){
						isExistRecord = TRUE;
						break;
					}
				}
				
//				NSLog(@"ATMUtil.searched:%d--%d", index_process, isExistRecord);
				
				if (isExistRecord) {
					[old_atmlist removeObjectAtIndex:index_process];
//					NSLog(@"ATMUtil.delete:%d", index_process);
					if (![expire isEqualToString:@"1"]){//edit
						[old_atmlist insertObject:rsp_item atIndex:index_process];
//						NSLog(@"ATMUtil.add:%d--%@", [old_atmlist count], rsp_item);
					}else {//delete
					}
				}else {
					[old_atmlist insertObject:rsp_item atIndex:index_process];
//					NSLog(@"ATMUtil.add:%d--%@", [old_atmlist count], rsp_item);
				}
				
			}
			
//			NSLog(@"ATMUtil.delta old:%d", [old_atmlist count]);
			
            //			if ([old_atmlist count]<1) {
            //				old_item = [NSDictionary dictionaryWithObject:@"0" forKey:@"id"];
            //				[old_atmlist insertObject:old_item atIndex:0];
            //			}
			
			NSMutableDictionary *updated_atm_plist = [NSMutableDictionary new];
			[updated_atm_plist setObject:atmlist_sn forKey:@"SN"];
			[updated_atm_plist setObject:old_atmlist forKey:@"atmlist"];
			[updated_atm_plist writeToFile:[[MBKUtil me] getDocATMplistPath] atomically:YES];
            [updated_atm_plist release];
		}
	}
	[[NSFileManager defaultManager] removeItemAtPath:ns_temp_file error:nil];
}


@end
