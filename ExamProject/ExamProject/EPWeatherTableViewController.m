//
//  EPWeatherTableViewController.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPWeatherTableViewController.h"
#import "EPWeatherModel.h"

@interface EPWeatherTableViewController ()

@property (nonatomic, retain) NSArray* weatherParams;

@end

@implementation EPWeatherTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WeatherParams" ofType:@"plist"];
    NSDictionary *tmpDictionary = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
    self.weatherParams = [tmpDictionary objectForKey:@"Params"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weatherParams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeatherDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    NSDictionary *row = [self.weatherParams objectAtIndex:indexPath.row];
    NSString *title = [row allKeys][0];
    NSString *key = [row allValues][0];
    NSString *value = @"nil";
    if ([[EPWeatherModel share] weatherDictionary] != nil)
    {
        value = [EPWeatherModel share].weatherDictionary[key];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@    %@",title,value];
    
    return cell;
}

-(void)dealloc
{
    self.weatherParams = nil;
    [super dealloc];
}

@end
