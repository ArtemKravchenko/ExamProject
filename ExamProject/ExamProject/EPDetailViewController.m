//
//  EPDetailViewController.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPDetailViewController.h"
#import "EPWeatherTableViewController.h"
#import "EPWeatherModel.h"
#import "EPSocialViewController.h"

@interface EPDetailViewController ()

@property (nonatomic, retain) EPWeatherTableViewController* weatherTableViewController;
@property (nonatomic, retain) UIImageView* iconView;
@property (nonatomic, retain) UIButton* addToFavorites;

@end

@implementation EPDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[EPWeatherModel share].weatherDictionary[kIcon]]]]];
    CGRect frame = CGRectMake(self.view.frame.size.width / 2 - 25, 0, 50, 50);
    self.iconView.frame = frame;
    
    [self.view addSubview:self.iconView];
    
    self.weatherTableViewController = [[EPWeatherTableViewController new] autorelease];
    frame = CGRectMake(0, self.iconView.frame.size.height, 320, 460 - self.iconView.frame.size.height - 44);
    self.weatherTableViewController.view.frame = frame;
    [self.view addSubview:self.weatherTableViewController.view];
    
    self.addToFavorites = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.addToFavorites.frame = CGRectMake(self.view.frame.size.width / 2 - 75, 330 , 150, 30);
    [self.addToFavorites setTitle:@"Add to Favorites" forState:UIControlStateNormal];
    [self.addToFavorites addTarget:self action:@selector(favoritesButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addToFavorites];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Social" style:UIBarButtonItemStyleBordered target:self action:@selector(socialSelected)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)unload
{
    self.iconView = nil;
    self.addToFavorites = nil;
}

-(void)viewDidUnload
{
    [self unload];
    [super viewDidUnload];
}

-(void)dealloc
{
    [self unload];
    self.delegate = nil;
    self.weatherTableViewController = nil;
    [super dealloc];
}

-(void)favoritesButtonClicked
{
    [self.delegate addCurrentModelToFavorites];
}

-(void)socialSelected
{
    EPSocialViewController *social = [[EPSocialViewController new] autorelease];
    [self.navigationController pushViewController:social animated:YES];
}

#pragma mark - Weather Tracker

- (void) modelCompletedInitialize
{
    [self.weatherTableViewController.tableView reloadData];
    NSData *tmpData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[EPWeatherModel share].weatherDictionary[kIcon]]];
    [self.iconView setImage:[UIImage imageWithData:tmpData]];
}

@end
