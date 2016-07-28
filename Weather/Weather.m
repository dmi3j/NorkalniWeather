//
//  Weather.m
//  Weather
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "Weather.h"

@interface Weather ()

@property (nonatomic, strong) NSNumberFormatter *temperatureFormatter;

@end

@implementation Weather

- (instancetype)initWithDictionary:(NSDictionary *)weatherDictionary
{
    if (self = [super init]) {
        self.localizedCondition = [[[weatherDictionary objectForKey:@"weather"] firstObject] objectForKey:@"description"];
        self.temperature = [NSNumber numberWithFloat:[[[weatherDictionary objectForKey:@"main"] objectForKey:@"temp"] floatValue]];
        self.iconName = [[[weatherDictionary objectForKey:@"weather"] firstObject] objectForKey:@"icon"];
    }
    return self;
}

- (NSNumberFormatter *)temperatureFormatter
{
    if (_temperatureFormatter == nil) {
        _temperatureFormatter = [[NSNumberFormatter alloc] init];
        _temperatureFormatter.maximumFractionDigits = 1;
        _temperatureFormatter.minimumFractionDigits = 1;
    }
    return _temperatureFormatter;
}

- (NSString *)localizedTemperature
{
    return [self.temperatureFormatter stringFromNumber:self.temperature];
}

- (NSString *)iconDownloadPath
{
    return [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", self.iconName];
}

@end
