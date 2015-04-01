//
//  Bookmark.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Bookmark.h"


@implementation Bookmark

+(void)removeExpiredBookmark {
	/*	NSMutableDictionary *bookmark = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"bookmark" Datatype:@"NSDictionary"]] retain];
	 if (bookmark==nil || [bookmark count]==0) {
	 return;
	 }
	 for (int i=[[bookmark objectForKey:@"offer"] count]-1; i>=0; i--) {
	 NSDate *expire = [[[bookmark objectForKey:@"offer"] objectAtIndex:i] objectForKey:@"expire"];
	 if ([expire compare:[NSDate date]]==NSOrderedAscending) {
	 [[bookmark objectForKey:@"offer"] removeObjectAtIndex:i];
	 }
	 }
	 for (int i=[[bookmark objectForKey:@"tactical"] count]-1; i>=0; i--) {
	 NSDate *expire = [[[bookmark objectForKey:@"tactical"] objectAtIndex:i] objectForKey:@"expire"];
	 if ([expire compare:[NSDate date]]==NSOrderedAscending) {
	 [[bookmark objectForKey:@"tactical"] removeObjectAtIndex:i];
	 }
	 }
	 [PlistOperator savePlistFile:@"bookmark" From:bookmark];*/
}

-(id)init {
	if (self=[super init]) {
//		NSLog(@"Get bookmark");
		data = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"bookmark" Datatype:@"NSDictionary"]] retain];
		if (data==nil || [data count]==0) {
			NSLog(@"Create bookmark");
			data = [NSMutableDictionary new];
			NSMutableArray *data_atm = [NSMutableArray new];
			[data setValue:data_atm forKey:@"ATM"];
			NSMutableArray *data_pri = [NSMutableArray new];
			[data setValue:data_pri forKey:@"PRI"];
			NSMutableArray *data_yro = [NSMutableArray new];
			[data setValue:data_yro forKey:@"YRO"];
			NSMutableArray *data_qs = [NSMutableArray new];
			[data setValue:data_qs forKey:@"QS"];
			NSMutableArray *data_lp = [NSMutableArray new];
			[data setValue:data_lp forKey:@"LP"];
			NSMutableArray *data_sar = [NSMutableArray new];
			[data setValue:data_sar forKey:@"SAR"];
			NSMutableArray *data_pbc = [NSMutableArray new];
			[data setValue:data_pbc forKey:@"PBC"];
			NSMutableArray *data_gpo = [NSMutableArray new];
			[data setValue:data_gpo forKey:@"GPO"];
            NSMutableArray *data_loan = [NSMutableArray new];
            [data setValue:data_loan forKey:@"CL"];         //modify Bookmark category: To be rested   CL: Consumer Loans
            NSMutableArray *data_gold = [NSMutableArray new];
            [data setValue:data_gold forKey:@"SG"];
			[PlistOperator savePlistFile:@"bookmark" From:data];
		}
	}
//    NSLog(@"Get bookmark end:%@", data);
	return self;
}

-(void) dealloc {
	[data release];
	[super dealloc];
}

-(void)addBookmark:(NSDictionary *)bookmark ToGroup:(int)group {
	NSLog(@"Add bookmark:%@--%d", bookmark, group);
	if (![self isOfferExist:bookmark InGroup:group]) {
		NSLog(@"Bookmark not exist");
		NSMutableArray *temp_offer;
		NSMutableDictionary *temp_record;
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"d MMM, yyyy"];
		
		NSDate *add_date = [NSDate date];
		
		switch (group) {
			case 0:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"ATM"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"ATM"];
				break;
			case 1:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"PRI"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"PRI"];
				break;
			case 2:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"YRO"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"YRO"];
				break;
			case 3:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"QS"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"QS"];
				break;
			case 4:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"LP"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"LP"];
				break;
			case 5:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"SAR"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"SAR"];
				break;
			case 6:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"PBC"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"PBC"];
				break;
			case 7:
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"GPO"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"GPO"];
				break;
            case 8:         //modify Bookmark category: To be rested   CL: Consumer Loans
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"CL"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"CL"];
				break;
            case 9:         //modify Bookmark category: To be rested   SG: Supreme Gold
				temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"SG"]];
				temp_record = [NSMutableDictionary new];
				[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
				[temp_record setValue:add_date forKey:@"add_date"];
				[temp_offer insertObject:temp_record atIndex:0];
				[data setValue:temp_offer forKey:@"SG"];
				break;
		}
        NSLog(@"Add bookmark end:%@", data);
		[PlistOperator savePlistFile:@"bookmark" From:data];
	}
}

-(void)removeBookmark:(NSDictionary *)bookmark InGroup:(int)group {
	NSLog(@"Check bookmark to remove bookmark:%@", bookmark);
	NSLog(@"Check bookmark to remove:%@", data);
	NSMutableArray *temp_offer;
	switch (group) {
		case 0:
			for (int i=0; i<[[data objectForKey:@"ATM"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"ATM"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"ATM"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"ATM"];
					break;
				}
			}
			break;
		case 1:
			for (int i=0; i<[[data objectForKey:@"PRI"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"PRI"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"PRI"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"PRI"];
					break;
				}
			}
			break;
		case 2:
			for (int i=0; i<[[data objectForKey:@"YRO"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"YRO"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"YRO"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"YRO"];
					break;
				}
			}
			break;
		case 3:
			for (int i=0; i<[[data objectForKey:@"QS"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"QS"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"QS"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"QS"];
					break;
				}
			}
			break;
		case 4:
			for (int i=0; i<[[data objectForKey:@"LP"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"LP"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"LP"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"LP"];
					break;
				}
			}
			break;
		case 5:
			for (int i=0; i<[[data objectForKey:@"SAR"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"SAR"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"SAR"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"SAR"];
					break;
				}
			}
			break;
		case 6:
			for (int i=0; i<[[data objectForKey:@"PBC"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"PBC"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"PBC"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"PBC"];
					break;
				}
			}
			break;
		case 7:
			for (int i=0; i<[[data objectForKey:@"GPO"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"GPO"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"GPO"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"GPO"];
					break;
				}
			}
        case 8:    // CL: Consumer Loans
			for (int i=0; i<[[data objectForKey:@"CL"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"CL"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"CL"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"CL"];
					break;
				}
			}
        case 9:    // SG: Supreme Gold
			for (int i=0; i<[[data objectForKey:@"SG"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"SG"] objectAtIndex:i] objectForKey:@"id"]]) {
					temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"SG"]];
					[temp_offer removeObjectAtIndex:i];
					[data setValue:temp_offer forKey:@"SG"];
					break;
				}
			}
	}
	[PlistOperator savePlistFile:@"bookmark" From:data];
}

-(BOOL)isOfferExist:(NSDictionary *)bookmark InGroup:(int)group {
//	NSLog(@"Check bookmark isOfferExist:%@", data);
	switch (group) {
		case 0:
			for (int i=0; i<[[data objectForKey:@"ATM"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"ATM"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 1:
			for (int i=0; i<[[data objectForKey:@"PRI"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"PRI"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 2:
			for (int i=0; i<[[data objectForKey:@"YRO"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"YRO"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 3:
			for (int i=0; i<[[data objectForKey:@"QS"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"QS"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 4:
			for (int i=0; i<[[data objectForKey:@"LP"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"LP"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 5:
			for (int i=0; i<[[data objectForKey:@"SAR"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"SAR"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 6:
			for (int i=0; i<[[data objectForKey:@"PBC"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"PBC"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
		case 7:
			for (int i=0; i<[[data objectForKey:@"GPO"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"GPO"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
        case 8:
			for (int i=0; i<[[data objectForKey:@"CL"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"CL"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
        case 9:
			for (int i=0; i<[[data objectForKey:@"SG"] count]; i++) {
				if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"SG"] objectAtIndex:i] objectForKey:@"id"]]) {
					return TRUE;
				}
			}
			break;
	}
	return FALSE;
}

-(NSString *)listOfferIdInGroup:(int)group {
	NSArray *list;
	int i;
	NSMutableString *result = [NSMutableString new];
//    NSLog(@"debug Bookmark listOfferIdInGroup result 1:%@", result);

	switch (group) {
		case 0:
			list = [data objectForKey:@"ATM"];
            NSLog(@"debug Bookmark listOfferIdInGroup list 0:%@", list);

			for (i=0; i<[list count]; i++) {
                NSLog(@"debug Bookmark listOfferIdInGroup list 0:%@", [list objectAtIndex:i]);
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 1:
			list = [data objectForKey:@"PRI"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 1:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 2:
			list = [data objectForKey:@"YRO"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 2:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 3:
			list = [data objectForKey:@"QS"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 3:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 4:
			list = [data objectForKey:@"LP"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 4:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 5:
			list = [data objectForKey:@"SAR"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 5:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 6:
			list = [data objectForKey:@"PBC"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 6:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
		case 7:
			list = [data objectForKey:@"GPO"];
//            NSLog(@"debug Bookmark listOfferIdInGroup list 7:%@", list);

			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
        case 8:
			list = [data objectForKey:@"CL"];
            //            NSLog(@"debug Bookmark listOfferIdInGroup list 7:%@", list);
            
			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;
        case 9:
			list = [data objectForKey:@"SG"];
            //            NSLog(@"debug Bookmark listOfferIdInGroup list 7:%@", list);
            
			for (i=0; i<[list count]; i++) {
				[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
				if (i<[list count]-1) {
					[result appendString:@","];
				}
			}
			break;

	}
    NSLog(@"debug Bookmark listOfferIdInGroup:%d--%@", group, result);
	return result;
}

- (NSMutableDictionary *)getBookmarkData
{
    return data;
}
@end
