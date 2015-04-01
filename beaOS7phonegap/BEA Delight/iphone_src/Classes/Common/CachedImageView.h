//
//  CachedImageView.h
//  Citibank Card Offer
//
//  Created by Algebra Lo on 10年3月12日.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "CoreData.h"

@interface CachedImageView : UIImageView {
	NSString *path, *current_url;
	UIActivityIndicatorView *loading;
}
@property (nonatomic, assign) NSString *current_url;
-(void)loadImageWithURL:(NSString *)url;
+(void)clearAllCache;
@end
