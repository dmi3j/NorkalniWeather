//
//  TodayViewController.m
//  Norkalni Weather
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <WeatherFramework/Weather.h>
#import <WeatherFramework/WeatherService.h>

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionImage;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self updateWeather];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)margins {
    margins.bottom = 10.0;
    return margins;
}

-(void)updateWeather {

    [WeatherService getWeather:^(Weather *weather) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageDate = [NSData dataWithContentsOfURL:[NSURL URLWithString:weather.iconDownloadPath]];
            UIImage *weatherImage = [UIImage imageWithData:imageDate];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.conditionImage.image = weatherImage;
            });
        });

        dispatch_async(dispatch_get_main_queue(), ^{
            self.temperatureLabel.text = weather.localizedTemperature;
            self.conditionLabel.text = weather.localizedCondition;

        });
    }];
}

@end
