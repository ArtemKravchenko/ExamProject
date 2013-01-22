//
//  EPFavoritesViewController.m
//  ExamProject
//
//  Created by Oksana Kovalchuk on 21.01.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "EPFavoritesViewController.h"
#import "EPWeatherModel.h"

@interface EPFavoritesViewController ()

@property (nonatomic, retain) NSMutableArray* favoritesArray;

@end

@implementation EPFavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath] ,@"Favorites.plist"];
    NSDictionary *tmpDictionary = [[[NSDictionary alloc] initWithContentsOfFile:path] autorelease];
    self.favoritesArray = [tmpDictionary objectForKey:@"Favorites"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc
{
    self.favoritesArray = nil;
    [super dealloc];
}

- (void) writeToPlist
{
    NSString* plistPath = nil;
    NSFileManager* manager = [NSFileManager defaultManager];
    if ((plistPath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath] ,@"Favorites.plist"]))
    {
        if ([manager isWritableFileAtPath:plistPath])
        {
            NSMutableDictionary* infoDict = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
            [infoDict setObject:self.favoritesArray forKey:@"Favorites"];
            [infoDict writeToFile:plistPath atomically:YES];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favoritesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FavoriteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    NSString *title = self.favoritesArray[indexPath.row][kDate];
    NSString *lat = self.favoritesArray[indexPath.row][kLat];
    NSString *lon = self.favoritesArray[indexPath.row][kLon];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",title,[NSString stringWithFormat:@"%@ %@",lat, lon]];
    
    return cell;
}

#pragma mark - Add to Favorites delegate

- (void) addCurrentModelToFavorites
{
    if (self.favoritesArray.count == 0)
        self.favoritesArray = [NSMutableArray array];
    NSDictionary *tmpDictionary = [EPWeatherModel share].weatherDictionary;
    [self.favoritesArray addObject:[tmpDictionary copy]];
    [self.tableView reloadData];
    [self writeToPlist];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EPDetailViewController *dvc = [[EPDetailViewController new] autorelease];
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
