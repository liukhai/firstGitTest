//
//  LangUtilTests.m
//  LangUtilTests
//
//  Created by Yilia on 14-6-16.
//  Copyright (c) 2014年 Yilia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LangUtil.h"

@interface LangUtilTests : XCTestCase

@end

@implementation LangUtilTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
   
    NSLog(@"%@", [[LangUtil me] getLanguage]) ;
}

@end
