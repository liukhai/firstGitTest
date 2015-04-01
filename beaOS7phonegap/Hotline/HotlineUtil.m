//
//  HotlineUtil.m
//  BEA
//
//  Created by yelong on 3/3/11.
//  Copyright 2011 The Bank of East Asia, Limited. All rights reserved.
//

#import "HotlineUtil.h"
#import "LangUtil.h"

@implementation HotlineUtil

@synthesize hotline;
@synthesize mvflag2;

static HotlineUtil* _me=nil;

+(HotlineUtil*) me
{
    if (!_me) {
        _me = [[HotlineUtil alloc] init];
    }
    return _me;
}

-(id) init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)increaseMvflag2{
	int li_count = [self.mvflag2 intValue];
	li_count++;
	self.mvflag2 = [NSNumber numberWithInt:li_count];
}

- (NSString *)getDocHotlinePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Hotlines.xml"];

	return filePath;
}

- (NSString*) getHotlineSNFromLocal{
	NSMutableDictionary *atmplistDict = [NSMutableDictionary dictionaryWithContentsOfFile:[[HotlineUtil me] getDocHotlinePath]];
	NSString *localhotlineSN = [atmplistDict objectForKey:@"SN"];
	return localhotlineSN;
}

- (void)dealloc {
	[hotline release];
    [super dealloc];
}

-(void) call: (NSString *)num{
	hotline = [[NSString alloc] initWithString:num];
    hotline = [hotline stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    hotline = [hotline stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSLog(@"debug call:[%@]", hotline);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:hotline message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) call:(NSString *)num
        name:(NSString*)name
{
	hotline = [[NSString alloc] initWithString:num];
    hotline = [hotline stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    hotline = [hotline stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    NSLog(@"debug call name:[%@]--[%@]", hotline, name);

	UIAlertView *alert_view = [[UIAlertView alloc] initWithTitle:name message:hotline delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Call",nil),nil];
	[alert_view show];
	[alert_view release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex==1) {
        NSURL *telno = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[hotline stringByReplacingOccurrencesOfString:@" " withString:@""]]];
		NSLog(@"hotline Call %@",telno);
		[[UIApplication sharedApplication] openURL:telno];
	}
}

@end
