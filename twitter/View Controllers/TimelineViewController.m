//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.tableView.dataSource = self; // Step 3: View controller becomes its dataSource and delegate in viewDidLoad
    self.tableView.delegate = self;
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) { //Step 4: Make an API request
        if (tweets) {
            self.tweets = tweets; //Step 6: View controller stores that data passed into the completion handler

            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *x in tweets) {
                NSString *text = x.text;
                NSLog(@"%@", text);
            }
            [self.tableView reloadData]; //Step 7: Reload the table view
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}


// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *x in tweets) {
                NSString *text = x.text;
                NSLog(@"%@", text);
            }
            [self.tableView reloadData];
            [refreshControl endRefreshing];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { //Step 8: Table view asks its dataSource for numberOfRows & cellForRowAt

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];  //Step 10 cellForRow returns an instance of the custom cell with that reuse identifier with it’s elements populated with data at the index asked for
    Tweet *tweet = self.tweets[indexPath.row];
    cell.nameLabel.text = tweet.user.name;
    cell.handleLabel.text = tweet.user.screenName;
    cell.tweetLabel.text = tweet.text;
    NSString *fullProfileImageURLString = tweet.user.profileImage;
    NSURL *profileImageURL = [NSURL URLWithString:fullProfileImageURLString];
    cell.AVIView.image = nil; 
    [cell.AVIView setImageWithURL:profileImageURL];
    cell.AVIView.layer.cornerRadius = 25;
    cell.AVIView.layer.masksToBounds = YES;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { //Step 8: Table view asks its dataSource for numberOfRows & cellForRowAt
    return self.tweets.count; //Step 8: numberOfRows returns the number of items returned from the API
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

- (void) didTweet:(Tweet *)tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];

}



@end
