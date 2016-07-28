//
//  WeatherService.h
//  Weather
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weather;

@interface WeatherService : NSObject

+ (void)getWeather:(void (^)(Weather *weather))completion;

@end
