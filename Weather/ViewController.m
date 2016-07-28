//
//  ViewController.m
//  Weather
//
//  Created by Dmitrijs Beloborodovs on 28/07/16.
//  Copyright © 2016 Dmitry Beloborodov. All rights reserved.
//

#import "ViewController.h"

#import "Weather.h"
#import "WeatherService.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *conditionImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self refreshData];

    UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc]
                                                         initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-50);
    verticalMotionEffect.maximumRelativeValue = @(50);

    UIInterpolatingMotionEffect *horizontalMotionEffect =[[UIInterpolatingMotionEffect alloc]
                                                          initWithKeyPath:@"center.x"
                                                          type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);

    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];

    [self.backgroundImageView addMotionEffect:group];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshButtonPressed:(UIButton *)sender {
    [self refreshData];
}

- (void)refreshData{
    self.refreshButton.hidden = YES;
    [self.activityIndicator startAnimating];

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

            self.refreshButton.hidden = NO;
            [self.activityIndicator stopAnimating];
        });
    }];
}

@end