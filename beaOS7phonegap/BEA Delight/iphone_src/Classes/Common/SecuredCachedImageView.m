//
//  CachedImageView.m
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月12日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SecuredCachedImageView.h"


@implementation SecuredCachedImageView
@synthesize current_url;

-(void)loadImageWithURL:(NSString *)url {
	
	if ([current_url isEqualToString:url]) {
		return;
	}
	current_url = url;
	path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/ImageCache",path];
	NSFileManager *file_manager = [NSFileManager defaultManager];
	if (![file_manager fileExistsAtPath:path]) {
		[file_manager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
	}
	[file_manager release];
	path = [NSString stringWithFormat:@"%@/%@",path,[url stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
	NSData *image_data = [NSData dataWithContentsOfFile:path];
	if (image_data==nil || [image_data length]==0) {
		NSLog(@"image not in cache");
		loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		loading.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
		[self addSubview:loading];
		[loading startAnimating];
		[path retain];
		ASIHTTPRequest *asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//        [asi_request setUsername:@"iphone"];
//        [asi_request setPassword:@"iphone"];
//        [asi_request setValidatesSecureCertificate:NO];    
		asi_request.delegate = self;
		[[CoreData sharedCoreData].queue addOperation:asi_request];
/*		image_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
		[image_data writeToFile:path atomically:TRUE];*/
	} else {
		NSLog(@"image in cache");
		self.image = [UIImage imageWithData:image_data];
	}
/*
	return [super imageWithData:image_data];*/
}

+(void)clearAllCache {
	NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/ImageCache",path];
	NSFileManager *file_manager = [NSFileManager defaultManager];
	NSArray *file_list = [file_manager contentsOfDirectoryAtPath:path error:nil];
	for (int i=0; i<[file_list count]; i++) {
		NSString *filename = [NSString stringWithFormat:@"%@/%@",path,[file_list objectAtIndex:i]];
		[file_manager removeItemAtPath:filename error:nil];
	}
	[file_manager release];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"%@",path);
	NSLog(@"Finished rsp:%@", [request responseString]);    
    NSLog(@"SecuredCachedImageView >> requestFinished");
	[loading stopAnimating];
	[loading removeFromSuperview];
	[loading release];
	self.image = [UIImage imageWithData:[request responseData]];
	[[request responseData] writeToFile:path atomically:TRUE];
	[path release];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
	NSLog(@"SecuredCachedImageView requestFailed path:%@",path);
	NSLog(@"SecuredCachedImageView requestFailed:%@", [request error]);    

	[loading stopAnimating];
	[loading removeFromSuperview];
	[loading release];
    [self removeFromSuperview];

}

@end

