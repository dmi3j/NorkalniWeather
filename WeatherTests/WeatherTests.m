//
//  WeatherTests.m
//  WeatherTests
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherService.h"
#import "Weather.h"

@interface WeatherTests : XCTestCase

@end

@implementation WeatherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    [WeatherService getWeather:^(Weather *weather) {
        XCTAssert(weather.localizedCondition.length > 0, @"No weather condition received");
        XCTAssert(weather.localizedTemperature.length > 0, @"No weather temperature received");
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
