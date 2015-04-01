
#import "sCachedImageView.h"
#import "SideMenuUtil.h"


@implementation sCachedImageView
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
    //    NSLog(@"debug sCachedImageView loadImageWithURL path:%@", path);
	NSData *image_data = [NSData dataWithContentsOfFile:path];
	if (image_data==nil || [image_data length]==0) {
        //NSLog(@"debug sCachedImageView image not in cache");
//        if ([self IsEnableIntent]) {
            loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            loading.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
            [self addSubview:loading];
            [loading startAnimating];
            [path retain];
        
            ASIHTTPRequest *asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
            asi_request.delegate = self;
            [asi_request setTimeOutSeconds:5.0];
            [[SideMenuUtil me].queue addOperation:asi_request];
            /*		image_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
             [image_data writeToFile:path atomically:TRUE];*/
//        }else{
//            self.image = [UIImage imageNamed:@"btn_back.png"];
//            
//            }

	} else {
        //NSLog(@"debug sCachedImageView image in cache");
		self.image = [UIImage imageWithData:image_data];
	}
    /*
     return [super imageWithData:image_data];*/
}
/*
 不清除的图片
 */
-(void)loadImageWithURLPermanent:(NSString *)url {
    
    if ([url isEqualToString:@"iconForAccessibility"]) {
        self.image = [UIImage imageNamed:@"accessibility_site map icon.png"];
        return;
    }
    
	if ([current_url isEqualToString:url]) {
		return;
	}
	current_url = url;
	path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE) objectAtIndex:0];
	path = [NSString stringWithFormat:@"%@/ImageCachePermanent",path];
	NSFileManager *file_manager = [NSFileManager defaultManager];
	if (![file_manager fileExistsAtPath:path]) {
		[file_manager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
	}
	[file_manager release];
	path = [NSString stringWithFormat:@"%@/%@",path,[url stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    //    NSLog(@"debug sCachedImageView loadImageWithURL path:%@", path);
	NSData *image_data = [NSData dataWithContentsOfFile:path];
	if (image_data==nil || [image_data length]==0) {
        //NSLog(@"debug sCachedImageView image not in cache");
        //        if ([self IsEnableIntent]) {
        loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loading.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:loading];
        [loading startAnimating];
        [path retain];
        
        ASIHTTPRequest *asi_request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
        asi_request.delegate = self;
        [asi_request setTimeOutSeconds:5.0];
        [[SideMenuUtil me].queue addOperation:asi_request];
        /*		image_data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
         [image_data writeToFile:path atomically:TRUE];*/
        //        }else{
        //            self.image = [UIImage imageNamed:@"btn_back.png"];
        //
        //            }
        
	} else {
        //NSLog(@"debug sCachedImageView image in cache");
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
//    NSLog(@"debug sCachedImageView requestFinished path:%@",path);
	[loading stopAnimating];
	[loading removeFromSuperview];
	[loading release];
	self.image = [UIImage imageWithData:[request responseData]];
	[[request responseData] writeToFile:path atomically:TRUE];
	[path release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [loading stopAnimating];
	[loading removeFromSuperview];
	[loading release];
     self.image = [UIImage imageNamed:@"default_images_2.png"];
}

@end

