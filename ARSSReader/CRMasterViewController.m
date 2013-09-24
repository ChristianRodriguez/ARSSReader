//
//  CRMasterViewController.m
//  ARSSReader
//
//  Created by Christian Rodriguez on 4/14/13.
//  Copyright (c) 2013 Christian Rodriguez. All rights reserved.
//

#import "CRMasterViewController.h"
#import "TableHeaderView.h"
#import "CRDetailViewController.h"
#import "RSSLoader.h"
#import "RSSItem.h"

@interface CRMasterViewController () {
    //adds objects array, url feed and the UI refresh control
    NSArray *_objects;
    NSURL *feedURL;
    UIRefreshControl * refreshControl;
}
@end

@implementation CRMasterViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //adds title and links up url feed
    self.title = @"RSS Reader";
    feedURL = [NSURL URLWithString:@"http://feeds.feedburner.com/TouchCodeMagazine"];
    
    //add refresh control to the table view, specifically the ability to pull-down refresh
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self
                       action:@selector(refreshInvoked:forState:)
             forControlEvents:UIControlEventValueChanged];
    
    NSString* fetchMessage = [NSString stringWithFormat:@"Fetching: %@",feedURL];
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:fetchMessage
                                                                     attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:11.0]}];
    
    [self.tableView addSubview: refreshControl];
    // adds custom header
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText:@"fetching rss feed"];
    
    //ADD at the end of viewDidLoad
    [self refreshFeed];
    
    
}

//ADD as a separate method
-(void) refreshInvoked:(id)sender forState:(UIControlState)state {
    [self refreshFeed];
}




-(void)refreshFeed
{
    RSSLoader* rss = [[RSSLoader alloc] init];
    [rss fetchRssWithURL:feedURL
                complete:^(NSString *title, NSArray *results) {
                    //completed fetching the RSS
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        
                        [(TableHeaderView*)self.tableView.tableHeaderView setText:title];
                        
                        _objects = results;
                        [self.tableView reloadData];
                        
                        // Stop refresh control
                        [refreshControl endRefreshing];
                        
                        
                        
                        //UI code on the main queue
                        
                    });
                }];
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    RSSItem *object = _objects[indexPath.row];
    cell.textLabel.attributedText = object.cellMessage;
    cell.textLabel.numberOfLines = 0;
    return cell;

}
    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        RSSItem *item = [_objects objectAtIndex:indexPath.row];
        CGRect cellMessageRect = [item.cellMessage boundingRectWithSize:CGSizeMake(200,10000)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                                context:nil];
        return cellMessageRect.size.height;
    }



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end