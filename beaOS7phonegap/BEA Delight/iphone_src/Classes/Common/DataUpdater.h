//
//  DataUpdater.h
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月21日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistOperator.h"
#import "ASIHTTPRequest.h"

@protocol DataUpdaterDelegate;

@interface DataUpdater : NSObject <NSXMLParserDelegate> {
	NSArray *keys;
	NSString *url, *filename, *md5url, *md5, *checksum, *new_checksum, *current_element;
	NSData *xml_data;
	ASIHTTPRequest *asi_request;
	int status, mode, request_page_size, request_page;
	NSString *request_action, *request_type, *request_category, *request_lang;
	id <DataUpdaterDelegate> delegate;

}

@property (nonatomic, assign) id <DataUpdaterDelegate> delegate;
@property (nonatomic, assign) NSArray *keys;
@property (nonatomic, assign) NSString *url, *filename;

-(id)initWithURL:(NSString *)url_input XMLFilename:(NSString *)filename_input;
-(id)initWithURL:(NSString *)url_input Keys:(NSArray *)keys_input Filename:(NSString *)filename_input;
-(void)setURL:(NSString *)url_input XMLFilename:(NSString *)filename_input;
-(void)setURL:(NSString *)url_input Keys:(NSArray *)keys_input Filename:(NSString *)filename_input;
-(void)setRequestAction:(NSString *)action Type:(NSString *)type Category:(NSString *)category PageSize:(int)page_size Page:(int)page Lang:(NSString *)lang; 
-(void)setMD5URL:(NSString *)url_md5;
-(void)updateInfo;
@end

@protocol DataUpdaterDelegate

-(void)dataUpdated:(BOOL)success;

@end

