//
//  ViewControllerDirectorParameter.m
//  MegaHub
//
//  Created by Hong on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewControllerDirectorParameter.h"


@implementation ViewControllerDirectorParameter

@synthesize m_iViewControllerID;
@synthesize m_iInt0;
@synthesize m_iInt1;
@synthesize m_iInt2;
@synthesize m_fFloat0;
@synthesize m_fFloat1;
@synthesize m_fFloat2;
@synthesize m_sString0;
@synthesize m_sString1;
@synthesize m_sString2;
@synthesize m_oArray;
@synthesize m_oObject;
@synthesize m_oObject0;
@synthesize m_oObject1;
@synthesize m_oObject2;


- (id)init {
	self = [super init];
	if (self == nil) {return nil;}
	
	m_oArray = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)dealloc {
	
	[m_sString0 release];
	[m_sString1 release];
	[m_sString2 release];
	[m_oArray release];
	[m_oObject release];
	[m_oObject0 release];
	[m_oObject1 release];
	[m_oObject2 release];
	[super dealloc];
}

@end
