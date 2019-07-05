//
//  TweetCell.m
//  twitter
//
//  Created by andrews9 on 7/2/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)didTapLike:(id)sender {
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    [sender setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    [sender setSelected:NO];
    self.favoriteCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

//- (IBAction)didTapRetweet:(id)sender {
//    self.tweet.retweeted = YES;
//    self.tweet.retweetCount += 1;
//    [sender setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
//    [sender setSelected:NO];
//    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
//    
//    
//    
//}

@end
