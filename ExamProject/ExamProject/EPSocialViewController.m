//
//  EPSocialViewController.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPSocialViewController.h"
#import <Twitter/Twitter.h>
#import "EPWeatherModel.h"

@interface EPSocialViewController ()

@property (nonatomic, retain) UIButton* twitterButton;

@end

@implementation EPSocialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.twitterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.twitterButton.frame = CGRectMake(self.view.frame.size.width / 2 - 100, 330 , 200, 30);
    [self.twitterButton setTitle:@"Send Twitter message" forState:UIControlStateNormal];
    [self.twitterButton addTarget:self action:@selector(twitterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.twitterButton];
}

- (void)twitterButtonClicked
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ %@ %@ %@ %@", [EPWeatherModel share].weatherDictionary[kDate]
                                                                                , [EPWeatherModel share].weatherDictionary[kLat]
                                                                                , [EPWeatherModel share].weatherDictionary[kLon]
                                                                                , [EPWeatherModel share].weatherDictionary[kTempMaxC]
                                                                                , [EPWeatherModel share].weatherDictionary[kTempMinC]
        ]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

-(void)unload
{
    self.twitterButton = nil;
}

-(void)viewDidUnload
{
    [self unload];
    [super viewDidUnload];
}

-(void)dealloc
{
    [self unload];
    [super dealloc];
}

@end