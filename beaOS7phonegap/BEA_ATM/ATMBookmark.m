//
//  ATMBookmark.m
//  BEA Surprise
//
//  Created by Algebra Lo on 10年3月25日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ATMBookmark.h"


@implementation ATMBookmark

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
		NSLog(@"ATMBookmart init");
		data = [[NSMutableDictionary dictionaryWithDictionary:[PlistOperator openPlistFile:@"ATMbookmark" Datatype:@"NSDictionary"]] retain];
		if (data==nil || [data count]==0) {
			NSLog(@"ATMBookmart init Create bookmark");
			NSMutableArray *data_atm = [NSMutableArray new];
			[data setValue:data_atm forKey:@"ATM"];
			[PlistOperator savePlistFile:@"ATMbookmark" From:data];
		}
	}
	return self;
}

-(void) dealloc {
	[data release];
	[super dealloc];
}

-(void)addBookmark:(NSDictionary *)bookmark ToGroup:(int)group {
	NSLog(@"ATMBookmark addBookmark:%@--%d", bookmark, group);
	if (![self isOfferExist:bookmark InGroup:group]) {
		NSLog(@"ATMBookmark addBookmark:ATMBookmark not exist");
		NSMutableArray *temp_offer;
		NSMutableDictionary *temp_record;
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"d MMM, yyyy"];
		
		NSDate *add_date = [NSDate date];
		
		temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"ATM"]];
		temp_record = [NSMutableDictionary new];
		[temp_record setValue:[bookmark objectForKey:@"id"] forKey:@"id"];
		[temp_record setValue:add_date forKey:@"add_date"];
		[temp_offer insertObject:temp_record atIndex:0];
		[data setValue:temp_offer forKey:@"ATM"];
		
		[PlistOperator savePlistFile:@"ATMbookmark" From:data];
	}
}

-(void)removeBookmark:(NSDictionary *)bookmark InGroup:(int)group {
	NSLog(@"Check bookmark to remove");
	NSMutableArray *temp_offer;
	for (int i=0; i<[[data objectForKey:@"ATM"] count]; i++) {
		if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"ATM"] objectAtIndex:i] objectForKey:@"id"]]) {
			temp_offer = [NSMutableArray arrayWithArray:[data objectForKey:@"ATM"]];
			[temp_offer removeObjectAtIndex:i];
			[data setValue:temp_offer forKey:@"ATM"];
			break;
		}
	}
	[PlistOperator savePlistFile:@"ATMbookmark" From:data];
}

-(BOOL)isOfferExist:(NSDictionary *)bookmark InGroup:(int)group {
	NSLog(@"ATMBookmark isOfferExist:%@", bookmark);
	for (int i=0; i<[[data objectForKey:@"ATM"] count]; i++) {
		if ([[bookmark objectForKey:@"id"] isEqualToString:[[[data objectForKey:@"ATM"] objectAtIndex:i] objectForKey:@"id"]]) {
			return TRUE;
		}
	}
	return FALSE;
}

-(NSString *)listOfferIdInGroup:(int)group {
	NSArray *list;
	int i;
	NSMutableString *result = [NSMutableString new];
	list = [data objectForKey:@"ATM"];
	for (i=0; i<[list count]; i++) {
		[result appendString:[[list objectAtIndex:i] objectForKey:@"id"]];
		if (i<[list count]-1) {
			[result appendString:@","];
		}
	}
	return result;
}

@end
