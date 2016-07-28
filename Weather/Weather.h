//
//  Weather.h
//  Weather
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)weatherDictionary;

@property (nonatomic, copy) NSString *localizedCondition;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, copy) NSString *iconName;

@property (nonatomic, readonly) NSString *localizedTemperature;
@property (nonatomic, readonly) NSString *iconDownloadPath;

@end
