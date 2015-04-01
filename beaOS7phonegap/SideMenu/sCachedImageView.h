#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "CoreData.h"

@interface sCachedImageView : UIImageView {
	NSString *path, *current_url;
	UIActivityIndicatorView *loading;
}
@property (nonatomic, assign) NSString *current_url;
-(void)loadImageWithURL:(NSString *)url;
-(void)loadImageWithURLPermanent:(NSString *)url;
+(void)clearAllCache;
@end
