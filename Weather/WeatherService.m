//
//  WeatherService.m
//  Weather
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "WeatherService.h"

#import "Weather.h"

@implementation WeatherService

+ (void)getWeather:(void (^)(Weather *weather))completion
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/weather?lat=56.955796&lon=24.586300&appid=76af6f8b0bf2eeb13a8f4881515722df&units=metric&lang=ru"]
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", json);
            Weather *weather = [[Weather alloc] initWithDictionary:json];
            completion(weather);
        } else {
            completion(nil);
        }
    }];
    [dataTask resume];
}

@end
