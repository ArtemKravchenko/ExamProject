//
//  EPHistoryViewController.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPHistoryViewController.h"
#import "EPDetailViewController.h"

@interface EPHistoryViewController ()

@property (nonatomic, retain) NSMutableArray* historyArray;

@end

@implementation EPHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"History" ofType:@"plist"];
    NSDictionary *tmpDictionary = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
    self.historyArray = [tmpDictionary objectForKey:@"History"];
}

-(void)dealloc
{
    self.historyArray = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *title = self.historyArray[indexPath.row][kDate];
    NSString *lat = self.historyArray[indexPath.row][kLat];
    NSString *lon = self.historyArray[indexPath.row][kLon];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",lat, lon];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPDetailViewController *dvc = [[EPDetailViewController new] autorelease];
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
